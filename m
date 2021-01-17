Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE792F9220
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbhAQLvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 06:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbhAQLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 06:50:42 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D96C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 03:50:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y8so7076514plp.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 03:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wjPyOsg006KMekw1viBbKY+LT22ITMgy31SMuHo+XjE=;
        b=UEJ0YS9PVCzhnwOAq8vy8s1DiBEwkOHdugb/hP6ITQ1KZOhJB/qWmDrX1D+TYUUXrL
         ZNmEmIjSMT8SBPtFlB0A0EWOEllM7jULsK1kxFqWqDqmbjlz7RUqlDhT+gf4Au+oZrRG
         pEEN7ojAqmS4WwwMpC/lMyFGmiy0SNWf0+5b9dHF+uvr1+B5piLw2aw4EnLqLNgK+XBJ
         Lw05V3jOTYDJeNtNoxEB0vEyaYya7fOYhmEr7VsPMI0/fIqc0Rthsdh3ymep+x3xpiwp
         01Itnwpf0fP/+4hDswe47zCCfnM+BjzcTZKMteY1Z1ubrdetJnqJ60glXeDT21kxDAHi
         S3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wjPyOsg006KMekw1viBbKY+LT22ITMgy31SMuHo+XjE=;
        b=MZ/1gb6Ppx0+AwEc3f8ekan5QZXD+nXF56dQ9yqIyRbRDxl7FAXbbAyvS7GBvKxbP6
         o08yoa0RCkWckdMBulw7OjiUcXZC6Wg1AdQj9L4SImRMBZh64Vkp8hMKssgPyS/u0+qy
         6/cf3LUAPXOOK8VBeBJBu4UmvTLo1AxTU8Y7FNKyzIg9ptMcscID4aLVHO48/Jk/eynN
         AbCFtuvwJzatKtxLGI5eD8oojMiu7795sm7TBWsyitBQ0NQVkncB30+UDkJHJmQzHIPl
         7fyvJDOuxHko01MQTponW51RZL0UWxkZCDrJ6qgEDcfaTLrs613/7pGjPwF8ouGXwYcV
         eTYQ==
X-Gm-Message-State: AOAM532owkbUaD5miySMmr4LAwIfqIxWVliyh6V0f13GLIShbfQjPUzO
        lCqr59lQcD8JWdjzhcCPquJ7i9SMUkNohg==
X-Google-Smtp-Source: ABdhPJx5JKiQ2y/nAVCQkVouzzubmUwRiuNk6Pz4z3bB8CGruuUzIqamVZEopjPuWzYryfL7Zhvt3g==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr16845778pjb.62.1610884201203;
        Sun, 17 Jan 2021 03:50:01 -0800 (PST)
Received: from [127.0.0.1] ([14.33.99.107])
        by smtp.gmail.com with ESMTPSA id 184sm13135964pgi.92.2021.01.17.03.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 03:50:00 -0800 (PST)
From:   Jinoh Kang <jinoh.kang.kr@gmail.com>
Subject: [PATCH] dm persistent data: fix return type of shadow_root
To:     dm-devel@redhat.com
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Joe Thornber <thornber@redhat.com>,
        linux-kernel@vger.kernel.org
Message-ID: <f271028d-182e-c665-f67b-a407a7f7674a@gmail.com>
Date:   Sun, 17 Jan 2021 11:49:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101 Firefox/78.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shadow_root() truncates 64-bit dm_block_t into 32-bit int.  This is
not an issue in practice, since dm metadata as of v5.11 can only hold at
most 4161600 blocks (255 index entries * ~16k metadata blocks).

Nevertheless, this can confuse users debugging some specific data
corruption scenarios.  Also, DM_SM_METADATA_MAX_BLOCKS may be bumped in
the future, or persistent-data may find its use in other places.

Therefore, switch the return type of shadow_root from int to dm_block_t.

Fixes: 3241b1d3e0aa ("dm: add persistent data library")
Cc: stable@vger.kernel.org
Signed-off-by: Jinoh Kang <jinoh.kang.kr@gmail.com>
---
 drivers/md/persistent-data/dm-btree-internal.h | 2 +-
 drivers/md/persistent-data/dm-btree-spine.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/persistent-data/dm-btree-internal.h b/drivers/md/persistent-data/dm-btree-internal.h
index 564896659dd4..fe073d92f01e 100644
--- a/drivers/md/persistent-data/dm-btree-internal.h
+++ b/drivers/md/persistent-data/dm-btree-internal.h
@@ -100,7 +100,7 @@ struct dm_block *shadow_parent(struct shadow_spine *s);
 
 int shadow_has_parent(struct shadow_spine *s);
 
-int shadow_root(struct shadow_spine *s);
+dm_block_t shadow_root(struct shadow_spine *s);
 
 /*
  * Some inlines.
diff --git a/drivers/md/persistent-data/dm-btree-spine.c b/drivers/md/persistent-data/dm-btree-spine.c
index e03cb9e48773..8a2bfbfb218b 100644
--- a/drivers/md/persistent-data/dm-btree-spine.c
+++ b/drivers/md/persistent-data/dm-btree-spine.c
@@ -235,7 +235,7 @@ int shadow_has_parent(struct shadow_spine *s)
 	return s->count >= 2;
 }
 
-int shadow_root(struct shadow_spine *s)
+dm_block_t shadow_root(struct shadow_spine *s)
 {
 	return s->root;
 }
-- 
2.26.2

