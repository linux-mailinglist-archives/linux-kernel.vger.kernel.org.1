Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C5F1E39E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgE0HKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 03:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgE0HKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:10:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879B22078C;
        Wed, 27 May 2020 07:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590563414;
        bh=5f88nzMEqPegezJKOkJqZXoqontH74AXnh+2bhAJsmo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=t5cNX77+4RbiAEdrszt2vjDDTNux0be5OEVSAxqKUyMPYEKG6r+VUtx/2z9tO08B6
         otpHXxk42k57ptJbk56rY8zXBpE+fImfz6Lz0Ir3aSShqx6hTwaG6hfuGw/GEhj5uI
         F0Mpf+dwsLgmBUY6Q5bL2XeUP1Q3zkVIZZzLUtzg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200508220238.4883-1-rikard.falkeborn@gmail.com>
References: <20200508220238.4883-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] clk: bcm2835: Constify struct debugfs_reg32
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, eric@anholt.net,
        f.fainelli@gmail.com, mturquette@baylibre.com,
        nsaenzjulienne@suse.de, rjui@broadcom.com, sbranden@broadcom.com,
        wahrenst@gmx.net
Date:   Wed, 27 May 2020 00:10:13 -0700
Message-ID: <159056341376.88029.8430380128281240784@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rikard Falkeborn (2020-05-08 15:02:38)
> bcm2835_debugfs_clock_reg32 is never changed and can therefore be made
> const.
>=20
> This allows the compiler to put it in the text section instead of the
> data section.
>=20
> Before:
>    text    data     bss     dec     hex filename
>   26598   16088      64   42750    a6fe drivers/clk/bcm/clk-bcm2835.o
>=20
> After:
>    text    data     bss     dec     hex filename
>   26662   16024      64   42750    a6fe drivers/clk/bcm/clk-bcm2835.o
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---

Applied to clk-next
