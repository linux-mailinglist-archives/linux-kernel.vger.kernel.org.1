Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A82B7D71
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgKRMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgKRMN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:13:56 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5748C0613D4;
        Wed, 18 Nov 2020 04:13:55 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id j12so1778381iow.0;
        Wed, 18 Nov 2020 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iF3K7BJnTiuP8dKZzbv6GYR2q4prKoKxdgZTYHPcqT8=;
        b=Q/S87YQtG1fuvVEQ1ExJqNbmG28uSgkfTIS6DginMfaKPXvFaiNnTpHFVEfWqzonuu
         T4waCvsjcoV2rwjDEuuAHhwbJjWo97g7sF06yFhpmIZoOW0uqfHcRSE9zI33z497xDbZ
         hckzF5rXLOAy2qhMC3Wytca0Y8BJIVqrRRJ8puG3d5yTJq5w4aGzCPm/q1xAumLLY/nh
         r87TdJCMdwO0S4Uyn4A82kIp45/GvWCG5+p7t48FABK2VKlGCa19fl0TS/OIAsKQoSn1
         8u4rgtSJg77N91GshfgwCAZHqRRyqCJv2KXkUloRaMFHXdPii8Wi0hrN6ugPjkYqiEHN
         qpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iF3K7BJnTiuP8dKZzbv6GYR2q4prKoKxdgZTYHPcqT8=;
        b=JHh8F4YxKz1PRmP5vqF7OtSGUqtT8R3XOJg04p188M8lRMFpDI1IrPiXR7hcsc85q2
         kii/WNcSEjGXfv2cEishe/OdwRy3fplYy1S14ZCJlqHWDxkkcO+JVHJwYEhzlUa/s4M/
         SuwX3fdNTZ4n4xNTqrq68ntMSw1GHMPrbkSryNI0bFhxgOfSUXgU6Xiy79WlsHApKT9F
         Z12ohgDZpNlw9o8Z3I8U2YmMehbW48C83G1xoW+rfTIUkkvBd5OcJ4DqYAvMAaqi39QJ
         aN5u5uWQTqMvUnf7/IHZhKd9axgBBy6LKfQdVxVjZ2hKAGoiSSCMooAVHCyln0vs4vJ/
         71BQ==
X-Gm-Message-State: AOAM531kn2i5oxPH4HCF9gliHVuM6FH5NJINQQCAC/u5DmMYwddO7YYA
        JVaxK2hWppiHyrJ8dh1tpmCpUp/nmdAwxMrQrdd3mxzN06jVmQ==
X-Google-Smtp-Source: ABdhPJxTWBYuvxdMAVVRtCgmy0owVY/5zjE7dHHSPDYLM45iY0W9qlTNGj2VpvVUHW9eHXe49XA9qumjO40kUNJlQRM=
X-Received: by 2002:a05:6602:d7:: with SMTP id z23mr15859729ioe.142.1605701635073;
 Wed, 18 Nov 2020 04:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20201111152523.76254-1-aford173@gmail.com> <20201111191809.GA1859246@bogus>
 <CAHCN7x+w3wpELWHVSd1-U38N+4TEDKWDRxzXEtDX2svkrTGJCw@mail.gmail.com> <CAL_JsqK580zBfPfPHF2pi52dhOkgf0Ovt8TOxfCjYz0Y54pQzA@mail.gmail.com>
