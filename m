Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA05528D8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgJNC7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbgJNC7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:59:30 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC81D21775;
        Wed, 14 Oct 2020 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602644369;
        bh=E7II5Y0NTzGOBCCR+nzlLEQrPpHNTPRGQQMsY+BHHbo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jus7c6tL3q2EV0qMSWqIE53TNMi93FnY1hEYKzH+T3x95vx0CvQOwxu+qsjCYbZHH
         OVwC9CZLqf+pNIrvLHeySH8PCj6pnyg8ZiqfD9PgOTfH3Erh8Nvmv7qVu39Z6Fe6IL
         KDievpja9eCEsBw8o/1CprU0CXEvMeb8K7JIyJCw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598338751-20607-3-git-send-email-claudiu.beznea@microchip.com>
References: <1598338751-20607-1-git-send-email-claudiu.beznea@microchip.com> <1598338751-20607-3-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 2/3] clk: at91: clk-main: update key before writing AT91_CKGR_MOR
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Tue, 13 Oct 2020 19:59:28 -0700
Message-ID: <160264436853.310579.18021487516220890712@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-08-24 23:59:10)
> SAMA5D2 datasheet specifies on chapter 33.22.8 (PMC Clock Generator
> Main Oscillator Register) that writing any value other than
> 0x37 on KEY field aborts the write operation. Use the key when
> selecting main clock parent.
>=20
> Fixes: 27cb1c2083373 ("clk: at91: rework main clk implementation")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
