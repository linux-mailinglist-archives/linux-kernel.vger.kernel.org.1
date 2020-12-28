Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D972E6984
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgL1Q7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:59:19 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33743 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgL1Q7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:59:18 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8040820003;
        Mon, 28 Dec 2020 16:58:34 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2] drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs
Date:   Mon, 28 Dec 2020 17:58:34 +0100
Message-Id: <160917470723.1246911.18364328241377492779.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211135846.1334322-1-sudeep.holla@arm.com>
References: <20201211135846.1334322-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 13:58:46 +0000, Sudeep Holla wrote:
> Since at91_soc_init is called unconditionally from atmel_soc_device_init,
> we get the following warning on all non AT91 SoCs:
> 	" AT91: Could not find identification node"
> 
> Fix the same by filtering with allowed AT91 SoC list.

Applied, thanks!

[1/1] drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs
      commit: 960ddf70cc11024e6e9dac206316d0160e00a77d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
