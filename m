Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F328D8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgJNC7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgJNC7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:59:37 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411C921775;
        Wed, 14 Oct 2020 02:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602644377;
        bh=+wEREaPEPiI4QMf9zRlaz4tk2MH99pLz8KK+8iIb5LY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TsBgszLEciercDNtpqWEPrey+bWeHpRaZqNZv/VU/6k9ZbXPfJjKSFRT7zoS1XEhq
         fAiylzHYSKtLBWR98g5Y9hQQMYIPovVvAVGC0K0agjomXJJ7819w+hqt2gHD78GVx7
         YRwxK6oCiPz63evzNim0FMnYhUL3xFvJqvvldBYM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598338751-20607-4-git-send-email-claudiu.beznea@microchip.com>
References: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com> <1598338751-20607-4-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 3/3] clk: at91: clk-sam9x60-pll: remove unused variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Tue, 13 Oct 2020 19:59:36 -0700
Message-ID: <160264437607.310579.3239730580449820389@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-08-24 23:59:11)
> Fix variable set but not used compilation warning.
>=20
> Fixes: 43b1bb4a9b3e ("clk: at91: clk-sam9x60-pll: re-factor to support pl=
ls with multiple outputs")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
