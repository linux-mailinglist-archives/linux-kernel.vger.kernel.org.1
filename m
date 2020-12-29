Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF72E716D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgL2OfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2OfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:35:13 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF53C061793;
        Tue, 29 Dec 2020 06:34:33 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAEBB98;
        Tue, 29 Dec 2020 15:34:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1609252472;
        bh=Pm2DbbyaogPH3NcFaH7A0BgvWpdrgjNXu0NnM+HaQ2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvP+7vKNPuk/QAcQWtTY02hpiXYdBvfRJWFX+Jctcbj11crVYy7bboIeoNpXhfAmv
         OWXmgfmGe4pTs4WGV0Nvtf/FRJPBgQoqVCFDAhtLbPCzuTGJVEPIC+nhU/n+TxgeTM
         +xZM0Z11G3y01rSvlDbSjXY51gAtpwzgGcfEUWPc=
Date:   Tue, 29 Dec 2020 16:34:20 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Sheng Pan <span@analogixsemi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: drm/bridge: anx7625: add DPI flag
 and swing setting
Message-ID: <X+s+bDHLbhxBDz7E@pendragon.ideasonboard.com>
References: <cover.1608883950.git.xji@analogixsemi.com>
 <c29b7d9fda9ce8619d1c718b077250998a8600b8.1608883950.git.xji@analogixsemi.com>
 <X+n1COtS8nrCFUHd@pendragon.ideasonboard.com>
 <20201229065048.GB7073@pc-user>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229065048.GB7073@pc-user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin Ji,

On Tue, Dec 29, 2020 at 02:50:48PM +0800, Xin Ji wrote:
> On Mon, Dec 28, 2020 at 05:08:56PM +0200, Laurent Pinchart wrote:
> > On Fri, Dec 25, 2020 at 07:01:09PM +0800, Xin Ji wrote:
> > > Add DPI flag for distinguish MIPI input signal type, DSI or DPI. Add
> > > swing setting for adjusting DP tx PHY swing
> > > 
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  .../bindings/display/bridge/analogix,anx7625.yaml     | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > index 60585a4..34a7faf 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> > > @@ -34,6 +34,14 @@ properties:
> > >      description: used for reset chip control, RESET_N pin B7.
> > >      maxItems: 1
> > >  
> > > +  anx,swing-setting:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description: an array of swing register setting for DP tx PHY
> > 
> > Register values in DT are frowned upon.
>
> Hi Laurent Pinchart, as the different vendor has the different PCB layout,
> it effects DP CTS test result, so they may need config DP tx Swing register
> to adjust signal swing(the default swing setting is not satisfy for
> every platform). If we move the config code to driver file, it must define
> swing register setting for each vendor, so the DT is the best way. Do you
> have any idea for it if you don't agree to add in DT.

If it depends on the PCB layout then it should indeed be in DT. What I
wonder is if there would be a better way to specify the data than
register values. The ANX7625 datasheet isn't public, so there's
effectively no way for someone to write a device tree compliant with
this binding only with the information contained here. Reviewing the
bindings is equally difficult. It would be best if this property instead
contained information that could be documented clearly.

> > > +  anx,mipi-dpi-in:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: indicate the MIPI rx signal type is DPI or DSI
> > 
> > This sounds similar to the bus-type property defined in
> > Documentation/devicetree/bindings/media/video-interfaces.txt (which is
> > getting converted to YAML, Rob has posted a patch series, I expect it to
> > land in v5.13). I think it would make sense to extend bus-type to
> > support DSI, and use that property.
>
> Sorry, I didn't found any define for DPI or DSI flag in Rob's patches.
> Do you mean I just remove this flag define and call a special function
> to read the port's type(DSI or DPI)?

video-interfaces.yaml has initially been written for cameras, so it
doesn't support DSI. I think it would make sense to extend the bus-type
property with a DSI type, and use it here instead of a vendor-specific
property.

Alternatively, I'm wondering if this isn't information we could query at
runtime. DRM bridges and panels have a type, so we could look at the
next bridge or panel to find the type of the connected device instead of
specifying it in DT.

> > > +
> > >    ports:
> > >      type: object
> > >  
> > > @@ -72,6 +80,17 @@ examples:
> > >              reg = <0x58>;
> > >              enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
> > >              reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> > > +            anx,swing-setting = <0x00 0x14>, <0x01 0x54>,
> > > +                <0x02 0x64>, <0x03 0x74>, <0x04 0x29>,
> > > +                <0x05 0x7b>, <0x06 0x77>, <0x07 0x5b>,
> > > +                <0x08 0x7f>, <0x0c 0x20>, <0x0d 0x60>,
> > > +                <0x10 0x60>, <0x12 0x40>, <0x13 0x60>,
> > > +                <0x14 0x14>, <0x15 0x54>, <0x16 0x64>,
> > > +                <0x17 0x74>, <0x18 0x29>, <0x19 0x7b>,
> > > +                <0x1a 0x77>, <0x1b 0x5b>, <0x1c 0x7f>,
> > > +                <0x20 0x20>, <0x21 0x60>, <0x24 0x60>,
> > > +                <0x26 0x40>, <0x27 0x60>;
> > > +            anx,mipi-dpi-in = <0>;
> > >  
> > >              ports {
> > >                  #address-cells = <1>;

-- 
Regards,

Laurent Pinchart
