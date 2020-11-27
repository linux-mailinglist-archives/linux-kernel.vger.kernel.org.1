Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944D92C688A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgK0POn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgK0POm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:14:42 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A0C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 07:14:41 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so5916432wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMzwoE0Dd6fGdbZptz4gO2+Eta2edZWtpfnfREQIYBk=;
        b=iNafPJ5ywOWSDkzoa418mygS+Pu6j0+b0FZhr6dG9lb3JOScnAd3oHUlc0LVjAmD3g
         exwlJ3BhHTSl3vuBryhe7Kgc56fC1N5rj6jJWeqihvbS3H0kM3HY57LQzY/0PqTshM70
         wHuQWaqK5Fxc12etXg9s39a4GbCEOsotO/7GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ZMzwoE0Dd6fGdbZptz4gO2+Eta2edZWtpfnfREQIYBk=;
        b=PJfuMbE5DLKnAh4jIdljCsR0klg6cPwbdBqYcDMduIt8p2oSrrV1HrQB3QRfNyiDCR
         oUplbg999FmQglaEp9KJHaqRxG/uOZwdLFzmfw+D+2r1i82kGTGATfGsqfH7xunLGkQJ
         u23aMxSnOnSSv84r77JP5oRU6TYzFh4f1S/cqkpvD3zOUZ7L5XvN6u+GOG2sGj4Nvnoi
         TN0UOD5ZNdKmL1WAuUJ5pcZGr1kAg6euFzMpO/sfQU6pmz/idbvCvjYO/U4sbXCZ6fQQ
         cR/Asz6CMQTGUaTtdQt+nMBn3PBL15H07hZtp/VdjnkzSHmdaxM+RisftDLKPbdRfj7O
         l8sA==
X-Gm-Message-State: AOAM531/xWR/69Vgz03IHTUTvV9Z883MpL11jcwXG7hlm/bnAyWml/Jj
        UifZmEdbJMN8HqA7LdJcHb/NZcqX1wCOOQ==
X-Google-Smtp-Source: ABdhPJzeFZUg0q2fzZp1cBShV/TYpSR++GJRHPfRmFTBFUpON/ZCauJL86rwWuavStjri4mOLdoRew==
X-Received: by 2002:adf:e444:: with SMTP id t4mr11341858wrm.152.1606490080594;
        Fri, 27 Nov 2020 07:14:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j13sm8370481wrp.70.2020.11.27.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 07:14:39 -0800 (PST)
Date:   Fri, 27 Nov 2020 16:14:37 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2] fbdev: aty: SPARC64 requires FB_ATY_CT
Message-ID: <20201127151437.GH401619@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <20201127031752.10371-1-rdunlap@infradead.org>
 <CAMuHMdWup4D9A-giF9xDEhva8PPH4Yhg2NHYx3+0q_=Uoi+iRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWup4D9A-giF9xDEhva8PPH4Yhg2NHYx3+0q_=Uoi+iRA@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:15:49AM +0100, Geert Uytterhoeven wrote:
> On Fri, Nov 27, 2020 at 4:18 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > It looks like SPARC64 requires FB_ATY_CT to build without errors,
> > so have FB_ATY select FB_ATY_CT if both SPARC64 and PCI are enabled
> > instead of using "default y if SPARC64 && PCI", which is not strong
> > enough to prevent build errors.
> >
> > As it currently is, FB_ATY_CT can be disabled, resulting in build
> > errors:
> >
> > ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> > ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> >
> > Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to drm-misc-next, thanks for the patch&review.
-Daniel

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
