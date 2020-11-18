Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A855E2B7FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKRO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgKRO6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:58:16 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C97A24727;
        Wed, 18 Nov 2020 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605711495;
        bh=U61exPEFiflzmEBPAelqp9n9O1THMYeJlPv88dcYPKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0TFyS1hNvwAurDa+AkI64wQL1jW8vBl5i0OMXrErLxK2tyV22mIibMBrDYff3vxTg
         IIB5rrtiEL5GH5FegXQkbqPFoPT8t7CcUn4vy/lRbtO8/aCph4ezlXXRtlp+d7rL1d
         xA411WdqRHgsJw2r65gQgDITIu9qSaUzBWUAcgos=
Received: by mail-ot1-f42.google.com with SMTP id y22so1975494oti.10;
        Wed, 18 Nov 2020 06:58:15 -0800 (PST)
X-Gm-Message-State: AOAM531yDB9/A9qwZ/QdA3h1bQ9SxXkoGcVSyywWBZeWdCxqNJRzcoXv
        00oUz8SdlfGz5wt9n8QdM5PAGn3ZGo6rNjwVxA==
X-Google-Smtp-Source: ABdhPJxOO1hc63MJavyeihL13HaVP57AoIDiLqfRBH5CR+RvjmUeHJCy5ZBMuIAL2wK2Xfna1uIqcHsOq5/yc4UFXvw=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr6913606otd.192.1605711494499;
 Wed, 18 Nov 2020 06:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20201111152523.76254-1-aford173@gmail.com> <20201111191809.GA1859246@bogus>
 <CAHCN7x+w3wpELWHVSd1-U38N+4TEDKWDRxzXEtDX2svkrTGJCw@mail.gmail.com>
 <CAL_JsqK580zBfPfPHF2pi52dhOkgf0Ovt8TOxfCjYz0Y54pQzA@mail.gmail.com> <CAHCN7xLRaB49n=Bja_aCZD_rUaD_A54_pL5ApC4Fh8Q8+mhwdQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLRaB49n=Bja_aCZD_rUaD_A54_pL5ApC4Fh8Q8+mhwdQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Nov 2020 08:58:03 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+r0oNsX-Am5LWGj1PpG6Xfeb9NmnFk3-82bd94C1i+fQ@mail.gmail.com>
Message-ID: <CAL_Jsq+r0oNsX-Am5LWGj1PpG6Xfeb9NmnFk3-82bd94C1i+fQ@mail.gmail.com>
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

On Wed, Nov 18, 2020 at 6:13 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Thu, Nov 12, 2020 at 7:52 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Nov 12, 2020 at 5:44 AM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Wed, Nov 11, 2020 at 2:18 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, 11 Nov 2020 09:25:23 -0600, Adam Ford wrote:
> > > > > Add binding doc for fsl,spba-bus.
> > > > >
> > > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > > ---
> > > > > make dt_binding_check showed no errors if I did this right.
> > > > >
> > > > > V4:  Remove an accidental makefile change
> > > > >      Move type:object under additional properties
> > > > >
> > > > > V3:  Rebase sample from aips-bus example
> > > > >      Split off from series adding i.MX8M Nano functions to reduce noise
> > > > >
> > > > > V2:  Attempted to update yaml from feedback
> > > > >
> > > >
> > > >
> > > > My bot found errors running 'make dt_binding_check' on your patch:
> > > >
> > > > yamllint warnings/errors:
> > > >
> > > > dtschema/dtc warnings/errors:
> > > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml: bus@30000000: reg: [[805306368, 1048576]] is not of type 'object'
> > > >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> > > >
> > >
> > > Rob,
> > >
> > > Can you give me a pointer on what this message is saying?  I don't
> > > undertsand the YAML language, and I cannot get my machine to generate
> > > the same messages you're seeing.
> >
> > 'reg' is not documented, so it's defaulting to the schema in
> > 'additionalProperties' which says anything else has to be a node
> > (which is an 'object' in json-schema).
> >
> > > >
> > > > See https://patchwork.ozlabs.org/patch/1398351
> > > >
> > > > The base for the patch is generally the last rc1. Any dependencies
> > > > should be noted.
> > > >
> > > > If you already ran 'make dt_binding_check' and didn't see the above
> > > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > > date:
> > > >
> > > > pip3 install dtschema --upgrade
> > >
> > > I have installed yamllint, and I have run the above line, but when I
> > > run make dt_binding_check it fails to finish script even before I add
> > > this new binding.  If I revert the Makefile back to before the
> > > implementation of yamllint, it works, but doesn't show the error.
> > > When I restore the Makefile, it runs but it doesn't show the error.
> > > Once I do a make clean, and run the dt_binding_check again, it fails
> > > to finish with the following error
> > >
> > > make[1]: *** [Documentation/devicetree/bindings/Makefile:59:
> > > Documentation/devicetree/bindings/processed-schema-examples.json]
> > > Error 123
> > >
> > > It appears as if the processed-schema-examples.json is not generated at all.
> > >
> > > When I revert back to the older makefile, it appears that file is
> > > generated, but when I restore the makefile to the current version and
> > > run it again, it doesn't show the dtschema warnings/errors you see.
> > > I am guessing it's because the processed-schema-examples.json isn't
> > > being generated correctly after I run make clean.
> > >
> > > Do you have any ideas what might be missing from my build machine?
> >
> > What tree? v5.10-rc3 landed some changes that shouldn't have gone in
> > and broke dt_binding_check. In any case, you can use 'make -k' to work
> > around any unrelated failure.
>
> Rob,
>
> I went and pulled a clean copy of 5.10-RC1 and did "make
> dt_binding_check -k" without adding my patch or modifying the branch
> in any way.

Oh right, since it's 1 rule now, -k isn't going to help. Use -rc2
which has fixes needed. Or comment out running yamllint in
.../bindings/Makefile

I'm going to change it to ignore yamllint errors.

>
> After a bunch of DTEX, then starts to give feedback from various yaml
> files like wrong intendentation, etc.  I can give you a larger log
> dump if you want.
>
> Then I get the error message again:
> ./Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml:35:15:
> [warning] wrong indentation: expected 16 but found 14 (indentation)
> ./Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml:38:15:
> [warning] wrong indentation: expected 16 but found 14 (indentation)
> ./Documentation/devicetree/bindings/eeprom/at25.yaml:84:8: [warning]
> wrong indentation: expected 6 but found 7 (indentation)
> ./Documentation/devicetree/bindings/eeprom/at25.yaml:90:8: [warning]
> wrong indentation: expected 6 but found 7 (indentation)
> make[1]: *** [Documentation/devicetree/bindings/Makefile:59:
> Documentation/devicetree/bindings/processed-schema-examples.json]
> Error 123
> make[1]: Target '__build' not remade because of errors.
> make: *** [Makefile:1364: dt_binding_check] Error 2
>
> It appears that
> Documentation/devicetree/bindings/processed-schema-examples.json was
> not generated.
>
> I went through the writing-schema.rst file to see what/if anything I
> am missing, but as far as I can tell, I have everything installed.
> I did " pip3 install
> git+https://github.com/devicetree-org/dt-schema.git@master" and "
> "apt-get install libyaml-dev"
>
> I am running Ubuntu 20.04 if that helps.
>
> thanks for any suggestions you might have.
>
> adam
>
> >
> > Rob
