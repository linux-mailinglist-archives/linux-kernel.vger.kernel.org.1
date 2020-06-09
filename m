Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F551F46A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbgFISxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 14:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgFISxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:53:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0DAC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:53:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y5so23940393iob.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzPKTAa5Gu8LlWI/PO8OGj/+p1JiITv0TUvZw1ovhtY=;
        b=BwoURYJ1hpKR4u1vWUdNE09sNzcyR99hfMRV/1qdIONrTBSPVMkHjtr/Q1DYZp2Cee
         TZXmqxnxG4LniPxk3i2LXAleeWI+1+9qNwo+aBibu8fNy8+HI0N60Hnq2SbHEvC+Nj6J
         zDWwPP6nUUok/F1wT1tNz8ZuE53r8DSk0hm9xQWiZd7s1DxXs9X2+jKSgaW5FdQCyr6c
         vY4XVEEeDSzJlPHfT8H8vzJz5zaRDnDmKkoW1wboFM/TSCrRWnmk8xEVkic4ixzDvoki
         uu56vb4Qc11X3UzRqmVk1NtS0pDsS9nYXgsJUMx0GVkbeDYgZAxV9ZF6+ajL/EKnMULn
         IhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzPKTAa5Gu8LlWI/PO8OGj/+p1JiITv0TUvZw1ovhtY=;
        b=ALLwiUy+/5cFrpMEcPoE2dJVmniH03SB734iiz5FLh9ERXHyU35j0GlaYoFNHNdupt
         nMK4lnJteBIqj2xhxLrkPBlAtBio231aPrsIi2XnEzv+OJMF9Y/PFMj0lJEh6yINKJlP
         9Aa+xnhrEg16dxcdtebhOYxEReMAbGyT0JLAZhEXNq1TFLll3gVKHtdp5PfTi3jFoNFl
         JlYaqF5yPLNfi/qWOjBw8SkWQ5FZOPN3h0wiNZ3wp2aeEL0W48ZfsGhEnWJf+JAIN3oV
         g7lQE9bPGAJZVCx8bQvTw64AvPRddZZm35ghIQbz1/Dvh5hxi6fM0z79eteyElUmYtPa
         Waew==
X-Gm-Message-State: AOAM530gSMBqpV+Cg9hcaZ2U7gFkk9BOw02vB5TxtbUtvL8JGzhBMQyu
        rqRyDRY9wdz1SxLS+V9V6pQ=
X-Google-Smtp-Source: ABdhPJylJMkN/+ueAEFHZ8sschSVIO5nbxZ9tKmY/rCgNVSNA2Oh43LoHjr729c0sNywrKFylQPQLg==
X-Received: by 2002:a05:6602:13c6:: with SMTP id o6mr27478745iov.84.1591728783088;
        Tue, 09 Jun 2020 11:53:03 -0700 (PDT)
Received: from archpc.localdomain (024-177-098-147.res.spectrum.com. [24.177.98.147])
        by smtp.googlemail.com with ESMTPSA id b9sm9473696ils.84.2020.06.09.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:53:02 -0700 (PDT)
From:   dylan-meiners <spacct.spacct@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dylan-meiners <spacct.spacct@gmail.com>
Subject: [PATCH] mm/vmscan.c: Fixed typo.
Date:   Tue,  9 Jun 2020 13:51:44 -0500
Message-Id: <20200609185144.10049-1-spacct.spacct@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed "optizimation" to "optimization".

Signed-off-by: dylan-meiners <spacct.spacct@gmail.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b6d84326bdf2..8ac7bf9c3c43 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -914,7 +914,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 		 * order to detect refaults, thus thrashing, later on.
 		 *
 		 * But don't store shadows in an address space that is
-		 * already exiting.  This is not just an optizimation,
+		 * already exiting.  This is not just an optimization,
 		 * inode reclaim needs to empty out the radix tree or
 		 * the nodes are lost.  Don't plant shadows behind its
 		 * back.
-- 
2.27.0

