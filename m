Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0F2F636C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbhANOsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbhANOsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:48:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BABC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:47:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d26so6020947wrb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LjjYZgklRWjLMMBlb88qLIEN7lLRBVq95xQ8skgikMk=;
        b=cxNrQ/wS5RylS1mLd3vjuHDvzVyo8WuHvwGuRC4FR2heBf7aAMFtd3keuoJEZOZBBr
         N7/B6xT5rjJ5DDp1b7Q51zY/fZqdl0x8q9X7YcXKojVsi6+TdolBneF+XcDVeN3uXx5r
         D7mAhI+GS2FHRYfUfcpAvSo+3womr+L7J98+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=LjjYZgklRWjLMMBlb88qLIEN7lLRBVq95xQ8skgikMk=;
        b=Y5QCEv+m91x44fv1e3mmrOcDhZqmEeXPJmh1GNnaz6cWVqSYCx9nNlsGDcnyJnaDFW
         roDaZE5CMw5O4+Rlvn+ypDdkei05muyQNB0MO4PZm+sgdyFcFRLLyNUB3NyY0cFHNxLz
         jjxDXHgCTRn1XYih5q3UFdmtA5PjxgjEDy+ybLfRkY3l+8I3JXhtiYrj7JIoXy7TXO51
         VHFRP/KA2erOhfhd8opgH4IavHUEYRWMit3mGJDiVoy5FT8WT8jlf9EYKvMp874TlVHf
         E17mvou8m2P1fZmWNBUsxYjZcpPOVmaAz3HGe+8GjLACA93fn/1tQZyy9kD28979+8ga
         eicA==
X-Gm-Message-State: AOAM531cIC4b0q+YGjL057PqSI8Ck6PQNyZMAe/eWN01OEhnFpHHBflu
        t4bi6YE2C49ncLHnEZIWH8ySUw==
X-Google-Smtp-Source: ABdhPJyb/IHCh3tcTbtEpGXHIFizVqnfT/d4Np+x9HepjrQC2XMwS3XmP1qV1pVz/sQVFRGmZJo6Lg==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr8359418wrv.397.1610635652487;
        Thu, 14 Jan 2021 06:47:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n12sm10764911wrg.76.2021.01.14.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:47:31 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:47:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vblank: Fix typo in docs
Message-ID: <YABZgVFuL0qZuET8@phenom.ffwll.local>
Mail-Followup-To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210114142245.udr7v2aa43ho56xs@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114142245.udr7v2aa43ho56xs@adolin>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 07:52:45PM +0530, Sumera Priyadarsini wrote:
> Fix typo in intro chapter in drm_vblank.c.
> Change 'sacn' to 'scan'.
> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Nice catch, applied.
-Daniel

> ---
>  drivers/gpu/drm/drm_vblank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index d30e2f2b8f3c..30912d8f82a5 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -74,7 +74,7 @@
>   *                |↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓|   updates the
>   *                |                                        |   frame as it
>   *                |                                        |   travels down
> - *                |                                        |   ("sacn out")
> + *                |                                        |   ("scan out")
>   *                |               Old frame                |
>   *                |                                        |
>   *                |                                        |
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
