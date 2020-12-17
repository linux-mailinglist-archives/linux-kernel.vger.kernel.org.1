Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1CC2DCFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgLQKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQKvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:51:01 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608202220;
        bh=Ro0hI3oK3wxsStmiMichCc3NaGtunDmMy0N4tSUrHvA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mB5QRYpLLHdVyomEOKfAx5GO+7StHxvVBWjJMnhll97xs2z9dUkqt5tEjaRyUpXqp
         olQRzZAUwBgfLvoK+kZzvmqqAR9Hfkb2KqFDBPv0ICd8XKPFiLCbQFiPfiqXmdHQMM
         IQyMWBWd9Phwel4HlMY0tTB35bqlLZh2inDBz3v8yq/lkExn37Y8te0Iw4k9S+UCvo
         P537SdVO7+cJD2xVq7Ub+SEVCU94MI+k0UaBFy6RX+TQXePf1JvDP4WW9iuuNALcj4
         liBU4nWp27QAQfSc8SS4JNhrcwOyc3vYTccKFKT018hUyaKXRWX3HhyEtM8sOYLxSr
         3XFJMGToAdfQw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMhs-H9SiZ90NYCGL+3ad9UR7CDUiA1gb99ZcfHp10=SZtVPpg@mail.gmail.com>
References: <20201122095556.21597-1-sergio.paracuellos@gmail.com> <20201122095556.21597-3-sergio.paracuellos@gmail.com> <160819550615.1580929.14234996916739809712@swboyd.mtv.corp.google.com> <CAMhs-H_EiDot_V4Qj1Q8noAf5RNi9BOyy0WmawE+70wY7=FxDg@mail.gmail.com> <160819962346.1580929.2348154780751858972@swboyd.mtv.corp.google.com> <CAMhs-H_ixfqMxVFOf+J0O-Tp0Q0ngviMm6jHrHJSgCLwZj+Tvw@mail.gmail.com> <160820116913.1580929.15821601182796836787@swboyd.mtv.corp.google.com> <CAMhs-H9SiZ90NYCGL+3ad9UR7CDUiA1gb99ZcfHp10=SZtVPpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt: bindings: add mt7621-clk device tree binding documentation
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:MIPS <linux-mips@vger.kernel.org>, open list:STAGING 
        SUBSYSTEM <devel@driverdev.osuosl.org>, NeilBrown <neil@brown.name>, 
        open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 02:50:18 -0800
Message-ID: <160820221883.1580929.5758849422177353179@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergio Paracuellos (2020-12-17 02:38:37)
> On Thu, Dec 17, 2020 at 11:32 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Sergio Paracuellos (2020-12-17 02:14:10)
> > > node is to use architecture operations in
> > > 'arch/mips/include/asm/mach-ralink/ralink_regs.h'
> > > instead of getting a phandle using the regmap is being currently used=
...
> >
> > Can that be done with
> >
> > CLK_OF_DECLARE_DRIVER("mediatek,mt7621-sysc", my_timer_clk_init)
> >
> > ? Is the syscon used anywhere besides by the clk driver?
>=20
> Yes, for example all the gates use them to access SYSC_REG_CLKCFG1 in
> all of their 'mt7621_gate_ops' and also in all 'recalc_rate' functions
> where SYSC_REG_SYSTEM_CONFIG0, is readed.

That sounds like it's only used by the clk provider/driver? Any other
code uses the syscon?
