Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1A30087D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbhAVQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 11:20:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbhAVQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:16:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 212F323A9A;
        Fri, 22 Jan 2021 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611332175;
        bh=1mxjcxDniCvxUAxOKwFFiFDSqjzi1cRxOC70wCic4U8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RV8swPyrj87Hi1E6siSqigY+H2F5XcJyThGBd6izulfSy9C5yRwimeFbPQM8/i2b9
         D+bnyOlZyiiXgqg971lLkHQmQC2FfEgSXamgU/8K9TBMRdB4D+9L+1pvd/Bp1wT3LK
         nrFKDOfKP4uq/DvNNzOKupL6t8EAkQzi7Y17i8OEyQnaeXN5Q9OeabBs7ArbRbWoue
         COZnO+Ry3YSFvDg0KTOmker1sbC7FNn0xCUA+Y+o+XQ/E7AGWtcwxD/BIqZA4eTG+r
         KhbM30sR1/Mf1F1NUl8S28vAiTtpErS9LQWYj5s+IZ5c7au/d4f8iQe4JLmA/5t8mF
         QkbMM/5m2EN4w==
Received: by mail-ed1-f41.google.com with SMTP id g24so7151753edw.9;
        Fri, 22 Jan 2021 08:16:15 -0800 (PST)
X-Gm-Message-State: AOAM532U56c4IZtvW2YK1R1QTKcM4Z0PxzMZZR47x0ViMWnTTT56sFWY
        xdtZm4qlgkcGnFy2AxML8DNIWYLxwRDLUJV9iQ==
X-Google-Smtp-Source: ABdhPJx6fXlF/B/n7s/fyNDQXIXcJX5/Z04VOxgaGoEnSITfzIvWEnsCH6iJJ3U9OQ4bKHEb1Q5UjuIjgQI6HG3gfuI=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr3761778edn.165.1611332173622;
 Fri, 22 Jan 2021 08:16:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1609380663.git.xji@analogixsemi.com> <d13442f84fefccc992d6c5e48ac1e6129882af31.1609380663.git.xji@analogixsemi.com>
 <20210111221435.GA3138373@robh.at.kernel.org> <20210112085737.GC5827@pc-user>
In-Reply-To: <20210112085737.GC5827@pc-user>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Jan 2021 10:16:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ1B6JzpdgtP=ZNtWasjW5R0rYyUGV3RTDxT1LPa1rz5w@mail.gmail.com>
Message-ID: <CAL_JsqJ1B6JzpdgtP=ZNtWasjW5R0rYyUGV3RTDxT1LPa1rz5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: add DPI flag and
 swing setting
To:     Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, Sheng Pan <span@analogixsemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:57 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> Hi Rob Herring, thanks for the comments.
>
> On Mon, Jan 11, 2021 at 04:14:35PM -0600, Rob Herring wrote:
> > On Thu, Dec 31, 2020 at 10:21:12AM +0800, Xin Ji wrote:
> > > Add DPI flag for distinguish MIPI input signal type, DSI or DPI. Add
> > > swing setting for adjusting DP tx PHY swing
> > >
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  .../bindings/display/bridge/analogix,anx7625.yaml  | 25 ++++++++++++++++++++--
> > >  1 file changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > index 60585a4..4eb0ea3 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > @@ -34,6 +34,16 @@ properties:
> > >      description: used for reset chip control, RESET_N pin B7.
> > >      maxItems: 1
> > >
> > > +  analogix,swing-setting:
> > > +    type: uint8-array
> >
> > Humm, this should have be rejected by the meta-schema.
> We needs define an array to adjust DP tx PHY swing, the developer hopes these
> settings are changeable, so I moved the register data to DT. Can you
> give me some suggestion if it is rejected by the meta-schema?
> >
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >
> > This is how types are defined other than boolean or nodes (object).
> >
> > > +    description: an array of swing register setting for DP tx PHY
> > > +
> > > +  analogix,mipi-dpi-in:
> > > +    type: int
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: indicate the MIPI rx signal type is DPI or DSI
> >
> > Why does this need to be in DT, you should be able to determine this
> > based on what you are connected to.
> As the anx7625 can receive MIPI DSI and DPI data (depends on hardware
> implement, we have a project which have two anx7625, one is DSI input,
> the other is DPI input), we needs to let driver know what kind of MIPI
> rx signal input. And there is no other way to tell driver the MIPI rx
> signal type, we needs define this flag.

That's only true if what's driving the output is a single h/w block
that can drive either. But typically you have 2 blocks: an LCD
controller driving parallel signals and a DSI controller in front of
it doing parallel to DSI conversion. The anx7625 would be connected to
the LCD controller or DSI controller via the graph binding depending
on the h/w connection.

However, if you do need this, then let's extend video-interfaces.yaml
'bus-type' to include DSI (it already has parallel).

Rob
