Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6554222C214
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGXJVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAEAB2063A;
        Fri, 24 Jul 2020 09:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582504;
        bh=1VMJq9yzY7QbzG6KZb+2LePKZYHt+/Xns6Okk/oKELA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ppJPiRn3flqFHao0j9HaTm61Lbx9YCaDmo419c5mR9d6SCuWYh5LamtO1FA2PbQV4
         9oHWcNdzPuz8klcxHSnSyk6DYfGe2+fZ+TPw8mv1jwaZ47/qJz7+jxtPWqW6crT9hA
         qhQO6LZ+w6IFTVJffNK5aaFP7D1Dx7QGuQSC3eeU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-13-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-13-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 12/18] clk: at91: clk-master: add master clock support for SAMA7G5
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:44 -0700
Message-ID: <159558250408.3847286.10708639381575932108@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:20)
> Add master clock support (MCK1..4) for SAMA7G5. SAMA7G5's PMC has
> multiple master clocks feeding different subsystems. One of them
> feeds image subsystem and is changeable based on image subsystem
> needs.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
