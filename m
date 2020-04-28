Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E301BB4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD1DaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 23:30:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3357 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbgD1DaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:30:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D54AAEE4D4C2439DAFE6;
        Tue, 28 Apr 2020 11:30:05 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 11:29:59 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] fs/gfs2:lock a spinlock always before returning from do_xmote()
Date:   Tue, 28 Apr 2020 11:29:05 +0800
Message-ID: <1588044545-59405-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call stack is as follows:
finish_xmote()
        ...
        spin_lock(&gl->gl_lockref.lock);
        ...
	--> do_xmote()
            spin_unlock(&gl->gl_lockref.lock);
            ...
            return;
        ...
        spin_unlock(&gl->gl_lockref.lock);
           
do_xmote function needs to be locked before returning,
Otherwise, there will be a double release lock in finish_xmote() function.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/gfs2/glock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 29f9b66..7129d10 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -613,6 +613,7 @@ static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int
 				fs_err(sdp, "Error %d syncing glock \n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
+			spin_lock(&gl->gl_lockref.lock);
 			return;
 		}
 	}
-- 
1.8.3.1

