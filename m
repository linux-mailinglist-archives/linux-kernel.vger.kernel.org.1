Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFB2C6CB5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 21:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgK0Urd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Nov 2020 15:47:33 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:50069 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727936AbgK0Upy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:45:54 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23138523-1500050 
        for multiple; Fri, 27 Nov 2020 19:27:01 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201127162828.2660230-1-trix@redhat.com>
References: <20201127162828.2660230-1-trix@redhat.com>
Subject: Re: [PATCH] drm/i915: remove trailing semicolon in macro definition
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Tom Rix <trix@redhat.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
To:     airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        trix@redhat.com
Date:   Fri, 27 Nov 2020 19:26:59 +0000
Message-ID: <160650521947.2925.9215342814329752171@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting trix@redhat.com (2020-11-27 16:28:28)
> From: Tom Rix <trix@redhat.com>
> 
> The macro use will already have a semicolon.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_device_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
> index e67cec8fa2aa..ef767f04c37c 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.c
> +++ b/drivers/gpu/drm/i915/intel_device_info.c
> @@ -104,7 +104,7 @@ void intel_device_info_print_static(const struct intel_device_info *info,
>         drm_printf(p, "ppgtt-type: %d\n", info->ppgtt_type);
>         drm_printf(p, "dma_mask_size: %u\n", info->dma_mask_size);
>  
> -#define PRINT_FLAG(name) drm_printf(p, "%s: %s\n", #name, yesno(info->name));
> +#define PRINT_FLAG(name) drm_printf(p, "%s: %s\n", #name, yesno(info->name))
>         DEV_INFO_FOR_EACH_FLAG(PRINT_FLAG);

I thought that this was a macro that avoided adding the ';' to each
invocation. Perhaps another time.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
