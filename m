Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E52DC7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgLPUVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgLPUVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:21:54 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608150073;
        bh=E6+S0iH7JA6VSioCcRQNsQtNX73hr73AJHCOek3qQ2U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i8ELWSJXsO/nvyD3rEMIkiZpJ4FaJ8R6rvUnukYchKNLenDvb7MAnP1Wc8X48UBhA
         HKBT6liNXbsbYY4IFcH3+wQAJLe/JLdvH/4xkUb1k7eJWHIlveQJ6I5ZdMNPV5Mard
         uiVgwDb0dc7XOWjgW5DfLCDNhsfjjIGSXiQjXsv9xp3Odu4xMx7gR6t00nElfk3wmu
         Tq1br+HoRo1Ew2hispa81r9iNWU20hE47XMtSCKZbAu1ucGyxBQCYyVWeEF5eUDTIi
         ZedmPDoyxPFIes1cmB5KZCRMOVrcDbw8IVWeS1Y9D3UAKiIvywrCQVx4PLhnDdTsnD
         X93r0EneG75tw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201209094916.17383-2-zong.li@sifive.com>
References: <20201209094916.17383-1-zong.li@sifive.com> <20201209094916.17383-2-zong.li@sifive.com>
Subject: Re: [PATCH v7 1/5] clk: sifive: Extract prci core to common base
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Zong Li <zong.li@sifive.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
To:     Zong Li <zong.li@sifive.com>, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        pragnesh.patel@openfive.com, schwab@linux-m68k.org,
        yash.shah@sifive.com
Date:   Wed, 16 Dec 2020 12:21:12 -0800
Message-ID: <160815007240.1580929.5097103153471981375@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Zong Li (2020-12-09 01:49:12)
> Extract common core of prci driver to an independent file, it could
> allow other chips to reuse it. Separate SoCs-dependent code 'fu540'
> from prci core, then we can easily add 'fu740' later.
>=20
> Almost these changes are code movement. The different is adding the
> private data for each SoC use, so it needs to get match data in probe
> callback function, then use the data for initialization.
>=20
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---

Applied to clk-next
