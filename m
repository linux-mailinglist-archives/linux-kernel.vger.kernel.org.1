Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2728AE72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJLGyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgJLGxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:53:54 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D812087D;
        Mon, 12 Oct 2020 06:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602485633;
        bh=tH6NLOQJIt/DSyl52aTub9ewoXy+F8+YPQXG765z5f8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vvLGYcGK/vfHmjh7kBBkmGom4/MjzlYPKZ0xOlUnv2srTL3Xx5OlzzynRtWJH5EWC
         2EBhJBJ9PgQAlJoECF5mDcexjCIX3EFx4bgNtAfDujxyd5EBRJxhjWo5TtT+xjXAx8
         CYy8pV0Dbq2Oa8Ck2iso/4nY3pJnSHH2kwS6jEGs=
Received: by mail-ed1-f45.google.com with SMTP id 33so15699040edq.13;
        Sun, 11 Oct 2020 23:53:53 -0700 (PDT)
X-Gm-Message-State: AOAM5308W73JFpKFOuIvEEtxzgVw+mzk4dmworDziZ4nr/XnJqZ8gPtO
        kIcNu9diGu3yr0blZw1M5FmEk3t2QEtXJUpMP84=
X-Google-Smtp-Source: ABdhPJzLONhrvMXi73IT1ZOzHRALo3OUFXuRTGz7UjWtP3NX9lBcaYDY7kNxpM16UfiKjb2egYsi9hve9E+DvPV11Jw=
X-Received: by 2002:aa7:c643:: with SMTP id z3mr10253119edr.104.1602485631707;
 Sun, 11 Oct 2020 23:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com> <1602229667-13165-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1602229667-13165-2-git-send-email-Anson.Huang@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 08:53:40 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeEnnOU_TYsO2svDCcZyMy7FPQyJkZzOWbDn7P8KhcZmg@mail.gmail.com>
Message-ID: <CAJKOXPeEnnOU_TYsO2svDCcZyMy7FPQyJkZzOWbDn7P8KhcZmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mn: Correct WDOG_B pin configuration
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aford173@gmail.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peter.chen@nxp.com,
        alifer.wsdm@gmail.com, abel.vesa@nxp.com, yibin.gong@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 09:52, Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Different revision of i.MX8MN EVK boards may have different external
> pull up registor design, some are enabled while some are NOT, to make
> sure the WDOG_B pin works properly, better to enable internal pull up
> resistor. Since enabling internal pull up resistor is NOT harmful and
> having benefit of flexibility on different board design, just enable
> it for all i.MX8MN boards.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

The same as patch #1 - you do more than just enable pull up.

Best regards,
Krzysztof
