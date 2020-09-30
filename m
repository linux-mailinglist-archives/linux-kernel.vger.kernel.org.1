Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDE527E6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgI3K3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:29:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgI3K26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:28:58 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90AC12085B;
        Wed, 30 Sep 2020 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601461737;
        bh=mbpDcPnXqfq0NeYcDMguth6Htz+txY3G/ufHXXdxeqo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o/OZ/rKxqjuuu/tTWYx6laCvApOr4LB7qRPDVEgEdfqbHdunCCHfy734i4J7INBQE
         bJoL6WoJbvxfx22htNzzQfK2Wf9/EpbXI0Kea6aqDSNkYdM4Ykxu8/bToI73ChKVmX
         r83o17Hs0mpHls3AfufATiXCw7xayDwBkdOxdw2c=
Received: by mail-ej1-f49.google.com with SMTP id q13so2003019ejo.9;
        Wed, 30 Sep 2020 03:28:57 -0700 (PDT)
X-Gm-Message-State: AOAM530cBhL8prfdWQJIKNoLkIC/lQlIEo6B/ztDGP3y12BgMxqyJps6
        6FMNgLvgSs8YHqi3oFlWvWAv7NpYkT1Jnp8qM1w=
X-Google-Smtp-Source: ABdhPJz8Ugd4z0UfwVWjjaen5DTm9+7ewSR+YqfdwUXyDIkfmGOdVpDBNoxFkspHVRsXZbkUoH2A7JL6SUEkkYmU5nI=
X-Received: by 2002:a17:906:1a11:: with SMTP id i17mr2006438ejf.381.1601461736013;
 Wed, 30 Sep 2020 03:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200926162811.5335-1-krzk@kernel.org> <20200926162811.5335-12-krzk@kernel.org>
 <2a329c9b-8bfc-fbd8-62a3-759f608347d6@denx.de> <686af5e6-d16a-7750-e47f-1ced9cb6c34a@denx.de>
 <CAJKOXPe7XOQspzTFDRtb=y79mwXEZSGiYiQP3J58JMjCkVRSCQ@mail.gmail.com> <abccfe07-4218-50a2-346b-bde77d1a987e@denx.de>
In-Reply-To: <abccfe07-4218-50a2-346b-bde77d1a987e@denx.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 30 Sep 2020 12:28:44 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdUkjd9--EC3GF08tsMMAr3t8BqJqddi4s+pwQV0+Pj_A@mail.gmail.com>
Message-ID: <CAJKOXPdUkjd9--EC3GF08tsMMAr3t8BqJqddi4s+pwQV0+Pj_A@mail.gmail.com>
Subject: Re: [RFC 12/14] dt-bindings: vendor-prefixes: add Aristainetos
To:     hs@denx.de
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 12:14, Heiko Schocher <hs@denx.de> wrote:
>
> Hello Krzysztof,
>
> Am 30.09.2020 um 09:11 schrieb Krzysztof Kozlowski:
> > On Wed, 30 Sep 2020 at 06:16, Heiko Schocher <hs@denx.de> wrote:
> >>
> >> Hello Krzysztof,
> >>
> >> Am 28.09.2020 um 06:04 schrieb Heiko Schocher:
> >>> Hello Krzysztof,
> >>>
> >>> Am 26.09.2020 um 18:28 schrieb Krzysztof Kozlowski:
> >>>> Document binding for an unknown entity Aristainetos with few boards
> >>>> mainlined.
> >>>>
> >>>> Cc: Heiko Schocher <hs@denx.de>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >>>>
> >>>> ---
> >>>>
> >>>> I tried to Google but except the patches from Heiko Schocher, I could
> >>>> not find any meaningful data.
> >>>>
> >>>> Heiko, you posted this. Do you know what is it?
> >>>
> >>> aristainetos is the name of the board, so it is not the vendor name.
> >>>
> >>> I just asked the customer if we can add a valid vendor name...
> >>
> >> Ok, it is not easy to get an okay from the customer to publish
> >> his name.
> >>
> >> Is there a dummy or unknown entry for vendor?
> >
> > We could use "denx" as it was done as part of your work or "linux".
> > Rob, any hints here?
>
> Ok we can use as vendor "abb" in all DTS files and regarding your
> change in Documentation/devicetree/bindings/vendor-prefixes.yaml
> it can be:
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 789a01b3d93a..bb4c85f00c8f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -105,6 +105,8 @@ patternProperties:
>       description: arcx Inc. / Archronix Inc.
>     "^aries,.*":
>       description: Aries Embedded GmbH
> +  "^abb,.*":
> +    description: ABB
>     "^arm,.*":
>       description: ARM Ltd.
>     "^armadeus,.*":
>
> Would you work in this changes?

Yes, I will send a v2 with a new name.

Thanks for checking this.

Best regards,
Krzysztof
