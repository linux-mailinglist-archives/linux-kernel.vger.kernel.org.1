Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498AC2B30DB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKNU64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgKNU6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:58:55 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A632242E;
        Sat, 14 Nov 2020 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387535;
        bh=Y51KJWly+cXvpdfsPzX2sOULAb0WXaebfYYmoq5wEOA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j7B8L37k1Hx9ysm2Mqzh+LVzR4vYo6t1U6QXfo55+xSCyxbtxzyu75YYloVFZSD70
         YTKWDlVE+wksQ8ecDl9NVNs56irYwwpaYfeJ2R3uYUTzGFYMAdcqLUCl6szaoPUf+I
         Eo0WmSTFGiLmriNuAeOFcwa+GmuNw9bfcfD2vObI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201021163847.595189-2-jbrunet@baylibre.com>
References: <20201021163847.595189-1-jbrunet@baylibre.com> <20201021163847.595189-2-jbrunet@baylibre.com>
Subject: Re: [PATCH 1/2] clk: add devm variant of clk_notifier_register
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Date:   Sat, 14 Nov 2020 12:58:53 -0800
Message-ID: <160538753380.60232.3216881025872069497@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-10-21 09:38:46)
> Add a memory managed variant of clk_notifier_register() to make life easi=
er
> on clock consumers using notifiers
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next
