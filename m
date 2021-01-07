Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB92ED5FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbhAGRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbhAGRrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:47:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54C6C0612FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:47:07 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g185so6278172wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FVkiNKl785rRHfkhT0jkIlxfyJmaCj+j7D8f/PwIPwo=;
        b=OCW93FBGDdlW1IO8YOTTOZvpz/xhQubaFj/5ogv9RP2Nx7Y0uGqnVF4q8AWtOeAR7O
         7N1mIeMLEGw9AHisb4KENC7FyrWeJ96lVQLVN1HQLsW05amJNePPz1V8rpB25ujEyxUh
         FIJsHSAQGaWJjVmSVC9JWqR0JsgL8JpKJARS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=FVkiNKl785rRHfkhT0jkIlxfyJmaCj+j7D8f/PwIPwo=;
        b=RKKZxjbxbtzpPoXARTWas6wpbOyvez0ytG1bHKb/DdSquR2cggexOb5wN8lDf45GJw
         mE+cFEkoS31eH4Y6VXfWg4pS9230m3cFEVstm0ZWzgM6ATl1vTCy+1wAKSQYkwAnbE6W
         UqVqcZS1eBaLxI7MZRhT+42xrjpXHbwnTibxINTLxu8720qZkyhTi0bNrGz2sDNibowT
         w9t4UbDZoSB2WDIHqDA6qoiqsUKiFOPtgFLJ0mUSkM9Yi0LJwcX8U8d8dKHnass8BwZv
         lXHjbtFOkOPL8Nv0p2ZVbaIXADSyF3DGKCNYjBqjOZNLB2VXhtYiDKml1DAgxsRKAWUI
         77Og==
X-Gm-Message-State: AOAM533DeAM+g7gWXvo3hGCkT+BuppgbV0+Zs/K2ftxp1R73IEgrPBvR
        FcwwsQd8PKvUiCFRGVbg+KH+XA==
X-Google-Smtp-Source: ABdhPJxCXJdiaSbPhtROxkoiYK0Ot/i0W4Y+zklyQv/Ov1KMlh/j29f2tZQs0FvUnDLFsEzHDc3lWw==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr8998813wmh.101.1610041626648;
        Thu, 07 Jan 2021 09:47:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q73sm9165220wme.44.2021.01.07.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:47:05 -0800 (PST)
Date:   Thu, 7 Jan 2021 18:47:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mipi-dbi: Switch to new kerneldoc syntax for named
 variable macro argument
Message-ID: <X/dJGPDCDjmu1jx/@phenom.ffwll.local>
Mail-Followup-To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20210101211818.1023919-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210101211818.1023919-1-j.neuschaefer@gmx.net>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 01, 2021 at 10:18:17PM +0100, Jonathan Neuschäfer wrote:
> The syntax without dots is available since commit 43756e347f21
> ("scripts/kernel-doc: Add support for named variable macro arguments").
> 
> The same HTML output is produced with and without this patch.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  include/drm/drm_mipi_dbi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
> index c2827ceaba0d2..f543d6e3e822c 100644
> --- a/include/drm/drm_mipi_dbi.h
> +++ b/include/drm/drm_mipi_dbi.h
> @@ -172,7 +172,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>   * mipi_dbi_command - MIPI DCS command with optional parameter(s)
>   * @dbi: MIPI DBI structure
>   * @cmd: Command
> - * @seq...: Optional parameter(s)
> + * @seq: Optional parameter(s)
>   *
>   * Send MIPI DCS command to the controller. Use mipi_dbi_command_read() for
>   * get/read.
> --
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
