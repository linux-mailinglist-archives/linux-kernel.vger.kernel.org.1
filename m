Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3931271492
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgITNcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgITNcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 09:32:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71F6C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 06:32:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so10037012wrn.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aus.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+IvPcfmSxe2t3wOAmoqckSrWQKodDu46tgSEpw2wHE=;
        b=JHhm/W2RyvXAqMaUmjKVWq7H24NEtvOSeAywzzQnB2wCEg8wmj5WI3fWCTOpyjamuK
         28lTtSO7VOMPilANNLAropRcT/VCd2xUUQnB/EnuKKU7+XHQ7VeBcKaIng1mlPlQxdP3
         KfPNL6a1bMLIEf8eQRmDJsh5KwHirlz3eV8h+YvgoB7pqXnymnvf3FPBi029rTOZDIlb
         tdD+yUrUqYtBShot6Pecc2/a8MhXC0J19+modRn5LBDWr1aKdqOXMXiCy9QfMztWlcNv
         plCuxJDPs3ysN8go9PcGEJ6or1k+IsKAaDdLrcx/it9xLh21ij3z6ngK7Pyp+C1ZUmFp
         SBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t+IvPcfmSxe2t3wOAmoqckSrWQKodDu46tgSEpw2wHE=;
        b=lPONIktPlRAmX45Xw3PrXhZ8pJOmBSN8C1d7+1KuwG4vMYqzO6+NGieW+uKBOiyKNF
         BXp3NULhN8pKNVx+A3wWMgs6ewwMG1a/K2FLhudEa3GfgJeWtfzvCTGghn/G2F636PVQ
         4sILd9Fp+OYtYa6Dk49yqB0X1pepC2DUEUcf0005WG+KQljRnyqcasEGA5ASIG8dvCxm
         GqIG0Abjb+jKNFmclKIvHTaEn36pP77fvx0kfM8eiTXRYIYFpyIRH2hufq3EnGNDCPYp
         k64s93D+6j0si41NzeZ+Ir7axMIoUdcrTkIBnR28EZItXgQqBw22w7cQpXujlO93ejV2
         NPSw==
X-Gm-Message-State: AOAM5315EAP3JMQb/ckSYu9bCkS/Bmth3ey0MrqzTClRosJeK//l+UfE
        YxO2A5AlMZ9RXvQanpnxFkscKDwpQ5RSth+Kd6dYlUT0u4qOrQCiCcZEW9/AkcNgXzT31lBRE9s
        8oLQERqtwxzulfaYmvPc4EFmR2Q==
X-Google-Smtp-Source: ABdhPJygjEDE6grx/gL+fC7zGvAyU3i47iV/YNJg0Yr/lgiDX8xyI56khkDqnyGlIcFOAvIjq+gPjA==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr47580527wrw.199.1600608719416;
        Sun, 20 Sep 2020 06:31:59 -0700 (PDT)
Received: from localhost.localdomain (bba460270.alshamil.net.ae. [86.96.43.22])
        by smtp.gmail.com with ESMTPSA id m4sm16403469wro.18.2020.09.20.06.31.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Sep 2020 06:31:58 -0700 (PDT)
From:   Asif Rasheed <b00073877@aus.edu>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, b00073877@aus.edu
Subject: [PATCH] Staging list.h: Modified comment
Date:   Sun, 20 Sep 2020 17:31:54 +0400
Message-Id: <20200920133154.71514-1-b00073877@aus.edu>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We (everyone from my Operating System Lecture Section) were confused on whether the list is circular or not (because no one bothered to look at the implementation). Modified the comment on top for clarification.

Signed-off-by: Asif Rasheed <b00073877@aus.edu>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 0d0d17a10d25..796975c3c35c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 
 /*
- * Simple doubly linked list implementation.
+ * Circular doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
  * manipulating whole lists rather than single entries, as
-- 
2.24.3 (Apple Git-128)

