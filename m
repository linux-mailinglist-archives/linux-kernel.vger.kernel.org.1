Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012332D4182
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgLIL4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbgLIL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:56:55 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:56:14 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id q25so1041645otn.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nac73jJQqwYAxYov3s+USnMs5pJwJ4HIU6DRKUk/10I=;
        b=DShSsknGSTcO5q371O1CRAExcAHKUwPxDf9oK9toeCgNoBIYCyTa75t5R+XoxYkFFB
         8qwuVPODWJ2c0F/Tsf7eEOd7Rbq5HErv2QRSQSBTD8yPfJ/KYl1WzNxgp5ACaz3qETgb
         OJt6GC1HR7wF9PRpFJ22c2EgAC5PS+slv3UPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nac73jJQqwYAxYov3s+USnMs5pJwJ4HIU6DRKUk/10I=;
        b=QGB/ycsOK4S2FWEEoAnBVY89GF2ns5HyRogMc+Y9C93+NOqBV+o4V2z6jVRDZSOxH8
         8aYKogc1SNaTYQmUSgk8f83WNI10zR/psEmXr43zqARW8a7Rws7J/59wjnoImcGWzHbp
         2Az1CES9mS1wqynf5/Y0K+nXyxpG8l9+pSrD7CUBPmDjAf3ptkucU9mk1rs1BHkx/rmN
         ebqqFWN4V5VZtf55CgG/4LJdQ1I/98ogMVl4+YCOXzDtBNsE8WY6ghcuqwRvSRqiQ3/1
         KdIEfvY1Cr3w2w+wD2Kvcj1T6lJNacaNkOIM0aX20TmnWpJi3+fhfo1DsXbUMD7hksyk
         2/VA==
X-Gm-Message-State: AOAM532r/GwI0qpcrJi5PCPY7XxOeaatQtZsDzl9UCX3gNNQqvR40Ou+
        caQp8Wi8ix9cQ4EKsw0aKD/cufYqh7MQ56B4UWgaRw==
X-Google-Smtp-Source: ABdhPJw6OH4BZjXBnN4BhUYKez2px51Lh3nsFIdCJ03taoHzCuFYhQw/XtzIBoIWsImaCPHFBE2+ISwGnoyYO8XmtxI=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr1378061otb.281.1607514974241;
 Wed, 09 Dec 2020 03:56:14 -0800 (PST)
MIME-Version: 1.0
References: <1607413859-63365-1-git-send-email-tiantao6@hisilicon.com>
 <20201209004828.GN401619@phenom.ffwll.local> <06c1dee7-488d-8a74-a55c-74043cb060cd@ti.com>
In-Reply-To: <06c1dee7-488d-8a74-a55c-74043cb060cd@ti.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Dec 2020 12:56:03 +0100
Message-ID: <CAKMK7uFsDPH3+CHGwkgtnDOc6pJY=_SocyaghETZda+RgjAJnQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tidss: Use the new api devm_drm_irq_install
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>, Jyri Sarha <jsarha@ti.com>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 12:29 PM Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> On 09/12/2020 02:48, Daniel Vetter wrote:
> > On Tue, Dec 08, 2020 at 03:50:59PM +0800, Tian Tao wrote:
> >> Use devm_drm_irq_install to register interrupts so that
> >> drm_irq_uninstall is not needed to be called.
> >>
> >> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >
> > There's another drm_irq_install in the error path. But I'm not sure this
> > is safe since you're chaning the order in which things get cleaned up now.
> > So leaving this up to Tomi.
>
> Right, I don't think this works. tidss irq_uninstall uses runtime_get/put, which needs to happen
> before pm_runtime_disable. With devm_drm_irq_install that's not the case.

Hm I don't spot devm_ versions of these, surely we're not the only
ones with this problem?
-Daniel

>  Tomi
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
