Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0928D8B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgJNCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbgJNCuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:50:24 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC4A21775;
        Wed, 14 Oct 2020 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602643824;
        bh=t1NAjWm5WI7hLJxk22EulkFvJQp0ZmLPSt6XkGLLllk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Kqz83Gst+aikoaD44NPIkqiQe/0o5n0N2H7JEI7FVc0emRLrys9O5hEE7/s4ThdRv
         vg4B73us88R77FyibZsG+3zBaBP0Zk+njKkK5O9E4krppJNbnPizBvYBiSZ9ayQQGB
         0yUAfgyjQRKSNZlWg1nFWqxdlkzrxBGNXZAB/LTs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200928070108.14040-2-ryan_chen@aspeedtech.com>
References: <20200928070108.14040-1-ryan_chen@aspeedtech.com> <20200928070108.14040-2-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 1/1] clk: aspeed: modify some default clks are critical
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>, bmc-sw@aspeedtech.com,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Oct 2020 19:50:22 -0700
Message-ID: <160264382296.310579.9835482254268204873@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ryan Chen (2020-09-28 00:01:08)
> In ASPEED SoC LCLK is LPC clock for all SuperIO device, UART1/UART2 are
> default for Host SuperIO UART device, eSPI clk for Host eSPI bus access
> eSPI slave channel, those clks can't be disable should keep default,
> otherwise will affect Host side access SuperIO and SPI slave device.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---

Is there resolution on this thread?
