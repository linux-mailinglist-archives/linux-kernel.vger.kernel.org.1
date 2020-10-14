Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02F28D7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgJNAoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgJNAog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:44:36 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF38208B3;
        Wed, 14 Oct 2020 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602636276;
        bh=4DUZaBes3YYLqaatzpILVoxrx80tQm+TTjEwTHDICO8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hZ/RtOu9MT+6EdswbuUXSzgy8271st21H2BolSRdRF46q592D73Qh+Z8bCgBMC3i9
         rvI9HB5qc8yozyjKXBFSn0Ap5FX+Uqd1a+snk8pCATAx+IO2rhQhgVH/WjOZLa8AvE
         FtNvN+49R61Y1GCe8ZSs4OkNs5ijF3XfuozhUb+c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1601233948-11629-2-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr> <1601233948-11629-2-git-send-email-Julia.Lawall@inria.fr>
Subject: Re: [PATCH 01/18] clk: uniphier: use semicolons rather than commas to separate statements
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Valdis =?utf-8?q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 13 Oct 2020 17:44:34 -0700
Message-ID: <160263627485.310579.15618699028327766120@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2020-09-27 12:12:11)
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
>=20
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---

Applied to clk-next
