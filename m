Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC58F279610
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgIZB5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:57:01 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:46389 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIZB5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:57:00 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 1273B4E1388;
        Sat, 26 Sep 2020 09:56:57 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Wang Qing <wangqing@vivo.com>, Xiong <xndchn@gmail.com>,
        SeongJae Park <sjpark@amazon.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] increase error-prone spell checking
Date:   Sat, 26 Sep 2020 09:56:16 +0800
Message-Id: <1601085397-27586-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSR1LSh0YGU5PQxhKVkpNS0pLQ05PSkxPTUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NUk6Igw*Hj8eKAE#Pi0ISi8R
        FBoaCSxVSlVKTUtKS0NOT0pMQ01LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKQkxMNwY+
X-HM-Tid: 0a74c820a7779376kuws1273b4e1388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase direcly,ununsed,manger spelling error check

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 scripts/spelling.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f253681..bd99940
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -482,6 +482,7 @@ disgest||digest
 dispalying||displaying
 diplay||display
 directon||direction
+direcly||directly
 direectly||directly
 diregard||disregard
 disassocation||disassociation
@@ -871,6 +872,7 @@ malplace||misplace
 managable||manageable
 managment||management
 mangement||management
+manger||manager
 manoeuvering||maneuvering
 manufaucturing||manufacturing
 mappping||mapping
@@ -1478,6 +1480,7 @@ unsolicitied||unsolicited
 unsuccessfull||unsuccessful
 unsuported||unsupported
 untill||until
+ununsed||unused
 unuseful||useless
 unvalid||invalid
 upate||update
-- 
2.7.4

