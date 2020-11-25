Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C62C3A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgKYHeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgKYHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:34:02 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0053220DD4;
        Wed, 25 Nov 2020 07:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606289641;
        bh=1tj/48GfzxzqmYgDCA/0eCd6TB+m5r4Xs7r8dncm/9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCkZTh02xMAF0hp/U900HVhQ3ZWPZlOLIZXixsLcuvvokJRAu2syT3ZScX53XJjYG
         qKL41Z93GJGX7Voe+VxhIOJ764Hiyi1QKw06e3knAuGVmk494DN/XCxz3ZA9FKAtZF
         I6J+IKuCvyeTx9WCyCr3TMguohqZOyXANPap1jM4=
Received: by mail-ej1-f47.google.com with SMTP id k9so1552761ejc.11;
        Tue, 24 Nov 2020 23:34:00 -0800 (PST)
X-Gm-Message-State: AOAM533YZ3kpquSMbajIlGmCRDxc8CpPGanDA7wiiR1Am40oJ53X++h5
        7wHbNk1V4sg7iMHNBN+nKlbLZl1oCKkM9OkMnYw=
X-Google-Smtp-Source: ABdhPJy5EHqICMEgwekRamL8E35QB8442mkRqJH2qON9l4m3HNLFhqKodjTStAuIadE7ALZ1lUC9x0XS/1iFROj1j3Q=
X-Received: by 2002:a17:906:7aca:: with SMTP id k10mr1907968ejo.215.1606289639405;
 Tue, 24 Nov 2020 23:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20201124015949.29262-1-alice.guo@nxp.com> <20201124015949.29262-4-alice.guo@nxp.com>
 <CAHCN7x+xRNZAEU0Y_nRSsKE5UtSvHT4E5WLx_NvLncbQMndnbw@mail.gmail.com>
In-Reply-To: <CAHCN7x+xRNZAEU0Y_nRSsKE5UtSvHT4E5WLx_NvLncbQMndnbw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Nov 2020 08:33:47 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdb9666qGfHd21pG_o7a5iQQF+BVwQwXBGYMJG1D5OzUg@mail.gmail.com>
Message-ID: <CAJKOXPdb9666qGfHd21pG_o7a5iQQF+BVwQwXBGYMJG1D5OzUg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] soc: imx8m: change to use platform driver
To:     Adam Ford <aford173@gmail.com>
Cc:     Alice Guo <alice.guo@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 at 01:44, Adam Ford <aford173@gmail.com> wrote:
>
> On Mon, Nov 23, 2020 at 8:04 PM Alice Guo <alice.guo@nxp.com> wrote:
> >
> > Directly reading ocotp register depends on that bootloader enables ocotp
> > clk, which is not always effective, so change to use nvmem API. Using
> > nvmem API requires to support driver defer probe and thus change
> > soc-imx8m.c to use platform driver.
> >
> > The other reason is that directly reading ocotp register causes kexec
> > kernel hang because the 1st kernel running will disable unused clks
> > after kernel boots up, and then ocotp clk will be disabled even if
> > bootloader enables it. When kexec kernel, ocotp clk needs to be enabled
> > before reading ocotp registers, and nvmem API with platform driver
> > supported can accomplish this.
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > ---
> >
> The patch reads V6, but the change log only shows V2.  Can you
> elaborate on what has changed between V2 and V6?
>
> adam
>
> > v2: remove the subject prefix "LF-2571-4"
> > v3: Keep the original way which uses device_initcall to read soc unique
> >     ID, and add the other way which uses module_platform_driver and
> >     nvmem API, so that it will not break the old version DTBs.
> > v4: delete "__maybe_unused"
> >     delete MODULE_DEVICE_TABLE(of, imx8m_soc_match);
> >     rename match table, "fsl,imx8mm/n/q/p" is actually a machine
> > compabile and "fsl,imx8mm/n/q/p-soc" is a compabile of soc@0
> >     delete "flag" and change to determine whether the pointer is NULL
> >     ues of_find_matching_node_and_match()
> >     delete of_match_ptr()
> > v5: add cleanup part "of_node_put"
> >     add note to explain that why device_initcall still exists
> > v6: none

Hi Adam,

It says up to v6, just in unnatural order... I was also surprised.

Best regards,
Krzysztof
