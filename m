Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70008285CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgJGKfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:35:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:24828 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgJGKfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:35:44 -0400
IronPort-SDR: Kq3QJuDVjpYxSHCstVdl08ZtuDOe2JqHTCyaQ6CJzAhWMS6W/g/n8Y0qJ83b21VftF3UbXeNC7
 yll2ES2U45MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144808105"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="144808105"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 03:35:43 -0700
IronPort-SDR: 8rHst02E2sEkrzvZ+k78mTWrUl74uPckDgOmsw32oJQ9+9C1PFIQrwMh1Amz282g97aQXxjyRu
 FKMfY+EyrKTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354845530"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 07 Oct 2020 03:35:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 07 Oct 2020 13:35:39 +0300
Date:   Wed, 7 Oct 2020 13:35:39 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Matteo Franchin <matteo.franchin@arm.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        airlied@linux.ie, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH] drm/fourcc: Add AXBXGXRX106106106106 format
Message-ID: <20201007103539.GA6112@intel.com>
References: <20201007092725.13300-1-matteo.franchin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007092725.13300-1-matteo.franchin@arm.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:27:25AM +0100, Matteo Franchin wrote:
> Add ABGR format with 10-bit components packed in 64-bit per pixel.
> This format can be used to handle
> VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
> architectures.
> 
> Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 722c7ebe4e88..bba03fcb016d 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_AXBXGXRX106106106106,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_RGB888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_BGR888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_XRGB8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 82f327801267..76eedba52b77 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -155,6 +155,13 @@ extern "C" {
>  #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
>  #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
>  
> +/*
> + * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
> + * of unused padding per component:
> + * [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian

I think we usually put that last bit at the end of the fourcc define.
In theory it makes grepping a bit nicer. The exceptions are all planar
formats where each plane can have different component packing.

> + */
> +#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0')
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
