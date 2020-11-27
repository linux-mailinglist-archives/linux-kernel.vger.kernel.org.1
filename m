Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303D42C6E24
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 02:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgK0UBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 15:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbgK0T5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:57:09 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9F9208B3;
        Fri, 27 Nov 2020 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606507008;
        bh=hD40k2v78JS8MUejTYj7Rnup4W4KIqn/L63Q/BBpWx0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bppiD1tl2IfBfd/S0pS5kJoI93oBhxGkdXrQ/F4bUT0hr5RkAqGvm52w3yYnlzMVQ
         u/PqofDiI2tV0gN2fSoYn2RgEFEqXsqWrgorEakjRjhld+mr5LLjyyV7PIRrrdPZKC
         JnH3U8NAVSA34TzND4TC0oT48JAF5Q9NdqypK3OE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201127090551.50254-1-vulab@iscas.ac.cn>
References: <20201127090551.50254-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: rockchip: Remove redundant null check before clk_prepare_enable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
To:     Xu Wang <vulab@iscas.ac.cn>, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mturquette@baylibre.com
Date:   Fri, 27 Nov 2020 11:56:47 -0800
Message-ID: <160650700726.2717324.52988673805116278@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xu Wang (2020-11-27 01:05:51)
> Because clk_prepare_enable() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
