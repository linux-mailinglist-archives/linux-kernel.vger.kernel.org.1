Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF39D1F1CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 18:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgFHQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 12:07:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:27267 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgFHQHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:07:49 -0400
IronPort-SDR: AqqjTEVb+3FN0luSSZbhfZ9H7fsxdtwuZM3czKCJfkuUSaw6D4p3UN8BtWQHr3AwGcQ0TV2CAw
 DroqIqm293BA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 09:07:48 -0700
IronPort-SDR: nj6H1nx1dfa6r0w/NIMfuEQlWaDAdrMcRgCbwY9lcFrLKtz9i47DJxhXA9oOgKYhQw47y86wAk
 mNLDIM8YSp8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="258727589"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2020 09:07:48 -0700
Date:   Mon, 8 Jun 2020 09:07:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v11 4/6] powerpc/papr_scm: Improve error logging and
 handling papr_scm_ndctl()
Message-ID: <20200608160747.GA2936401@iweiny-DESK2.sc.intel.com>
References: <20200607131339.476036-1-vaibhav@linux.ibm.com>
 <20200607131339.476036-5-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607131339.476036-5-vaibhav@linux.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 06:43:37PM +0530, Vaibhav Jain wrote:
> Since papr_scm_ndctl() can be called from outside papr_scm, its
> exposed to the possibility of receiving NULL as value of 'cmd_rc'
> argument. This patch updates papr_scm_ndctl() to protect against such
> possibility by assigning it pointer to a local variable in case cmd_rc
> == NULL.
> 
> Finally the patch also updates the 'default' add a debug log unknown
> 'cmd' values.
> 
> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v10..v11:
> * Instead of returning *cmd_rd just return '0' in case nd_cmd is
>   handled. In case of unknown nd-cmd return -EINVAL
>   [ Ira and Dan Williams ]
> * Updated patch description.
> 
> v9..v10
> * New patch in the series
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0c091622b15e..692ad3d79826 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -355,11 +355,16 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  {
>  	struct nd_cmd_get_config_size *get_size_hdr;
>  	struct papr_scm_priv *p;
> +	int rc;
>  
>  	/* Only dimm-specific calls are supported atm */
>  	if (!nvdimm)
>  		return -EINVAL;
>  
> +	/* Use a local variable in case cmd_rc pointer is NULL */
> +	if (!cmd_rc)
> +		cmd_rc = &rc;
> +
>  	p = nvdimm_provider_data(nvdimm);
>  
>  	switch (cmd) {
> @@ -381,6 +386,7 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
>  		break;
>  
>  	default:
> +		dev_dbg(&p->pdev->dev, "Unknown command = %d\n", cmd);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.26.2
> 
