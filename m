Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEDF2A010E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgJ3JS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3JS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:18:27 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468C1221FF;
        Fri, 30 Oct 2020 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604049506;
        bh=41CsPVrmLRTWYg3B1zMTIDApQHnGk5g2mzfYPc3CDZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0BFjXnZCyCoaPQgPnjyfUutyINgXG8mk+sVhP65jtk9FKk2gy9zExgJYSsBnwXdkD
         eadDFfV9/NA8Rg9d+uxs3NmM4vuLp4ZHuQrc5zaJqkrFRZhyeY87DicrIbOvmvgMvv
         zrOrZZILJwEbbsv5272xZUTvnV8W3D8iqk1ZmW6s=
Received: by mail-ej1-f49.google.com with SMTP id 7so7662483ejm.0;
        Fri, 30 Oct 2020 02:18:26 -0700 (PDT)
X-Gm-Message-State: AOAM531KFW2oS5a5tO5il1I8WpVh5EPIGlxlyCBmVn3q5WotbNMX16TP
        VR7kaQqeSCZtNmvj5+USxFlt7fW+7Bw5IFzMFpI=
X-Google-Smtp-Source: ABdhPJw8ybYdZkgu/ZUNenftV4PFN3bC42EE8St3lWNKB35w7dhI7OjNeL+oewCWtSCY6ivHYDKHaxxLJ4p637TxYg4=
X-Received: by 2002:a17:906:6a07:: with SMTP id o7mr1435936ejr.454.1604049504625;
 Fri, 30 Oct 2020 02:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201001170759.9592-1-krzk@kernel.org> <20201030071102.GF28755@dragon>
In-Reply-To: <20201030071102.GF28755@dragon>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 30 Oct 2020 10:18:12 +0100
X-Gmail-Original-Message-ID: <CAJKOXPd14EiwWdfYjJOj8Ym0jM2pnD-Kreo9FHKWTeCPDgZBwQ@mail.gmail.com>
Message-ID: <CAJKOXPd14EiwWdfYjJOj8Ym0jM2pnD-Kreo9FHKWTeCPDgZBwQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] dt-bindings: arm: fsl: fix and document compatibles
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 08:11, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Oct 01, 2020 at 07:07:47PM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > This is a continuation of my series:
> > https://lore.kernel.org/linux-arm-kernel/20200930190143.27032-1-krzk@kernel.org/
> >
> > It is rebased on top of it and finally fixes remaining i.MX2 - i.MX8
> > boards compatibles.
> >
> > There is ongoing discussion in my previous patchset about imx6q-pico
> > (Technexion) board compatibles so the DTS is marked as RFC.
> >
> > Best regards,
> > Krzysztof
> >
> >
> > Krzysztof Kozlowski (12):
> >   dt-bindings: vendor-prefixes: add Element14
> >   dt-bindings: arm: fsl: document i.MX6Q boards
> >   dt-bindings: arm: fsl: document i.MX6QP boards
> >   dt-bindings: arm: fsl: document i.MX6SL boards
> >   dt-bindings: arm: fsl: document i.MX6SX boards
> >   dt-bindings: arm: fsl: document i.MX6UL boards
> >   dt-bindings: arm: fsl: document i.MX6ULL boards
> >   dt-bindings: arm: fsl: document i.MX7S boards
>
> This one doesn't apply ...

Thanks. I will rebase and resend.

Best regards,
Krzysztof
