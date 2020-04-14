Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5711A83F1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 17:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391177AbgDNP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 11:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391157AbgDNP6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:58:00 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1834206D5;
        Tue, 14 Apr 2020 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586879880;
        bh=WnEynZVdNXmkcOxwNOFKZvRoxvYFMjHKWTn4kRxO2SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCvkljOZ/CptBbWKuB9u0Vy8vPypg+stcShRKEn7AmdBl0Ai6ffvDBHw+Qxgz+aBk
         +CMtZxFBe1dfGRv5PZicHF1VCAhzcqLkW8Spp1hmZAmG2VYf0fjYIzDrs3NOhi8BAL
         dLXHtf/uXCj0pEMhWFIA7If7qz4NdpmZsFybWCL0=
From:   Leon Romanovsky <leon@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Borislav Petkov <bp@suse.de>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] kernel/module: Hide vermagic header file from general use
Date:   Tue, 14 Apr 2020 18:57:32 +0300
Message-Id: <20200414155732.1236944-5-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200414155732.1236944-1-leon@kernel.org>
References: <20200414155732.1236944-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

VERMAGIC* definitions are not supposed to be used by the drivers,
see this [1] bug report, so simply move this header file to be visible
to kernel/* files only.

[1] https://lore.kernel.org/lkml/20200411155623.GA22175@zn.tnic
Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 kernel/module.c                      | 2 +-
 {include/linux => kernel}/vermagic.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {include/linux => kernel}/vermagic.h (100%)

diff --git a/kernel/module.c b/kernel/module.c
index 3447f3b74870..fce06095d341 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -29,7 +29,6 @@
 #include <linux/moduleparam.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/vermagic.h>
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/device.h>
@@ -55,6 +54,7 @@
 #include <linux/audit.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
+#include "vermagic.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
diff --git a/include/linux/vermagic.h b/kernel/vermagic.h
similarity index 100%
rename from include/linux/vermagic.h
rename to kernel/vermagic.h
-- 
2.25.2

