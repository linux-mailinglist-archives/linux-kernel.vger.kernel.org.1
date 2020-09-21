Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2B8272285
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgIUL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:29:32 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53642 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgIUL3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:29:31 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 07:29:30 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C2AF6542C0;
        Mon, 21 Sep 2020 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1600687278; x=
        1602501679; bh=YIKwPp9PgxP7cgWzG+qGdK2an79Qi369mnKtqyTcmY8=; b=h
        Siis93r8cc5T2iQWDlCED/Nn06xCAjr3mtTgrONPMOjkxu2m4X0ir413DbEEHtZv
        ehlnC801nDQOlHwHD2fB9FD1NnJou2nuuvctX3VEUcA0ZoU4jxqPd6CmPkyqzA4a
        kowSwERB+yKWf5I3K0JL+8l5GIDd/gQqxM3eRfxq64=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RVjcfKRWjR3K; Mon, 21 Sep 2020 14:21:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8310E52ACE;
        Mon, 21 Sep 2020 14:21:18 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.3.38) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 21 Sep 2020 14:21:18 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 0/2] enable lock interface for macronix chips
Date:   Mon, 21 Sep 2020 14:24:48 +0300
Message-ID: <20200921112450.4824-1-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.3.38]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TB(Top/Bottom protection bit) is not present in the status register for
macronix chips, do not touch TB bit in status register in this case.
Enable lock interface for most of macronix chips which are suitable for it.

Tested only mx25l51245g (BP0-3).

Ivan Mikhaylov (2):
  mtd: spi-nor: do not touch TB bit without SPI_NOR_HAS_TB
  mtd: spi-nor: enable lock interface for macronix chips

 drivers/mtd/spi-nor/core.c     | 22 +++++++---
 drivers/mtd/spi-nor/macronix.c | 75 ++++++++++++++++++++++------------
 2 files changed, 66 insertions(+), 31 deletions(-)

-- 
2.21.1

