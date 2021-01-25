Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41251302263
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhAYHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 02:18:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:24598 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbhAYHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611558855; x=1643094855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJBLB6P2jIwrzZxMBwWwieyM4efEub1T3vO1tr4sFD8=;
  b=TtKFrTIFK8W1X7MZ7+nwiKJGIojsXQHXkhuySHBe8i8xfYEFTfqmiD6V
   NTLfHURRquyCrea1uabC9k+02ac8TfWOs2fcX82tzUjXJq87udODPmjat
   ItdZqvo6NtWcYCIY/XlHSj1Fo1JnUDol89SBCH2o5wJDq16/oBqBoN0La
   KZqcNmupFjbgp2Q51nverZRZrGR1wPDjf1+Hofac4sTD+ID4YokvnWc8D
   gzY8GgUDGnU/UHQ/NskyokyGfZsTlsw+qXzoAN23VNgGrb9Zw4GhofshD
   tcWMvuBEV4oiRX4dM+IJR1hEjkiWVwJc5oJS8li3oSg62gNIczqSXBLgH
   w==;
IronPort-SDR: UukdEmfwL6ux++UfwOQJsldYuK9CRujJOhLYD7vqatCles2Ox2lgJQ16AfDLOYU/gR2s/Sj4Qn
 ET9E2WM3SUg/10PRlhfzJzcUc4dSPl5rHoPk1xAmpkGSJfO8bOtje/HnXXJyltkx3t37VM1pPo
 pM6lzGD3N5t+95dPaW5Z93MjBeAJBgH+pjLBVXxcltFwUDsoX3WePz65kTPFmX76v0ih1xxdMQ
 sgrql8iL4Rrhqnk/lBI/7vL881QN3BQ9kXBB8sHE0BPDEaQMt1NP+Q0wpSUmTKsyktwVx+0fda
 I/U=
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="112321286"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2021 00:09:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 25 Jan 2021 00:09:37 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 25 Jan 2021 00:09:35 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pan Bian <bianpan2016@163.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: hisi-sfc: Put child node np on error path
Date:   Mon, 25 Jan 2021 09:09:31 +0200
Message-ID: <161155840485.1247075.6322709143299496385.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121091847.85362-1-bianpan2016@163.com>
References: <20210121091847.85362-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 01:18:47 -0800, Pan Bian wrote:
> Put the child node np when it fails to get or register device.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: hisi-sfc: Put child node np on error path
      https://git.kernel.org/mtd/c/fe6653460ee7

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
