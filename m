Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4DC23E224
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHFT0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 15:26:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:47327 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFT0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:26:38 -0400
IronPort-SDR: 83LaL0pXqCO2ulJnk0iaXB67jUYJHqkmJPiv+SP1rZP6yJahu+K4b/CjCIzjHnbGUH2a4zQYoV
 CoXjPfDNKrtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="132990437"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="132990437"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:26:38 -0700
IronPort-SDR: dBZabNtMYg4WmnmsghcQq2ljNwJqcGP6+gd4BZC1t7IEktnfXuBISk9F9V3Q8B9djC+MIDE0UN
 7J9b8wRmI2aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="289379037"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2020 12:26:37 -0700
Date:   Thu, 6 Aug 2020 12:26:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, jmoyer@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] libnvdimm/security: ensure sysfs poll thread woke
 up and fetch updated attr
Message-ID: <20200806192637.GM1573827@iweiny-DESK2.sc.intel.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
 <1596494499-9852-3-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596494499-9852-3-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:41:39PM -0600, Jane Chu wrote:
> commit 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
> adds a sysfs_notify_dirent() to wake up userspace poll thread when the "overwrite"
> operation has completed. But the notification is issued before the internal
> dimm security state and flags have been updated, so the userspace poll thread
> wakes up and fetches the not-yet-updated attr and falls back to sleep, forever.
> But if user from another terminal issue "ndctl wait-overwrite nmemX" again,
> the command returns instantly.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/security.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 8f3971c..4b80150 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  	else
>  		dev_dbg(&nvdimm->dev, "overwrite completed\n");
>  
> -	if (nvdimm->sec.overwrite_state)
> -		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	/*
> +	 * Mark the overwrite work done and update dimm security flags,
> +	 * then send a sysfs event notification to wake up userspace
> +	 * poll threads to picked up the changed state.
> +	 */
>  	nvdimm->sec.overwrite_tmo = 0;
>  	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
>  	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
> -	put_device(&nvdimm->dev);
>  	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>  	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	if (nvdimm->sec.overwrite_state)
> +		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	put_device(&nvdimm->dev);
>  }
>  
>  void nvdimm_security_overwrite_query(struct work_struct *work)
> -- 
> 1.8.3.1
> 
