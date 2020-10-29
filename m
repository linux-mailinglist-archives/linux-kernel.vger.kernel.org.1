Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE2429F874
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJ2Wha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgJ2Wh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:37:29 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FB3C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:37:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f9so2737915qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=BiCPGNHEYq7IED6pRZ/BzCt1AxbVwIiK4WTDKoCvHSM=;
        b=dnxy95AUQmjaY8Bv8LSaCRLQqP0eaMVA7DHEhwQJSsLrrv5iYturZZMke2JunjNxWs
         Crh95X5tigSC6Y9q3VS175Ihr8AEZxaJKKUjvlh19VOPVXKwuZqPYEQvqmJ05tL07jPy
         Te68NYUPjuK845g+oAbUVgeef6XVgBN8rTMmFWRDrDcnsPWBFY8CmLz3VGvDBgF3K/8f
         l2QzEtpWq/7e/JgQFf8luCGNrtql8MmZ6jkPpZVwHK25ERtw+C9ME61Ort0Ax4hDnR2f
         y6x+xvlKUJ3MS5QNt0QdwG50c/CH3ND4BqD8ON0IjQMmh+fpY8uXOfKt9mcNPUtS6y33
         Pe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=BiCPGNHEYq7IED6pRZ/BzCt1AxbVwIiK4WTDKoCvHSM=;
        b=fi93fwcRS/VL6+nU8fWmNFfPogXfo3s8wWMi10ryNabaMOuFZfAKI/+BWbAZo0xGCx
         v8ALkXosErH5j/ww03SPCRQJR71yhKc0rMVwSl+Pat2F2nnQT2bx30DVFclbtAu9t4rM
         1WVlP8oUPCkwC8y2WEgCTeO0ockcxRZ7qgTlyOIg1pPZX3crPx2OjP18UXmi+hu8UK5g
         B87R9AA+AcjemCC640TskVOuska4IRVo0B5ZyADwdvjwkE530gqs57E/xO7oERtLTG4/
         3fK6BSMfpP44RSdaXxlyUa0LRhD1zXXDF3uZ5XvadzVfTi4MBV52udSiV+0w451j0uLp
         JT1A==
X-Gm-Message-State: AOAM533+jZqcgjK6Cvpo5K4IpX9axvH/dw7aTO/0wtVORnrK1PdWaoul
        OoZj8S4opLufrZlJFzaGPVPacVlO7i/1
X-Google-Smtp-Source: ABdhPJxWrWDS38PkkbgZk9b4i52L8CEXtkQ8bJSOEdv/nw+U1dByIV6meridJeVbYTlItASPFe201nMxl5oZ
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:ad4:43ca:: with SMTP id
 o10mr6868463qvs.33.1604011048079; Thu, 29 Oct 2020 15:37:28 -0700 (PDT)
Date:   Thu, 29 Oct 2020 15:37:07 -0700
Message-Id: <20201029223707.494059-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2] libbpf hashmap: Fix undefined behavior in hash_bits
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bits is 0, the case when the map is empty, then the >> is the size of
the register which is undefined behavior - on x86 it is the same as a
shift by 0. Fix by handling the 0 case explicitly and guarding calls to
hash_bits for empty maps in hashmap__for_each_key_entry and
hashmap__for_each_entry_safe.

Suggested-by: Andrii Nakryiko <andriin@fb.com>,
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index d9b385fe808c..10a4c4cd13cf 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -15,6 +15,9 @@
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
+	if (bits == 0)
+		return 0;
+
 #if (__SIZEOF_SIZE_T__ == __SIZEOF_LONG_LONG__)
 	/* LP64 case */
 	return (h * 11400714819323198485llu) >> (__SIZEOF_LONG_LONG__ * 8 - bits);
@@ -174,17 +177,17 @@ bool hashmap__find(const struct hashmap *map, const void *key, void **value);
  * @key: key to iterate entries for
  */
 #define hashmap__for_each_key_entry(map, cur, _key)			    \
-	for (cur = ({ size_t bkt = hash_bits(map->hash_fn((_key), map->ctx),\
-					     map->cap_bits);		    \
-		     map->buckets ? map->buckets[bkt] : NULL; });	    \
+	for (cur = map->buckets						    \
+		     ? map->buckets[hash_bits(map->hash_fn((_key), map->ctx), map->cap_bits)] \
+		     : NULL;						    \
 	     cur;							    \
 	     cur = cur->next)						    \
 		if (map->equal_fn(cur->key, (_key), map->ctx))
 
 #define hashmap__for_each_key_entry_safe(map, cur, tmp, _key)		    \
-	for (cur = ({ size_t bkt = hash_bits(map->hash_fn((_key), map->ctx),\
-					     map->cap_bits);		    \
-		     cur = map->buckets ? map->buckets[bkt] : NULL; });	    \
+	for (cur = map->buckets						    \
+		     ? map->buckets[hash_bits(map->hash_fn((_key), map->ctx), map->cap_bits)] \
+		     : NULL;						    \
 	     cur && ({ tmp = cur->next; true; });			    \
 	     cur = tmp)							    \
 		if (map->equal_fn(cur->key, (_key), map->ctx))
-- 
2.29.1.341.ge80a0c044ae-goog

