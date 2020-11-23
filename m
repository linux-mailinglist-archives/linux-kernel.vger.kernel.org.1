Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE42C028A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKWJvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:51:38 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:51:38 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id c80so19062222oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=728drbmfpSOfgNwr2SHggiRFvZplFRXowT2/IwDi3MA=;
        b=aZmfbQS5bOq7GKshLqmpzvbj9JqRIZg+SQ6+JXjk006NODOiJvOc9K0ThqI9EeJ0Ss
         kpJ3Oixwd4FyEweXjrMI69FfahUjsSmqhl/Zka8+LwLsuPsscTUQelh8K9iGVNQHqIdA
         7JL/fyCgL4PV8RyQ5VxsFOKao6chb6kp6twMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=728drbmfpSOfgNwr2SHggiRFvZplFRXowT2/IwDi3MA=;
        b=WP5ORIvixp9qQWxE7ibApujd6Dh2ScPYSqgdYExP8XSB7gIwfL4nu2S11KQiet/Zga
         E/FEr7B0XD8kDRWIfwKr4I772sBcp2sPYy4RYCm3tbWBZlBrP04eWkev9rP0G/UI3ivN
         RjtSUSn2CNspFtn0ncv72b1SqqGQcrvov1cuLpTQxNX0VLKehoppqqa0lkerIFV1Pd8T
         JGhQlxeEqMvfcvjh6dALTOBTtJDvTFZHHW35wYIcvsW0N7IWADq8wmOfQceXh0xvjbcK
         MTht35F4nnANMtpcz8ZROm7Du9VKdgzjcrIpMIUR71aX2Z18UswqaG1zupF+6pzQd2uT
         1e5w==
X-Gm-Message-State: AOAM530uGyqzlm7fzY+XVMh7zMlIpcjj2lpI1JH2s7rsHaxK+olRBB7y
        nu7xyuUk6Dqznao7HbG0Jo0tLF54B1p9x1KJ/2BSZ3ZyDLY=
X-Google-Smtp-Source: ABdhPJz66bLEmQYNG5dQJaXv0p24rXXX0adIcxsC4vA3n6gZsVDrskubfwiQzARt62M0gUBQfr2zgbuk5o/zH1ExS14=
X-Received: by 2002:aca:1713:: with SMTP id j19mr13385242oii.101.1606125097243;
 Mon, 23 Nov 2020 01:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20201120152338.1203257-1-ccr@tnsp.org>
In-Reply-To: <20201120152338.1203257-1-ccr@tnsp.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 23 Nov 2020 10:51:25 +0100
Message-ID: <CAKMK7uGDY+aLP-yYwyW5t-usUK3XM-oU9ZLHm1_jU0BTjJUN+g@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: fix relocations applying logic and a double-free
To:     Matti Hamalainen <ccr@tnsp.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 4:23 PM Matti Hamalainen <ccr@tnsp.org> wrote:
>
> Commit 03e0d26fcf79 ("drm/nouveau: slowpath for pushbuf ioctl") included
> a logic-bug which results in the relocations not actually getting
> applied at all as the call to nouveau_gem_pushbuf_reloc_apply() is
> never reached. This causes a regression with graphical corruption,
> triggered when relocations need to be done (for example after a
> suspend/resume cycle.)
>
> Fix by setting *apply_relocs value only if there were more than 0
> relocations.
>
> Additionally, the never reached code had a leftover u_free() call,
> which, after fixing the logic, now got called and resulted in a
> double-free. Fix by removing one u_free(), moving the other
> and adding check for errors.
>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Matti Hamalainen <ccr@tnsp.org>
> Fixes: 03e0d26fcf79 ("drm/nouveau: slowpath for pushbuf ioctl")
> Link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/11

Link: is for the mailing list submission of the patch itself (to link
the git log to the mailing list discussions), this should be
References: or similar. Aside from this:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Ben, I'm assuming you'll push this through your tree.
-Daniel


> ---
>  drivers/gpu/drm/nouveau/nouveau_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 549bc67feabb..c2051380d18c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -558,8 +558,10 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
>                         NV_PRINTK(err, cli, "validating bo list\n");
>                 validate_fini(op, chan, NULL, NULL);
>                 return ret;
> +       } else if (ret > 0) {
> +               *apply_relocs = true;
>         }
> -       *apply_relocs = ret;
> +
>         return 0;
>  }
>
> @@ -662,7 +664,6 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
>                 nouveau_bo_wr32(nvbo, r->reloc_bo_offset >> 2, data);
>         }
>
> -       u_free(reloc);
>         return ret;
>  }
>
> @@ -872,9 +873,10 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
>                                 break;
>                         }
>                 }
> -               u_free(reloc);
>         }
>  out_prevalid:
> +       if (!IS_ERR(reloc))
> +               u_free(reloc);
>         u_free(bo);
>         u_free(push);
>
>
> base-commit: 3494d58865ad4a47611dbb427b214cc5227fa5eb
> --
> 2.29.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
