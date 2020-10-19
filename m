Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E928F292AED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgJSP4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbgJSP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:56:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC92C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:56:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b8so349825wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ExyTIzaV0pr3Eai44qIOEkkWvYQoFZOO2NPesnlxaJg=;
        b=LauR/Atww+62lrIAoI0S2aXFYC3jXL8fwHGmpYG11gT0kpCJSlFHUFXzKtkFAV4O0P
         HgNhi4Xzc7LNZ86YW6xp2qpqxF9fUjmU3Sww/YmAaNfW8lzaxOhMfDssyPcFYnBMQloE
         zTbV1d/w/3aqdvChRUejuygCo/WdvsgMuPWKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ExyTIzaV0pr3Eai44qIOEkkWvYQoFZOO2NPesnlxaJg=;
        b=aD7ZPZS9O9gQRLrjbCpgsp+67AB5DbW/deEAJCGraEHQcmLFNkaZiNY1zdnjzt7q/G
         GXns0xYqE06VzkvKE56cNoSWTBV/IuTikDUi/lFBmieY/hDFkTZXI+pkGh7gEmVW/A6f
         6jE6xO3IdMBNc1gpCBwkdqAQZMf0ecFKTNgoxR5P4rp/5GgJhXw7TFWPpgONFMIc3/rS
         ZxTkJuFrjFaxM0jlucwrVevZQVeUB30sh7fALuQ7LZZ5vD4qgzyRWRCTjerWQ0INpkob
         8rZkNJvmZ9LSuyJc26z1KJpiNJ7NPfWUUGgcDMUgV3P6KAsT8afLwwxxIxnxz723RPog
         kz/g==
X-Gm-Message-State: AOAM532SQt6QRryW3jOfrDZ3pUwhWZysG7mHv05MDVeLy+Y+lZWICivp
        +JJIQgGQkijitNuQRvqOGFRjDA==
X-Google-Smtp-Source: ABdhPJwXRObsL8ejRw2Heh5XRu+rRn4ydix5fTKFeZYFLvSwm2ojMD2la1MO54JxNhao+Rk9S4EHZg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr257359wrn.96.1603122982550;
        Mon, 19 Oct 2020 08:56:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w11sm191745wrs.26.2020.10.19.08.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:56:21 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:56:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 RESEND] docs: fb: Add font_6x8 to available built-in
 fonts
Message-ID: <20201019155619.GH401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
 <20201018205401.698242-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018205401.698242-1-yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 04:54:01PM -0400, Peilin Ye wrote:
> Recently we added a new 6x8 font in commit e2028c8e6bf9 ("lib/fonts: add
> font 6x8 for OLED display"). Add its name to the "compiled-in fonts"
> list.
> 
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> Resending +Cc: dri-devel, sorry if I spammed.

Both this and patch 1/2 with the actual bugfix merged to
drm-misc-next-fixes, should still make it into the merge window before
-rc1.

Thanks, Daniel

> 
>  Documentation/fb/fbcon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
> index 9aad964b767c..57f66de2f7e1 100644
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -81,7 +81,7 @@ C. Boot options
>  1. fbcon=font:<name>
>  
>  	Select the initial font to use. The value 'name' can be any of the
> -	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> +	compiled-in fonts: 10x18, 6x10, 6x8, 7x14, Acorn8x8, MINI4x6,
>  	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>  
>  	Note, not all drivers can handle font with widths not divisible by 8,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
