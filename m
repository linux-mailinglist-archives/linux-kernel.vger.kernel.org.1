Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA41429ECE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgJ2N1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:27:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:58033 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgJ2N1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:27:49 -0400
IronPort-SDR: jf4xuRCNQj/vyN1QFow5SPp0vZZcWqIKA7WkyO1bPwOUINlNrSSpXpd4rIJ3jFoifIdanRx7Pq
 fH3GhKTJOQWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="230068812"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="230068812"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 06:27:48 -0700
IronPort-SDR: tCx8fBPfk+dxIcMBHFS0/6FZmrAa+Ju2lsYykZeBNKcrzw4fgvTvz+lF73U9W4xNlm9RwAjGwE
 YJ9HraOSkO/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="356256540"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 29 Oct 2020 06:27:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 29 Oct 2020 15:27:43 +0200
Date:   Thu, 29 Oct 2020 15:27:43 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/i915: Remove unused variable ret
Message-ID: <20201029132743.GZ6112@intel.com>
References: <1603937925-53176-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1603937925-53176-1-git-send-email-zou_wei@huawei.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:18:45AM +0800, Zou Wei wrote:
> This patch fixes below warnings reported by coccicheck
> 
> ./drivers/gpu/drm/i915/i915_debugfs.c:789:5-8: Unneeded variable: "ret". Return "0" on line 1012
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thanks. Applied.

> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index ea46916..200f6b8 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -786,7 +786,6 @@ static int i915_frequency_info(struct seq_file *m, void *unused)
>  	struct intel_uncore *uncore = &dev_priv->uncore;
>  	struct intel_rps *rps = &dev_priv->gt.rps;
>  	intel_wakeref_t wakeref;
> -	int ret = 0;
>  
>  	wakeref = intel_runtime_pm_get(&dev_priv->runtime_pm);
>  
> @@ -1009,7 +1008,7 @@ static int i915_frequency_info(struct seq_file *m, void *unused)
>  	seq_printf(m, "Max pixel clock frequency: %d kHz\n", dev_priv->max_dotclk_freq);
>  
>  	intel_runtime_pm_put(&dev_priv->runtime_pm, wakeref);
> -	return ret;
> +	return 0;
>  }
>  
>  static int i915_ring_freq_table(struct seq_file *m, void *unused)
> -- 
> 2.6.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
