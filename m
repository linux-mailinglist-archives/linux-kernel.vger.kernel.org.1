Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE32C748A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbgK1Vtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729225AbgK0Ts2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 14:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=/d0gr28L5usZ6CMCStP6D3CMWZKIP6JyYolWhvHhl68=;
        b=Snf4FfF2F3eTsPq7xketrqoK+3H7ofBdKKmOHwraq0cYYWN13bds7ko8sWsrQrbStB2oxf
        x68NxbW5Be6sKuh3TK1aj/FZK/npI3M3z9ZSM/2UeG024ftIxumlfb0u8bI3zGBcIEooBj
        4mCSH8v5cJdoM56YyGNhJgBdd35+J6Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-mTLCH1OePi6wRVTEtlR36g-1; Fri, 27 Nov 2020 14:14:03 -0500
X-MC-Unique: mTLCH1OePi6wRVTEtlR36g-1
Received: by mail-qt1-f200.google.com with SMTP id i14so3736005qtq.18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 11:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/d0gr28L5usZ6CMCStP6D3CMWZKIP6JyYolWhvHhl68=;
        b=ugu7+9TRpnDPNKqlMFvZDgz6fjX3G7DYf4VlJ3w+HJ6pcJXuTiiMG2fdyMd2tv/aq9
         n1w+RZwfxoE+rJZeT1KQs2vXp+LlwRRHQ4Di0TMNJfDEYUxoNzI/kytPBu0B7GwgDyGU
         D2hEXdtSTED5yLUb+6omYiZcrXNILe1xGPUR48V1Exs7BX++85qt8zvBJegc6xWOd8MA
         EFR2/mZ6vgwEC1bo6NJr831DbHEycATvX6/kNHmt5liop7R3j1W7o8g9F6trQTzpJl8V
         wQLmtLcmcMIUsh+OrgjRpdYNY6jhe1COj+8VJDod3SJku/A82wRHdSNEInkhGZGJJVN2
         60CA==
X-Gm-Message-State: AOAM530/fK/rUaG4KZh63/Bt8/eiwx3wnuzP+a1tSGFs/xlK0zEBvIy4
        v3gDqWA+PaqjAA5J+TJq9RpZGFQx7E45Ban8HSMoD0P6ORiUh2QD/ERpbKVUBNYOx7eG6E9z4vZ
        /OEdSpMHL6E035mQT/KepGuV3
X-Received: by 2002:a05:620a:48b:: with SMTP id 11mr10169623qkr.0.1606504442621;
        Fri, 27 Nov 2020 11:14:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmHKP07wAts1TRf4OZfzg/0usM+pvzZL055IEPgN96PXnE7spOh+01PIIHtFzGB/nP4UcOWQ==
X-Received: by 2002:a05:620a:48b:: with SMTP id 11mr10169611qkr.0.1606504442440;
        Fri, 27 Nov 2020 11:14:02 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e131sm7210805qkb.101.2020.11.27.11.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:14:01 -0800 (PST)
From:   trix@redhat.com
To:     dwmw2@infradead.org, richard@nod.at, gustavoars@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] jffs2: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:13:57 -0800
Message-Id: <20201127191357.2852751-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/jffs2/nodelist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 8ff4d1a1e774..2e98fa277dab 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -349,14 +349,14 @@ static inline struct jffs2_node_frag *frag_last(struct rb_root *root)
 #define frag_parent(frag) rb_entry(rb_parent(&(frag)->rb), struct jffs2_node_frag, rb)
 #define frag_left(frag) rb_entry((frag)->rb.rb_left, struct jffs2_node_frag, rb)
 #define frag_right(frag) rb_entry((frag)->rb.rb_right, struct jffs2_node_frag, rb)
-#define frag_erase(frag, list) rb_erase(&frag->rb, list);
+#define frag_erase(frag, list) rb_erase(&frag->rb, list)
 
 #define tn_next(tn) rb_entry(rb_next(&(tn)->rb), struct jffs2_tmp_dnode_info, rb)
 #define tn_prev(tn) rb_entry(rb_prev(&(tn)->rb), struct jffs2_tmp_dnode_info, rb)
 #define tn_parent(tn) rb_entry(rb_parent(&(tn)->rb), struct jffs2_tmp_dnode_info, rb)
 #define tn_left(tn) rb_entry((tn)->rb.rb_left, struct jffs2_tmp_dnode_info, rb)
 #define tn_right(tn) rb_entry((tn)->rb.rb_right, struct jffs2_tmp_dnode_info, rb)
-#define tn_erase(tn, list) rb_erase(&tn->rb, list);
+#define tn_erase(tn, list) rb_erase(&tn->rb, list)
 #define tn_last(list) rb_entry(rb_last(list), struct jffs2_tmp_dnode_info, rb)
 #define tn_first(list) rb_entry(rb_first(list), struct jffs2_tmp_dnode_info, rb)
 
-- 
2.18.4

