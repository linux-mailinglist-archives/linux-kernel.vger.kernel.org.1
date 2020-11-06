Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2362A8C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgKFCDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbgKFCDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:03:54 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5CC0613CF;
        Thu,  5 Nov 2020 18:03:54 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b1so5177327lfp.11;
        Thu, 05 Nov 2020 18:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oi4Xnuin4gO7W988u55luyGaQtlR2ivokoUJshemqZc=;
        b=qs05jK2U/NSfmW8tqCVslUD2thvDwf+/D9jAQWoya/ee/SdPzR8idqYwA4w5HXLCNt
         UZB1WbolKKQqbEvmzo7qmF0W6zUonoqZ77aj5mDZ1/YJPy9Os/l8W85VTJydKrkt0uqz
         /TuROap7oK8POEfMwrHSavEcpmwagexusTzeYkvLGpfiBfZc0nDpiYZOyKUpMzJvzg52
         I6oOK/OeNMTCY/uwGpV5RWXo7OoK1Iexx9ESKqCr/ub15SHV13LfmyRtMwTIX9GbQR5K
         Ykp1BcGp+igBayReahprZEC5b8L40ciiYNi0ygGmAYiQez7hL+en8CZlhax1hrNL72cE
         mRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oi4Xnuin4gO7W988u55luyGaQtlR2ivokoUJshemqZc=;
        b=q4+helZv5iR5JzqUQbyTlU+eJaw9IkOWSruVtYZ1wLp62D/EOWKoAZqIxE5cjrAMe4
         NnMYoejjmzUSwXAntg0MUHC4/4rXmtGjnrgHFVzvHTFmBhxQvmG6ZiFJaav9pqZf/HTZ
         tjW14WybR+LOhyOdkuCE6ZxcGTJsNIZDuPy/jaRC5cj6+abVdp7lHwUyL9+TnQHdv5GF
         TpqYurKzuxOqs2nHVfAnyqa3mULW4l13TemPqSL/pykCvFCbPeRL/udUM5t6rvIUnEny
         aQ8ywCG6DE0UOmRZfLJnZ4mJGHPTLXzaRxhJ2Qm7ok/n6Q8cz86hafzmWnm4f8eaVCsT
         X9Xw==
X-Gm-Message-State: AOAM533GiTzbSK61aCEJoZD6p91t+SldXm+KT1HOMeJLa/aYR8HUBgVi
        IxphYZebAGTYIh2oEEdErGig65AFLognsZ8rZo4=
X-Google-Smtp-Source: ABdhPJz0NbCaQyv+/RvgXgO7a/Go63Pbbz2HImQ4G9q1mKT2Wf4Ltwv1YrojL8VW3uH1u2MLn3h5RKsDnjGT+EjUyzk=
X-Received: by 2002:a05:6512:3a9:: with SMTP id v9mr2297074lfp.568.1604628232809;
 Thu, 05 Nov 2020 18:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20201102100157.85801-1-mtwget@gmail.com> <20201102100157.85801-2-mtwget@gmail.com>
 <20201103113743.5764tj2ryrht4dfs@gilmour.lan> <CAHRgzyOao=w6Yyqqvi1Z26=rfJgumkzDbWLxD+_5uaLmyAWiQA@mail.gmail.com>
 <20201105171051.ducvxcdj5jfarmgn@gilmour.lan>
In-Reply-To: <20201105171051.ducvxcdj5jfarmgn@gilmour.lan>
From:   Yu-Tung Chang <mtwget@gmail.com>
Date:   Fri, 6 Nov 2020 10:03:35 +0800
Message-ID: <CAHRgzyNzXk1uJzEVLvrqPu2CT8jzF+5UFEubT6kEtF=8HVgROQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2020=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 04, 2020 at 04:07:48PM +0800, Yu-Tung Chang wrote:
> > > > +&uart1 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&uart1_pins>;
> > >
> > > This should be already set in the DTSI
> > >
> > uart0 as the debugging interface, uart1 as the external uart port,
> > uart3 as the bluetooth.
>
> What I mean is that since it's the only muxing option, the pinctrl
> properties should already be set in the DTSI, so it's redundant to put
> them in the DTS.
>
I can only see the definition of uart0 in the DTSI,
because uart1 as the extension interface is exclusive to NanoPi R1.
> Maxime
