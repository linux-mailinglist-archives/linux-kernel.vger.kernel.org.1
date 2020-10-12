Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822EA28C157
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbgJLTRY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Oct 2020 15:17:24 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57204 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbgJLTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:17:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A63AF6125F33;
        Mon, 12 Oct 2020 21:17:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0sY4GwlcOtH7; Mon, 12 Oct 2020 21:17:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1558A61D8A8D;
        Mon, 12 Oct 2020 21:17:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VOYcOp75qzIk; Mon, 12 Oct 2020 21:17:19 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DEBF16125F33;
        Mon, 12 Oct 2020 21:17:19 +0200 (CEST)
Date:   Mon, 12 Oct 2020 21:17:19 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2029402034.189005.1602530239737.JavaMail.zimbra@nod.at>
In-Reply-To: <20201012070958.11083-1-vigneshr@ti.com>
References: <20201012070958.11083-1-vigneshr@ti.com>
Subject: Re: [PATCH] mtd: hyperbus: Fix build failure when only
 RPCIF_HYPERBUS is enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: hyperbus: Fix build failure when only RPCIF_HYPERBUS is enabled
Thread-Index: Uh0XQbUp09aZK/SHpd4OdKcrRr0PTg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Vignesh Raghavendra" <vigneshr@ti.com>
> An: "Vignesh Raghavendra" <vigneshr@ti.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>
> CC: "Sergei Shtylyov" <sergei.shtylyov@gmail.com>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 12. Oktober 2020 09:09:58
> Betreff: [PATCH] mtd: hyperbus: Fix build failure when only RPCIF_HYPERBUS is enabled

> commit 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver") leads
> to build failure[1] with COMPILE_TEST and RPCIF_HYPERBUS enabled. This
> is because driver needs functions RENESAS_RPCIF which is only buildable
> for CONFIG_ARCH_RENESAS.
> 
> Fix this by dropping COMPILE_TEST from RPCIF_HYPERBUS Kconfig entry.
> This ensures driver can be built only when RENESAS_RPCIF is also
> selected.
> 
> [1]:
> rpc-if.c:(.text+0x20): undefined reference to `rpcif_disable_rpm' ld:
> drivers/mtd/hyperbus/rpc-if.o: in function `rpcif_hb_prepare_read':
> rpc-if.c:(.text+0xd6): undefined reference to `rpcif_prepare' ld:
> drivers/mtd/hyperbus/rpc-if.o: in function `rpcif_hb_read16':
> [...]
> 
> Fixes: 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver") leads
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> 
> Based on mtd/next
> 
> Richard,
> 
> Could you please pull this into mtd/next?

Applied! :-)

Thanks,
//richard
