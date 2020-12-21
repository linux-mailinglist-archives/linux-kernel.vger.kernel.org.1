Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94352DF788
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 02:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgLUBsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 20:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgLUBr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 20:47:59 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608515238;
        bh=cAPnsXBJUnGGzwY3CB4NbAYIw7ntX3aA/4lciHAco70=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eNxmGVmrCnazZEwWwNha+XOTmgHmG46/YENnYewukqN+i+OnHDXUH5ZGttP+TRQtK
         xvl8npBVyso5WjaIWUbGVZUtkm8rn/a8l6VYNkzs4Pr+yQ+B/9pkR59W4q374s1abt
         btgZQcyw+uYSqPPLNFIMrtAKR63PNFmRaYC5qEYHEtY072msUDPlOXP6Th62H3eZim
         XoyZXT1h82ongneFSb/pKfGDRYj04JKBa1yxJvyy9H2O8m6M4jfFrB4qi4DS8LlPjJ
         EhBKbj4iGrOhHCHeG77j1BbUWowE+4jB7bOJ5pVdFlT5sqMFhJ+k+Zjj/y0gryY9Zr
         uHYOjfqSoqz6g==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201220162135.yyijnczu6dxgnpda@pali>
References: <20201106100039.11385-1-pali@kernel.org> <160842189035.1580929.16863503861561557281@swboyd.mtv.corp.google.com> <20201220162135.yyijnczu6dxgnpda@pali>
Subject: Re: [PATCH] clk: mvebu: a3700: fix the XTAL MODE pin to MPP1_9
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek Behun <marek.behun@nic.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Terry Zhou <bjzhou@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
To:     Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Sun, 20 Dec 2020 17:47:17 -0800
Message-ID: <160851523731.1580929.3311960856996476601@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2020-12-20 08:21:35)
> On Saturday 19 December 2020 15:51:30 Stephen Boyd wrote:
> > Quoting Pali Roh=C3=A1r (2020-11-06 02:00:39)
> > > From: Terry Zhou <bjzhou@marvell.com>
> > >=20
> > > There is an error in the current code that the XTAL MODE
> > > pin was set to NB MPP1_31 which should be NB MPP1_9.
> > > The latch register of NB MPP1_9 has different offset of 0x8.
> > >=20
> > > Signed-off-by: Terry Zhou <bjzhou@marvell.com>
> > > [pali: Fix pin name in commit message]
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > Fixes: 7ea8250406a6 ("clk: mvebu: Add the xtal clock for Armada 3700 =
SoC")
> > > Cc: stable@vger.kernel.org
> > >=20
> > > ---
> >=20
> > Applied to clk-next
>=20
> Hello Stephen! As this is fix also for stable releases, could you please
> queue this patch for 5.11 release?

No problem.
