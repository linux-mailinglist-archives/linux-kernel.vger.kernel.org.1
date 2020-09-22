Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7236A274428
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIVOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgIVOYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:24:53 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F5323A1D;
        Tue, 22 Sep 2020 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600784692;
        bh=VH0jM+A8P5sFG/bKWMqp/z6QPkFgM7VMiqVFFHF/OLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W4rY78hm5XDVexazBMATM/BiRb0z27jzC/vRN5xE9xgcCJY9MOjEo0XJUMwF5iGiY
         7DBzTFkmqCan30A0d1IwOSHSB1LFxCa3M1x12h71/E6qHMSvaIWd3/l0QmAC6EKDj2
         CWtFrXRF8bqvw3GhdxqO16GSz7UePw8Uin+cg7/8=
Received: by mail-ed1-f43.google.com with SMTP id n13so16296072edo.10;
        Tue, 22 Sep 2020 07:24:52 -0700 (PDT)
X-Gm-Message-State: AOAM530iauyFwkjPKZZERAXAO0R3ZGXPY2qWiTn/rv1OqmD9tlG9cwJ/
        q7BtDNm8U55et5763T3JcCCOzLrEf0ru1eyfNuU=
X-Google-Smtp-Source: ABdhPJxZ2CrqnrJLb1T6VBVOBSunR4FrEAjor/RNBGpBRboAOMh20/Svsx+Y1Q0FoTRmqeOWKEl8LD1QHAzIXKbyk7U=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr4049681edb.143.1600784690888;
 Tue, 22 Sep 2020 07:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200920195749.26952-1-krzk@kernel.org> <20200920195749.26952-2-krzk@kernel.org>
 <20200922065154.GH25109@dragon>
In-Reply-To: <20200922065154.GH25109@dragon>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 22 Sep 2020 16:24:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPemE-mHdp-OAOMi5xQvTcW4k-f1aMcmX10zFLFFTRMv2Q@mail.gmail.com>
Message-ID: <CAJKOXPemE-mHdp-OAOMi5xQvTcW4k-f1aMcmX10zFLFFTRMv2Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-librem5: align GPIO hog names
 with dtschema
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 at 08:52, Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Sun, Sep 20, 2020 at 09:57:48PM +0200, Krzysztof Kozlowski wrote:
> > dtschema expects GPIO hogs to end with 'hog' suffix.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Ping me after dtschema gets accepted.

Hi Shawn,

Happened just now, in dt-schema repo:
https://github.com/devicetree-org/dt-schema/pull/47

Best regards,
Krzysztof
