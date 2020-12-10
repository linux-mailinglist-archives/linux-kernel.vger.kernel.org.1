Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830542D6B63
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbgLJXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732423AbgLJW71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 17:59:27 -0500
X-Gm-Message-State: AOAM531FCbjQPYUdz0bd6fYcLNeMHkVclKRlMTRrH7i4BlpiLYqPimQR
        1ftsfJxr2CB07NlL4nbdiRYhajjAmYL8+Vzi9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607639681;
        bh=OGim0nUmmFrhwRPTUiMdWCclYojhxjLVbOmmtJU4csU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pIzEUMdDngDPEPv1mxXK3P8k1MqGQ7IN6Hzi9TfM1duXUnxWlP2Atfr6EPBjpjVIo
         83NMie0udPEshI50YQu1c/BSvr7xTQ4sz06xcjkjQElOgVxylOSBShws30NUSqfPPK
         gC8Si7qqgDqhQeW8PhZGAu2rRqKaUUyjukjsaLLZKRzCs54ggN+LbVXD4FLSLsVklg
         delcrLz06oi3b01RlG5HPJ9CSMR0+jot87TcAp4eKCdezQchXcI3lvuk/A04TDDN4y
         hvQdi0REGHKptG4mNC7sZXR0aBahaVdJDD94YgpLSMG/mHhOnEOFV1G2cghbzDiBNL
         sT9SJHJpsxoGg==
X-Google-Smtp-Source: ABdhPJyTeI4Fqqlgkg8TfgiNC7IGq3b3XP/pJwOIHVSU/+bD3CpvBX8H6BjP2pJF0xW3VGAOfGYUAz+3FJJN4crEEgE=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr9276310edy.194.1607639679585;
 Thu, 10 Dec 2020 14:34:39 -0800 (PST)
MIME-Version: 1.0
References: <20201124121842.1037035-1-jonathanh@nvidia.com>
 <20201207231352.GA1028809@robh.at.kernel.org> <X8+FCbks0dax2L4J@ulmo>
In-Reply-To: <X8+FCbks0dax2L4J@ulmo>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Dec 2020 16:34:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLzzWAmJ-hwgxZv6utpiGnsVTWvWjgV+Gn0L8XRVFBxGQ@mail.gmail.com>
Message-ID: <CAL_JsqLzzWAmJ-hwgxZv6utpiGnsVTWvWjgV+Gn0L8XRVFBxGQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Correct GV11B GPU register sizes
To:     Thierry Reding <treding@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 7:52 AM Thierry Reding <treding@nvidia.com> wrote:
>
> On Mon, Dec 07, 2020 at 05:13:52PM -0600, Rob Herring wrote:
> > On Tue, 24 Nov 2020 12:18:42 +0000, Jon Hunter wrote:
> > > Commit 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> > > added the GV11B GPU device-tree bindings information but incorrectly
> > > added an additional 0 to the size of the addresses in the example.
> > >
> > > Fixes: 90a09178f309 ("dt-bindings: Add documentation for GV11B GPU")
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >  Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> >
> > Applied, thanks!
> >
> > But really, it's just an example and rather than fix trivial things in
> > txt bindings, convert them to schema please.
>
> The conversion to schema of this binding was part of a series I sent out
> earlier this year converting a bunch of Tegra-related bindings. At the
> time you had requested that rather than converting one binding after
> another it might be easier to review if whole directories were converted
> at a time.

That's largely just because the issues tend to be the same (both doing
the conversion and reviewing it).

> I've been struggling to find time to do so, so I wonder if you'd prefer
> me to send out that series again, or perhaps in smaller chunks? That
> sounds better than not doing any conversions at all because I lack the
> time to do whole directories at once.

The whole series is fine.

Rob
