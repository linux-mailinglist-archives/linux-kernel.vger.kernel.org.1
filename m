Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEBB2F5CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbhANJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbhANJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:11:53 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EEEC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:11:13 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d8so4585946otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1QrDVL3JghRKNRHXL12rqtEE0tKj2MqpWK7d7Dp7koU=;
        b=j27X4dwjO4Ly94sasNgINsUIh1NWEsF5UTfak9x5atHAeWWZiIbuaLwkiXiyHR4lHC
         2nQXhfulw5ihbAKgOjlO32328eHJ98wHGC3O3Tms28ltWSytb+hNjW6GzhnnBj9Ws/I/
         v9vITQfeAskAHWoUudBGMewa24VNZNWjqsIyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QrDVL3JghRKNRHXL12rqtEE0tKj2MqpWK7d7Dp7koU=;
        b=X0Yi8LfNuCHM+opifvoyHWOP7UfWasZfRwd6hXvTpaAkRV1p4+H6tnpH2yssOT3sj3
         aC/Al+OBufjQ/Nqvjcp0HaZMrfiOd+vU3AkhDVcBYFJ9qEOMMi4theLfcsW2BPKI2l/E
         ym9NgB1AHcJzui/Qd5iVf3ooxS9J5hx81y4P5QMbQ3n0Xn/247qplG6aYnzitMuY0ft2
         ZPzPZ8jyA3w7eG6I4HFe9hnoW29rlWCXutgETSPt7e8v7PlKq97U7LtaLJNpYPP+/q84
         FrL+mnKhxVh3WEExEjYiT8Xl6Q4iuWD6PjAQ31LjDkL1swh3Fus9x/NGG+Zob1lPuPZq
         I2qA==
X-Gm-Message-State: AOAM531D55ZLS4KljbuksP9DEBxeDUrI2yVTPkpCBnEP9laYa6/lzcAG
        WFoB/mYft9KXo8R/cF8Om83vIPosRnIlPCdBP/gTSw==
X-Google-Smtp-Source: ABdhPJzCOWPyVHkXXcDvYk5dCjB0QhimhzZ6T8IE/czFeItPQR0TAeKiu6z7JidRPyHoe2BOUth2Y9ayNic9tvMeU0U=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr4050934otb.281.1610615472722;
 Thu, 14 Jan 2021 01:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20210113145009.1272040-1-lee.jones@linaro.org>
 <20210113190118.GA180942@ravnborg.org> <20210113202546.GG3975472@dell> <877dofriss.fsf@intel.com>
In-Reply-To: <877dofriss.fsf@intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 14 Jan 2021 10:11:01 +0100
Message-ID: <CAKMK7uEU32=Sw4F6b4RzkX0Y6svVn0nL+b6cm6e6KYN8bni_SQ@mail.gmail.com>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from Video
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Anthony Tong <atong@uiuc.edu>, Alex Kern <alex.kern@gmx.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Software Engineering <lg@denx.de>,
        Paul Mundt <lethal@chaoticdreams.org>,
        Frodo Looijaard <frodol@dds.nl>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        James Simmons <jsimmons@users.sf.net>, Urs Ganse <ursg@uni.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Helge Deller <deller@gmx.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Ani Joshi <ajoshi@unixbox.com>,
        Emmanuel Marty <core@ggi-project.org>,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        daniel.mantione@freepascal.org, carter@compsci.bristol.ac.uk,
        Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Eddie C. Dost" <ecd@skynet.be>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        "Thomas J. Moore" <dark@mama.indstate.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Fremlin <vii@users.sourceforge.net>,
        Ilario Nardinocchi <nardinoc@cs.unibo.it>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Jakub Jelinek <jj@ultra.linux.cz>,
        William Rucklidge <wjr@cs.cornell.edu>,
        Antonino Daplas <adaplas@pol.net>,
        Brad Douglas <brad@neruo.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Philip Edelbrock <phil@netroedge.com>,
        Jim Hague <jim.hague@acm.org>,
        Egbert Eich <Egbert.Eich@physik.tu-darmstadt.de>,
        Jes Sorensen <jds@kom.auc.dk>,
        Gerd Knorr <kraxel@goldbach.in-berlin.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Oliver Kropp <dok@directfb.org>, Martin Mares <mj@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>, Hannu Mallat <hmallat@cc.hut.fi>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:04 AM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> On Wed, 13 Jan 2021, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 13 Jan 2021, Sam Ravnborg wrote:
> >
> >> Hi Lee,
> >>
> >> On Wed, Jan 13, 2021 at 02:49:38PM +0000, Lee Jones wrote:
> >> > This set is part of a larger effort attempting to clean-up W=1
> >> > kernel builds, which are currently overwhelmingly riddled with
> >> > niggly little warnings.
> >> >
> >> > This patch-set clears all of the W=1 warnings currently residing
> >> > in drivers/video.
> >>
> >> I am sorry to say that I expect most of your nice patches to clash
> >> with patches that is already present in drm-misc-next.
> >>
> >> drivers/video/ are warning free with W=1 in drm-misc-next today.
> >>
> >> I do not know why drm-misc-next is not yet pullled into linux-next.
> >
> > Well that kinda sucks.  What are the chances of that?
> >
> > Most of my patches fix issues that have been there for years!

I planned to go through them all today, let's see what's still needed.

> We auto-update the for-linux-next and for-linux-next-fixes branches, and
> they seem to be up-to-date [1].

It only happened last week instead of right after -rc1 due to some
confusion, but it should have been in linux-next for a few days
already.

> How recent are the fixes, maybe because of this: [2]?
>
> BR,
> Jani.
>
>
> [1] https://cgit.freedesktop.org/drm/drm-misc
> [2] http://lore.kernel.org/r/20210114113107.622102e0@canb.auug.org.au

Patch for that just got committted, so this shouldn't be too big a
window for drm-misc-next to be excluded should have been very small.
-Daniel

>
> --
> Jani Nikula, Intel Open Source Graphics Center
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
