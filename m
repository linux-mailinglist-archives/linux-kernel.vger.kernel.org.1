Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568522138FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgGCKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 06:53:26 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33754 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593773601; x=1625309601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fbZsA13yxwa9teNIQIl5i9ecK01Ey9FAWxpcodemLkg=;
  b=V1joZJ8EUPxTbdKChKIT4BTUVLGkMc17R1m4YxXrlh3k57dnojsAPW5X
   emyQ0oqnLT11GwSCwDZJj/JYocKHvWqATDclJzo0dj5kcEph2VJ63uOb/
   v/RXVI2TJXAXmFj+Jabx4syEIxhxEGs+t2NxhRyrT2buGoYe+kPspaFn1
   Fnt1Q0nod/fr6PgBsTGSTGWd75D+B7X+X7fQJGgP2pixkYn3LdvVJdHy1
   8DlA93PsNknI6eXp5jsMWtee1+jrfJYoIRWLeOXmDp7M3e6pqnoWOh/Kk
   XsTTjmSfrAUPd23zYyO90mMCLbpkjfT3UdJEZuWlAIVOzoNLnNQt9+VQ9
   A==;
IronPort-SDR: /LCZH9duXpF5WXUZdbbZOQ1XBByBgXnqKYGC203mHlboByrImXmoGoxXoSQMTMm4xVcGjuvSXq
 9wbuN7UyibTYmfK44RF638/hfFbRMNS2IymKwklg4IGSWr+ACiVMkkyLEf5i9YJFOFSaxrqYbz
 s2TdxI1XmpAH/VrvjxQ/fcxwprM00Kh0C5NF7rts7Zjgth05zyEHKNHnlpWxUxCi1O0UbJVl/0
 4R4GWSvvZfNfKOky06mDqL7tHvc2tWs/RqC2fhI8kQrofC/DDlunWK1J/Bx2w9uoE4Fk2+8NOK
 0MQ=
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="86131696"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2020 03:53:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 3 Jul 2020 03:52:59 -0700
Received: from atudor-ThinkPad-T470p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 3 Jul 2020 03:52:57 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for Winbond w25q64jvm spi flash
Date:   Fri, 3 Jul 2020 13:53:08 +0300
Message-ID: <159377313302.183636.9201993342908919115.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629195306.1030-1-TheSven73@gmail.com>
References: <20200629195306.1030-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 15:53:06 -0400, Sven Van Asbroeck wrote:
> This chip is (nearly) identical to the Winbond w25q64 which is
> already supported by Linux. Compared to the w25q64, the 'jvm'
> has a different JEDEC ID.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: winbond: Add support for w25q64jvm
      https://git.kernel.org/mtd/c/0ee2872f10

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
