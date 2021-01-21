Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF502FE51A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhAUIfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbhAUIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:33:42 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:33:01 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p5so1341547oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uX11i9ntHKvjXSr2VUaKfVVivjbrt/oL5DMR5Av1mfQ=;
        b=Waj5/Hh9QiVwxjR4nEz5y7b01uPWEmRMy/6wqmXtXcfpKDHMGBiKtBZRZfHBNYRvsS
         8G1lfiJ1/4cmnM3eKji6pjpCYGh9STOXBBPHdEQmT3Q3g3wWwmGnWDoYL56mbi1XU2iI
         bpUQccinaAKzE9oQk31XcfFtfv6GDskoDLYNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uX11i9ntHKvjXSr2VUaKfVVivjbrt/oL5DMR5Av1mfQ=;
        b=oekJ3N1ycg1/AOEYsyxKd28YbrCYGjDSl0zoBeC1oeNCeE0uME8lwMaC4dcbUOmvvI
         du78ZljDC5hBsv3lwnoE/Q8frWw6Apm8Z4DJ3VFGt0E57KPw25Txc+PiBIXUQu5o613w
         aHVJFCr0E0DrY75jL7cqdT1UfI4k7YAm2mIcyHpD4jcWYi/Vwz8HZkNRqDNFMQoNOLQx
         VNQOCRJP+HsgkDXtTYgbAw9pyVnEdmkhG9+/gQYGG2gbOX8vmiJeX3IovFwmlbx5QGJ6
         Jl1fX/xKKoLhnxYzX4yzdwC6WeRZ4dRZfxgsHMfYkXsxX4/MmPZJZgFy0K4aB1xCh1my
         9GmA==
X-Gm-Message-State: AOAM530lDO7iqvVPZga2S6VGVV+y9LgZC9DUqhesuHxQGShwuDvdqEuX
        iZ6IlcNbnyWZhO75zS0+QeWL/7T0Pv6BhPMX7ww6AD+pwwweDA==
X-Google-Smtp-Source: ABdhPJw+4IsAgRHo2MtvXqtNHIi15f7EcB4J/2s7VVzDrmrcmIIQo+1zUjeULyIuUrzgvFuyBO2o90wnLGPb4+F9yEY=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr5164573oia.14.1611217981254;
 Thu, 21 Jan 2021 00:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20210115120014.4211dec6@canb.auug.org.au> <20210120171501.61aa0786@canb.auug.org.au>
 <20210121115341.012c1a55@canb.auug.org.au> <CADnq5_PuH6RNpkAKfUD011rDEXCRd5-0_ad0Rv40k_2gqiQaYA@mail.gmail.com>
In-Reply-To: <CADnq5_PuH6RNpkAKfUD011rDEXCRd5-0_ad0Rv40k_2gqiQaYA@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 21 Jan 2021 09:32:50 +0100
Message-ID: <CAKMK7uF8U8X54DFjRpovw1UO6B2xv16nzBrX1t2HQ6bZOmskcw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the amdgpu tree
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 4:07 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jan 20, 2021 at 7:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > On Wed, 20 Jan 2021 17:15:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Fri, 15 Jan 2021 12:00:14 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > >
> > > > After merging the amdgpu tree, today's linux-next build (x86_64
> > > > allmodconfig) failed like this:
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'dm_set_vblank':
> > > > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5380:33: warning: unused variable 'dm' [-Wunused-variable]
> > > >  5380 |  struct amdgpu_display_manager *dm = &adev->dm;
> > > >       |                                 ^~
> > > >
> > > > Caused by commit
> > > >
> > > >   98ab5f3513f9 ("drm/amd/display: Fix deadlock during gpu reset v3")
> > >
> > > I am still getting this warning.
> >
> > I now get this warning from the drm tree merge.

Drat, I missed that when merging.

> Bhawan sent out the fix today:
> https://patchwork.freedesktop.org/patch/415092/

Applied directly to drm-next, thanks.
-Daniel

>
> Alex
>
> >
> > --
> > Cheers,
> > Stephen Rothwell
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
