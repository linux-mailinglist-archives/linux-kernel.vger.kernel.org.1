Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BC2A75B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 03:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgKECpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 21:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgKECpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 21:45:46 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 944272074B;
        Thu,  5 Nov 2020 02:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604544344;
        bh=ZND+etKvo9cOoumubJj8jAyx7zVBF0vSY5DA1VtbySY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vToYG6rik7/vw09/YnScFZDKwVW3nkERgEDEL8Yf27KpbBKY5P/Ne4vovyhUQYFqY
         ciLFlMCU6d5LuUAGnh9afyXRgmEjB2DaVPKu8XUYAQADGo3d8EuXA6wH9DPToqMjvB
         +KKewqJce9mQktXfsCl34SICmOwIPwpJJUmqlr2E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b10784643665ad56ca41ea6754c7f28f8be1c7ca.1602838910.git.zong.li@sifive.com>
References: <cover.1602838910.git.zong.li@sifive.com> <b10784643665ad56ca41ea6754c7f28f8be1c7ca.1602838910.git.zong.li@sifive.com>
Subject: Re: [PATCH 1/4] clk: sifive: Extract prci core to common base
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, yash.shah@sifive.com
Date:   Wed, 04 Nov 2020 18:45:42 -0800
Message-ID: <160454434294.3965362.6100009498384462585@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-10-16 02:18:23)
> Extract common core of prci driver to an independent file, it could
> allow other chips to reuse it. Separate SoCs-dependent code 'fu540'
> from prci core, then we can easily add 'fu740' later.

Please indicate if there are any functional changes or this is just code
movement.

>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/clk/sifive/Makefile      |   2 +
>  drivers/clk/sifive/fu540-prci.c  | 586 +------------------------------
>  drivers/clk/sifive/fu540-prci.h  |  21 ++
>  drivers/clk/sifive/sifive-prci.c | 409 +++++++++++++++++++++
>  drivers/clk/sifive/sifive-prci.h | 201 +++++++++++

How much of this is a copy/pastes? Can you generate patches with
format-patch -M -C to try to find copies and renames?

>  5 files changed, 652 insertions(+), 567 deletions(-)
>  create mode 100644 drivers/clk/sifive/fu540-prci.h
>  create mode 100644 drivers/clk/sifive/sifive-prci.c
>  create mode 100644 drivers/clk/sifive/sifive-prci.h
>
