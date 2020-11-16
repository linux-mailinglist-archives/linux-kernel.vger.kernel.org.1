Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCED2B410D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgKPKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKPKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:25:34 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AC6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:25:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so18068335wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9yOkDKk8O8Zbcoo1oIBcwjMEFD0KCWNdx2glmywuk8k=;
        b=OzD+92wXybj6khN9/TPr3KHAFkzhaitOD8SQQ4Bm2lzi1Z7QO4ZVpz1FoGBdhcOT3n
         LlaOvxB8Q/pbIoz8BDwLBgAaxu4e2NZTK1Ny80T3WC6TxcQZ4nGWNPmrGIi1MTSjv/6v
         8MASxWc4Rn/8ftGFdZocRz6Zk9s10S7mnxK/wbyqEnvpNco7CF//OzDr5TSr0SbH9Zo9
         84TftOHzSdw5tQsAwclcKIz4UTMPm33r8BL2k+oGqGh+kc22/iDgJK8vHNO9Os2rzqKm
         GntVuVW5k/gQO45s77zbD3YIa7WFGtN6h4OTeXfvJP5KfjdBrn8RJqzh7cPU4MAfLUCk
         RzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9yOkDKk8O8Zbcoo1oIBcwjMEFD0KCWNdx2glmywuk8k=;
        b=N0gmShboBvtMuIqqD7U3bjAQ2YVKVgcTn5Y65u+bKOGvmTV10QZ/QN3GYCuoexhvDh
         JOQ1mNtwhuiHlkM3gBxLCSUWwpNd5ywzorI1zyck+MYkWoPY5zDcKihb2ek/MphwE83U
         cFN8V+H6Nj6sIO7Ump1x1hj965BEhakCOwsN163KtIcRD4otc90KDkynmnSpSPYrc1U4
         yBlC1qBWdqgBMUhhFbFLhaVLyYW2vzbih6eRdZwtNJsAhENvbt+NaKmCv8Z80+b5wiwp
         D1BNEYZv89fB5rXUJ+MSPGcIFo0NKSjgIq7WX4UjrEHO44W/UrlqFHuTMCQq0Z/lHZn5
         5lNw==
X-Gm-Message-State: AOAM5306+japzMFgeT4bj6P5gePHMF/96rgq2c16gamclxAoSizTMhcO
        i7Jz83QzK2togRYoqkfG4rfO/A==
X-Google-Smtp-Source: ABdhPJwmcKCBCMr7gcoJyJEIWKSc5TgNbHIt3p+CjCaJC1fuxdyZIRT3ZqbW2TBC6bIWej5RfmN78Q==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr19285633wrp.77.1605522332437;
        Mon, 16 Nov 2020 02:25:32 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id e6sm19813883wme.27.2020.11.16.02.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:25:31 -0800 (PST)
Date:   Mon, 16 Nov 2020 10:25:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/40] drm/pl111/pl111_display: Make local function static
Message-ID: <20201116102530.GN3718728@dell>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-13-lee.jones@linaro.org>
 <20201114191127.GB3797389@ravnborg.org>
 <20201116084023.GL3718728@dell>
 <20201116101734.GA65688@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201116101734.GA65688@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Sam Ravnborg wrote:

> Hi Lee,
> On Mon, Nov 16, 2020 at 08:40:23AM +0000, Lee Jones wrote:
> > On Sat, 14 Nov 2020, Sam Ravnborg wrote:
> > 
> > > Hi Lee,
> > > On Fri, Nov 13, 2020 at 01:49:10PM +0000, Lee Jones wrote:
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/gpu/drm/pl111/pl111_display.c:356:6: warning: no previous prototype for ‘pl111_display_disable’ [-Wmissing-prototypes]
> > > > 
> > > > Cc: Eric Anholt <eric@anholt.net>
> > > > Cc: David Airlie <airlied@linux.ie>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > 
> > > Eric's was not copied on this or the other pl111 patch.
> > > Added Eric so he can be aware of this fix.
> > 
> > Eric Anholt?
> > 
> > He's on Cc?
> Not on the original mail I received.

Looks fine to me:

Date: Fri, 13 Nov 2020 13:49:10 +0000
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH 12/40] drm/pl111/pl111_display: Make local function static

Also reflected in Gmail:

 https://i.imgur.com/d69YTzz.png

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
