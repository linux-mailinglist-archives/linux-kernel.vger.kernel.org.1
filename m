Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0142DC7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgLPUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgLPUWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:22:18 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608150098;
        bh=7ckuVfE0d05hL3c+ScGa4gAayuEONTcC8xOhReADeyM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=YK2h4QuCqaxq6KZIXPkLIcKysjp9AyWuLXFN1crIGkTx8ArT9vkxFop93wGrdA2YG
         axtvGpeb46FMFyrgUi84IGrNkokb+zs6xcdTCvS4RnqvVMo+yIZOa5qF1qipu02k+T
         YyHNeJOwpy6PLsNzgCavmBD91ZXmCZY+nj7fWvE3qAbGTnyZO/w62frre0/s8gKad5
         Gdz+Xwuaf3Cxr5XT0UBRWT5pJBSqXrLcePVcxPGGZEVnZnylz4eoNogqqbyCfNaSv3
         Up+YDKcSLHPwKut/xXPYpYabR8UAbdzkAJe9diXkXKPA69MJ18ydtiWVw1DEIlWygT
         p+DQYrx8tOfRQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201209094916.17383-6-zong.li@sifive.com>
References: <20201209094916.17383-1-zong.li@sifive.com> <20201209094916.17383-6-zong.li@sifive.com>
Subject: Re: [PATCH v7 5/5] clk: sifive: Add clock enable and disable ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Zong Li <zong.li@sifive.com>
To:     Zong Li <zong.li@sifive.com>, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        pragnesh.patel@openfive.com, schwab@linux-m68k.org,
        yash.shah@sifive.com
Date:   Wed, 16 Dec 2020 12:21:36 -0800
Message-ID: <160815009666.1580929.1809751674908825268@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-12-09 01:49:16)
> From: Pragnesh Patel <pragnesh.patel@sifive.com>
>=20
> Add new functions "sifive_prci_clock_enable(), sifive_prci_clock_disable()
> and sifive_clk_is_enabled()" to enable or disable the PRCI clock
>=20
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> Tested-by: Zong Li <zong.li@sifive.com>
> ---

Applied to clk-next
