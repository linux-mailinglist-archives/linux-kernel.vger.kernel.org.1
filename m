Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13462A6F60
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 22:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgKDVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 16:08:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37694 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgKDVIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:08:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id m17so2417191oie.4;
        Wed, 04 Nov 2020 13:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6N7y6aqHymIOGjWcFaM/nQ9os/1RczW+s0nXe0CnlM=;
        b=aoRn86R51/XbDJekRNtAG+GYTHTUukca+quZqdJrsYWh/yYWNjBX07E3wGhjtkFveK
         xizBr0JC/PcrvBhRtCd35kEG0tzmKWeRXHctYjyTpXVC4Yujf3ceRKmB0nM5QKSEXcti
         OxmbAU1RvbhWN4GsYeKY506t11LhUJGwje5s9wCYL6XhnFkBmQhrPOQ0iQ6B5B9QjXEC
         y6WYEATG0OkAEh2iLPfhvlum0fI1k09mJD5PFZw6ayXA14gC04+UAXr0DsB6hCD4skpJ
         NR8BCXOfHEc9ivCSb/VT1PoMCFYBXpmWJ1L/29OAzxVvq4jx1m8TjYBUUxD/9/i3hrk4
         Z35A==
X-Gm-Message-State: AOAM531Z5hEUAtZSi/sVdGbFqqduUvFmrA5JLfXvRAiyM1qtzMiNsj+o
        Q9HnpzNa/AX9bM8FWNQXvA==
X-Google-Smtp-Source: ABdhPJwgJn7aeZ8zCXOQwqnAD2VEZKNdyYfV8x1BfKUkOMGErVQR7l0m5hQ7mxJhgu8/lVoowdOfmw==
X-Received: by 2002:aca:d6d3:: with SMTP id n202mr3608860oig.74.1604524085067;
        Wed, 04 Nov 2020 13:08:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p72sm803239oop.28.2020.11.04.13.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:08:04 -0800 (PST)
Received: (nullmailer pid 4127142 invoked by uid 1000);
        Wed, 04 Nov 2020 21:08:03 -0000
Date:   Wed, 4 Nov 2020 15:08:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode
 optional property to usb-connector
Message-ID: <20201104210803.GA4115079@bogus>
References: <20201029095806.10648-1-amelie.delaunay@st.com>
 <20201029095806.10648-2-amelie.delaunay@st.com>
 <20201029154016.GA1917373@bogus>
 <860d5620-4fdf-6e01-9a04-3967d6fcfd6b@st.com>
 <CAL_JsqKs-Po8BdShjQNDNPjNWBCD3FSPdq4KbQGx3=VnV+3nPw@mail.gmail.com>
 <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebccf61a-c88f-c7f4-9f06-01d2bd1f43de@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 04:27:14PM +0100, Amelie DELAUNAY wrote:
> 
> 
> On 10/30/20 3:29 PM, Rob Herring wrote:
> > On Thu, Oct 29, 2020 at 11:49 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> > > 
> > > 
> > > 
> > > On 10/29/20 4:40 PM, Rob Herring wrote:
> > > > On Thu, Oct 29, 2020 at 10:58:03AM +0100, Amelie Delaunay wrote:
> > > > > Power operation mode may depends on hardware design, so, add the optional
> > > > > property power-opmode for usb-c connector to select the power operation
> > > > > mode capability.
> > > > > 
> > > > > Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > > > > ---
> > > > >    .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
> > > > >    1 file changed, 18 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > > index 728f82db073d..200d19c60fd5 100644
> > > > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > > @@ -93,6 +93,24 @@ properties:
> > > > >          - device
> > > > >          - dual
> > > > > 
> > > > > +  power-opmode:
> > > > 
> > > > I've acked this version:
> > > > 
> > > > https://lore.kernel.org/r/20201020093627.256885-2-badhri@google.com
> > > > 
> > > 
> > > frs is used for Fast Role Swap defined in USB PD spec.
> > > I understand it allows to get the same information but I'm wondering why
> > > the property name is limited to -frs- in this case. What about a
> > > non-power delivery USB-C connector ?
> > 
> > I've got no idea. The folks that know USB-C and PD details need to get
> > together and work all this out. To me, it looks like the same thing...
> > 
> 
> It looks but...
> 
> The purpose of power-opmode property is to configure the USB-C controllers,
> especially the non-PD USB-C controllers to determine the power operation
> mode that the Type C connector will support and will advertise through CC
> pins when it has no power delivery support, whatever the power role: Sink,
> Source or Dual
> The management of the property is the same that data-role and power-role
> properties, and done by USB Type-C Connector Class.
> 
> new-source-frs-typec-current specifies initial current capability of the new
> source when vSafe5V is applied during PD3.0 Fast Role Swap. So here, this
> property is not applied at usb-c controller configuration level, but during
> PD Fast Role Swap, so when the Sink become the Source.
> Moreover, the related driver code says FRS can only be supported by DRP
> ports. So new-source-frs-typec-current property, in addition to being
> specific to PD, is also dedicated to DRP usb-c controller.
> The property is managed by Type-C Port Controller Manager for PD.

But it's the same set of possible values, right? So we can align the 
values at least.

Can we align the names in some way? power-opmode and frs-source-opmode 
or ??

Are these 2 properties mutually exclusive? If so, that should be 
captured.

Rob
