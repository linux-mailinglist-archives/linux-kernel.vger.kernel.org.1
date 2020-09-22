Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B531D274091
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIVLS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:18:56 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:54125 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgIVLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:18:55 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 6E85F4E1664;
        Tue, 22 Sep 2020 19:18:52 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Wang Qing <wangqing@vivo.com>,
        David Hildenbrand <david@redhat.com>,
        SeongJae Park <sjpark@amazon.de>, Xiong <xndchn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: increase error-prone spell checking
Date:   Tue, 22 Sep 2020 19:18:23 +0800
Message-Id: <1600773524-3158-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSE1IQhkZSBhLTk1PVkpNS0tMTEhOSElDSUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N006FTo5Hz8ZNA5KMVZKPzZK
        KAgKCzhVSlVKTUtLTExITkhISUpNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk5NNwY+
X-HM-Tid: 0a74b589ac249376kuws6e85f4e1664
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase direcly,ununsed,manger spelling error check

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 scripts/spelling.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f253681..91ab82b
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1534,3 +1534,6 @@ writting||writing
 wtih||with
 zombe||zombie
 zomebie||zombie
+direcly||directly
+ununsed||unused
+manger||manager
\ No newline at end of file
-- 
2.7.4

