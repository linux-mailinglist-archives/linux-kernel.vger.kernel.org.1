Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B69B2DF164
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgLSTyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:54:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgLSTyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:54:15 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608407615;
        bh=xiP3AdpNUHOLEugoe68jbXGURKfneiyyRpCg5ydscY0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h5owMe5NC/7appqgyLi0XuNG40io16geNiKFya5bksPNTFGQSsRIOrSUGSxwV7mxn
         s2wGC0nI+mX5cEOznLZOsmV+tVqL183DcMrjKy+VQcapY9Gp+TqMGc8ZnWJnDRAZ5J
         R/I7X/9jEz8zVvRzuAYclaJ2HiiU4gupSzXuriIXaO7Q8CU3ximNKr1fdX5tkgN4nn
         XxRfl2B2jutE+VFp692zJdARBwzzlcv18XID1G+O/J4RDXzoIXfobAmazk5atklmDv
         rdIRQ5XB7Ah5m1VJxk9BCpERaJUJAmG681OwnJde5AUc5imOaNFfU5bLq5lpM7d2Os
         kzZijqVj+bs/Q==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-4-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-4-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 03/11] clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and referenced in DT
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 11:53:33 -0800
Message-ID: <160840761391.1580929.14208822809019159327@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:09)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Allow SYSPLL and CPUPLL to be referenced as a PMC_TYPE_CORE clock
> from phandle in DT.
>=20
> Suggested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [claudiu.beznea@microchip.com: adapt commit message, add CPU PLL]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
