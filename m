Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F12C4F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgKZHFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbgKZHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:05:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43142C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:05:14 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so1249474wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ssUyDjxHgveCYHcSneSBCki2wyrxz+WJuAVHLW5ABU=;
        b=FxTEFUH67gsaxH703aaVavAsuhSKkvo8z/ec60AFRrzZRT9zOEETlanfV195SXR3cj
         SZRG+b59KIaQEGtefAFg4LVxVF5BIo2WhHa6aEn059GLC7SGtw2mHbdD5xY0zwHmhgE7
         yDjD017lZTgkTZPQ3gcUXxnLcvF9Kh0BRGf5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+ssUyDjxHgveCYHcSneSBCki2wyrxz+WJuAVHLW5ABU=;
        b=L7pXtDqOv/2QeVGaV7Hl1vLbJyFbxO49nM6xWRnD2J+W+rVQwr93JGiV3fEzu5m6yx
         Rwa2Efw2lHQi5DyqIY8dMo276ESd0WZxykA/xwM1G2VS086IuRHKewyi1jXBaxaaVC+f
         KnVw9p4d9MM5V5yHgLTyyz8DE90g1da3Y3tOb8Ii5K9wN9SoZHzzXDeSC6oT5wrwFqhv
         /MN17sl4Nv++Wsn9q7TKHK9wVMqu+f7YPaaJNKfqMT/3goHtSsR+GIR3jtpPf0g6LItu
         cnS5GisEW0gbjDvfsNZgjy/jp8N6uaJgsSAokWobK6T0Hjc7RRsXsQglXecS8y3j2+Pg
         BoZQ==
X-Gm-Message-State: AOAM530SL1o40EvZzYpn5TIZyvlzGIeGVyHWd8dDpUCRF8dKhMTH4ziC
        0lmmVnp+2xZVHLHPlVnDNPbefQWYcneU2g==
X-Google-Smtp-Source: ABdhPJzpkoO8QKPC6d3ZxgXrjJu4huFOtj4AiQ2JvXSolZ5ScNLTxBfP1RuqNtD6THSN9IgvknpK1g==
X-Received: by 2002:a05:600c:2601:: with SMTP id h1mr1626720wma.35.1606374312862;
        Wed, 25 Nov 2020 23:05:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m3sm7310982wrv.6.2020.11.25.23.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:05:12 -0800 (PST)
Date:   Thu, 26 Nov 2020 08:05:10 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Matti Hamalainen <ccr@tnsp.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/nouveau: fix relocations applying logic and a
 double-free
Message-ID: <20201126070510.GA401619@phenom.ffwll.local>
Mail-Followup-To: Matti Hamalainen <ccr@tnsp.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20201120152338.1203257-1-ccr@tnsp.org>
 <CAKMK7uGDY+aLP-yYwyW5t-usUK3XM-oU9ZLHm1_jU0BTjJUN+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGDY+aLP-yYwyW5t-usUK3XM-oU9ZLHm1_jU0BTjJUN+g@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:51:25AM +0100, Daniel Vetter wrote:
> On Fri, Nov 20, 2020 at 4:23 PM Matti Hamalainen <ccr@tnsp.org> wrote:
> >
> > Commit 03e0d26fcf79 ("drm/nouveau: slowpath for pushbuf ioctl") included
> > a logic-bug which results in the relocations not actually getting
> > applied at all as the call to nouveau_gem_pushbuf_reloc_apply() is
> > never reached. This causes a regression with graphical corruption,
> > triggered when relocations need to be done (for example after a
> > suspend/resume cycle.)
> >
> > Fix by setting *apply_relocs value only if there were more than 0
> > relocations.
> >
> > Additionally, the never reached code had a leftover u_free() call,
> > which, after fixing the logic, now got called and resulted in a
> > double-free. Fix by removing one u_free(), moving the other
> > and adding check for errors.
> >
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: nouveau@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Matti Hamalainen <ccr@tnsp.org>
> > Fixes: 03e0d26fcf79 ("drm/nouveau: slowpath for pushbuf ioctl")
> > Link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/11
> 
> Link: is for the mailing list submission of the patch itself (to link
> the git log to the mailing list discussions), this should be
> References: or similar. Aside from this:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Ben, I'm assuming you'll push this through your tree.

Ok Dave asked me to just push it into drm-misc-fixes.

Thanks for your patch!
-Daniel

> -Daniel
> 
> 
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_gem.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > index 549bc67feabb..c2051380d18c 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > @@ -558,8 +558,10 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
> >                         NV_PRINTK(err, cli, "validating bo list\n");
> >                 validate_fini(op, chan, NULL, NULL);
> >                 return ret;
> > +       } else if (ret > 0) {
> > +               *apply_relocs = true;
> >         }
> > -       *apply_relocs = ret;
> > +
> >         return 0;
> >  }
> >
> > @@ -662,7 +664,6 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
> >                 nouveau_bo_wr32(nvbo, r->reloc_bo_offset >> 2, data);
> >         }
> >
> > -       u_free(reloc);
> >         return ret;
> >  }
> >
> > @@ -872,9 +873,10 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
> >                                 break;
> >                         }
> >                 }
> > -               u_free(reloc);
> >         }
> >  out_prevalid:
> > +       if (!IS_ERR(reloc))
> > +               u_free(reloc);
> >         u_free(bo);
> >         u_free(push);
> >
> >
> > base-commit: 3494d58865ad4a47611dbb427b214cc5227fa5eb
> > --
> > 2.29.2
> >
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
