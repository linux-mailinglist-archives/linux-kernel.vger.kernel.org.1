Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E1234ED1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 02:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgHAAEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 20:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgHAAEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 20:04:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120F620829;
        Sat,  1 Aug 2020 00:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596240294;
        bh=yxrZ9zLGHwCQkdHooEsEc31zMVV+ku9MMSMFZZ9NGaU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kVGL86X56eRvB5piccOvfJH72r8Au6nFJykPkbYuTBA6yHT1lrcHDmVIzhSa1nn+7
         sR2s+CRu+9jkqUWhq/YGiPr5SqdYBOM1K7JzC+bpjfRbA3T/Ro6gVIwpKPK6tP9ymn
         WyaVfCUi6b3TKPS3perpyiXW2tPlOI5DAChzlrgM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200729152634.GA26850@dragon>
References: <1596034117-24246-1-git-send-email-Anson.Huang@nxp.com> <20200729152634.GA26850@dragon>
Subject: Re: [PATCH V7 0/6] Support building i.MX ARMv8 platforms clock driver as module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        arnd@arndb.de, peng.fan@nxp.com, abel.vesa@nxp.com,
        fugang.duan@nxp.com, daniel.baluta@nxp.com, yuehaibing@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 31 Jul 2020 17:04:52 -0700
Message-ID: <159624029292.1360974.8047925230522121316@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2020-07-29 08:26:35)
> On Wed, Jul 29, 2020 at 10:48:31PM +0800, Anson Huang wrote:
> > Nowdays, there are more and more requirements of building SoC specific =
drivers as
> > modules, such as Android GKI (generic kernel image), this patch set sup=
ports building
> > i.MX ARMv8 SoCs clock drivers as modules,
> >=20
> > The CLK_IMXxxx is introduced for i.MX ARMv7 platforms in order to make =
the build
> > options aligned, the reason why i.MX ARMv7 platforms clock driver do NO=
T support
> > module build and COMPILE_TEST is because, some drivers like i.MX GPT ti=
mer driver
> > depends on clock driver to be ready before it, GPT driver uses TIMER_OF=
_DECLARE(),
> > while i.MX6/7 clock drivers use CLK_OF_DECLARE(), and GPT driver is cri=
tical for
> > i.MX6/7 platforms kernel boot up, so GPT driver needs to be changed to =
support
> > loadable clock driver first, then the i.MX6/7 clock drivers can support=
 loadable
> > module, this will be done later.
> >=20
> > Changes since V6:
> >       - improve patch #6's subject and move it to be first patch of thi=
s series.
> >=20
> > Anson Huang (6):
> >   clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31
> >     bits
> >   clk: composite: Export clk_hw_register_composite()
> >   clk: imx: Support building i.MX common clock driver as module
> >   clk: imx: Add clock configuration for ARMv7 platforms
> >   clk: imx8m: Support module build
> >   clk: imx8qxp: Support building i.MX8QXP clock driver as module
>=20
> Acked-by: Shawn Guo <shawnguo@kernel.org>
>=20
> Stephen,
>=20
> I had sent v5.9 material off my hand to you, so please pick this up
> directly if it looks good to you.  Thanks!
>=20

Ok. At this point it's pretty late so I think it will have to wait to
after the merge window unless there's an rc8.
