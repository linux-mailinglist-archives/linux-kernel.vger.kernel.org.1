Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CC2A87EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgKEUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732430AbgKEUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:43 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A4BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 12:21:41 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so2205084pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 12:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u9q33gCTTRJK5AVG9DQojto+J/DJ69G/peuw5a12MEU=;
        b=rRRKymgTqnrT4EGa4W/y9zlMpHJgOt7VzD8NLdeDFlTi1xJ1qyU6CVmaPvapwd3lK0
         wK55ZySOhQsnHzqxa4I/JXLIgu0z1ql+qLYFrJm5W3pKfloiBFdV6xUoLw/Ajx1/ASiz
         aNuRSvY+u+x1s+rm27sFEkosNPdtl9579CKnqPxoeYX1MCgMi1uoAuQLgAy7R3Rd9zAD
         bR0iput7JbuyPR9Bg/1J1gUVZ59ZnNxlMGjFgpcZ5OxlOcu1PxqJQxEAdDx3zyZGso1L
         Tb0AsI7LqFOZaJeO/F0Q8nKfY/uu3MdUgicOakbO5OLh3ZLfE8XnnfxDp0iQOCDfPdvP
         4QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u9q33gCTTRJK5AVG9DQojto+J/DJ69G/peuw5a12MEU=;
        b=YbELA3OzkcKReNhjk5aRfw+n4jqXctBmc5SbqdobcLpxhW0uD3PjbSj/DRWP5YPn4A
         uQq0DRkVPo4vV/iIrukmENRUbwwu8nrrm44ZTvSyKIwKwdGbO2Ks1yLDP2ps+Q+z1y+X
         Fuhi4rSzTH9bmjw1oinhjJVkm/kH3UYgapL/xmam4CW8Y9upoC2dQj7y5SFXGNLXY9cE
         hvybBD1cfNVyna1rA5EpWPcS1y9MXSHGYsismuXUKbKMiJzEj6MSKoLrJ3Vznm57Daqo
         oect7KsqxBfRK2snKgUXS+xdowx7amz842dGQ3YD7eS8iwvh5yrR5nlARAaJ+aYVXYJY
         AmCA==
X-Gm-Message-State: AOAM532QQYMsE2gznDhYOUfBLDii2BwARU4Jb+oUuKxSVXx/etDrX04h
        xscMBcCQy+wmdm+XcDzfoJc=
X-Google-Smtp-Source: ABdhPJwvL6uA2IU1FQBcROzyhlpu5THuY9mxHBMAuHSCl6H9CMydeGr72MtMdZfdisw4hYytRne2Rw==
X-Received: by 2002:aa7:8548:0:b029:164:769a:353 with SMTP id y8-20020aa785480000b0290164769a0353mr4328512pfn.45.1604607701254;
        Thu, 05 Nov 2020 12:21:41 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id l7sm2970079pjg.29.2020.11.05.12.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:21:40 -0800 (PST)
Date:   Fri, 6 Nov 2020 01:51:35 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v2] drm/vc4: replace idr_init() by idr_init_base()
Message-ID: <20201105202135.GA145111@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier for this driver.
The idr_alloc for this driver uses VC4_PERFMONID_MIN as start value for
ID range and it is #defined to 1. The new function idr_init_base allows
IDR to set the ID lookup from base 1. This avoids all lookups that
otherwise starts from 0 since 0 is always unused / available.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Changes since v1:
   - Change suggested by Eric Anholt
     1. Use VC4_PERFMONID_MIN instead of magic number 1

 drivers/gpu/drm/vc4/vc4_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index f4aa75efd16b..18abc06335c1 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -77,7 +77,7 @@ struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
 void vc4_perfmon_open_file(struct vc4_file *vc4file)
 {
 	mutex_init(&vc4file->perfmon.lock);
-	idr_init(&vc4file->perfmon.idr);
+	idr_init_base(&vc4file->perfmon.idr, VC4_PERFMONID_MIN);
 }
 
 static int vc4_perfmon_idr_del(int id, void *elem, void *data)
-- 
2.25.1

