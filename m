Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE929F5C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ2UCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgJ2UCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:02:31 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858B7C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:02:31 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g21so2245442vsp.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHWeGLndJ6xxN0MAwysL/++BG9BlJzB6qOfq725eGSk=;
        b=nGhX7HR2IWiCY4pI4GXVjaNF4rXrEKJCkKSUb640yjof+beWnJaznvUSHH9V8ia1bI
         PUgBHGcU1NNEQDDd7ltP8i5PkwDS2ZjZwWvNWKy9PFwRhRS/6YepzOfsG1J53Nq29N3O
         +Q44RLheaWRDj7oEk1ys03ZJFAtjnciCfbjsx+oacjjY1q+GHTGGITRJGOTW7jdpI9Bh
         J+KczpneR/M0MjR2dQ3UM9+HV97LEUhYR5dSP4Ekya48vBN3NiQrsrcUgoq1imWOmC/V
         8lppAylhcn0CAatmgnkieBYZm/ugbSlsXHD/vRngF0Z17GO2S7gYTMloZaKCm38Ef9AW
         re+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHWeGLndJ6xxN0MAwysL/++BG9BlJzB6qOfq725eGSk=;
        b=GRQc6OjLpYFdpOoLtNEn4T3Em0uSG3wrh8u4UqQf1XW84hZSGQm4PgeN/ZLwJ+vRo9
         L4T1QObgXrINw42OLRKAlhPzx55A/0If2grDiPaqjDYdPulxIm/cf8Shg+U3E2gQJRHd
         Ox10uewkHf/No7WO5hxF/6L3WR4AnzYx2KmZdkZ4F6jOWWphho2HplTFpa8mc+9C7+Vk
         cSOCMGrZLvj942maoGrDUIqg11f7c55jOpxQKrR9NagC8byQ7dtTE95QYnov6RMrefFk
         HRAVgbEU9mP2TSToFV0ti0ZRntkiiMOznFhdoVcAr6TINxxJzNAkTFCtuH1T/ERI4D51
         8eEQ==
X-Gm-Message-State: AOAM532m8VlPKNggP3Kkw34FV5NHSOUc35HfC1bVZ4UNYa8cX4hxoU6e
        npAczYwKyCY7PEk6uzubHGe4RjjRI8Yl+kKoL5BcYA==
X-Google-Smtp-Source: ABdhPJx3ipOjqxWLspHm1PdFbyoLH1B9iR40Eah0PBO3efo+jMYR6ljyioVHJKH0Jp0GWSsPFuvei8Y1EzODH7lPOBw=
X-Received: by 2002:a67:fc4d:: with SMTP id p13mr4795515vsq.60.1604001750400;
 Thu, 29 Oct 2020 13:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com> <20201029063138.1429760-2-badhri@google.com>
 <20201029153351.GA1911637@bogus>
In-Reply-To: <20201029153351.GA1911637@bogus>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 29 Oct 2020 13:01:52 -0700
Message-ID: <CAPTae5L8bnv1S6dK0XkPiF7aha88ed5vfaiw5HAdtvu7TQMD5g@mail.gmail.com>
Subject: Re: [PATCH v12 01/10] dt-bindings: usb: Maxim type-c controller
 device tree binding document
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        USB <linux-usb@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

The error seems to be because the following patch
5ed132db5ad4 dt-bindings: connector: Add property to set initial
current cap for FRS
is in usb-next but not in the rc1 branch yet. To make the bot
recognize that this is a
dependency, Is it suffice to mention the following in the commit description?
This patch depends on patch "dt-bindings: connector: Add property to
set initial current cap for FRS".
Or is there something else that I should do ?

Thanks,
Badhri


On Thu, Oct 29, 2020 at 8:33 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 28 Oct 2020 23:31:29 -0700, Badhri Jagan Sridharan wrote:
> > Add device tree binding document for Maxim 33359 Type-C chip driver
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since v1:
> > - Changing patch version to v6 to fix version number confusion.
> >
> > Changes since v6:
> > - Migrated to yaml format.
> >
> > Changes since v7:
> > - Rebase on usb-next
> >
> > Changes since v8:
> > - Fix errors from make dt_binding_check as suggested by
> >   Rob Herring.
> >
> > Changes since v9:
> > - additionalProperties: false as suggested by Rob Herring.
> >
> > Changes since v10:
> > - Added the chip number to the binding as suggested by Rob Herring.
> > - Renamed the filename as well.
> >
> > Changes since v11:
> > Addressed comments from Rob Herring to rename from maxim,33359
> > to maxim,max33359
> > ---
> >  .../bindings/usb/maxim,max33359.yaml          | 75 +++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/usb/maxim,max33359.example.dts:39.53-54 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/usb/maxim,max33359.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1364: dt_binding_check] Error 2
>
>
> See https://patchwork.ozlabs.org/patch/1389879
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
