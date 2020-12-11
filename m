Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C542D82C6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 00:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437361AbgLKXev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 18:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389857AbgLKXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:34:26 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F204BC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:33:45 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id kk4so3242085pjb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Iu352o38cH38gPmg4WLLZRhgJxjvxf30w/1vSczLt9o=;
        b=ZqeVMFcucNwA/18frxZWmorIH7IpIJqIFs1kUdtDd2c1o/05p+P/F07P9Mms6Y5Mrh
         U8j7TY+LKlWAIzaCyAkyFm+lRRU8exknvw/w7dcxCIZD5AbzxeEDkFcX7zTZfFpm2o+g
         NYA3eBlRI+//e58fPiZx8J0vVptjUDFK26+Nx0tRVktZogDPaSDHkYLKoe9SF79vjVOP
         YkPYVre6yPcBcNtfJGSVGVyY0W+J4uzdtTby2G3wGhQuJT8SRlZzHIoxAcehtmYtPmqT
         L9gwgXpAly+8k+P8YUsKvz9ic+Ks6Ef6RiTjHnohAlJCSVCB1K0s/Yee1ZwTNmAZeLcH
         0YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iu352o38cH38gPmg4WLLZRhgJxjvxf30w/1vSczLt9o=;
        b=LMwKC7YtSCjSbqCx9Wj70WhreJegdLjcD5UFp+7qoEGDL+czXRwn6TyKH5v4hEioD3
         /cNPi6yyY2t7ByiavB4GC7mj5ns2IjqU2P78CZubDdFgTNiKa1ekE4ggXS7USaKsUBbT
         IoYzZUJ1mtfvVHw6KudHH0bTtX678M+jfWXSklGu3RO6uPOg8df+eXwweoSRoLYqaakb
         XNbNgUXVYX3kzrPErSlIU1JypmBczObxjLH4V2jR3VgshClWI99EXpipCSjw4qfj1AhC
         o+SoI7l++4DVaxoIICxn3EVxmGyGjyxIaCyme151UfiBiJMK4j+DSW9CyWKjEjr9NKm8
         tPpA==
X-Gm-Message-State: AOAM530Ed6XjmFXSqyFTaRJcJ+LnXlG1PJQOVTGuONoUhaT/7nWyCX8Z
        uvPE4QrzdZ6bqCUViGuOmEwKyl8mMB73
X-Google-Smtp-Source: ABdhPJxuuiHUKuvUPeFysBTT6sPHLW5xDIymKoiDTgbWM+xZzuHcMxdZ2etEf3M6DNpwvFjzorP6I4Dq22jh
Sender: "brianvv via sendgmr" <brianvv@brianvv.c.googlers.com>
X-Received: from brianvv.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:348])
 (user=brianvv job=sendgmr) by 2002:a17:90a:17a4:: with SMTP id
 q33mr1469702pja.0.1607729624998; Fri, 11 Dec 2020 15:33:44 -0800 (PST)
Date:   Fri, 11 Dec 2020 23:33:37 +0000
In-Reply-To: <20201211233340.1503242-1-brianvv@google.com>
Message-Id: <20201211233340.1503242-2-brianvv@google.com>
Mime-Version: 1.0
References: <20201211233340.1503242-1-brianvv@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH net-next v2 1/4] net: use indirect call helpers for dst_input
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
 include/net/dst.h   | 6 +++++-
 net/ipv4/ip_input.c | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

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
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index b0c244af1e4d..3a025c011971 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -253,6 +253,7 @@ int ip_local_deliver(struct sk_buff *skb)
 		       net, NULL, skb, skb->dev, NULL,
 		       ip_local_deliver_finish);
 }
+EXPORT_SYMBOL(ip_local_deliver);
 
 static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 {
-- 
2.29.2.576.ga3fc446d84-goog

