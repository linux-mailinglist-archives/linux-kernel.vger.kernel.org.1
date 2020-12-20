Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB12DF269
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 01:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgLTAFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 19:05:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgLTAFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 19:05:03 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608422662;
        bh=gqMTugewts3Hb8LJ33K8G/Tf7vaLtKfa16r7eCRI6gU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XoTOBxrYnoyRperv63KRlKk2+OR/42U13vK+/c9DHz25UKw38Sys+vGyJsWA+jv/F
         z4MrZZnb3nSWmTb+y9Gv8RIXY/Hvrt1lDh9DN8gLsn1CD/ELYUxSgEDMo+y9BoLv8X
         iBjNPxPBrGklNIyYSLAMuWUgUpKs6TvF8zTCum9IqjJ+yFgpZkFYuids2E5hoZZ0hU
         JirI8P1oithOR8emOnXzPj58XACEmMptMZCvqpB+5kBNZngup1mN9OJVXWZUTN/ko9
         7mGg3O+aaaF80cvVSbzRqZ7q+QGrBvkktCB0jabh+M1RUtnOXL2V9/NnA3ZYSmVaoz
         UCSv6rtV5zIRQ==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201202123446.21902-1-info@metux.net>
References: <20201202123446.21902-1-info@metux.net>
Subject: Re: [PATCH v3] drivers: clk: make gpio-gated clock support optional
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Date:   Sat, 19 Dec 2020 16:04:21 -0800
Message-ID: <160842266128.1580929.15786525540819499647@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enrico Weigelt, metux IT consult (2020-12-02 04:34:46)
> The gpio-gate-clock / gpio-mux-clock driver isn't used much,
> just by a few ARM SoCs, so there's no need to always include
> it unconditionally.
>=20
> Thus make it optional, but keep it enabled by default.
>=20
> changes v3: default to y when gpiolib enabled
>             fix depends on gpiolib to uppercase
>=20
> changes v2: added missing dependency on gpiolib
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---

Applied to clk-next
