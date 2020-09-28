Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7848127B078
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgI1PCL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 11:02:11 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44550 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgI1PCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:02:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A27F6FB03;
        Mon, 28 Sep 2020 17:02:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q109Wptkrg7z; Mon, 28 Sep 2020 17:02:04 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 461E045BEF; Mon, 28 Sep 2020 17:02:03 +0200 (CEST)
Date:   Mon, 28 Sep 2020 17:02:03 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on
 mantix panel
Message-ID: <20200928150203.GA58525@bogon.m.sigxcpu.org>
References: <cover.1600707235.git.agx@sigxcpu.org>
 <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
 <20200924193807.GA1223313@ravnborg.org>
 <20200928065039.GB2837573@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200928065039.GB2837573@ulmo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
On Mon, Sep 28, 2020 at 08:50:39AM +0200, Thierry Reding wrote:
> On Thu, Sep 24, 2020 at 09:38:07PM +0200, Sam Ravnborg wrote:
> > Hi Guido.
> > 
> > On Mon, Sep 21, 2020 at 06:55:52PM +0200, Guido Günther wrote:
> > > We need to reset both for the panel to show an image.
> > > 
> > > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > > ---
> > >  .../bindings/display/panel/mantix,mlaf057we51-x.yaml       | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > > index 937323cc9aaa..ba5a18fac9f9 100644
> > > --- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > > +++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
> > > @@ -35,7 +35,9 @@ properties:
> > >    vddi-supply:
> > >      description: 1.8V I/O voltage supply
> > >  
> > > -  reset-gpios: true
> > > +  reset-gpios:
> > > +    minItems: 2
> > > +    maxItems: 2
> > 
> > reset-gpios is, as you already wrote, defined in panel-common.yaml.
> > Do not try to change it here.
> > It would be much better, I think, to introduce a mantix,reset-gpios
> > property.
> > 
> > This would avoid that we had two different reset-gpios definitions.
> 
> My understanding is that this will only override the defaults defined in
> panel-common.yaml. So everything else about the
> panel-common.yaml#/properties/reset-gpios definition remains valid and
> all this does is say that when this matched on "mantix,mlaf057we51-x",
> then the "reset-gpios" property is expected to contain two entries as
> opposed to the single entry that is expected by default.

I thought so too but I get:

linux/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.example.dt.yaml: panel@0: reset-gpios: [[4294967295, 29, 1], [4294967295, 24, 1]] is too long
	From schema: /.../linux/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml

It seems to bepossible to *extend* reset-gpios though because when i use
an example like:

            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>,
                          <&gpio1 24 GPIO_ACTIVE_LOW>;

i correctly get

linux/linux/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.example.dt.yaml: panel@0: reset-gpios: [[4294967295, 29, 1]] is too short
	From schema: /.../linux/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
 
so the `minItems: 2` is being picked up. This mens i can add
properties but i can't overwrite the existing `maxItems: 2` - that's why
i was wondering how that is supposed to work (if properties should be
overrideable from common files or not).
Cheers,
 -- Guido

> 
> Thierry


