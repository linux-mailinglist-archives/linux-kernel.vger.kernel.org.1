Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42226DA16
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIQLXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgIQLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:08:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F6C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:08:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so1644015ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fzxb6kNCOD+DqnVPedrk4ksMuODtrVDGEO33gyPazGw=;
        b=B64gIrXrRDM1onplNYixz/gQEBZY1ILGIczqYFuVbeUT85sUR7x1nBTni0AD2S8U0X
         Ux0Sm4hyhvgvsP1Vk1IZQgu6cuCHxj23/8yd1pFvkPAvw+KU9sEa3DAFJAh/Cj0b5Vme
         vjWfRAyoq6KKPkDXhmfdZk00JrJNNfNElPmO8UkOnySs718i9HZTIFRHg5BPJkZaye3w
         gx5go2pQ5wpbScBofFhfzg7fEsIh8QVJcO6AUxyr81QtaW1r9h11pHYYXPWr7yN6dAM5
         j0KKiYNkh/wtmw2rmLfYjrg2069HNaht/lDiri5X+UfEc7TQUBWPSwt+vnxqBvC4fyB0
         4UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fzxb6kNCOD+DqnVPedrk4ksMuODtrVDGEO33gyPazGw=;
        b=MQPotOoJknmS+xqlQxSDqSdrMMKDzGf8HYvoYHB0Fpi4IGMFi5W8oHaxTiuq8v5h3Q
         +nFLHhONZubKc3L2paW+DdwjmyIFl1V+jS4fNsys75bBbaZHN3k+xo5F5OdUxyeVJHOk
         lE0EN7ArhcdggZO0oi+srwUZDMv4Zru662Tkm/VACFoNbLlKR8KTywn4daP5M5f7LiXE
         F1fdKcOtYnNB7xKMqhbNm7IsgVp+H0aKV9Px+roWiyC5BSBMw7eQ6gNgS4zDaiEf1OpI
         6Yjn+0hh+zKjz7ON/MPZS0lNb2WTeIv/p4xK3l/1bIyuJQw7s9QXm916FX8HNpXHCLAK
         K9ow==
X-Gm-Message-State: AOAM531a56ukDgirviSF2BHn62Syu3CCx1JjohBrkoJh9NKtM6CsVRVq
        GLj+dzLepgBJDutw+WwBKOnV7ntRuFa8+w==
X-Google-Smtp-Source: ABdhPJz47WCCueKSK2oljgVZEVs06Xevc2jCjCDRWBviVru8kGC2LKPhdr0mNzOmQsedW3VMt63RaQ==
X-Received: by 2002:a05:651c:1203:: with SMTP id i3mr5625871lja.382.1600340906861;
        Thu, 17 Sep 2020 04:08:26 -0700 (PDT)
Received: from localhost.localdomain (188.147.112.12.nat.umts.dynamic.t-mobile.pl. [188.147.112.12])
        by smtp.gmail.com with ESMTPSA id m22sm6001734lji.36.2020.09.17.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:08:26 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] include/linux/compaction.h: clean code by removing unused enum value
Date:   Thu, 17 Sep 2020 13:07:50 +0200
Message-Id: <20200917110750.12015-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

The enum value 'COMPACT_INACTIVE' is never used so can be removed.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 include/linux/compaction.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 25a521d299c1..1de5a1151ee7 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -29,9 +29,6 @@ enum compact_result {
 	/* compaction didn't start as it was deferred due to past failures */
 	COMPACT_DEFERRED,
 
-	/* compaction not active last round */
-	COMPACT_INACTIVE = COMPACT_DEFERRED,
-
 	/* For more detailed tracepoint output - internal to compaction */
 	COMPACT_NO_SUITABLE_PAGE,
 	/* compaction should continue to another pageblock */
-- 
2.20.1

