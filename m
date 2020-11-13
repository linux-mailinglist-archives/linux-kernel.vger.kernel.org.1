Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15502B28CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgKMWwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKMWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:52:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F66C0613D1;
        Fri, 13 Nov 2020 14:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pjJwRKUevFcY0ivt/D6u+qhWzbAvgz4cA1cjYy+mCI4=; b=pPtVgLW969ym6HVeW9Y9TLiSs8
        0wAHmEwcl6t1eRw4ONQwsU2SMznXI+TezADpnjxFrC6+bo4s7mS2BFda3Pl0LdAcVRGJYGxKPAkOu
        jdP7xZW+inEIElaMv12sSbeWEK75c4dlb/2iQq08T0XXaHgcM+XEEIysbO549VLwPjPvdksq+sjdV
        6icdaIiQP0opKVJ+QW+3Ec7Rm93cqntpR+Ps1VydaPDkOQfoVWRUoPovpa3n1M8WqlSwIF+Q2aTkD
        8TUHdNVt13uLEugB10Gcnen2dsvrnOsICBuAftWE7U34ZfDWXxQl6ozysqkwnI77izZ2xv+ZotkXq
        tAfkEeYg==;
Received: from [2601:1c0:6280:3f0::662d] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdhvl-0006gG-Qf; Fri, 13 Nov 2020 22:52:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] md: dm-writeback: add __noreturn to BUG-ging function
Date:   Fri, 13 Nov 2020 14:52:28 -0800
Message-Id: <20201113225228.20563-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on arch/s390/ flags this as an error, so add the
__noreturn attribute modifier to prevent the build error.

cc1: some warnings being treated as errors
../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]

Fixes: 48debafe4f2f ("dm: add writecache target")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/md/dm-writecache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201113.orig/drivers/md/dm-writecache.c
+++ linux-next-20201113/drivers/md/dm-writecache.c
@@ -317,7 +317,7 @@ err1:
 	return r;
 }
 #else
-static int persistent_memory_claim(struct dm_writecache *wc)
+static int __noreturn persistent_memory_claim(struct dm_writecache *wc)
 {
 	BUG();
 }
