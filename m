Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725102DC7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgLPUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgLPUWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:22:00 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608150080;
        bh=b1ue91HKAdvBszoEAlb+S8MEYd6BUIJHMyKElC7UKEI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bFsNp+XaUY3yM/uKFPmFtw+0F+Rvv9QTkkS8lgcmQWattARGL7xIG8aHw1BYmRH1K
         p/mBbkr9SJTOx7lQQPm4A3bjfqt1wBrMe4X5PH1OhzHRleDaP+vATxj2qivGGROvMd
         rYPHa+n7omYgL9hl3ra9EDfZzEx8giao8pZc/A2H4YBkt2tKBZaCI7bdExb6SjndyX
         al8rfGtHj0LVZHq8SALLTmygzxfBYufYf+OesKJRcagGfLLbUZD6ayWL5nyHJSNkiw
         e0FsW0+fpLIaiQ2uDGpsJBWWo916DczBWuQ90c2JVq0JPUJlF6g5PMsrspeaiWB/vV
         4yTNnmQybLOjQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201209094916.17383-3-zong.li@sifive.com>
References: <20201209094916.17383-1-zong.li@sifive.com> <20201209094916.17383-3-zong.li@sifive.com>
Subject: Re: [PATCH v7 2/5] clk: sifive: Use common name for prci configuration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>
To:     Zong Li <zong.li@sifive.com>, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        pragnesh.patel@openfive.com, schwab@linux-m68k.org,
        yash.shah@sifive.com
Date:   Wed, 16 Dec 2020 12:21:18 -0800
Message-ID: <160815007878.1580929.1338503226146217305@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-12-09 01:49:13)
> Use generic name CLK_SIFIVE_PRCI instead of CLK_SIFIVE_FU540_PRCI. This
> patch is prepared for fu740 support.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>
> ---

Applied to clk-next
