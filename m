Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0E27AF7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1N5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgI1N5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:57:04 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5629821D7F;
        Mon, 28 Sep 2020 13:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601301423;
        bh=jpy86xlaUGPlUxTUN9/FT28T6TJmY9Ad8uRAhplOiLM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vDmSUBpYh7JEkaKpuSJodZASpvn5qYNR9WD7Zz+ui1FtxvuddwJe0WaOjmp/axHLo
         CvGi+htN93Dw+bCHcooMeEmLM6ROMwqzptJbER2UAJzI5Gc0Rbgm9qtlYuoiCTp2kJ
         kSRDYEYKPRHzv/MBnvBvucpR9bEchfKfyRLFlTYk=
Received: by mail-oi1-f179.google.com with SMTP id i17so1368230oig.10;
        Mon, 28 Sep 2020 06:57:03 -0700 (PDT)
X-Gm-Message-State: AOAM533YkebO7Em65jlKwaInsqvecp/1Izm6K5dwseVO26IlCjuIwbxh
        6leaTj1LaaOHGON5YRlfpSw362VOLmMmtn0Mtg==
X-Google-Smtp-Source: ABdhPJyYmZnCW5ClUtpTwg9oOuQczSxGPBFDOMMXF/U6MycG0QqSC1DUS8ybQXFW/wpG74B1ug8+ncnraesKmTdxWF0=
X-Received: by 2002:aca:7543:: with SMTP id q64mr978362oic.147.1601301422618;
 Mon, 28 Sep 2020 06:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200916081831.24747-1-ran.wang_1@nxp.com> <20200923023234.GA3751572@bogus>
 <AM6PR04MB5413BB2F8D044B2312DAEC4FF1380@AM6PR04MB5413.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5413BB2F8D044B2312DAEC4FF1380@AM6PR04MB5413.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Sep 2020 08:56:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+uzkr7CcvwQTe5vhpMPtdqL9v4EeqH5yZjMoT=JrDtDQ@mail.gmail.com>
Message-ID: <CAL_Jsq+uzkr7CcvwQTe5vhpMPtdqL9v4EeqH5yZjMoT=JrDtDQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr1-alt-addr' property
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 1:44 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> Hi Rob,
>
> On Wednesday, September 23, 2020 10:33 AM, Rob Herring wrote:
> >
> > On Wed, Sep 16, 2020 at 04:18:27PM +0800, Ran Wang wrote:
> > > From: Biwen Li <biwen.li@nxp.com>
> > >
> > > The 'fsl,ippdexpcr1-alt-addr' property is used to handle an errata
> > > A-008646 on LS1021A
> > >
> > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 19
> > > +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > index 5a33619..1be58a3 100644
> > > --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> > > @@ -34,6 +34,11 @@ Chassis Version          Example Chips
> > >  Optional properties:
> > >   - little-endian : RCPM register block is Little Endian. Without it RCPM
> > >     will be Big Endian (default case).
> > > + - fsl,ippdexpcr1-alt-addr : The property is related to a hardware issue
> > > +   on SoC LS1021A and only needed on SoC LS1021A.
> > > +   Must include 2 entries:
> > > +   The first entry must be a link to the SCFG device node.
> > > +   The 2nd entry must be offset of register IPPDEXPCR1 in SCFG.
> >
> > You don't need a DT change for this. You can find SCFG node by its compatible
> > string and then the offset should be known given this issue is only on 1 SoC.
>
> Did you mean that RCPM driver just to access IPPDEXPCR1 shadowed register in SCFG
> directly without fetching it's offset info. from DT?

Yes. There's only 1 possible value of the offset because there's only
one SoC, so the driver can hardcode the offset. And I assume there's
only one SCFG node, so you can find it by its compatible string
(of_find_compatible_node).

Rob
