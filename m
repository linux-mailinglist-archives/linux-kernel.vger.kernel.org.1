Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9822C227
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgGXJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgGXJWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:22:33 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052B92063A;
        Fri, 24 Jul 2020 09:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582553;
        bh=YxjCqc3c70WmBM1Z/2lO1civQ0BWIy65LVGyrw/aUWs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TnD7bEFspL7oSxi5oGj62ESihSAjCshfJ0+8qT44VidUXvWbgZyI1byG4jrGOZPpa
         kmxr/7BAjhAZ4YYb4i9gdoXt7ajQEbjt73UF2AvrEvyCpuuWywQ/DQiSzh9pi3uXKG
         Hp0RZfdgxkvWjQ12N2bUw0fcFsd2ubKWRJ3VSgBQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-18-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-18-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 17/18] clk: at91: clk-utmi: add utmi support for sama7g5
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:22:32 -0700
Message-ID: <159558255240.3847286.332647413278631908@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:25)
> Add UTMI support for SAMA7G5. SAMA7G5's UTMI control is done via
> XTALF register. Values written at bits 2..0 in this register
> correspond to the on board crystal oscillator frequency.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
