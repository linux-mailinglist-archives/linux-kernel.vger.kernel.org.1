Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B392FE55E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAUIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:50:37 -0500
Received: from m12-14.163.com ([220.181.12.14]:53021 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbhAUIsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aK3UL
        Y00MYQGj6IGa55PKkl6dXVNizNs2jDN5NTvN0M=; b=emh5CO22znJJwE36Tv/IG
        fkXLhnnyjECQSHBtCKNvIRDM0RroX49ntSzA0wh2ToQgTJk9rVNzO5qFUc6LNxJj
        /wbAsA0Jetdb9ml/B+e6XsbFi6CHMNNUSi2WnqrthbLjcRMYWtg+AKu9oFk9Smqd
        5DhKXebFchNcL8qnENTnks=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowABHSR3b4QhgGWdXhA--.34257S2;
        Thu, 21 Jan 2021 10:07:29 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     akpm@linux-foundation.org, colin.king@canonical.com,
        xndchn@gmail.com, j.neuschaefer@gmx.net, luca@lucaceresoli.net,
        naoki.hayama@lineo.co.jp, ebiggers@google.com, sjpark@amazon.de,
        joe@perches.com
Cc:     linux-kernel@vger.kernel.org, zhangwen@yulong.com,
        tangchunyou@yulong.com
Subject: [PATCH] scripts/spelling.txt: increase error-prone spell checking
Date:   Thu, 21 Jan 2021 10:07:31 +0800
Message-Id: <20210121020731.2316-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABHSR3b4QhgGWdXhA--.34257S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUr_M-UUUUU
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbipQAhUVUMb9PClAABsn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

Increase direcly,maping,manger spelling error check

Signed-off-by: WenZhang <zhangwen@yulong.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 953f4a2..ebcb27b 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -875,6 +875,7 @@ manger||manager
 manoeuvering||maneuvering
 manufaucturing||manufacturing
 mappping||mapping
+maping||mapping
 matchs||matches
 mathimatical||mathematical
 mathimatic||mathematic
-- 
1.9.1


