Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57C22C216
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGXJVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1662074F;
        Fri, 24 Jul 2020 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582508;
        bh=RXHoUs8gG3HgkwJJrMSxdFJLiMhQhlKcCDcKmHLrb7g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NY5IGpAssHnZJ64DMD6jZEjKrD8EbNqx4QHLzXdcwzNcj6RsTfUBiFutJ6BLj1Dwi
         OaG89tSlqEzF71zxt+uo52ui8XS/BatCJUttQG10ztsVxmuCx6UVqoZGb+BgqkNFRD
         HdsnX3QO7orE7cAl9CKuu8Oh+aarnI392bAq6JK0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-14-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-14-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 13/18] clk: at91: clk-peripheral: add support for changeable parent rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:48 -0700
Message-ID: <159558250810.3847286.16562540185626421563@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:21)
> Some peripheral clocks on SAMA7G5 supports requesting parent to change
> its rate (image related clocks: csi, csi2dc, isc). Add support
> so that if registered with this option the clock rate to be
> requested from parent.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
