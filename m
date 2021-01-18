Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8462F9B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbhARIe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbhARIeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:34:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD621C061573;
        Mon, 18 Jan 2021 00:34:03 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x23so17278875lji.7;
        Mon, 18 Jan 2021 00:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NxbXFKF94p6kEsRAtmd8BKyy9JENwa9sivc+ZAodEKA=;
        b=A2RSX4y2LmMv6mR7pwlrf3u6T3rGFBse1drQ3xjZKsSLH2Wb5CBopN0Tdz9y8eXBQP
         kAFWmHreQYGoFj+NYj3SHu6ce3tYIQMekoexo1meFdbwptfhfM44+l3RDgA7JQVVFEbd
         8bm9FjCb8rzH8w6Ew8sijtTEYsfyzOoNBPxcVvAu7mrpZWtqwzqevN5S6qSYBg1m8vSL
         piLsmxcfauKP/oTrw8wu7xtJD0MddqhyzJ7iqkN/jZNRUm4Y6LM8YY3jEduWM49lnYIg
         /bsJ++4LJSwhCDav/DwNlIbCiYP3FuEBFqfOiYvEHZqXoJGeItOcb1YzywOHWuhz1nuI
         d4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NxbXFKF94p6kEsRAtmd8BKyy9JENwa9sivc+ZAodEKA=;
        b=ema9lq1Tvx5TAG8zNbtYzZ3D2gq3NkXKEV96SoFrUYf8ZJ/FtkZAYKUTjDyW92Tpjf
         380cN2IsRAj7fhnrrmGtSeF28nMmOXmVErvDtSPg+71lwj7gviKW3aY23QIwjjWy9Zie
         apbNjc9nUez39/66+NXAo4MUPW/OGVyeSbrLzvVp3ZjGH1U/mjz5CO6+ef+FN1SiB8r/
         EprgP8q/Y76jm64rF5n/WSlXd7PQA8C7Y9Jyxz0m/TSbkwGt65+aA7e7X2dGDzs33CmS
         bBdFmqxGm33CMY4zpuvt1vBy9pD+7dpLFXJ+kBhXKeS3tgfsiBmfWNK1lHIKVmhQs6oP
         Dzog==
X-Gm-Message-State: AOAM531ZcjDh76hE22t2fZAMh6dQanG/0y+v3QUAXnzV3AoLNgxchQMv
        kbeR1vVvbTXYtcasPR35vJITwwsRDB7ORprticg=
X-Google-Smtp-Source: ABdhPJynqi6oTwFjkTNFUl1fP0igBITsisexmUdUKnImyJVj0NHltLH5ZKbkHMkITjIr3opjkpv5LEywTjJJTrhJ9R4=
X-Received: by 2002:a2e:8e64:: with SMTP id t4mr10154052ljk.141.1610958842168;
 Mon, 18 Jan 2021 00:34:02 -0800 (PST)
MIME-Version: 1.0
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
 <1610720001-15300-2-git-send-email-u0084500@gmail.com> <1610898357.197444.1730305.nullmailer@robh.at.kernel.org>
In-Reply-To: <1610898357.197444.1730305.nullmailer@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 18 Jan 2021 16:33:50 +0800
Message-ID: <CADiBU3_pH3_=Dpi8auWTekBaev-ZF2WNPUZRzJEu8+pA0Lk18w@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb typec: tcpci: mt6360: Add vbus supply into
 dt-binding description
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        Rob Herring <robh+dt@kernel.org>, gene_chen@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8817=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=8811:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 15 Jan 2021 22:13:21 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add external vbus source into dt-binding description.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml | 7 ++=
+++++
> >  1 file changed, 7 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/=
mediatek,mt6360-tcpc.yaml: properties:vbus-supply: 'maxItems' is not one of=
 ['description', 'deprecated']
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/=
mediatek,mt6360-tcpc.yaml: ignoring, error in schema: properties: vbus-supp=
ly
> warning: no schema found in file: ./Documentation/devicetree/bindings/usb=
/mediatek,mt6360-tcpc.yaml
>
> See https://patchwork.ozlabs.org/patch/1427073
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
Thanks, after I re-installed the yamlint, the error can be seen.
Refer to https://www.kernel.org/doc/Documentation/devicetree/bindings/examp=
le-schema.yaml
*-supply is only a phandle

In next series patch, I'll remove the maxItems in vbus-supply.
I already checked the below change. make dt_binding_check can be passed

   vbus-supply:
     description:
       Vbus source supply regulator.
-    maxItems: 1

   connector:
     type: object
