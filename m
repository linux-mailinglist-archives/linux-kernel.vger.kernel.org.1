Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D792FC744
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbhATB5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbhATBvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:51:48 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21984C061757;
        Tue, 19 Jan 2021 17:51:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id m13so24169734ljo.11;
        Tue, 19 Jan 2021 17:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EOmNpRX8SEbQAJ9InTqMSNS2j7g0suVcBgq97tfbIbQ=;
        b=I3qDBA9cDib9CkJzwuxF/g+0zMDc3JeLl4/2KThX16QQW/b9GqN6PeAwLvoWmhNgSr
         yonfe7+Hp0cDnEFp19D5zWRQKycOsHRhVqsxYcGMFmiOBiH/nDUG0eRK9gPwHSrUg8cu
         PPpxCmhNMLHm6IRN9FIr05AZpI8A1sDnubZp/fBN4qlEj3pOU4JOMUtkuHlv5krn4iqi
         yBk7zYG29xoVqd20crDKnauAKeJu0NrapS/9fkYWCggiMIgI1Bya++HwZC/Kp+4uG2Lz
         jfn5PVPSmwxUvAfLFj0nIL9dTU0/wmb6HsGGT8MM9I2o2k3Bl4nr191BGn3uYAV9LzX7
         vPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EOmNpRX8SEbQAJ9InTqMSNS2j7g0suVcBgq97tfbIbQ=;
        b=TiHmOQVFOLAiapjFOeWddrWOQKAeMx5+NjkqM6X9sRE7gsnYG42fqHRiIqL6UmMYnv
         tPqK6/tqjCkKVrNss8iYJVnQlei3A8QP+1s+Xdz/QM2tPzymoq1hqjqAMWroDr7hh1pe
         Kw6QIJJsrj2ZKcjt0V94GXn4vYhm4XvxW4DeQ4ZxDULDayynTJPF8zm1oBwEvjVnFXw2
         ei4QWSYXSZSkr2n4zvLCVQbfufR3SxxeAlwbhGu8qI3ZL45W5HTpusOxBil5IPh2FGFz
         R/mrOlgxIEuMcZdRaai1pL1KPO9w52+umHVE5Jj/2U6NzFsX3eBi7NgTBPQUcKDfYNPb
         3teg==
X-Gm-Message-State: AOAM532jOwDpTacEUuQKzxJx33f9dJhhT25htWgFkjo0PHJWHCDHGSP1
        QvLlBVqQxlNmuyWlyvxhReGsNu+OcQTYzJBbV9BvPKQdeog=
X-Google-Smtp-Source: ABdhPJygEfsArRDrh+JnpahiHFfQMmrfKhHFHuwAbP4alJJdACL3ihQ5Qh4sGJ6Cu8lTbQlN90Y6Ea5V6E77+v3Tbfc=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr3159325ljn.342.1611107466601;
 Tue, 19 Jan 2021 17:51:06 -0800 (PST)
MIME-Version: 1.0
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
 <1610720001-15300-2-git-send-email-u0084500@gmail.com> <20210119231058.GA2772032@robh.at.kernel.org>
In-Reply-To: <20210119231058.GA2772032@robh.at.kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 20 Jan 2021 09:50:55 +0800
Message-ID: <CADiBU3_t5jozakQnD7Wuuj1pjumbXhW3P9kkWRqh5pG1pfi_Sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb typec: tcpci: mt6360: Add vbus supply into
 dt-binding description
To:     Rob Herring <robh@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        matthias.bgg@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8820=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=887:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jan 15, 2021 at 10:13:21PM +0800, cy_huang wrote:
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
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc=
.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > index 1e8e1c2..b8d842b 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> > @@ -26,6 +26,11 @@ properties:
> >      items:
> >        - const: PD_IRQB
> >
> > +  vbus-supply:
> > +    description:
> > +      Vbus source supply regulator.
> > +    maxItems: 1
>
> vbus-supply is already in the 'connector' node, you don't need it here.
>
If not put here, 'regulator_get' only can follow the legacy way to get
vbus regulator.
Currently, there's no one to use the 'vbus-supply' property.
From my understanding, the 'vbus-supply' is the chip level property,
not connector type property.

> > +
> >    connector:
> >      type: object
> >      $ref: ../connector/usb-connector.yaml#
> > @@ -38,6 +43,7 @@ required:
> >    - compatible
> >    - interrupts
> >    - interrupt-names
> > +  - vbus-supply
> >
> >  examples:
> >    - |
> > @@ -54,6 +60,7 @@ examples:
> >            compatible =3D "mediatek,mt6360-tcpc";
> >            interrupts-extended =3D <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> >            interrupt-names =3D "PD_IRQB";
> > +          vbus-supply =3D <&otg_vbus>;
> >
> >            connector {
> >              compatible =3D "usb-c-connector";
> > --
> > 2.7.4
> >
