Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C61E3673
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 05:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgE0DWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 23:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:22:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85142207D8;
        Wed, 27 May 2020 03:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590549724;
        bh=3BfeorGCkLtdTas1uzCnbhiIA2SgE1HFtEW+jxo7+p4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=w1F1E7q7WjgpBJt3y6p4FfKfpi3hE1+4bLCoozWc/cNiKtCS/TYTU3McAIHrjdZ69
         WUxhQSB9GJ4gzWd9dNT6IOv6+0i6AK9xEc34FPhVUhU5P1/5fdtugE2JggRbCfAvdw
         Cnu1VgUlD5mcSJodvEa2vHCqj4tp2qP/Y3SDjpYc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1588508289-10140-1-git-send-email-claudiu.beznea@microchip.com>
References: <1588508289-10140-1-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/2] clk: at91: pmc: do not continue if compatible not located
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Tue, 26 May 2020 20:22:03 -0700
Message-ID: <159054972384.88029.12499827364972798016@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-05-03 05:18:08)
> pmc_register_ops() is called for all AT91 devices. Return
> -ENODEV in case of_find_matching_node() returns NULL.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
