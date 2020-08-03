Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5361A23AE72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 22:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgHCUwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 16:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHCUwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:52:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5BE22BF3;
        Mon,  3 Aug 2020 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596487966;
        bh=KkMFcL/WXUfYXneGIkwKgonJSMxmmqy0pZLbqTkdThg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Kz5PC1pSQ13vmx1spi1kPX8nD5Y9p4FKSVyGGB2VUrDdsaRWsCDywXMmtoI7K2jAm
         CBQnAIGTHY+Es9i28rJq1CW4nBY/qvBHGFk+S1WYi3gnAbEz2Iu3b+wnTl7UnRcTYQ
         AdA1jEUONPhJIbyovnodr/3WvybwNa+yyIHSGA34=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200803084835.21838-1-geert+renesas@glider.be>
References: <20200803084835.21838-1-geert+renesas@glider.be>
Subject: Re: [PATCH] clk: hsdk: Fix bad dependency on IOMEM
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     David Gow <davidgow@google.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 03 Aug 2020 13:52:45 -0700
Message-ID: <159648796545.1360974.17742434774055874684@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-08-03 01:48:35)
> CONFIG_IOMEM does not exist.  The correct symbol to depend on is
> CONFIG_HAS_IOMEM.
>=20
> Fixes: 1e7468bd9d30a21e ("clk: Specify IOMEM dependency for HSDK pll driv=
er")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next
