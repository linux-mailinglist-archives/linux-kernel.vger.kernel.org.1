Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA427B317
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgI1RZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:25:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:44713 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgI1RZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:25:04 -0400
IronPort-SDR: KwEmQUc+k9KFDDlmgOTc/CFurkt+EglV8esopPD9ejrSCJJdez2BvOxPW8C2dHrXcoLfIiaen2
 5D2EwfGq0Yjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223625767"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="223625767"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:25:03 -0700
IronPort-SDR: 4WIJbj5K0sIe+bmBUpyIDeZm5z/xcEN5g6l7fpRJYcuQZ78GihJee+w7OCJd4oDLuUv6jARImD
 ocGBp05s50bg==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="349916054"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 10:25:02 -0700
Date:   Mon, 28 Sep 2020 10:25:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvdimm: Use kobj_to_dev() API
Message-ID: <20200928172502.GC458519@iweiny-DESK2.sc.intel.com>
References: <1601103260-10249-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601103260-10249-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 02:54:17PM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/namespace_devs.c | 2 +-
>  drivers/nvdimm/region_devs.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 6da67f4..1d11ca7
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1623,7 +1623,7 @@ static struct attribute *nd_namespace_attributes[] = {
>  static umode_t namespace_visible(struct kobject *kobj,
>  		struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  
>  	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
>  		return 0;
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119..92adfaf
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -644,7 +644,7 @@ static struct attribute *nd_region_attributes[] = {
>  
>  static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, typeof(*dev), kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nd_region *nd_region = to_nd_region(dev);
>  	struct nd_interleave_set *nd_set = nd_region->nd_set;
>  	int type = nd_region_to_nstype(nd_region);
> @@ -759,7 +759,7 @@ REGION_MAPPING(31);
>  
>  static umode_t mapping_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nd_region *nd_region = to_nd_region(dev);
>  
>  	if (n < nd_region->ndr_mappings)
> -- 
> 2.7.4
> 
