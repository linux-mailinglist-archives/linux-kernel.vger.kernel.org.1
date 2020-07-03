Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0521392E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 13:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGCLN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 07:13:29 -0400
Received: from vps.xff.cz ([195.181.215.36]:40748 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCLN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593774803; bh=PK9XQwVLZikvPIqIQvVj+rgD6Y+uR8PxJm+ULrZzNEY=;
        h=Date:From:To:Subject:References:X-My-GPG-KeyId:From;
        b=S7oWV+ePVh3bfJXlbi+307IscRv04ljcgUCHfqikI/1D//XWGqaz4mN46BGZAazVj
         5bdCe0vCNFUu1n/lHJ7onleN+X9HghCqqMprndSR8s+JCw/aKbIpo8LQ8SKVK0q3vR
         b1gDz1xB4J3mN4HoEExzY3QakP/cqkk5MQuGnFsE=
Date:   Fri, 3 Jul 2020 13:13:23 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, Bhushan Shah <bshah@kde.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-sunxi@googlegroups.com, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 02/13] dt-bindings: panel: Convert rocktech,
 jh057n00900 to yaml
Message-ID: <20200703111323.zcmv3cuo7toa4d3g@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, Purism Kernel Team <kernel@puri.sm>,
        Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, Bhushan Shah <bshah@kde.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-sunxi@googlegroups.com, Luca Weiss <luca@z3ntu.xyz>,
        Martijn Braam <martijn@brixit.nl>, Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20200701162928.1638874-1-megous@megous.com>
 <20200701162928.1638874-3-megous@megous.com>
 <20200702205143.GA1670522@bogus>
 <20200702210354.562wkzpdmyrlwojx@core.my.home>
 <20200703051155.GA1685118@ravnborg.org>
 <20200703104448.iwhxk77d2hyrr3x5@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703104448.iwhxk77d2hyrr3x5@core.my.home>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 12:44:48PM +0200, megous hlavni wrote:
> Hello Sam,
> 
> On Fri, Jul 03, 2020 at 07:11:55AM +0200, Sam Ravnborg wrote:
> > Hi Ondrej.
> > 
> > > > My bot found errors running 'make dt_binding_check' on your patch:
> > > > 
> > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: '#address-cells', '#size-cells', 'port@0' do not match any of the regexes: 'pinctrl-[0-9]+'
> > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'vcc-supply' is a required property
> > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'iovcc-supply' is a required property
> > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/nwl-dsi.example.dt.yaml: panel@0: 'reset-gpios' is a required property
> > > 
> > > Paths look bogus ^^^^
> > > 
> > > It should be .../rocktech,jh057n00900.yaml: ...
> > 
> > The example in nwl-dsi.yaml contains:
> > 	compatible = "rocktech,jh057n00900";
> > 
> > So the example is checked against your updated binding.
> > And the binding check fails because the example is no longer valid.
> 
> Ah, now I understand.
> 
> > This needs to be fixed as we do not wat to introduce new errors.
> > Either the example or the binding needs the fix.
> 
> I think we can unrequire the supplies, but reset is needed really.

Hmm, that's probably wrong kind of thinking. Panel has the supplies, and
obviously requires them, so the dts must describe them somehow, even if
they are the fixed supplies. So I'll not unrequire them.

> The panel only has one port, so there should be no address/size-cells
> in the example, and port@0 should be just port to match existing binding.
> If it had  multiple ports, port@0 would have to be inside ports { } node
> anyway, according to the existing binding. Then add reset-gpios to
> the example...
> 
> And that should fix it.
> 
> I'll prepare the patch shortly.
> 
> regards,
> 	o.
> 
> > 	Sam
> > 
> > 
> > > 
> > > regards,
> > > 	o.
> > > 
> > > > 
> > > > See https://patchwork.ozlabs.org/patch/1320690
> > > > 
> > > > If you already ran 'make dt_binding_check' and didn't see the above
> > > > error(s), then make sure dt-schema is up to date:
> > > > 
> > > > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> > > > 
> > > > Please check and re-submit.
> > > > 
