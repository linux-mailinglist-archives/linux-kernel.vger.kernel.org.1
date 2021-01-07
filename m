Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698732ECBC9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAGIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:37:11 -0500
Received: from mout01.posteo.de ([185.67.36.65]:53444 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbhAGIhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:37:10 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BA85416006A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:36:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1610008572; bh=YIcrgMu6xr+HD2IV2ZHdi98qC9d9rFzndJxFrBYcbtU=;
        h=Date:From:To:Cc:Subject:From;
        b=TYuvxxmocS865nQmvcIwqno+2JluYeFA2ffdQ6CByzAdJKy0ZYwSKu1xJdQBW8VTi
         WXM8l5VvnI8ukJ5SJnNR6J9+TTI3U8n+uRhOzGQxQK6iEcO4m/eRDsywUPHtSBnHfe
         /+vhtNBGRl9XtI4GoNH6B5j0MSgUv3LIF0+8seMlY/4qNyp2y0IdIh0EFuN7LycKQ/
         29bX+c0FGGUB0zLnOmySoW2i3svaeyXktF7MsrkMJjw7r1pKOUye2tRoVKgBiM3+Mk
         0VLqGhv95+BuCW5+OG7zoLuj2ojz0oEE4gv28faxgzZYwjlcD1ZkQI836tmi4ektIJ
         2z5vDpEPPkJGA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DBKMD5qbQz6tmQ;
        Thu,  7 Jan 2021 09:36:08 +0100 (CET)
Date:   Thu, 7 Jan 2021 09:36:06 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210107093606.2d087970@monster.powergraphx.local>
In-Reply-To: <20210106101436.nrjlgaxsllvotxq3@gilmour>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
        <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
        <CAL_JsqKZ44fDZzvY+Z0J5eMqjxGX3LM=MoJzV9Y7Y7Wisf2bnA@mail.gmail.com>
        <20210106101436.nrjlgaxsllvotxq3@gilmour>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 11:14:36 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> Hi,
> 
> On Wed, Dec 23, 2020 at 03:49:19PM -0700, Rob Herring wrote:
> > On Wed, Dec 23, 2020 at 4:34 AM Wilken Gottwalt
> > <wilken.gottwalt@posteo.net> wrote:
> > >
> > > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > > compatible SoCs.
> > 
> > Please resend to DT list so that automated checks run and it's in my
> > queue (PW). You need to run 'make dt_binding_check' as there are
> > several issues.
> > 
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > ---
> > > Changes in v5:
> > >   - changed binding to earliest known supported SoC sun6i-a31
> > >   - dropped unnecessary entries
> > >
> > > Changes in v4:
> > >   - changed binding to sun8i-a33-hwpinlock
> > >   - added changes suggested by Maxime Ripard
> > >
> > > Changes in v3:
> > >   - changed symbols from sunxi to sun8i
> > >
> > > Changes in v2:
> > >   - fixed memory ranges
> > > ---
> > >  .../bindings/hwlock/sun6i-a31-hwspinlock.yaml | 44 +++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> > > b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml new file mode 100644
> > > index 000000000000..481c5c995ad7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwlock/sun6i-hwspinlock.yaml#
> > 
> > This will fail checks. Wrong filename.
> 
> Also, the name should be the whole compatible, so
> "allwinner,sun6i-a31-hwspinlock.yaml".

Yes, I mixed it up a bit. I was a bit to tired this day. And changing the
names/symbols in the last minute didn't go well either.

> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SUN6I hardware spinlock driver for Allwinner sun6i compatible SoCs
> > > +
> > > +maintainers:
> > > +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > +
> > > +description:
> > > +  The hardware unit provides semaphores between the ARM cores and the embedded
> > > +  companion core on the SoC.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: allwinner,sun6i-a31-hwspinlock
> > > +
> > > +    reg:
> > > +      maxItems: 1
> > > +
> > > +    clocks:
> > > +      maxItems: 1
> > > +
> > > +    resets:
> > > +      maxItems: 1
> 
> And this is not indented properly, it should be at the same level than
> compatible, not under it. Doesn't the meta-schema catch this?

Hmm, yeah, this is odd. I need to check my scripts. The bindings stuff is
clearly not checked.

> Maxime

