Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB72329D764
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbgJ1WXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbgJ1WXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1EAC0613CF;
        Wed, 28 Oct 2020 15:23:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id l2so853169lfk.0;
        Wed, 28 Oct 2020 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KjbxQEkg9QA1o/E7c1m2TX9Jq7W/b3iFj6FdzJ/ZjE=;
        b=sUpOJDTkNaLBJDvzrFEZJJCarTzrhwOlreub6zH/9tnWfnyQSS/WP+Nd+2EoOPMQVY
         7CsLQzbFwTY1TuzY1mTTwFwWYQxgG8r3Z/p/e/Rd4igrbPiWGhHlYGX+aPYPPfpf+vlf
         SoLgMCIgGgfh5GXcHmMH9syaGrbUcvkXHFZSl4c6C74nfmnQi00VGxxzi5ujC0GfhOXu
         +SVs3AnKWam/d+h5SsClRY0EH9q6UA1LvwRNQGUtA/QnuAOmb2YeMOz5/pFIQbiN4yJC
         t5Ie78mGtT2Z1mbnTm88YOoHubHAVoPIh1CjC637tcJ9rDHiBYNQmuJ4KnVKlDTw96o0
         zjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KjbxQEkg9QA1o/E7c1m2TX9Jq7W/b3iFj6FdzJ/ZjE=;
        b=MdSO1EcMWWLXjzgT3jTXLt+muMnrhGUD3wS3aMsOMp/T9rj8XEmWC+n5EAubZpdyS0
         HxStwQdt0Yd0ptmYpazpx+eJG5L8RdgVHBKYY8tFsqNj4bjte/v073JmGkGp9fgEQ0Yp
         26P+572oGw+DbMihqnljbMnckSHTOP6eyAZHA6p2dsYQzFk5FTHGBhh9Ayz3mGmWSdMA
         281nObNZpKk9sU1RnOG3SUkPBpyzXNch/HbPx0/+xaoaycVL/hmEDOIBtVQ80dVd7HkG
         CbS7jR/rcUz+xXv0RD5J1BsSMoa8gwpe1yKX3YlzrVBIz5iFGnB9CN5ZbDJ8wnhRnrDX
         MUdw==
X-Gm-Message-State: AOAM532D8AfHhiJRYM4oPYyXGUPUfo5mXBpQrKbkXV4bcT2xUjZfs1gQ
        3x2uoHJ6SkbNDrtQCkN0i1ELVU4JCudjIHiWSLApUx0/fklTvQ==
X-Google-Smtp-Source: ABdhPJwTpcx2ILDMoOSAHFWBR7y5FILG4WAR9ukBLbcCRJsVi7I/4AwRORXJ+EqcACwWZ40LD+UhTUnPzmDqfgD9oyk=
X-Received: by 2002:a17:906:53d7:: with SMTP id p23mr7135255ejo.232.1603887356260;
 Wed, 28 Oct 2020 05:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200715115412.2544-1-frank@allwinnertech.com>
 <20200717160727.e6y5htg4sjd7bezi@gilmour.lan> <db1908ae-817c-f30d-7b88-f4afa593b258@sholland.org>
 <20200729130637.5md3tr6zg7s4wrmh@gilmour.lan>
In-Reply-To: <20200729130637.5md3tr6zg7s4wrmh@gilmour.lan>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 28 Oct 2020 20:15:45 +0800
Message-ID: <CAEExFWstKV_uMbh5iQ9ULX7=24aj0_6Ge+4uFe07WmwiyDDRMA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_1=2F3=5D_dt=2Dbindings=3A_gpio=3A_sunxi=EF=BC=9Acreate_a_?=
        =?UTF-8?Q?DT_header_for_Allwinner_pin_controller?=
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 9:06 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Sat, Jul 25, 2020 at 02:18:39PM -0500, Samuel Holland wrote:
> > On 7/17/20 11:07 AM, Maxime Ripard wrote:
> > > Hi!
> > >
> > > On Wed, Jul 15, 2020 at 07:54:12PM +0800, Frank Lee wrote:
> > >> From: Yangtao Li <frank@allwinnertech.com>
> > >>
> > >> The sunxi gpio binding defines a few custom cells for its gpio specifier.
> > >> Provide bank name for those.
> > >>
> > >> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> > >
> > > Thanks for working on this, I wanted to do it at some point but it kept
> > > getting pushed further into my todo list.
> > >
> > >> ---
> > >>  include/dt-bindings/gpio/sunxi-gpio.h | 29 +++++++++++++++++++++++++++
> > >>  1 file changed, 29 insertions(+)
> > >>  create mode 100644 include/dt-bindings/gpio/sunxi-gpio.h
> > >>
> > >> diff --git a/include/dt-bindings/gpio/sunxi-gpio.h b/include/dt-bindings/gpio/sunxi-gpio.h
> > >> new file mode 100644
> > >> index 000000000000..c692b4360da6
> > >> --- /dev/null
> > >> +++ b/include/dt-bindings/gpio/sunxi-gpio.h
> > >
> > > So generally we've been using the compatible name as the file name. You
> > > should follow that convention too, and since it was added with the A10,
> > > using the A10 compatible.
> > >
> > >> @@ -0,0 +1,29 @@
> > >> +/* SPDX-License-Identifier: GPL-2.0 */
> > >> +/*
> > >> + * GPIO definitions for Allwinner SoCs
> > >> + *
> > >> + * Copyright (C) 2020 Yangtao Li <frank@allwinnertech.com>
> > >> + */
> > >> +
> > >> +#ifndef _DT_BINDINGS_SUNXI_GPIO_H
> > >> +#define _DT_BINDINGS_SUNXI_GPIO_H
> > >> +
> > >> +#include <dt-bindings/gpio/gpio.h>
> > >> +
> > >> +/* pio */
> > >> +#define PA        0
> > >> +#define PB        1
> > >> +#define PC        2
> > >> +#define PD        3
> > >> +#define PE        4
> > >> +#define PF        5
> > >> +#define PG        6
> > >> +#define PH        7
> > >> +#define PI        8
> > >> +
> > >> +/* r-pio */
> > >> +#define PL        0
> > >> +#define PM        1
> > >> +#define PN        2
> > >> +
> > >> +#endif /* _DT_BINDINGS_SUNXI_GPIO_H */
> > >
> > > Maybe we can go one step further and use a macro to have something like
> > > PIN(A, 12) ?
> >
> > Since we have separate cells for the bank and pin, I don't think it would be
> > appropriate to have a single macro generating both.
>
> Yeah, but it's "just" an encoding issue though, it's not a major concern
> if it makes our life easier.
>
> > And I'm not sure what the benefit of the macro would be, if all it
> > does is forward its arguments. Are you concerned that P[A-M] could
> > conflict with something else in the device tree?
>
> There's indeed a bunch of names that are fairly generic and could be
> conflicting with others (PD for power domain is the first one that comes
> to my mind). Using a prefix would make the GPIO descriptors pretty long,
> so it wasn't ideal either. A macro makes it readable without increasing
> too much the risks of conflicts

I tried to use macros, but failed.

I have a look at some other GPIO macros, which have a prefix in front of them.
Maybe we can do the same? It's all numbers. It's not intuitive.

Yangtao
