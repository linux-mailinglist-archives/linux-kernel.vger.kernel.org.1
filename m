Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39562B30C8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKNUyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKNUye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:54:34 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C42C22409;
        Sat, 14 Nov 2020 20:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387274;
        bh=Iwt23hbsl5VQbWNx6NNp6vv8PfR3pLoUQgv0aUq3IhE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ES1K3w8gsQr1pegsMlgZxBYtRlI/aJeTS5JsrsUG4t7soo4GF/lA22f2amJhbvAhm
         cQWlZHu3KldcGrBZkZamvmql+9eou1Nr2wBfjvbsg/OJ29zGdJZiuy2+mFii6vKebq
         HhDHVs1ks8mvhxnK0cXv70JA0OBGpRCeK5cUM4Qo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201021162147.563655-2-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com> <20201021162147.563655-2-jbrunet@baylibre.com>
Subject: Re: [PATCH v2 1/3] clk: avoid devm_clk_release name clash
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Nov 2020 12:54:32 -0800
Message-ID: <160538727297.60232.6643959847633368696@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-10-21 09:21:45)
> In clk-devres.c, devm_clk_release() is used to call clk_put() memory
> managed clock. In clk.c the same name, in a different scope is used to ca=
ll
> clk_unregister().
>=20
> As it stands, it is not really a problem but it does not readability,
> especially if we need to call clk_put() on managed clock in clk.c
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next
