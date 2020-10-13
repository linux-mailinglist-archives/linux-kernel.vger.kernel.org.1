Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B366128D000
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbgJMOQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbgJMOQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:16:13 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8910A247FD;
        Tue, 13 Oct 2020 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598572;
        bh=5Lk25OLCC32WS63IlcGvOhBrDcQgWDeXJsC5Zyy3gvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gbtZWHBlNeLwIICi6kiE7crT/GvF7AZBBDByae5w6Knu0AfIqirczFW23FnE/ojJq
         Xltb/xtegpsj3onoDvKtRYU11edbX2gTqY7tyeAtchIewGRm9R0wtjXpdtkFqVz6pw
         cIKdnzL0MMeEu9kA0HjCi2nxUpzM4rezhbNk9zYg=
Received: by mail-ot1-f51.google.com with SMTP id i12so113495ota.5;
        Tue, 13 Oct 2020 07:16:12 -0700 (PDT)
X-Gm-Message-State: AOAM531rX781SwpOTQn1qCYiFuNzw8rM3d/5mH29CvGp5E0HTtricLW7
        96xIR/evUqrVVWqqiwcv+LUq7+ID/CBwhqoR0Q==
X-Google-Smtp-Source: ABdhPJycrrYkiUDNpjBSkSAYzAMb1vVcJHqVOx0KqxuWylYsusqkJFbzfmLBJ0Z4MepVkK3qz6EVKGpnhTz+V91NZOI=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr12866634oti.107.1602598569659;
 Tue, 13 Oct 2020 07:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com> <20200929024004.244992-6-badhri@google.com>
 <20201006182940.GA2574941@bogus> <CAPTae5L6UFGNJ0pxxfFAS3=KDNDVU-WDW-OHk6prLStbe+EaOQ@mail.gmail.com>
In-Reply-To: <CAPTae5L6UFGNJ0pxxfFAS3=KDNDVU-WDW-OHk6prLStbe+EaOQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Oct 2020 09:15:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKxW9BeFQGsLqa-ZRurR8gDDrTSaDYs=mj7TYtF9ZDiYQ@mail.gmail.com>
Message-ID: <CAL_JsqKxW9BeFQGsLqa-ZRurR8gDDrTSaDYs=mj7TYtF9ZDiYQ@mail.gmail.com>
Subject: Re: [PATCH v9 05/15] dt-bindings: connector: Add property to set
 initial current cap for FRS
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 8:07 PM Badhri Jagan Sridharan <badhri@google.com> wrote:
>
> On Tue, Oct 6, 2020 at 11:29 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Sep 28, 2020 at 07:39:54PM -0700, Badhri Jagan Sridharan wrote:
> > > This change adds frs-typec-current which allows setting the initial current
> > > capability of the new source when vSafe5V is applied during PD3.0
> > > sink Fast Role Swap.
> >
> > Shouldn't you Cc the person you copied this from?
> Not sure whether I get this comment. The patch wasn't copied. Maybe you were
> expecting me to CC amelie.delaunay@st.com ? if so, just now CC'ed.
>
> >
> >
> > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > ---
> > > Changes since v1:
> > > - Changing patch version to v6 to fix version number confusion.
> > >
> > > Changes since v6:
> > > - Removed the redundant usb-connector.txt that I created by mistake.
> > > - Moved to yaml.
> > >
> > > Changes since v7:
> > > - Rebase
> > >
> > > Changes since v8:
> > > - Redefine new-source-frs-typec-current as string enums to address
> > >   Rob Herring's comment.
> > > ---
> > >  .../bindings/connector/usb-connector.yaml     | 26 +++++++++++++++++++
> > >  include/dt-bindings/usb/pd.h                  | 10 +++++++
> > >  2 files changed, 36 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > index 9bd52e63c935..0b8cd08a8678 100644
> > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > @@ -142,6 +142,32 @@ properties:
> > >      required:
> > >        - port@0
> > >
> > > +  new-source-frs-typec-current:
> > > +    description: Initial current capability of the new source when vSafe5V
> > > +      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
> > > +      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
> > > +      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
> > > +      provides a detailed description of the field. The sink PDO from current source
> > > +      reflects the current source's(i.e. transmitter of the FRS signal) power
> > > +      requirement during fr swap. The current sink (i.e. receiver of the FRS signal),
> > > +      a.k.a new source, should check if it will be able to satisfy the current source's,
> > > +      new sink's, requirement during frswap before enabling the frs signal reception.
> > > +      This property refers to maximum current capability that the current sink can
> > > +      satisfy. During FRS, VBUS voltage is at 5V, as the partners are in implicit
> > > +      contract, hence, the power level is only a function of the current capability.
> > > +      "not-supported" implies sink to source fast role swap not supported.
> > > +      "default" refers to default USB power level as described by
> > > +      "Table 6-14 Fixed Supply PDO - Sink".
> > > +      "1.5A" refers to 1.5A@5V.
> > > +      "3.0A" refers to 3.0A@5V.
> >
> >
> > > +
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum:
> > > +      - not-supported
> > > +      - default
> > > +      - 1.5A
> > > +      - 3.0A
> >
> > What happens if the property is not present?
>
> The behavior would be the same as "not-supported".

Then you don't need 'not-supported'.

>
> >
> > I'm not crazy about mixing strings and what could be a number.
>
> v8 version[1] of the patch was using uint32. I moved to using strings
> as you were asking to unify with the approach in [2]. Since [3] was using
> string enums, I moved to that. I don't have a strong preference here, so
> I can move back to using u32 if you feel so.

Since the u32 values are based on the USB spec, I think I prefer that.
Should be easier to deal with in the driver than doing strcmp's.

Rob
