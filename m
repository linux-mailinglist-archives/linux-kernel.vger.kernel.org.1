Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B22DF227
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgLSXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:32:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:32906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgLSXcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:32:36 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608420715;
        bh=h4zfuL+50Lz1IKB6YCKldollgufXdyY4atdbMGPLpjM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gQrlDMKzbpiitsSgWhOZv8JejkHN0QtilFbjngg2RB5VP1eqhj55QosmLGfIUDzrE
         u/JkM9Y8rlTre8bzZb+1hGFTrSGBpO0GVKH58V3nnXmMj/znh6iHhDZk2tnZVna7QI
         795DCRlPQURN7S5lYaCXrDtqThMUz0gAmRqIlMa7SpBluBtYZnXyQoYc3NLB8F1Kik
         Aeh6zYp9QNW2hkur3higzox9ecizjbUwUNJObM4bP415MFoWAX5qJTEFEZv4lwH9MG
         1FCFTD0GUWb76a6sycJlgXSlWXAue+WCXdP8nyRXgZPQButkejmhhNDPr9m0vUWX58
         2IuU8ctnraD2Q==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1605800597-16720-7-git-send-email-claudiu.beznea@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com> <1605800597-16720-7-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v6 06/11] clk: at91: clk-sam9x60-pll: allow runtime changes for pll
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com,
        robh+dt@kernel.org
Date:   Sat, 19 Dec 2020 15:31:54 -0800
Message-ID: <160842071450.1580929.14539889501318480847@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-11-19 07:43:12)
> Allow runtime frequency changes for PLLs registered with proper flags.
> This is necessary for CPU PLL on SAMA7G5 which is used by DVFS.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
