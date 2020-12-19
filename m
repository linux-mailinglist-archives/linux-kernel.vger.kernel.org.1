Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278F2DF157
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgLSTtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgLSTtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:49:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608407314;
        bh=tw9RrhmPriJl25KLA4OPCo3uuWpUbQk/llrJeqULCXk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nIx48oEMaaRG1I95ddukVnP1UjdIhi7Oodypjo/QxqwFUjRyuM9fnGzmkVsqOOP8W
         uMW8a6/6Q6n9g8pNN5NMzmYEN014OLJueNNuSlgyq/iHPe9TEH/W2nkxWpRAXsDfYf
         QPjT7/tyKaUhj8D6w4xCrdMXOe2o4PEpUPKTcXikruqhy/95r8CAm3ybd8gG/gNCKi
         vizRRtsL0g7PmnmPC86mk37p8MlCJNaexJL2za1sd9WfAWRJXs/gNm2UsItHvvKjEN
         9LRzXDUoGUSwZnuCAeR0Dfk/h24d0SWkMHJkouMvquu0P9iyNYDx1uaGGffUD4LT2R
         ynRTkqhnhvtIA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201202103518.21889-1-nsaenzjulienne@suse.de>
References: <20201202103518.21889-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH] clk: bcm: dvp: Add MODULE_DEVICE_TABLE()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Sat, 19 Dec 2020 11:48:33 -0800
Message-ID: <160840731315.1580929.1043525207378404751@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2020-12-02 02:35:18)
> Add MODULE_DEVICE_TABLE() so as to be able to use the driver as a
> module. More precisely, for the driver to be loaded automatically at
> boot.
>=20
> Fixes: 1bc95972715a ("clk: bcm: Add BCM2711 DVP driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to clk-next
