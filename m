Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6482BB700
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbgKTUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbgKTUcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:32:32 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65CA522470;
        Fri, 20 Nov 2020 20:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605904351;
        bh=nBNR6Kcuyu4HsWDtioHd2Yt10KwexTkZX/FhI5KMvpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DGE0pypM+6Et9l+6LyYzwvAcDGtNpS+fK4RyXnAG478S1BZ43UIN5mjKlouxkdIxD
         vHUKrNI4oQKPRWJQlVlYNKQYQ4/euvhDoml71f4f/fSvrssnMFjphCpf361tjZ//zp
         iy852KNsyu2hTdA+nmw+WWPgrelnBTrsiinygjQ0=
Received: by mail-oi1-f174.google.com with SMTP id l206so11821167oif.12;
        Fri, 20 Nov 2020 12:32:31 -0800 (PST)
X-Gm-Message-State: AOAM533M1Ft9kpY30/SZR3FB9EhSX/xKkHbkTaRVQGiHkGjNjjKsv3g9
        m/QFELpsTOxexXvJBjopOrpqr3YwMuPgws+ikw==
X-Google-Smtp-Source: ABdhPJym5NklP+6sFp3njodEc4XZImaIoXN0PinQjFQ9iXvdbCxFfXK+k/TkVG8ZRTgL+TldhMsUigWDpqkSu7LaHEU=
X-Received: by 2002:aca:b40a:: with SMTP id d10mr7935101oif.147.1605904350599;
 Fri, 20 Nov 2020 12:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20201103100021.19603-1-vincent.whitchurch@axis.com>
 <20201103100021.19603-2-vincent.whitchurch@axis.com> <20201104185755.GA3948381@bogus>
 <20201105093926.msls7vgl42z7cpjy@axis.com>
In-Reply-To: <20201105093926.msls7vgl42z7cpjy@axis.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Nov 2020 14:32:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLOTy_dDDGhDQdZgsyh_qr3NGmKiD=BzHVVU5DDJe--TA@mail.gmail.com>
Message-ID: <CAL_JsqLOTy_dDDGhDQdZgsyh_qr3NGmKiD=BzHVVU5DDJe--TA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add DA9121
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        kernel <kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 3:39 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Wed, Nov 04, 2020 at 07:57:55PM +0100, Rob Herring wrote:
> > On Tue, 03 Nov 2020 11:00:20 +0100, Vincent Whitchurch wrote:
> > > Add bindings for the Dialog Semiconductor DA9121 voltage regulator.
> > >
> > > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > > ---
> > >  .../bindings/regulator/dlg,da9121.yaml        | 47 +++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: 'additionalProperties' is a required property
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml: ignoring, error in schema:
> > warning: no schema found in file: ./Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> >
> > See https://patchwork.ozlabs.org/patch/1392753
>
> OK, thanks.  I'll fix it by changing the unevaluatedProperties to an
> additionalProperties (since the $ref has moved).
>
> I think I should also move the unevaluatedProperties to the buck1 level
> instead of removing it completely, because I see a bunch of other
> regulator bindings doing it, but the checks don't complain about that
> being missing and I can't see that making any difference for the
> validation.

Because the meta-schema is not recursing down levels. It probably
should, but that's another round of fixing all the current cases. And
the top-level is more well defined as to what the structure is (IOW,
we might not be able to define a rule that works everywhere).

> For example, I was hoping that this:
>
>   buck1:
>     description:
>       Initial data for the Buck1 regulator.
>     $ref: "regulator.yaml#"
>     type: object
>     unevaluatedProperties: false
>
> would complain about something like:
>
>         buck1 {
>           not-a-real-property;
>           regulator-min-microvolt = <680000>;
>           regulator-max-microvolt = <820000>;
>         };
>
> but it doesn't, so I don't quite understand what "unevaluatedProperties:
> false" prevents.

That's because it's currently a nop as the Python jsonschema package
doesn't yet support 2019.09 version of jsonschema.

If you aren't defining properties in addition to what's defined by a
$ref, then use additionalProperties.

Rob
