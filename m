Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A434224686
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgGQXB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 19:01:56 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37843 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQXB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:01:56 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AA4261BF205;
        Fri, 17 Jul 2020 23:01:53 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     yu kuai <yukuai3@huawei.com>, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, linux@armlinux.org.uk
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        yi.zhang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: at91: pm: add missing put_device() call in at91_pm_sram_init()
Date:   Sat, 18 Jul 2020 01:00:24 +0200
Message-Id: <159502678064.777887.12884289483323132020.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604123301.3905837-1-yukuai3@huawei.com>
References: <20200604123301.3905837-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 20:33:01 +0800, yu kuai wrote:
> if of_find_device_by_node() succeed, at91_pm_sram_init() doesn't have
> a corresponding put_device(). Thus add a jump target to fix the exception
> handling for this function implementation.

Applied, thanks!

[1/1] ARM: at91: pm: add missing put_device() call in at91_pm_sram_init()
      commit: f87a4f022c44e5b87e842a9f3e644fba87e8385f

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
