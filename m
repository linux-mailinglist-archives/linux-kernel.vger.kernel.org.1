Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604FA202984
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgFUILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 04:11:19 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:54014 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbgFUILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 04:11:18 -0400
Received: from localhost.localdomain ([93.22.149.109])
        by mwinf5d20 with ME
        id tkBE220052MrWsD03kBEmz; Sun, 21 Jun 2020 10:11:15 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jun 2020 10:11:15 +0200
X-ME-IP: 93.22.149.109
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] topology: mark a function as __init to save some memory
Date:   Sun, 21 Jun 2020 10:11:06 +0200
Message-Id: <20200621081106.881915-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'topology_sysfs_init()' is only called via 'device_initcall'.
It can be marked as __init to save a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/base/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 4e033d4cc0dc..ad8d33c6077b 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -133,7 +133,7 @@ static int topology_remove_dev(unsigned int cpu)
 	return 0;
 }
 
-static int topology_sysfs_init(void)
+static int __init topology_sysfs_init(void)
 {
 	return cpuhp_setup_state(CPUHP_TOPOLOGY_PREPARE,
 				 "base/topology:prepare", topology_add_dev,
-- 
2.25.1

