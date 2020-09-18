Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3939926FD73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgIRMsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIRMsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:48:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531FC061351
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:48:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x23so5202029wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6z/UJ7CNrSXR9o7Cfm16LszuY4Y2gIbIznxSeH0B9A=;
        b=lG981rnRtgZAm6syEr1bZwt4N84LNEPYwI/TtyOO/VThTo/f9Li5vCEwYo6F3ZuutF
         6Gslyar/X9Ttu77h6dUYdULlgBkFmFESpKnO8YxLOmCCqVxm+xNqSqCSvB8T2cqti2My
         /HA7oinA8lX9Ie/JT9IPM3+mo8pr5NmmDoZmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=j6z/UJ7CNrSXR9o7Cfm16LszuY4Y2gIbIznxSeH0B9A=;
        b=gnA3VT2UvADFNelMNeWAwQbGwVt3tzFIBDjKAK6xiQdb+xOgq7a61d5E93r6E61uXn
         q+1JFhr6hEcwNzybyTtldy/rgVljveQiBXudgfZoUWe2TZCjdK3iPee6Mx5HWmnfb3fw
         4Zm2YHNl6fZB91yf2jb/cCheK1JOW5JZHApvHZb1y2h6biLtePvqUnWBDP1vOuM+2cs4
         nSDXc9xLpYDX3VlO22KrVOJl/rDJtWf9phx2J8kpz/Akg+uoIBFOIpT2R8NZhvY1u0rg
         nn4csIf+15hjRkS76NGS0gzwbkh2pT1T4z4bp/kz2laPqPmopsm+DmK9sL11ZrCC9KHl
         W7SA==
X-Gm-Message-State: AOAM5336S6r9DJ55n53aPuOjr4GLeet2j2vnNYg2PevPt+g6FoIDgDig
        I3uT2RAFrMD9w1g1oj04sB/46A==
X-Google-Smtp-Source: ABdhPJyAwBd6mEl7zhhB5tmC68RAnfpPY5rzLITEX8vAOCgabHANhMyPXmiUCR2jm9cGTwuUEaAfOw==
X-Received: by 2002:a7b:c141:: with SMTP id z1mr15912912wmi.79.1600433290849;
        Fri, 18 Sep 2020 05:48:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b18sm5415123wrn.21.2020.09.18.05.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:48:10 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:48:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "David S . Miller" <davem@davemloft.net>, hch@lst.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
Message-ID: <20200918124808.GD438822@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "David S . Miller" <davem@davemloft.net>, hch@lst.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200918100812.1447443-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918100812.1447443-1-arnd@arndb.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:08:10PM +0200, Arnd Bergmann wrote:
> The fbdev code uses compat_alloc_user_space in a few of its
> compat_ioctl handlers, which tends to be a bit more complicated
> and error-prone than calling the underlying handlers directly,
> so I would like to remove it completely.
> 
> This modifies two such functions in fbdev, and removes another
> one that is completely unused.
> 
>     Arnd
> 
> Arnd Bergmann (3):
>   fbdev: simplify fb_getput_cmap()
>   fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
>   fbdev: sbuslib: remove compat_alloc_user_space usage

Looks all good, but we're also kinda looking for a new volunteer for
handling fbdev patches ... drm-misc commit rights, still not interested?
-Daniel

> 
>  drivers/video/fbdev/core/fbmem.c |  44 +++++------
>  drivers/video/fbdev/sbuslib.c    | 124 ++++++++++++++++++-------------
>  2 files changed, 90 insertions(+), 78 deletions(-)
> 
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
