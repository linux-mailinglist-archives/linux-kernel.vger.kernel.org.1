Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5B291555
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 05:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgJRC6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 22:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgJRC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 22:58:17 -0400
X-Greylist: delayed 71 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Oct 2020 19:58:16 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78ECC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 19:58:16 -0700 (PDT)
Received: from sas1-5717c3cea310.qloud-c.yandex.net (sas1-5717c3cea310.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3616:0:640:5717:c3ce])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id ED1CA2E1459;
        Sun, 18 Oct 2020 05:57:03 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by sas1-5717c3cea310.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id YadsvykfIF-v3wqsC8h;
        Sun, 18 Oct 2020 05:57:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1602989823; bh=6lp/5CCN676MYQXMykfX11lxJIGliJoMsNDB5UsVD+w=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=QjBwb/FOWgAtyPMBs3yksSKX0Cg2zMVjVUTYTndKYGi+073bUflvSH79ffXqx0BwU
         IgtmzdjR9j9vXhGxOx131YtDZsus8qtilDFuFFirlgb9EFA7SiT8CMGCfW76GuR2f1
         45i6eCAfxfIIoCh5VlMA4bg/e+MwlBH/9/1uut1Q=
Authentication-Results: sas1-5717c3cea310.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Mume1kCumA-v3nSCGCV;
        Sun, 18 Oct 2020 05:57:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     jack@suse.cz, dmtrmonakhov@yandex-team.ru, dotdot@yandex-team.ru
Subject: [PATCH] fs/quota: update quota state flags scheme with project quota flags
Date:   Sun, 18 Oct 2020 05:56:54 +0300
Message-Id: <1602989814-28922-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current quota state flags scheme doesn't include project quota and thus
shows all flags after DQUOT_USAGE_ENABLED wrong. Fix this and also add
DQUOT_NOLIST_DIRTY to the scheme.

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
---
 include/linux/quota.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/quota.h b/include/linux/quota.h
index 27aab84..18ebd39 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -448,17 +448,18 @@ struct quota_format_type {
 };
 
 /**
- * Quota state flags - they actually come in two flavors - for users and groups.
+ * Quota state flags - they come in three flavors - for users, groups and projects.
  *
  * Actual typed flags layout:
- *				USRQUOTA	GRPQUOTA
- *  DQUOT_USAGE_ENABLED		0x0001		0x0002
- *  DQUOT_LIMITS_ENABLED	0x0004		0x0008
- *  DQUOT_SUSPENDED		0x0010		0x0020
+ *				USRQUOTA	GRPQUOTA	PRJQUOTA
+ *  DQUOT_USAGE_ENABLED		0x0001		0x0002		0x0004
+ *  DQUOT_LIMITS_ENABLED	0x0008		0x0010		0x0020
+ *  DQUOT_SUSPENDED		0x0040		0x0080		0x0100
  *
  * Following bits are used for non-typed flags:
- *  DQUOT_QUOTA_SYS_FILE	0x0040
- *  DQUOT_NEGATIVE_USAGE	0x0080
+ *  DQUOT_QUOTA_SYS_FILE	0x0200
+ *  DQUOT_NEGATIVE_USAGE	0x0400
+ *  DQUOT_NOLIST_DIRTY		0x0800
  */
 enum {
 	_DQUOT_USAGE_ENABLED = 0,		/* Track disk usage for users */
-- 
2.7.4

