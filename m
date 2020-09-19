Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C411270B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgISH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 03:58:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:9419 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgISH6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:58:44 -0400
IronPort-SDR: 6RLAm5l++MtqiuuDWzoUa1aD/g2BIXs7K1YuchpPvSbHhG6QEXNZNmxgYVMTta71aOAyvQCL8w
 x6Qx2flD9eLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="244939802"
X-IronPort-AV: E=Sophos;i="5.77,278,1596524400"; 
   d="scan'208";a="244939802"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2020 00:58:41 -0700
IronPort-SDR: B/SXFwDUMfw+9Xirb9HcNd4+el4a/ZS01my2XwQkyhBPKH3DYvQLY41glukoAf9n+k6tfwdEyJ
 8EXxUPxzrgBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,278,1596524400"; 
   d="scan'208";a="340112893"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2020 00:58:41 -0700
Received: from [10.249.228.91] (abudanko-mobl.ccr.corp.intel.com [10.249.228.91])
        by linux.intel.com (Postfix) with ESMTP id 8585F580279;
        Sat, 19 Sep 2020 00:58:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        alexander.h.duyck@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0ec64bdc-66fd-4be1-03cf-561a7c42de68@linux.intel.com>
Date:   Sat, 19 Sep 2020 10:58:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911194549.12780-4-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patches.

On 11.09.2020 22:45, David E. Box wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Add support for the Intel Platform Monitoring Technology crashlog
> interface.  This interface provides a few sysfs values to allow for
> controlling the crashlog telemetry interface as well as a character driver
> to allow for mapping the crashlog memory region so that it can be accessed
> after a crashlog has been recorded.
> 
> This driver is meant to only support the server version of the crashlog
> which is identified as crash_type 1 with a version of zero. Currently no
> other types are supported.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
>  drivers/platform/x86/Kconfig                  |  10 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
>  4 files changed, 665 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
>  create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c

<SNIP>

> +
> +/*
> + * devfs
> + */
> +static int pmt_crashlog_open(struct inode *inode, struct file *filp)
> +{
> +	struct crashlog_entry *entry;
> +	struct pci_driver *pci_drv;
> +	struct pmt_crashlog_priv *priv;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

Will not this above still block access to /dev/crashlogX for admin_group users
in case root configured access e.g. similar to this:

ls -alh /dev/
crw-rw----.  1 root admin_group      1,   9 Sep 15 18:28 crashlogX

If yes then that capable() check is probably superfluous and
should be avoided in order not to block access to PMT data.

Could you please clarify or comment?

Thanks,
Alexei  
