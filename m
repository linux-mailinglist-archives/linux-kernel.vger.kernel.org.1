Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949B52BBB0A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 01:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgKUAd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 19:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728275AbgKUAd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 19:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605918835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x+2FVCoUrDqnhADckFSP/psuNV4yeinap0Vncl0UAfQ=;
        b=JOV2WzfgyDTZPhG2ZVgC264yB611kDoDgpgjSe/76OzXOmg7fI9UjTloY+2Lv633oIW+uN
        1mNq8jpF/UAYval/4UpXkS2Oeg4SKnVB7dfwKZ+MLK0XU+q5U4HBHJK3QT1h0OTBgWmS58
        f6ytoDCBzcbfpezgN0vy00MtRI04ymg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-rXNqsWTFP7K37anzyHzFAA-1; Fri, 20 Nov 2020 19:33:50 -0500
X-MC-Unique: rXNqsWTFP7K37anzyHzFAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E705B380;
        Sat, 21 Nov 2020 00:33:35 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D936C10013C1;
        Sat, 21 Nov 2020 00:33:33 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     linux-kernel@vger.kernel.org, ira.weiny@intel.com,
        darrick.wong@oracle.com
Cc:     Xiaoli Feng <fengxiaoli0714@gmail.com>
Subject: [PATCH] fs/stat: set attributes_mask for STATX_ATTR_DAX
Date:   Sat, 21 Nov 2020 08:33:31 +0800
Message-Id: <20201121003331.21342-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoli Feng <fengxiaoli0714@gmail.com>

keep attributes and attributes_mask are consistent for
STATX_ATTR_DAX.
---
 fs/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e79..914a61d256b0 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -82,7 +82,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
-
+	stat->attributes_mask |= STATX_ATTR_DAX;
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
 					    query_flags);
-- 
2.18.1

