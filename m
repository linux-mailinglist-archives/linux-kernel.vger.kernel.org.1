Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1533E2DCEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgLQJoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 04:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQJox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:44:53 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608198253;
        bh=ikfT3J4cp9RZ4SXbFw0CdXwwOatRQz49AWAYsE6V1Gc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tr+DCue326ay89U4z4qnr4do/C0Q/NNVNHdH0JE9G7d9KrUdbg+04uZoLHBEVd/zo
         asNtmtRWfo63N/QRIDzuLefbruJ258o/CR1YZwT9d2tP6+Y+gTPIzSGoaCFuh1K/Qc
         jjh+wBguFpWkyiQA4WGlgK2JErUoxetcE9X8sLOCGggI+lOsIYZG5c5NnYkvsk9lnv
         5X+Vf84ZIQBX8kpK42JtYan4Sh9H9B1Omlqf8NKAh7scPC1jl8t1cyZqfpi0e3JaVU
         sOkTDGZAUfXlo5Uo1rXw99shDRUVemfML4ddC9CgDguAucvvF55T8FaQ7RUkOmZhU0
         qacLr8sgiGrww==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201115203432.13934-1-digetx@gmail.com>
References: <20201115203432.13934-1-digetx@gmail.com>
Subject: Re: [PATCH v2] clk: Add hardware-enable column to clk summary
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 17 Dec 2020 01:44:11 -0800
Message-ID: <160819825148.1580929.18243466975992148882@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2020-11-15 12:34:32)
> Add "hardware enable" column to the clk summary in order to show actual
> hardware enable-state of all clocks. The possible states are "Y/N/?",
> where question mark means that state is unknown, i.e. clock isn't a
> mux and clk-driver doesn't support is_enabled() callback for this clock.
>=20
> In conjunction with clk_ignore_unused, this tells us what unused clocks
> are left enabled after bootloader. This is also useful a useful aid for
> debugging interactions with firmware which changes clock states without
> notifying kernel.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next
