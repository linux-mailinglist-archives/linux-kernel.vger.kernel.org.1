Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA261BDD94
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 15:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgD2N2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 09:28:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbgD2N2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:28:20 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2DFC29AB7CC4F543F003;
        Wed, 29 Apr 2020 21:28:18 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 29 Apr 2020
 21:28:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <tglx@linutronix.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: seq: oss: remove unused inline function snd_seq_oss_timer_is_realtime
Date:   Wed, 29 Apr 2020 21:28:05 +0800
Message-ID: <20200429132805.18712-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/seq/oss/seq_oss_timer.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_timer.h b/sound/core/seq/oss/seq_oss_timer.h
index 2d86125b5d0f..dee190b4ec6b 100644
--- a/sound/core/seq/oss/seq_oss_timer.h
+++ b/sound/core/seq/oss/seq_oss_timer.h
@@ -44,14 +44,4 @@ snd_seq_oss_timer_cur_tick(struct seq_oss_timer *timer)
 	return timer->cur_tick;
 }
 
-
-/*
- * is realtime event?
- */
-static inline int
-snd_seq_oss_timer_is_realtime(struct seq_oss_timer *timer)
-{
-	return timer->realtime;
-}
-
 #endif
-- 
2.17.1


