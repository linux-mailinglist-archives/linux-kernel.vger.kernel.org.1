Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0936227B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGUJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 05:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUJRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:17:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233DA20792;
        Tue, 21 Jul 2020 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595323073;
        bh=EpFAb27sGLwFNOk1HxhQm+upKgiBrlrxa2Y4c8oI5VA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ovn/SmP2YnVoi61dJntmTWhISW4wOV7R4MtmL0yhzWkmJvFlGu/OHrkbiLrk1Alf6
         xlUqVDPk//fntjo5lhOhBspebW8HarT5RUNRwxUh4+V1cSJfdwiz6deSwE7LyGULUM
         IX0j0Tbew8MoB+I/QJx/qx2DihxwEqxqLb1V30sE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200719143324.25695-1-trix@redhat.com>
References: <20200719143324.25695-1-trix@redhat.com>
Subject: Re: [PATCH] clk: vc5: Fix use after free in vc5_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
To:     aford173@gmail.com, marek.vasut@gmail.com, mturquette@baylibre.com,
        trix@redhat.com
Date:   Tue, 21 Jul 2020 02:17:52 -0700
Message-ID: <159532307235.3847286.13486568388676452154@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting trix@redhat.com (2020-07-19 07:33:24)
> From: Tom Rix <trix@redhat.com>
>=20
> clang static analysis reports this error
>=20
> clk-versaclock5.c:887:3: warning: Use of memory after it is freed
>   [unix.Malloc]
>       dev_err(&client->dev, "unable to register %s\n", init.name);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> A representative problem block of code is
>=20
> ret =3D devm_clk_hw_register(&client->dev, &vc5->clk_mux);
> kfree(init.name);       /* clock framework made a copy of the name */
> if (ret) {
>         dev_err(&client->dev, "unable to register %s\n", init.name);
>         goto err_clk;
> }
>=20
> init.name is freed and then used.
>=20
> So reorder the free.
>=20
> Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multip=
le instances")
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

There's another patch on the mailing list for this.
