Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D328A2B0436
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKLLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbgKLLoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:44:30 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9390C0613D1;
        Thu, 12 Nov 2020 03:44:28 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id u21so5657257iol.12;
        Thu, 12 Nov 2020 03:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjG+3fN6tWT0l9kBXwiMBUPZHTw/Ki7x6SY3rKyWanI=;
        b=uqztGz9E5O3z4VS98sgFfWVmfAZ7ztqXBoHmagSMuHnpvSO8ShCExSkETu/j/MY4y/
         WDP0+llM3771v0RFj6xFmylSk3xaNzgNkFjh6PsRwVHfU74ptHyfJ+26dQ1Z/+OfDA+i
         IGMF2eEoGMbcmHKEjIaoXsL1Gr/hvEAyOQku4KRB8if5CqS0DsRIRW/W/hAC7j3zRqms
         3fA/eJkvJk9OaHnoVZYJdy5viobUocBSSDVehCUW/sdnAzj+PcNYWM/SdnEoLv9ywZnY
         KEkm1X+roX0k4jgO9tflZZVfFToKpzS7W0y67BR8c2ZTsgJYdPUsiveCjWFQtDsO4vO4
         Rw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjG+3fN6tWT0l9kBXwiMBUPZHTw/Ki7x6SY3rKyWanI=;
        b=od+LIafELzo0aWkGQtCp3Aj+D0VXfElStwDGf4TGJMyZHF+Up4oVk0zxWQaBWcIxOc
         fROLLeazH1xDEzIfLx8ugQbUKlrso8jjQI/3uxTpHcTnE9hBoMZrX5zB5uZ6Xnj3vgul
         oLdDyPh3Tv2i3V60039AhtTgeZ2+lbNd8vx4KOGzeKt7n4WCNAfIMgc1kBzoKcFpNDxx
         BBVbY8zVxHTXiJ3Mh+r6W8TfpLGcMhjyQXkOnl/SZIOkk8seEzUT3Uyfo39dUhWXUxr4
         p186fEJeDbGNxwv7slMrFfnjmTBAuK17WMcnuZx3Hpf/WninE8vlwiiPslfBRtu+bwYa
         jV5Q==
X-Gm-Message-State: AOAM531rqNM0DWR2h/nPSU1vGSEqeUlb3xZAmKVkiHXPwgc2cxx2UBW0
        YsJbaR1QrZJx0Ayg7W6YJ6mALO0a7kmzBQXQ/wI=
X-Google-Smtp-Source: ABdhPJw6mtg+Wsg99W56SGu91b1DRfwQGGbt3J8n99qr1kWI36WvQ+CgwQxUWY4OSIgBtJAdzTBLlUI3RTj8Q0jsg4g=
X-Received: by 2002:a5d:824b:: with SMTP id n11mr12310712ioo.10.1605181468096;
 Thu, 12 Nov 2020 03:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20201111152523.76254-1-aford173@gmail.com> <20201111191809.GA1859246@bogus>
In-Reply-To: <20201111191809.GA1859246@bogus>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 12 Nov 2020 06:44:16 -0500
Message-ID: <CAHCN7x+w3wpELWHVSd1-U38N+4TEDKWDRxzXEtDX2svkrTGJCw@mail.gmail.com>
Subject: Re: [PATCH V4] dt-bindings: soc: imx: Add binding doc for spba bus
To:     Rob Herring <robh@kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 2:18 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 11 Nov 2020 09:25:23 -0600, Adam Ford wrote:
> > Add binding doc for fsl,spba-bus.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > make dt_binding_check showed no errors if I did this right.
> >
> > V4:  Remove an accidental makefile change
> >      Move type:object under additional properties
> >
> > V3:  Rebase sample from aips-bus example
> >      Split off from series adding i.MX8M Nano functions to reduce noise
> >
> > V2:  Attempted to update yaml from feedback
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.example.dt.yaml: bus@30000000: reg: [[805306368, 1048576]] is not of type 'object'
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
>

Rob,

Can you give me a pointer on what this message is saying?  I don't
undertsand the YAML language, and I cannot get my machine to generate
the same messages you're seeing.
>
> See https://patchwork.ozlabs.org/patch/1398351
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade

I have installed yamllint, and I have run the above line, but when I
run make dt_binding_check it fails to finish script even before I add
this new binding.  If I revert the Makefile back to before the
implementation of yamllint, it works, but doesn't show the error.
When I restore the Makefile, it runs but it doesn't show the error.
Once I do a make clean, and run the dt_binding_check again, it fails
to finish with the following error

make[1]: *** [Documentation/devicetree/bindings/Makefile:59:
Documentation/devicetree/bindings/processed-schema-examples.json]
Error 123

It appears as if the processed-schema-examples.json is not generated at all.

When I revert back to the older makefile, it appears that file is
generated, but when I restore the makefile to the current version and
run it again, it doesn't show the dtschema warnings/errors you see.
I am guessing it's because the processed-schema-examples.json isn't
being generated correctly after I run make clean.

Do you have any ideas what might be missing from my build machine?

adam

>
> Please check and re-submit.
>
