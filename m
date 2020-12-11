Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B922D8004
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbgLKU2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:28:55 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44505 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbgLKU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:28:02 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2A68660002;
        Fri, 11 Dec 2020 20:27:19 +0000 (UTC)
Date:   Fri, 11 Dec 2020 21:27:18 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Message-ID: <20201211202718.GI1781038@piout.net>
References: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
 <20201210020545.GA1480364@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210020545.GA1480364@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 20:05:45-0600, Rob Herring wrote:
> What's wrong with the generic mux binding and driver(s)?
> 

The main issue is that the driver doesn't expose audio routes and so
DAPM can't do its job properly. Also, it is more convenient to have the
control part of the ALSA sound card which is not possible with gpio-mux.

You could argue that we can have simple-audio-mux use the mux subsystem
but we still need a new binding and driver anyway, just as we have
io-channel-mux or i2c-mux. I'm not sure this would be useful but I can
be convinced otherwise.

> > +
> > +properties:
> > +  compatible:
> > +    const: simple-audio-mux
> > +
> > +  mux-gpios:
> > +    description: |
> > +      GPIOs used to select the input line.
> > +
> > +  sound-name-prefix:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Used as prefix for sink/source names of the component. Must be a
> > +      unique string among multiple instances of the same component.
> > +
> > +required:
> > +  - compatible
> > +  - mux-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    mux {
> > +        compatible = "simple-audio-mux";
> > +        mux-gpios = <&gpio 3 0>;
> > +    };
> > -- 
> > 2.28.0
> > 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
