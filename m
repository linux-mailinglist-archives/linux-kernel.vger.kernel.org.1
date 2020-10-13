Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21E528CF82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgJMNul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387949AbgJMNuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:50:40 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F4F24770;
        Tue, 13 Oct 2020 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602597040;
        bh=ifE0Ha5o2XG4AKS/0u0N1d994tavHWMY4bLOdzKHqbM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dw6Nvlaelu4WZC9bnk5H5VKQxCdOx0EqMkPeAAGhRvYvXkCnYp0xR8sX+QlaPNhEq
         WXQ7PBh+Zn8Skv1OrHhiGbQRScHu6h9x86+JGZmdEGgn0UC4wgC4SRubRJHND65yvl
         M0cOIUo70Th/S1pIBtnZQyA6X7exB0Aqzi0eM96g=
Received: by mail-ot1-f46.google.com with SMTP id e20so18662894otj.11;
        Tue, 13 Oct 2020 06:50:40 -0700 (PDT)
X-Gm-Message-State: AOAM531BmjTDfcOvMMSXPEobG4ZXwKS3DIG1pJZlMHgoQmse5xk2QlAA
        MGrdGFqPTc31nVd7eiaKc1S9Ev0KHQb+IEzZdg==
X-Google-Smtp-Source: ABdhPJyy8pkBm/rH1RsgSNwitplg9Rb0bqHTBjDtl+Y96Z/jlmD7XWQdqpFugB9tRrh2WBnMNGylHAKIiG7F2DlEjX0=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr18816592otm.129.1602597039244;
 Tue, 13 Oct 2020 06:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200929024004.244992-1-badhri@google.com> <20200929024004.244992-4-badhri@google.com>
 <20201005144618.GA154206@bogus> <CAPTae5+e74k22Vcf-cnFLFGnR-mBdb9qvN6i-E-31VexhpUSeA@mail.gmail.com>
 <CAL_JsqLqs2qZqwmCOMgCeiGsw4Hj2xMAbRYqWCphH92+8T6qUg@mail.gmail.com>
In-Reply-To: <CAL_JsqLqs2qZqwmCOMgCeiGsw4Hj2xMAbRYqWCphH92+8T6qUg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 13 Oct 2020 08:50:28 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+bhEKGXoObGWbWw=1KQAovyJgvvfJe+=n7829HhKmmSw@mail.gmail.com>
Message-ID: <CAL_Jsq+bhEKGXoObGWbWw=1KQAovyJgvvfJe+=n7829HhKmmSw@mail.gmail.com>
Subject: Re: [PATCH v9 03/15] dt-bindings: usb: Maxim type-c controller device
 tree binding document
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
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 8:43 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Oct 7, 2020 at 7:43 PM Badhri Jagan Sridharan <badhri@google.com> wrote:
> >
> > Hi Robb,
> >
> > Thanks for the reviews ! Responses inline.
> >
> > Regards,
> > Badhri
> >
> > On Mon, Oct 5, 2020 at 7:46 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Sep 28, 2020 at 07:39:52PM -0700, Badhri Jagan Sridharan wrote:
> > > > Add device tree binding document for Maxim TCPCI based Type-C chip driver
> > > >
> > > > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > > > ---
> > > > Changes since v1:
> > > > - Changing patch version to v6 to fix version number confusion.
> > > >
> > > > Changes since v6:
> > > > - Migrated to yaml format.
> > > >
> > > > Changes since v7:
> > > > - Rebase on usb-next
> > > >
> > > > Changes since v8:
> > > > - Fix errors from make dt_binding_check as suggested by
> > > >   Rob Herring.
> > > > ---
> > > >  .../devicetree/bindings/usb/maxim,tcpci.yaml  | 68 +++++++++++++++++++
> > > >  1 file changed, 68 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml b/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> > > > new file mode 100644
> > > > index 000000000000..f4b5f1a09b98
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
> > > > @@ -0,0 +1,68 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: "http://devicetree.org/schemas/usb/maxim,tcpci.yaml#"
> > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > +
> > > > +title: Maxim TCPCI Type-C PD controller DT bindings
> > > > +
> > > > +maintainers:
> > > > +  - Badhri Jagan Sridharan <badhri@google.com>
> > > > +
> > > > +description: Maxim TCPCI Type-C PD controller
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - maxim,tcpci
> > >
> > > Is there a datasheet for this? Searching for 'tcpci' doesn't really come
> > > up with anything other than this patch. Only chip I found is MAX77958.
> > > Bindings are for specific h/w devices.
> >
> > Unfortunately the datasheet cannot be made public yet. Has the datasheet
> > have to be made public before sending the bindings ?
>
> No, but we need a part number or some assurance that 'tcpci' is a specific part.

I guess TCPCI is USB Type-C Port Controller Interface Specification.

That's just a protocol definition, not a chip. DT describes h/w which
is more than just the protocol.

Rob
