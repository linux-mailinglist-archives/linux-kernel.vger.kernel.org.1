Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8F82B6CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgKQSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgKQSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:12:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:12:54 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so24142080wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sy11XZxk2UapLYKn4i4gXsIKXlY4QqHYxqwrkdcDSg4=;
        b=wUafgPlH0pdlylG8w4VJtjz2eCiqI8uWYjuWKDcZerO7JqIH06BqNXcYPF+AfMM7RW
         5qZLCajp6dntsBGiOp6L+s+uqRv7JCv0eHkT27tOhpdy3qQQl+TWbZZYCxRl/xqlSXPG
         kq1ClL1K4yPBMzdZEpIF65EfPpcQwUlo1iQ6VXbhvbEg0xusMHYryjp9Pu7Rn307l0+a
         8beTKUVURc/fuk6QAxqnCXwCT9m48ZrEcECxj0Y/czaXcAEt+rR38G0jm/lXeNvkvePe
         hXm23B0BGeoJdmX66MKsmacvQFjwA/Y+oJCJEkg91pJkv2QBuaHOAYQpw0naV9KOb62J
         yOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sy11XZxk2UapLYKn4i4gXsIKXlY4QqHYxqwrkdcDSg4=;
        b=VTO5t2IRNoRl9VvCBw7SxeqQXVM4CUnDUjhmUGQmz007MX+JKIjpenORjS6lWy6x/F
         4yVZ4EuchorHs89qgb4vBG5F/9Z+XbZ+0KQ3pLc10jEDA9+l7Cmz5qvPiR/MgZqhK1yH
         WLe6P60bU+Vt0iQT2TmjETc9tkkxUjazGEhbaKnLoY4fn7Sn8aVf0WrasrLCkJKeq4ee
         C1dUWCIq7iU7LmnqTeV940747krfLqwn/x93O8gwJfxjJWFHcLa7pX4Y+jlJOz6xqFyd
         AjwO+l+qF4D4crM9Wmc+SO9cSsj5yWqxAW9aWCGLRPDe+r8svWCfBF2JVcwasEDZpWXu
         1nPQ==
X-Gm-Message-State: AOAM533VXh9BD4X2YDXpsOgBwkK1QuTDdik+yar7Atyd9RgK64FZHwXA
        ynpy8RJeX3yd1f5pMugaQ3fDYggFXejclHaW
X-Google-Smtp-Source: ABdhPJxWNo3jDSMV6Q/igylxB209/03TI6WOA2HljuZCCtF8aRIy/XIUcF+ZPgfMNkk3gZ43jnJJiw==
X-Received: by 2002:adf:b358:: with SMTP id k24mr725103wrd.388.1605636773200;
        Tue, 17 Nov 2020 10:12:53 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t13sm29699403wru.67.2020.11.17.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 10:12:52 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:12:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 03/42] drm/drm_dp_mst_topology: Remove set but never used
 variable 'len'
Message-ID: <20201117181250.GL1869941@dell>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-4-lee.jones@linaro.org>
 <20201117172925.GN401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117172925.GN401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Daniel Vetter wrote:

> On Mon, Nov 16, 2020 at 05:40:33PM +0000, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/drm_dp_mst_topology.c: In function ‘drm_dp_send_query_stream_enc_status’:
> >  drivers/gpu/drm/drm_dp_mst_topology.c:3263:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Going to apply this, but I noticed that the return value of the
> build_query_stream_enc_status() is pointless. Can you pls follow up with
> an additional patch to change that to void?

I can.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
