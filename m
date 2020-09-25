Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68424278A50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIYOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:07:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0FC0613CE;
        Fri, 25 Sep 2020 07:07:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so2973433lfn.2;
        Fri, 25 Sep 2020 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Ivfe1lL+hCqZxdP169zdf3ZjScUQpb79ncCuDdSP+I=;
        b=dZtavOBHs/+I7lh4LsWAHTw6kcue2fHdywqFcPTw4ykA5XvkuFCkGcxaHe//9LhiXT
         3M05HIHmq9gEJX3HvrcKAwJMsSNUMoq2Yco4Cwt2oXIS4RtS90xn3LsNhutlWjumBwiF
         1v9eKOmuGY+G8G3CcLUHXNTrmrnPBi0scmejRxMGsXZp/k4H1YqYKbJZC37r4Msfqwi+
         drCZevwl6gKecAdFqY8m53oQGYbGAYC0BZ6h2or71wa+FXbvikYO2p6TyTRh+oJ9J0yu
         KrFJddLHNT6NrFdStne32JhxIKQ/mt0FwePcoAm5FWGn12c3k1QnWjKX7VjaXEi9qTAV
         hc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Ivfe1lL+hCqZxdP169zdf3ZjScUQpb79ncCuDdSP+I=;
        b=Zs+CTeRH3Nm8xGasU209/TZKDmdfS70pVzmd3EyHXyUUfKHxpIVI2T8VNa8eUW90EF
         WXjksxNi5uPBCa0evFPgj32n3TbSTnvZTDT+X2fSQDyMVsYTH0B4yLsc/VECGSCwPk8c
         99XWpLLEY0L67csdlLV7b9oQ6D7SZYJkIUcwXxYT8Ut3cUEPNk4cjkmt9SeCNWnI1rtQ
         Wih6LSW3llK3AIObQ8eV2O92t2x8ZUCkz22wmzcDOstsn9EgzAfBgGQVj4Xp2e7vOuQP
         XmvLzhwHN6qWwlrDUgPTWuO1ZiWQhdbfck0UEsweSN0AYuBl6lqt/3KFyzJC4wFnyLwS
         gLsA==
X-Gm-Message-State: AOAM531+19rq/JuZrf5235aagK+zMZYsy+85tIdPWiiUgfRpD8eHqvjx
        p24dmoIO7dN184+40Y+kHUfMhctsqd1vP70TfH8=
X-Google-Smtp-Source: ABdhPJzYyKWyeip8y9/HtpIhKv0a27VAchsH38PPp8nSXsNl8s1hk1xZ3eGlpU/QR5p9Wr4CC665U0yRkph6AXMkgE4=
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr1511593lfb.20.1601042828225;
 Fri, 25 Sep 2020 07:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
 <1600959891-16606-2-git-send-email-u0084500@gmail.com> <20200924162332.GH4754@sirena.org.uk>
 <CADiBU39ShyHNT=NiWz2Y81+wLMJjDqD6aZ0mgzVSxp_rzLZSFQ@mail.gmail.com>
In-Reply-To: <CADiBU39ShyHNT=NiWz2Y81+wLMJjDqD6aZ0mgzVSxp_rzLZSFQ@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Sep 2020 22:06:57 +0800
Message-ID: <CADiBU39yO=HYm9G_ftE=MnMjOW5DQjVS4E=HYkhU6ucOJ7yyqQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] regulator: rtmv20: Add DT-binding document for
 Richtek RTMV20
To:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-add into the mail loop list.

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8812:09=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8812:24=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Thu, Sep 24, 2020 at 11:04:51PM +0800, cy_huang wrote:
> >
> > > +  enable-gpio:
> > > +    description: A connection of the 'enable' gpio line.
> > > +    maxItems: 1
> >
> > -gpios.  GPIO properties should always be plural even if there's only
> > one GPIO.
> >
> > > +  ld_pulse_delay:
> >
> > Properties should use - not _ and for all the properties specifying
> > things like times you should have units so...
> >
> > > +    description: |
> > > +      load current pulse delay in microsecond after strobe pin pulse=
 high.
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> >
> > ...add -us here.
> >
> Ack
> > > +  fsin_enable:
> > > +    description: Fsin function enable control.
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > > +    minimum: 0
> > > +    maximum: 1
> > > +    default: 0
> >
> > This looks like it should be a boolean property not a number.  The same
> > is true for most if not all of the other properties with min/max of 0/1=
.
> Ok, just change the property as boolean type.
