Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFE25153C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 11:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgHYJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgHYJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:21:17 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D6AC061574;
        Tue, 25 Aug 2020 02:21:17 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v2so9819879ilq.4;
        Tue, 25 Aug 2020 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O5ZePddE7+2hNWWo8aSkH/TkS7aUaHrfFN3bU8JewnQ=;
        b=AklZ0aZuCA3+GJ0XJ+PRbCWWB0W1arHTu7OZqdh5V49EiqOpO0rOB/mGE7iOY1tLfb
         hoiKGScSflRxbFxkm4pzX7YttP3A7ZcwYsr2L0CB0foOE3EF0WoHGdj/ilpgJM2dnDOr
         ju1wdEHTC4t/lfElQ9XC2D6AP7CU0uJoXECSmqjfa7fyGiWm8UHHVCuGi9Mog6GRbzS3
         2UOPsIhvT2h8BykHwMAxlXr7cPoYsiUxyrWjbztXm+sHk/n8rO8W1MAyTaslSOO7oW/p
         +wPobgqN4vA5xD60ZVvrS19F2UkiDxFBZIqmPG9OPi7NpElliZpEK6ZGBEpdg8Icy7Q6
         A8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O5ZePddE7+2hNWWo8aSkH/TkS7aUaHrfFN3bU8JewnQ=;
        b=qRfXbsyIqhuJ0STjvx9QPZjnV3VGqRbOk9RRvXEGrMLR31tvnW7XTn4pD1A2Ngg+Ml
         PiJKFBjrb6EsrDxgNTkSjtuOU0lt62EhH6TfEjV37/9E9CF+xZ+bdTx2KLecOLfEnflV
         34HXHuq3mgJ8wgynHKTN2HTJiLkFfSIwfr0cFRMY7Ji11bSHosXJmdH/IcL11+hOEXR0
         NM4WqXUQu72EXTXsNEDmFBfpdfoGOH8mBzOstreAxbvYByYDC2Cz3lTaMyeNrSVS/TbZ
         gkQZetesKDodJEHseUIlgmi+QqIKVCfOSnK5nsAAOymLr47N3WzR40MpOjr7Zmg+Lqxq
         /7ag==
X-Gm-Message-State: AOAM533et9HsBj4Nq1CpIXIHt2yIkDOTspnv7ZyYRwNSjVCdkkQYgc7j
        EC5juV7bEtm1s/uWbdLB/FAjTlANcY3AQ1A2Io1XfIvSUCM=
X-Google-Smtp-Source: ABdhPJwUTHNJrsritlvIyqvwywRovUNlslidY5JbPeOUgN5sF/K+k8KoxiM3CYAkzCB6ZeH4UcpQc/ljrwCFnEkzwbA=
X-Received: by 2002:a92:d386:: with SMTP id o6mr8517221ilo.292.1598347277087;
 Tue, 25 Aug 2020 02:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200820113015.GB5854@sirena.org.uk> <CAE+NS36C0AwbrFJdYGY6_n_g3DVitp_e1GfZUxjMbKu1bJ_t4w@mail.gmail.com>
 <20200824194840.GF4676@sirena.org.uk>
In-Reply-To: <20200824194840.GF4676@sirena.org.uk>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Tue, 25 Aug 2020 17:21:06 +0800
Message-ID: <CAE+NS37p38dAN1bAi_VvEYYGNiWDVFKrdHL-hTgi2nim_7Zvqw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Aug 24, 2020 at 03:21:57PM +0800, Gene Chen wrote:
> > > On Thu, Aug 20, 2020 at 03:53:42PM +0800, Gene Chen wrote:
>
> > > > +  LDO_VIN3-supply:
> > > > +    description: Input supply phandle(s) for LDO3
>
> > > Only LDO3 needs a supply?
>
> > LDO_VIN1/LDO_VIN2 is real MT6360 pin supply from VSYS to LDO1/2/3/5
> > LDO_VIN3 is also real pin supply from BUCK2 to LDO6/7
>
> So shouldn't there be a documented LDO_VIN1/2 then?

LDO_VINx is HW design layout, so actually it can't be changed by device tre=
e.
LDO_VIN1/LDO_VIN2 supply from VSYS, not regulator, so I think usually
not to show the supply from in device tree.
or I should declare a dummy reference to system power like "*-supply =3D
<&system_power>;"?
