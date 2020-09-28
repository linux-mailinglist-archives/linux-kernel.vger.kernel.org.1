Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0693D27AF28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1NhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:37:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:8175 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1NhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:37:11 -0400
IronPort-SDR: s5y5ae9g9g/y9/Wkcw8atyFxi/9/U7SETPSXop6faJEBX8otrdNQk0sfLoMJoqL1+wLfMcoljv
 e/6igHnbCCCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149767412"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="149767412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 06:37:09 -0700
IronPort-SDR: OLZxjiXOr/5BwX+rto37oFgNE72aMNGYJ36SUAoCZkhSx1kOjtJj8TFkIo+0B3LbPO0Nq4gqs0
 +v9YXBpu9bNg==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="307338790"
Received: from lizwalsh-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.86.12])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 06:37:04 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, james.ausmus@intel.com,
        matthew.d.roper@intel.com, jose.souza@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        hariom.pandey@intel.com
Subject: Re: [PATCH 1/2] drm/i915/jsl: Split EHL/JSL platform info and PCI ids
In-Reply-To: <20200928080931.246347-2-tejaskumarx.surendrakumar.upadhyay@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200928080931.246347-1-tejaskumarx.surendrakumar.upadhyay@intel.com> <20200928080931.246347-2-tejaskumarx.surendrakumar.upadhyay@intel.com>
Date:   Mon, 28 Sep 2020 16:37:21 +0300
Message-ID: <87d026owdq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020, Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com> wrote:
> Split the basic platform definition, macros, and PCI IDs to
> differentiate between EHL and JSL platforms.
>
> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h          | 4 +++-
>  drivers/gpu/drm/i915/i915_pci.c          | 9 +++++++++
>  drivers/gpu/drm/i915/intel_device_info.c | 1 +
>  drivers/gpu/drm/i915/intel_device_info.h | 1 +
>  include/drm/i915_pciids.h                | 9 ++++++---
>  5 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 72a9449b674e..4f20acebb038 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -1417,7 +1417,9 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
>  #define IS_COMETLAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_COMETLAKE)
>  #define IS_CANNONLAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_CANNONLAKE)
>  #define IS_ICELAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_ICELAKE)
> -#define IS_ELKHARTLAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_ELKHARTLAKE)
> +#define IS_ELKHARTLAKE(dev_priv) (IS_PLATFORM(dev_priv, INTEL_ELKHARTLAKE) || \
> +				IS_PLATFORM(dev_priv, INTEL_JASPERLAKE))
> +#define IS_JASPERLAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_JASPERLAKE)

I think we've learned from history that we want the platform checks to
be independent. I.e. if you need to split ELK and JSP, you need to make
IS_ELKHARTLAKE() match *only* ELK, and you need to replace every current
IS_ELKHARTLAKE() check with IS_ELKHARTLAKE() || IS_JASPERLAKE().

We've been here before, and we've thought before that we can get by with
the minimal change. It's just postponing the inevitable and generates
confusion.

BR,
Jani.


>  #define IS_TIGERLAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_TIGERLAKE)
>  #define IS_ROCKETLAKE(dev_priv)	IS_PLATFORM(dev_priv, INTEL_ROCKETLAKE)
>  #define IS_DG1(dev_priv)        IS_PLATFORM(dev_priv, INTEL_DG1)
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 366ddfc8df6b..8690b69fcf33 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -846,6 +846,14 @@ static const struct intel_device_info ehl_info = {
>  	.ppgtt_size = 36,
>  };
>  
> +static const struct intel_device_info jsl_info = {
> +	GEN11_FEATURES,
> +	PLATFORM(INTEL_JASPERLAKE),
> +	.require_force_probe = 1,
> +	.platform_engine_mask = BIT(RCS0) | BIT(BCS0) | BIT(VCS0) | BIT(VECS0),
> +	.ppgtt_size = 36,
> +};
> +
>  #define GEN12_FEATURES \
>  	GEN11_FEATURES, \
>  	GEN(12), \
> @@ -985,6 +993,7 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_CNL_IDS(&cnl_info),
>  	INTEL_ICL_11_IDS(&icl_info),
>  	INTEL_EHL_IDS(&ehl_info),
> +	INTEL_JSL_IDS(&jsl_info),
>  	INTEL_TGL_12_IDS(&tgl_info),
>  	INTEL_RKL_IDS(&rkl_info),
>  	{0, 0, 0}
> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
> index adc836f15fde..e67cec8fa2aa 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.c
> +++ b/drivers/gpu/drm/i915/intel_device_info.c
> @@ -62,6 +62,7 @@ static const char * const platform_names[] = {
>  	PLATFORM_NAME(CANNONLAKE),
>  	PLATFORM_NAME(ICELAKE),
>  	PLATFORM_NAME(ELKHARTLAKE),
> +	PLATFORM_NAME(JASPERLAKE),
>  	PLATFORM_NAME(TIGERLAKE),
>  	PLATFORM_NAME(ROCKETLAKE),
>  	PLATFORM_NAME(DG1),
> diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
> index 6a3d607218aa..d92fa041c700 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.h
> +++ b/drivers/gpu/drm/i915/intel_device_info.h
> @@ -79,6 +79,7 @@ enum intel_platform {
>  	/* gen11 */
>  	INTEL_ICELAKE,
>  	INTEL_ELKHARTLAKE,
> +	INTEL_JASPERLAKE,
>  	/* gen12 */
>  	INTEL_TIGERLAKE,
>  	INTEL_ROCKETLAKE,
> diff --git a/include/drm/i915_pciids.h b/include/drm/i915_pciids.h
> index 7eeecb07c9a1..1b5e09cfa11e 100644
> --- a/include/drm/i915_pciids.h
> +++ b/include/drm/i915_pciids.h
> @@ -579,15 +579,18 @@
>  	INTEL_VGA_DEVICE(0x8A51, info), \
>  	INTEL_VGA_DEVICE(0x8A5D, info)
>  
> -/* EHL/JSL */
> +/* EHL */
>  #define INTEL_EHL_IDS(info) \
>  	INTEL_VGA_DEVICE(0x4500, info),	\
>  	INTEL_VGA_DEVICE(0x4571, info), \
>  	INTEL_VGA_DEVICE(0x4551, info), \
>  	INTEL_VGA_DEVICE(0x4541, info), \
> -	INTEL_VGA_DEVICE(0x4E71, info), \
>  	INTEL_VGA_DEVICE(0x4557, info), \
> -	INTEL_VGA_DEVICE(0x4555, info), \
> +	INTEL_VGA_DEVICE(0x4555, info)
> +
> +/* JSL */
> +#define INTEL_JSL_IDS(info) \
> +	INTEL_VGA_DEVICE(0x4E71, info), \
>  	INTEL_VGA_DEVICE(0x4E61, info), \
>  	INTEL_VGA_DEVICE(0x4E57, info), \
>  	INTEL_VGA_DEVICE(0x4E55, info), \

-- 
Jani Nikula, Intel Open Source Graphics Center
