Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638CE22C882
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGXOy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXOy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:54:28 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DFA206D8;
        Fri, 24 Jul 2020 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595602468;
        bh=lA8L4QbfMWZzFUbBzDVpfC0tQQM+meY4raaaZQOddqk=;
        h=From:To:Cc:Subject:Date:From;
        b=qdIWxsZMfM+uWkvquOcATmNMTDMlYCx0VtHVfeeLpcE6fBqeFgYb9oswE1n4rnxiu
         tHE8AIKo69bXI1dyhrGmeA0fMDcLFLZ1oYD/ixk5sDYAM/WWN1UWQHXwrZMoIslsVw
         t993egJsJ64Qo5u3fyoXk93TQor+/inEGHcvJMiw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 0/2] mips: jz4780: Kconfig cleanup
Date:   Fri, 24 Jul 2020 16:53:59 +0200
Message-Id: <20200724145401.2566-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a subset of my bigger work for memory controller drivers [1].

Patch #1 (memory): I can take it through my tree because of dependant
work around compile testing.

Patch #2: Independent, please pick it up if it looks good.

[1] https://lore.kernel.org/lkml/20200724140345.GB13472@kozik-lap/T/#t

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  memory: jz4780-nemc: Limit dependency and compile testing to Ingenic
    architecture only
  mtd: rawnand: ingenic: Limit MTD_NAND_JZ4780 to architecture only

 drivers/memory/Kconfig               | 4 ++--
 drivers/mtd/nand/raw/ingenic/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.17.1

