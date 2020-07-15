Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F968220453
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 07:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgGOFYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 01:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgGOFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:24:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975EDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YMqA4e1JC5L+qLXFvqzuaShUVuLVIuYUnNwfr5LoQVE=; b=FussjJjxrO6Ou5ypAx7HgdpCvv
        /bCUIKQBeT3mpCjCXj2mjJ6JyXA95qjDOsX1n76uxYZCSqMV1CPWrxoNm5P31gy6gW3U64UYOu+un
        NrFoxfZZiyiAYCdyDPgh5vh0t6pdPpCoYf6Y978ky0lQFExfZaaIAeMHT8DepIyfvSJC8qpkQqBFG
        kMfIqUazby4vRAnHIW9qYv5OW1jIqGEiFo7ubZBCZ0Fpcol/LDYVTiLsWOuWHn2XD2i7MYOBhpdeh
        pXh7rBujm9iktR3aPMgbhxhEm3oA7CxG1QAByOEknwMi5lzjOBLCItmmkg/Kw7ZZamDkklBOWnPFg
        veWDn2tA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvZti-0006Vd-Rt; Wed, 15 Jul 2020 05:24:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 7/7] drm: drm_rect.h: delete duplicated word in comment
Date:   Tue, 14 Jul 2020 22:23:49 -0700
Message-Id: <20200715052349.23319-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715052349.23319-1-rdunlap@infradead.org>
References: <20200715052349.23319-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_rect.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/drm/drm_rect.h
+++ linux-next-20200714/include/drm/drm_rect.h
@@ -180,7 +180,7 @@ static inline int drm_rect_height(const
 }
 
 /**
- * drm_rect_visible - determine if the the rectangle is visible
+ * drm_rect_visible - determine if the rectangle is visible
  * @r: rectangle whose visibility is returned
  *
  * RETURNS:
