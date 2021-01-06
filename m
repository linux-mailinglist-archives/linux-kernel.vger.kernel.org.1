Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182322EBD43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbhAFLkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:40:16 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39619 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbhAFLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:40:10 -0500
Received: by mail-lf1-f48.google.com with SMTP id a12so5834400lfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 03:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=einBe1Mqw7hvQ/lyKqeQNbgAjBHlOanQqIUAzyAn2Yo=;
        b=dVTQVHrALMPOrJ/EzBb3iv3Sp763B6JiH1O1MSoPJvR4sa4aQQr8ofMX5qSlOTAGfF
         PycV1AEK3L58odS5D02DdRbclZSa8Te7KPmHjQnzYqGGANGa+cdDk4UoibmBh0+rLXix
         /Pv1DOENM9bwEGAkFRnbCMc6iFuoMFgzos4RtGYv1GguqmtWFspgoXm7eABaKxl5G/1u
         WxEPD+YJu+ykKO9wGzPMtrak8QQWCxPuo6Ml3WWSzAYsNfNCJ1c2rXAqfng7HttaN6tb
         fHU3pCM3SlqvdlZ4GaRTEKUFvBBVDvnwSaPjtIDTV5RCCL5lXtBFnvNpWu8yT2eZmxxV
         sNdA==
X-Gm-Message-State: AOAM530yttFP9KIf0ZOAw2d0lEw+c5OQLIKdREe1/cPZQQefgYTHV5en
        CBCauXoaig3XYiXggh3Ki+quY4mzLa1wyQ==
X-Google-Smtp-Source: ABdhPJyTK/vU055+EuLNnctoEVeZRB5EAIrluv/2T7Dn2Omg+W8aA8Hgdfl6XSPdidbXCmNorEOYVA==
X-Received: by 2002:a05:6512:2e9:: with SMTP id m9mr1687019lfq.118.1609933167409;
        Wed, 06 Jan 2021 03:39:27 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k20sm314273ljc.61.2021.01.06.03.39.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 03:39:26 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id m12so5824155lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 03:39:26 -0800 (PST)
X-Received: by 2002:a19:c783:: with SMTP id x125mr1715893lff.303.1609933166423;
 Wed, 06 Jan 2021 03:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20210103110635.34823-1-samuel@sholland.org> <20210106104958.k4ooczptqjgdrbfd@gilmour>
In-Reply-To: <20210106104958.k4ooczptqjgdrbfd@gilmour>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 6 Jan 2021 19:39:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dycZ1_pnT0YRx8Y1d3am7dpYcyGvEC=js_migNyLqew@mail.gmail.com>
Message-ID: <CAGb2v66dycZ1_pnT0YRx8Y1d3am7dpYcyGvEC=js_migNyLqew@mail.gmail.com>
Subject: Re: [PATCH 0/4] bus: sunxi-rsb: Implement power managment
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 6:50 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi!
>
> On Sun, Jan 03, 2021 at 05:06:31AM -0600, Samuel Holland wrote:
> > This series adds system (complete power down) and runtime (clock gate)
> > PM hooks to the RSB controller driver. Tested on A64 and H6.
> >
> > Samuel Holland (4):
> >   bus: sunxi-rsb: Move OF match table
> >   bus: sunxi-rsb: Split out controller init/exit functions
> >   bus: sunxi-rsb: Implement suspend/resume/shutdown callbacks
> >   bus: sunxi-rsb: Implement runtime power management
> >
> >  drivers/bus/sunxi-rsb.c | 211 ++++++++++++++++++++++++++++------------
> >  1 file changed, 150 insertions(+), 61 deletions(-)
>
> For the whole series,
>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks! Pushed out to kernel.org.
