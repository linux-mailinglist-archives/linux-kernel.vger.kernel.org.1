Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A462B070C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgKLNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgKLNwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:52:50 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1730720A8B;
        Thu, 12 Nov 2020 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605189169;
        bh=KOQsWdsbmptEqiIz23XZR8nofnEven+O1r5V6kdPPmg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y2qX5kPWePgtOSL/l4a8kNAg0qOAQJ09BllEPSIm/0cO6l7GUWmJ2evlJaXSQMBeD
         rDXL7JUcDHlISp4RVYFdIWSO9eHaBT2oDs6ksu0nJ8cI1mOBYdAEO3/Iy5rWc5Oyu/
         5S2Of04/rieeMZ5A2+GZERoMJh/rF01/9koKR6rI=
Received: by mail-oo1-f49.google.com with SMTP id c25so1309976ooe.13;
        Thu, 12 Nov 2020 05:52:49 -0800 (PST)
X-Gm-Message-State: AOAM532JGATK8vGwjB1Zp8Q7f2gwGrsqqGKoesO4nATiMRsocLcEWEH9
        pjd/a4Ez48hdW6dn3m2LQWifQJuUAqfNqWqCSw==
X-Google-Smtp-Source: ABdhPJyO4pVq5jfcaPbDSPnAh3tegTIikMW7I9a4L0OrQE8cRh6KknxwudS2YRO23v78T94IOikH0kLsa+6dLO8Ixnc=
X-Received: by 2002:a4a:1a82:: with SMTP id 124mr20848521oof.81.1605189168278;
 Thu, 12 Nov 2020 05:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20201111152523.76254-1-aford173@gmail.com> <20201111191809.GA1859246@bogus>
 <CAHCN7x+w3wpELWHVSd1-U38N+4TEDKWDRxzXEtDX2svkrTGJCw@mail.gmail.com>
In-Reply-To: <CAHCN7x+w3wpELWHVSd1-U38N+4TEDKWDRxzXEtDX2svkrTGJCw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Nov 2020 07:52:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK580zBfPfPHF2pi52dhOkgf0Ovt8TOxfCjYz0Y54pQzA@mail.gmail.com>
Message-ID: <CAL_JsqK580zBfPfPHF2pi52dhOkgf0Ovt8TOxfCjYz0Y54pQzA@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Adam Ford <aford173@gmail.com>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 5:44 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Nov 11, 2020 at 2:18 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, 11 Nov 2020 09:25:23 -0600, Adam Ford wrote:
> > > Add binding doc for fsl,spba-bus.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > make dt_binding_check showed no errors if I did this right.
> > >
> > > V4:  Remove an accidental makefile change
> > >      Move type:object under additional properties
> > >
> > > V3:  Rebase sample from aips-bus example
> > >      Split off from series adding i.MX8M Nano functions to reduce noise
> > >
> > > V2:  Attempted to update yaml from feedback
> > >
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml: bus@30000000: reg: [[805306368, 1048576]] is not of type 'object'
> >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> >
>
> Rob,
>
> Can you give me a pointer on what this message is saying?  I don't
> undertsand the YAML language, and I cannot get my machine to generate
> the same messages you're seeing.

'reg' is not documented, so it's defaulting to the schema in
'additionalProperties' which says anything else has to be a node
(which is an 'object' in json-schema).

> >
> > See https://patchwork.ozlabs.org/patch/1398351
> >
> > The base for the patch is generally the last rc1. Any dependencies
> > should be noted.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
>
> I have installed yamllint, and I have run the above line, but when I
> run make dt_binding_check it fails to finish script even before I add
> this new binding.  If I revert the Makefile back to before the
> implementation of yamllint, it works, but doesn't show the error.
> When I restore the Makefile, it runs but it doesn't show the error.
> Once I do a make clean, and run the dt_binding_check again, it fails
> to finish with the following error
>
> make[1]: *** [Documentation/devicetree/bindings/Makefile:59:
> Documentation/devicetree/bindings/processed-schema-examples.json]
> Error 123
>
> It appears as if the processed-schema-examples.json is not generated at all.
>
> When I revert back to the older makefile, it appears that file is
> generated, but when I restore the makefile to the current version and
> run it again, it doesn't show the dtschema warnings/errors you see.
> I am guessing it's because the processed-schema-examples.json isn't
> being generated correctly after I run make clean.
>
> Do you have any ideas what might be missing from my build machine?

What tree? v5.10-rc3 landed some changes that shouldn't have gone in
and broke dt_binding_check. In any case, you can use 'make -k' to work
around any unrelated failure.

Rob
