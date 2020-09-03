Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713E625B8A9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 04:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgICCPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 22:15:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbgICCPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:15:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8658E86DF3E6611CB73A;
        Thu,  3 Sep 2020 10:15:45 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 10:15:38 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: trace: fix typo
Date:   Thu, 3 Sep 2020 10:15:15 +0800
Message-ID: <20200903021515.100621-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a typo from 'compreesed' to 'compressed'.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/trace/events/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 06c73f3f6dd2..f8f1e85ff130 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -136,7 +136,7 @@ TRACE_DEFINE_ENUM(CP_RESIZE);
 	__print_symbolic(type,						\
 		{ CP_NO_NEEDED,		"no needed" },			\
 		{ CP_NON_REGULAR,	"non regular" },		\
-		{ CP_COMPRESSED,	"compreesed" },			\
+		{ CP_COMPRESSED,	"compressed" },			\
 		{ CP_HARDLINK,		"hardlink" },			\
 		{ CP_SB_NEED_CP,	"sb needs cp" },		\
 		{ CP_WRONG_PINO,	"wrong pino" },			\
-- 
2.26.2

