Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70A2D6DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 03:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395004AbgLKB70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391182AbgLKB7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:59:11 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6CC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id i6so5437060pgg.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aDAJY+8VIyQrulSE2QmK19TS3uRloTNCtUe012HVBlY=;
        b=WY0wPAkEvRHvd0V95IlCbjSJdmpuWYQiBudlmdQoBVhngtSq6VOXDHi7se/3cQ0lAH
         L1x0OCQnhimFFGx1IuKBQaela/tfqY+ZhyFxvDmKnxKvX/Q7pvOY+QKeKr8tk7hXlnGW
         MpFnWponVBcwuzxQ34lHdTY6E2hFY60CJVVR/p7/MauubF3jFubAfKFOcZVo4SWFmtKF
         RA1cHNV3qfvr3RfEexC8d5wBXKUdwVZ2OG2C8KP+PGHTQRzFeoCnJhCbtrigFhXpWivT
         jA8FtbYA6BAc4KbvSl/UB/dXoSLhCQ853Tlc9g5L5wZgy2Os+YK6TLoH9QOdLONRpkOK
         JtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aDAJY+8VIyQrulSE2QmK19TS3uRloTNCtUe012HVBlY=;
        b=RoDRWs3kctDXkSLyjDGSntTL4+j0OzMVXBJH1g+3FaCZopxGWpy95jOZESMWcLkUwo
         J0ClHO97QMhhvJgWOZ2s/o/xYFFXbVEujA7FTrbO1hCu1wZHST9uotLlWjrAaM7J7yuR
         lmBnH764yVwF2BOf/va/voRJp2EPmau/uVE2Cekcw/k4nIZet7YTFvqAZ0pqpZ2dpu3I
         n5jTXa4SLfXLPDpnZYL6KkcpERsNc3UnhgCyZe0ARz5MtiQOBHHQp+aCYahAI12hk39H
         jHXGFj6w/+bKP+Fzn3LZ35q0ieWz/qkR+4XRDy7fnaYlEd2+l7jIxs36kup4VLvNmk6F
         OGxg==
X-Gm-Message-State: AOAM533nDDiVAsVVI7saexTM0LysK6WNYGzPgMmaHtb0/GicnlkZD6v9
        C9ug/sidjDdtGZ+jqNle7gy56hqrs/20
X-Google-Smtp-Source: ABdhPJyE+T1lUsVnjG3z+ekBg5fk/dWQGlg2Lt+8NFAN9tJ8AgJmz3L0ypm/3zvMOBc7quLCVZeFu64KWlKL
Sender: "brianvv via sendgmr" <brianvv@brianvv.c.googlers.com>
X-Received: from brianvv.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:348])
 (user=brianvv job=sendgmr) by 2002:a62:7e09:0:b029:19e:9fdd:80a3 with SMTP id
 z9-20020a627e090000b029019e9fdd80a3mr8312032pfc.24.1607651910852; Thu, 10 Dec
 2020 17:58:30 -0800 (PST)
Date:   Fri, 11 Dec 2020 01:58:20 +0000
In-Reply-To: <20201211015823.1079574-1-brianvv@google.com>
Message-Id: <20201211015823.1079574-2-brianvv@google.com>
Mime-Version: 1.0
References: <20201211015823.1079574-1-brianvv@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH net-next 1/4] net: use indirect call helpers for dst_input
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: brianvv <brianvv@google.com>

This patch avoids the indirect call for the common case:
ip_local_deliver and ip6_input

Signed-off-by: brianvv <brianvv@google.com>
---
 include/net/dst.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 10f0a8399867..98cf6e8c06c4 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -18,6 +18,7 @@
 #include <linux/refcount.h>
 #include <net/neighbour.h>
 #include <asm/processor.h>
+#include <linux/indirect_call_wrapper.h>
 
 struct sk_buff;
 
@@ -441,10 +442,13 @@ static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *s
 	return skb_dst(skb)->output(net, sk, skb);
 }
 
+INDIRECT_CALLABLE_DECLARE(int ip6_input(struct sk_buff *));
+INDIRECT_CALLABLE_DECLARE(int ip_local_deliver(struct sk_buff *));
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return skb_dst(skb)->input(skb);
+	return INDIRECT_CALL_INET(skb_dst(skb)->input,
+				  ip6_input, ip_local_deliver, skb);
 }
 
 static inline struct dst_entry *dst_check(struct dst_entry *dst, u32 cookie)
-- 
2.29.2.576.ga3fc446d84-goog

