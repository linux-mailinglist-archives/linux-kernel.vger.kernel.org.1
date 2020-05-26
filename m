Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA5D1A4D60
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 04:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgDKCGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 22:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgDKCGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:06:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B35A2078E;
        Sat, 11 Apr 2020 02:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586570808;
        bh=cqQHICDlQYt+YHy+M5Ki3zElzEywEsrfk8xOa//FTqE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pg77HT6z8He1VaE2NrM3WF72TCihcC55IYYroLSsU+MZIg8FFnv1erH/HtwrJCCDX
         6O4mdR9uXpLlc1i3M3vDLetp4GhSMVkesMhjdVI7TDfo12Vv0heLZGGkg/zcr+q43W
         7L0XiSFGF70AhQQ6rRniXpIybeC2JrIGclGvcOoc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200408155402.2138446-1-arnd@arndb.de>
References: <20200408155402.2138446-1-arnd@arndb.de>
Subject: Re: [PATCH] clk: asm9260: fix __clk_hw_register_fixed_rate_with_accuracy typo
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 10 Apr 2020 19:06:47 -0700
Message-ID: <158657080736.199533.14290297278383794385@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-04-08 08:53:43)
> The __clk_hw_register_fixed_rate_with_accuracy() function (with two '_')
> does not exist, and apparently never did:
>=20
> drivers/clk/clk-asm9260.c: In function 'asm9260_acc_init':
> drivers/clk/clk-asm9260.c:279:7: error: implicit declaration of function =
'__clk_hw_register_fixed_rate_with_accuracy'; did you mean 'clk_hw_register=
_fixed_rate_with_accuracy'? [-Werror=3Dimplicit-function-declaration]
>   279 |  hw =3D __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pl=
l_clk,
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       clk_hw_register_fixed_rate_with_accuracy
> drivers/clk/clk-asm9260.c:279:5: error: assignment to 'struct clk_hw *' f=
rom 'int' makes pointer from integer without a cast [-Werror=3Dint-conversi=
on]
>   279 |  hw =3D __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pl=
l_clk,
>       |     ^
>=20
> From what I can tell, __clk_hw_register_fixed_rate() is the correct
> API here, so use that instead.
>=20
> Fixes: 728e3096741a ("clk: asm9260: Use parent accuracy in fixed rate clk=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-fixes