In-Reply-To: <CAL_JsqK580zBfPfPHF2pi52dhOkgf0Ovt8TOxfCjYz0Y54pQzA@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 18 Nov 2020 06:13:43 -0600
Message-ID: <CAHCN7xLRaB49n=Bja_aCZD_rUaD_A54_pL5ApC4Fh8Q8+mhwdQ@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Rob Herring <robh@kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 7:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 12, 2020 at 5:44 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 2:18 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, 11 Nov 2020 09:25:23 -0600, Adam Ford wrote:
> > > > Add binding doc for fsl,spba-bus.
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > > ---
> > > > make dt_binding_check showed no errors if I did this right.
> > > >
> > > > V4:  Remove an accidental makefile change
> > > >      Move type:object under additional properties
> > > >
> > > > V3:  Rebase sample from aips-bus example
> > > >      Split off from series adding i.MX8M Nano functions to reduce noise
> > > >
> > > > V2:  Attempted to update yaml from feedback
> > > >
> > >
> > >
> > > My bot found errors running 'make dt_binding_check' on your patch:
> > >
> > > yamllint warnings/errors:
> > >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml: bus@30000000: reg: [[805306368, 1048576]] is not of type 'object'
> > >         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> > >
> >
> > Rob,
> >
> > Can you give me a pointer on what this message is saying?  I don't
> > undertsand the YAML language, and I cannot get my machine to generate
> > the same messages you're seeing.
>
> 'reg' is not documented, so it's defaulting to the schema in
> 'additionalProperties' which says anything else has to be a node
> (which is an 'object' in json-schema).
>
> > >
> > > See https://patchwork.ozlabs.org/patch/1398351
> > >
> > > The base for the patch is generally the last rc1. Any dependencies
> > > should be noted.
> > >
> > > If you already ran 'make dt_binding_check' and didn't see the above
> > > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > > date:
> > >
> > > pip3 install dtschema --upgrade
> >
> > I have installed yamllint, and I have run the above line, but when I
> > run make dt_binding_check it fails to finish script even before I add
> > this new binding.  If I revert the Makefile back to before the
> > implementation of yamllint, it works, but doesn't show the error.
> > When I restore the Makefile, it runs but it doesn't show the error.
> > Once I do a make clean, and run the dt_binding_check again, it fails
> > to finish with the following error
> >
> > make[1]: *** [Documentation/devicetree/bindings/Makefile:59:
> > Documentation/devicetree/bindings/processed-schema-examples.json]
> > Error 123
> >
> > It appears as if the processed-schema-examples.json is not generated at all.
> >
> > When I revert back to the older makefile, it appears that file is
> > generated, but when I restore the makefile to the current version and
> > run it again, it doesn't show the dtschema warnings/errors you see.
> > I am guessing it's because the processed-schema-examples.json isn't
> > being generated correctly after I run make clean.
> >
> > Do you have any ideas what might be missing from my build machine?
>
> What tree? v5.10-rc3 landed some changes that shouldn't have gone in
> and broke dt_binding_check. In any case, you can use 'make -k' to work
> around any unrelated failure.

Rob,

I went and pulled a clean copy of 5.10-RC1 and did "make
dt_binding_check -k" without adding my patch or modifying the branch
in any way.

After a bunch of DTEX, then starts to give feedback from various yaml
files like wrong intendentation, etc.  I can give you a larger log
dump if you want.

Then I get the error message again:
./Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml:35:15:
[warning] wrong indentation: expected 16 but found 14 (indentation)
./Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml:38:15:
[warning] wrong indentation: expected 16 but found 14 (indentation)
./Documentation/devicetree/bindings/eeprom/at25.yaml:84:8: [warning]
wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/eeprom/at25.yaml:90:8: [warning]
wrong indentation: expected 6 but found 7 (indentation)
make[1]: *** [Documentation/devicetree/bindings/Makefile:59:
Documentation/devicetree/bindings/processed-schema-examples.json]
Error 123
make[1]: Target '__build' not remade because of errors.
make: *** [Makefile:1364: dt_binding_check] Error 2

It appears that
Documentation/devicetree/bindings/processed-schema-examples.json was
not generated.

I went through the writing-schema.rst file to see what/if anything I
am missing, but as far as I can tell, I have everything installed.
I did " pip3 install
git+https://github.com/devicetree-org/dt-schema.git@master" and "
"apt-get install libyaml-dev"

I am running Ubuntu 20.04 if that helps.

thanks for any suggestions you might have.

adam

>
> Rob
