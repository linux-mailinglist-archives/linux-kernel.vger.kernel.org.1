Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C212E0D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgLVQoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:44:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbgLVQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608655361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lrk6ItTLyfFFu92WG6dQ6R2YCLUBjao3+3CmL/ZZMi0=;
        b=LDUGiDYHiOTNFu/v1hF1ULFc2SPX/w+G+ZdkPCAgJZ9HzYoQPCJNP0dYUdhYSrTNwPonud
        WWr6hz4wT00F2rv4bghltooH2LUEuTb/tqxqydiGPaszI01EJWsVHhBxP9JDtDKrS4hoBv
        slpPZVV4W7msMc5EGsIOOHYdkePcbV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-loHxs7zkN8uHxuNKvdSgKg-1; Tue, 22 Dec 2020 11:42:36 -0500
X-MC-Unique: loHxs7zkN8uHxuNKvdSgKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60610107ACE8;
        Tue, 22 Dec 2020 16:42:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-116.ams2.redhat.com [10.36.112.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14A185E1A8;
        Tue, 22 Dec 2020 16:42:33 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/iova: fix 'domain' typos
Date:   Tue, 22 Dec 2020 17:42:32 +0100
Message-Id: <20201222164232.88795-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace misspelled 'doamin' with 'domain' in several comments.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/iommu/iova.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4bb3293ae4d7..d20b8b333d30 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -358,7 +358,7 @@ static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
  * @iovad: - iova domain in question.
  * @pfn: - page frame number
  * This function finds and returns an iova belonging to the
- * given doamin which matches the given pfn.
+ * given domain which matches the given pfn.
  */
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
@@ -601,7 +601,7 @@ void queue_iova(struct iova_domain *iovad,
 EXPORT_SYMBOL_GPL(queue_iova);
 
 /**
- * put_iova_domain - destroys the iova doamin
+ * put_iova_domain - destroys the iova domain
  * @iovad: - iova domain in question.
  * All the iova's in that domain are destroyed.
  */
@@ -712,9 +712,9 @@ EXPORT_SYMBOL_GPL(reserve_iova);
 
 /**
  * copy_reserved_iova - copies the reserved between domains
- * @from: - source doamin from where to copy
+ * @from: - source domain from where to copy
  * @to: - destination domin where to copy
- * This function copies reserved iova's from one doamin to
+ * This function copies reserved iova's from one domain to
  * other.
  */
 void
-- 
2.26.2

