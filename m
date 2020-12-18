Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA4C2DE39A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLROA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgLROAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:00:25 -0500
X-Gm-Message-State: AOAM5339fOJsbMzH4Bi8zGVvhAFQMf0IIWAuXfSZ7OeRYyb3x0PbTyfJ
        VU1V+0gRCPO4IP6eL4cBvOloectYZak4Ei3AOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608299984;
        bh=m00YljXra1Y/T/YfniHalMSRr8Wa9EbvPsqoHcbJuQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CIxPTTY6yOXl8Xg3nZftZRRQczo0Jus3KD18july77D71YUo7Vwlkky946XKzMkCs
         i/a8rrnNRZbNqCgn/Ki8pk0M7dST6JN2KmBw7v4e+rtjq47OAtk1r/lCqAfuVuqRfa
         jTjaraOSE5lY9XKZtGYF5l1GWMHmTTIgC9UJ0+WBkATPpHAvThgHFSMMrmIwenGoU9
         3IZT4Qk6l1VDoTIiDpireKYvyGsAmnnVSrvfU+k+QTgznNwJ7Gu5wf4B0Ygnl/ypmj
         qfrBIQYnl5zIl1MaKqfiGST9YrDnKiwoI19NGH9gAfe541TJaZZuFz+oUhEKgHHLnH
         UZ9jieDQZDdXA==
X-Google-Smtp-Source: ABdhPJwwXUMO1JazN6yGwB2BQ/TiRBZQQH2BQ/8487xFVIuF0HkXlCcEnxpLYWuKK744YqYdCQzbFJyAbWhQy/3FI00=
X-Received: by 2002:a17:906:d87:: with SMTP id m7mr4161246eji.108.1608299983083;
 Fri, 18 Dec 2020 05:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20201218083726.16427-1-alice.guo@oss.nxp.com> <20201218085223.GA17306@kozik-lap>
 <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201218093641.GA38684@kozik-lap> <AM6PR04MB60534C972777EED96FD105D2E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB60534C972777EED96FD105D2E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 18 Dec 2020 07:59:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLyPPpO5OVLa4baqaJ3MGjJe5p_100ULZSmuf4q8UjWGw@mail.gmail.com>
Message-ID: <CAL_JsqLyPPpO5OVLa4baqaJ3MGjJe5p_100ULZSmuf4q8UjWGw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 4:14 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wro=
te:
>
>
>
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020=E5=B9=B412=E6=9C=8818=E6=97=A5 17:37
> > To: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; dl-=
linux-imx
> > <linux-imx@nxp.com>
> > Subject: Re: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc=
 for soc
> > unique ID
> >
> > On Fri, Dec 18, 2020 at 09:05:00AM +0000, Alice Guo (OSS) wrote:
> >  > > +    required:
> > > > > +      - compatible
> > > > > +      - nvmem-cells
> > > > > +      - nvmem-cell-names
> > > > > +
> > > > > +additionalProperties: true
> > > >
> > > > Don't leave comments unresolved (or resolve them against review
> > > > without discussion). Rob asked for changing it. The same as with al=
l
> > > > schemas - you need to describe the missing properties.
> > > >
> > > > Best regards,
> > > > Krzysztof
> > >
> > > Hi,
> > > Thank you for your advice. I replied to him and let him know I remain=
ed here
> > unchanged. There will be errors according to his suggestion.
> >
> > Then the solution is to correct the errors - describe missing propertie=
s
> > - instead of ignoring the suggestion and making a resubmit right away.
> >
> > Best regards,
> > Krzysztof
>
> Hi,
> I am sorry I do not DT Binding doc very well.
>
> I checked the usage of patternProperties and additionalProperties in http=
s://json-schema.org/understanding-json-schema/reference/object.html.
> I noticed a sentence on the website: " If additionalProperties is a boole=
an and set to false, no additional properties will be allowed.", so I think=
 that
> if additionalProperties is a boolean and set to true, additional properti=
es will be allowed. Letting here unchanged is my solution to correct the er=
rors.
> I am not sure, I asked Rob for advice on the v6 by email, but he didn't r=
eply to me, so I made a resubmit.

You waited an hour and I was sleeping! Waiting means waiting a week.

You need to add '#address-cells' and '#size-cells'.

Rob
