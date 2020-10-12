Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848A528B46C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbgJLMOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbgJLMOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:14:39 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC591C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3cb7WZFRBswsrdws6R8QmvzchDk3x4uafw61Cqj46FE=; b=MktsYIDrMHeWyYQQFErIcK5cU
        NFHtdu8v0drlLLjOeQTWnWlr6q9uz1x3Vn673Ustp5/XskoF5KGILucp3vuFaq8NuQTFX5fjaKUUq
        Cu1MFC78UaMcmxkZp40Yf/jZZoJGN0RB2tJErpTb6PtGaTfe1VqemFhqVP2Uy9Twm1+Uw2YbraekZ
        2Smca42r+QwqTSqDHYPKG7+TyqSfjKLbWArtPm7SuLnJ4H1LF5jtar7Blx/hUYA9QM5ICYA8V9fiy
        IdfwQJbJzR4ZWWWIqB2T9FmJH4yeqlFCaS9fp6So0wOojLVqdj/4ytDMMBmYcYHufq86hSFi9YWdY
        ycr1OIB9g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45066)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kRwio-0003zN-CC; Mon, 12 Oct 2020 13:14:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kRwik-0005bg-Hu; Mon, 12 Oct 2020 13:14:30 +0100
Date:   Mon, 12 Oct 2020 13:14:30 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] gpu/drm/armada: fix unused parameter warning
Message-ID: <20201012121430.GP1551@shell.armlinux.org.uk>
References: <20201012115724.8980-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201012115724.8980-1-bernard@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 04:57:24AM -0700, Bernard Zhao wrote:
> Functions armada_drm_crtc_atomic_flush &
> armada_drm_crtc_atomic_enable don`t use the second parameter.
> So we may get warning like :
> warning: unused parameter ‘***’ [-Wunused-parameter].
> This change is to fix the compile warning with -Wunused-parameter.

Under what circumstances do we build the kernel with that warning
enabled?

> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/armada/armada_crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
> index 38dfaa46d306..fc8b922c3e44 100644
> --- a/drivers/gpu/drm/armada/armada_crtc.c
> +++ b/drivers/gpu/drm/armada/armada_crtc.c
> @@ -427,7 +427,7 @@ static int armada_drm_crtc_atomic_check(struct drm_crtc *crtc,
>  }
>  
>  static void armada_drm_crtc_atomic_begin(struct drm_crtc *crtc,
> -					 struct drm_crtc_state *old_crtc_state)
> +				struct drm_crtc_state __attribute__((unused)) *old_crtc_state)
>  {
>  	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>  
> @@ -441,7 +441,7 @@ static void armada_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>  }
>  
>  static void armada_drm_crtc_atomic_flush(struct drm_crtc *crtc,
> -					 struct drm_crtc_state *old_crtc_state)
> +				struct drm_crtc_state __attribute__((unused)) *old_crtc_state)
>  {
>  	struct armada_crtc *dcrtc = drm_to_armada_crtc(crtc);
>  
> -- 
> 2.28.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
