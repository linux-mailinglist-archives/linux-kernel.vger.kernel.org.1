Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20B24B61D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgHTKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbgHTKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:20:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77B642067C;
        Thu, 20 Aug 2020 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918807;
        bh=qiSuuWBMSyShVnhW2u6bdkeMmDZ6T2EMNDEsJ/IiqMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxEPkQQ7Z08KIopF095eQGfWE4NyPcAKz11z+6PTABC/QymRd0JQqB/M/ENmmeltn
         +93f0JHvOU3toV8Ba9CJlF8bQTxoYNFEJoYeuTseMDvV2k/aohlm/bl51eHeUYKKdw
         5kChiiRNzcc7iHX7CgwQQyXYmlQHzaxRe7W5V24o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 044/149] atm: fix atm_dev refcnt leaks in atmtcp_remove_persistent
Date:   Thu, 20 Aug 2020 11:22:01 +0200
Message-Id: <20200820092127.872137487@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Xiong <xiongx18@fudan.edu.cn>

[ Upstream commit 51875dad43b44241b46a569493f1e4bfa0386d86 ]

atmtcp_remove_persistent() invokes atm_dev_lookup(), which returns a
reference of atm_dev with increased refcount or NULL if fails.

The refcount leaks issues occur in two error handling paths. If
dev_data->persist is zero or PRIV(dev)->vcc isn't NULL, the function
returns 0 without decreasing the refcount kept by a local variable,
resulting in refcount leaks.

Fix the issue by adding atm_dev_put() before returning 0 both when
dev_data->persist is zero or PRIV(dev)->vcc isn't NULL.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/atmtcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/atmtcp.c b/drivers/atm/atmtcp.c
index 480fa6ffbc090..04fca6db273ef 100644
--- a/drivers/atm/atmtcp.c
+++ b/drivers/atm/atmtcp.c
@@ -432,9 +432,15 @@ static int atmtcp_remove_persistent(int itf)
 		return -EMEDIUMTYPE;
 	}
 	dev_data = PRIV(dev);
-	if (!dev_data->persist) return 0;
+	if (!dev_data->persist) {
+		atm_dev_put(dev);
+		return 0;
+	}
 	dev_data->persist = 0;
-	if (PRIV(dev)->vcc) return 0;
+	if (PRIV(dev)->vcc) {
+		atm_dev_put(dev);
+		return 0;
+	}
 	kfree(dev_data);
 	atm_dev_put(dev);
 	atm_dev_deregister(dev);
-- 
2.25.1



