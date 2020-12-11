Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5190E2D6DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 03:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbgLKCAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 21:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391596AbgLKB7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:59:50 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D11CC06179C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:33 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q4so5431967pgn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JZuBMUjdVVVxh6WnK4CWaG8XFlwg5qneM5nzLNIVeag=;
        b=ko6IbsPShEqsmfAfsfV9qvC127/jPkMqeofdfguKVDhv4nl4PDHYX0VMp3YLRGQHpd
         M9FIEZPyHzEjhCzMvJS1Q3kmPNYL88oBazzPo+UWk5Bj9slbUNmN+z7RIEwVb7od+GtU
         sW1+wy9m4H3MrISFx6vRt3pCu3UUUrpSQsw1Cv3EOAXbhNBzj+hFbcT72q90susNYJuM
         2g3YmJtYWRQnDygT5FJIG5GfVA7FvANcKmFVmI1MtfOzZ2Rv2CsQLe7zpQ3sMnV+zzs+
         j7rSlK/ixBtETx6kq03jHXYo2XnRMuM4/XE1PAsbJ1WtZBuErSpMuVfVKX3cUoY1yn0T
         JHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JZuBMUjdVVVxh6WnK4CWaG8XFlwg5qneM5nzLNIVeag=;
        b=rdPxbSCJQcFXjKS1EccvszXGYNOeBeKV+jyNcgTA5AWlA9AkDBmsTBk7pop/XxUcRC
         h5eQRNyjdKkuTc0haSawadumKCsKjrZGR5aVoVgs4wBt9kcVPfiJUPRAeoKCYBl4U3ee
         Sgq7vpk/q9P8cGr9NleQ9R3bz5ZU9l4u8/3xARp2SxoWXRAV+zvHKPaULJwpRxwlVsiL
         gr5nrfgEYNyarhPGIv4XFrarf6ue9aqojkjBe9LXhuUoXH1ngD6bOJvZnfFZKq99cVvE
         212L990/ZaD2e7B1vPx5oV69tkiRWJ7B9Mc0VbX6Vugt2cCIyPe+vOdy5i60CeBd262X
         S5Cg==
X-Gm-Message-State: AOAM531kNHhv4Rv4bPBdIA3feEiJevQafUZCgNRgzAOrgZCTCkuXgcJt
        4HYPIHL8MGs+vTO7VmFsUAhEjt5Umw96
X-Google-Smtp-Source: ABdhPJx/ZdLB8Kbh0dsoZNXoyjhao5SR68H1LrrwYVUeY7aVjpBjpUw3heJ5jdAZ1rEM4Qyww7Y4lrqeEZ5q
Sender: "brianvv via sendgmr" <brianvv@brianvv.c.googlers.com>
X-Received: from brianvv.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:348])
 (user=brianvv job=sendgmr) by 2002:a17:90b:50a:: with SMTP id
 r10mr10755699pjz.103.1607651912600; Thu, 10 Dec 2020 17:58:32 -0800 (PST)
Date:   Fri, 11 Dec 2020 01:58:21 +0000
In-Reply-To: <20201211015823.1079574-1-brianvv@google.com>
Message-Id: <20201211015823.1079574-3-brianvv@google.com>
Mime-Version: 1.0
References: <20201211015823.1079574-1-brianvv@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH net-next 2/4] net: use indirect call helpers for dst_output
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
ip6_output and ip_output

Signed-off-by: brianvv <brianvv@google.com>
---
 include/net/dst.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 98cf6e8c06c4..3932e9931f08 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -436,10 +436,16 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+INDIRECT_CALLABLE_DECLARE(int ip6_output(struct net *, struct sock *,
+					 struct sk_buff *));
+INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
+					 struct sk_buff *));
 /* Output packet to network from transport.  */
 static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return skb_dst(skb)->output(net, sk, skb);
+	return INDIRECT_CALL_INET(skb_dst(skb)->output,
+				  ip6_output, ip_output,
+				  net, sk, skb);
 }
 
 INDIRECT_CALLABLE_DECLARE(int ip6_input(struct sk_buff *));
-- 
2.29.2.576.ga3fc446d84-goog

