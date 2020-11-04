Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91312A5F23
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKDIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgKDIMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:12:47 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3953C223C7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604477566;
        bh=zMzZrWx2IXhl/Cyh/m1Iiz3JMtBjvBovOMMHg9VdGUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f+yjZpkkayKaAuRxpZew9acwh9iE4gUEpEZ/9+vKpJw19d8ekKNObsmrWTDgHQN5F
         fzKtrh1XSE0tjXQNhcUBQCmm4q+9PKMLyulodeubpyyvGa7X2D0HQRiLGYH8OamdwD
         zULQ+blviN48gHh9+gDay2Ay+rZV/FI+qsPRlaI4=
Received: by mail-ed1-f42.google.com with SMTP id b9so11294625edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:12:46 -0800 (PST)
X-Gm-Message-State: AOAM533I5NgqAxeccWxAC0dSfOS9tPCSbvzFyfB3KZvsfdBEZMTn8ez6
        euTMkgIu1dbYBUqyhHpyN3ftyttAUdBSnX6HRDw=
X-Google-Smtp-Source: ABdhPJzLcmOxaq6t3mAz7sOoOclvQWzmvxE0qmw9sqC3M71XjkyDKc49lYC5BnGwHy3sMCJPJmJL8V8E2nkLTEyfUR0=
X-Received: by 2002:a50:8b65:: with SMTP id l92mr26319773edl.132.1604477564706;
 Wed, 04 Nov 2020 00:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20201104030645.12931-1-alice.guo@nxp.com> <20201104030645.12931-2-alice.guo@nxp.com>
 <CAJKOXPd_sArJ5-Ka2btZNxn3aBGFioDGOmQKbqeVNgtpUZUw=A@mail.gmail.com> <DB6PR0402MB27608D5A8A11C2D3779C4D0188EF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0402MB27608D5A8A11C2D3779C4D0188EF0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Nov 2020 09:12:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPck-Rh6b_xLdYsxodCFE2em3dvQ2Y58s3EUGAKRRoPwkw@mail.gmail.com>
Message-ID: <CAJKOXPck-Rh6b_xLdYsxodCFE2em3dvQ2Y58s3EUGAKRRoPwkw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] LF-2571-1: dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Alice Guo <alice.guo@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 09:04, Peng Fan <peng.fan@nxp.com> wrote:
> > > +ed=0
> > > +
> > > +title: NXP i.MX8M Platforms Device Tree Bindings
> >
> > This is not a title for these bindings. Please describe the bindings for this
> > device. Based on description, this might could go to bindings/nvmem
> > directory.
>
> It might be misleading here. I think the bindings is for SoC, just like
> "arm,realview-eb-soc" in
> Documentation/devicetree/bindings/arm/arm,realview.yaml
>
> Reading the patch, it is to convert soc-imx8m.c to platform driver,
> so need to add a compatible string for the soc device,
> I think Documentation/devicetree/bindings/arm/fsl.yaml should be
> a better place.

Thanks for clarification. Putting it with arm/fsl.yaml looks reasonable.

Best regards,
Krzysztof
