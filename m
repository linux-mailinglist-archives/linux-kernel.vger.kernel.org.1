Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96AC294AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438425AbgJUJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:58:23 -0400
Received: from smtp2.axis.com ([195.60.68.18]:2804 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438399AbgJUJ6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1614; q=dns/txt; s=axis-central1;
  t=1603274302; x=1634810302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0uunYDarLOCJQZDPzFnBlNCfPwBebHlyjXfwWLNZ7OI=;
  b=RW+g6QTHNS1SONtKPLNRev6bD/KX3Yh2Rld7xF59CtbjAYr9D2PHsIFR
   6YtE8NrIwm9bHTy7tqAyUHoLnfdfIHdGo7UkuW15XLU/iTg5rFUve7+Pi
   gXrQ4d+j4MirRqA7kJPx5jfm0/tyco8zHr5xptGYJvRo8+rVD5UoXrj4j
   sTFXEx3O09wPYSBGnq99SaOL7f04TJDl5LBhGAnrkXQRIaQG2VasQSM9E
   GWaycAbxjg2grzOE3RtWJwnFC1ozIgEH9l1XB29PazpipTYvMVPjAYgUR
   e+X/8LwaMU8HB18w9p8CW6LvLGS1GlvbCSAFI50UapgqkwVUPKh9boKMa
   A==;
IronPort-SDR: nYtZPDdCJr/zt644280jfPTyAlH8CnViDMCXXT1IT8lWHG3AWvXTfddGXf0rVQLU3z3r7xsjQI
 DNaOLhdKuW1NwONjVFoiv2OP817H6hij+lfZVsVDPYFr+koVodZtLvOwdQTTcdsmWFh3WQsWvi
 q1BxWLFgXIdjIEjtE5v7ONYbEGUaT359iTVgZ6tgLAOp+7QcuvnVqGnb0A+Fvvqf39fy2Xl7xz
 lRGa+efHe31sXwSZbrkCZEmuIqsEUi2wt15W9POCAjOppufLUI3QVLKeQm1n5XAI4pF2dV2p4b
 M8A=
X-IronPort-AV: E=Sophos;i="5.77,401,1596492000"; 
   d="scan'208";a="13744378"
Date:   Wed, 21 Oct 2020 11:58:20 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>, kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of: Fix reserved-memory overlap detection
Message-ID: <20201021095820.fe2u5cecxtkupqko@axis.com>
References: <20201020073558.3582-1-vincent.whitchurch@axis.com>
 <CAL_JsqL=mpw9KxiYe_bMa+y4mU8ybrRnJ2LcO8jRco9C3N_n_w@mail.gmail.com>
 <20201020134633.3vv7hyvodg4tbro2@axis.com>
 <CAL_JsqJrM4mS+tRDjipEQ8HBGgoevWHzGBWCiioMAFLnBRb63Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJrM4mS+tRDjipEQ8HBGgoevWHzGBWCiioMAFLnBRb63Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 04:17:27PM +0200, Rob Herring wrote:
> On Tue, Oct 20, 2020 at 8:46 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > On Tue, Oct 20, 2020 at 03:00:14PM +0200, Rob Herring wrote:
> > > On Tue, Oct 20, 2020 at 2:36 AM Vincent Whitchurch
> > > <vincent.whitchurch@axis.com> wrote:
> > > >
> > > > The reserved-memory overlap detection code fails to detect overlaps if
> > > > either of the regions starts at address 0x0.  For some reason the code
> > > > explicitly checks for and ignores such regions, but this check looks
> > > > invalid.  Remove the check and fix this detection.
> > >
> > > Wouldn't 'base' be 0 for nodes that have a 'size' and no address? The
> > > base in those cases isn't set until later when
> > > __reserved_mem_alloc_size() is called.
> >
> > Ah, yes, I guess that's why the check was there.  I see that those
> > entries have both a zero address and a zero size, so this seems to work:
> 
> Yes, I think it should work.

Thanks, I've tested it a bit more and sent it out as a v2 now.

> > diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > index 623246f37448..6627e71c7283 100644
> > --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > @@ -81,6 +81,18 @@ vram: vram@4c000000 {
> >                         reg = <0x4c000000 0x00800000>;
> >                         no-map;
> >                 };
> > +
> > +               foo@0 {
> > +                       reg = <0x0 0x2000>;
> > +               };
> > +
> > +               bar@1000 {
> > +                       reg = <0x0 0x1000>;
> 
> 0x1000 base?

I've corrected this in the example in the commit message for v2.
