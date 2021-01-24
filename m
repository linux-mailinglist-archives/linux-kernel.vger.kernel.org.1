Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B1301E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbhAXTJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:09:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbhAXTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611515295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BObjur6w5Zyn1iSvTdoLrwThuMrSePyOuptlnRaBSlQ=;
        b=Qb6EUNcsPenzvyMw6SSIX0M4/z/7Fjphl2PJMblu4BtI/xxNVVFzH/uzMehsV4M6Ayc/9x
        gQVNwazVC06B9NA4UjppJspH/WeGiSHGARgr2qnmoU45r+xC3y2e60eaTij87+VcNKNps+
        uesJpMDNPsJuIHMYeMGDqN0eFaCgMUg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-V4ucLKUaPJSF1Wg805ctKQ-1; Sun, 24 Jan 2021 14:08:13 -0500
X-MC-Unique: V4ucLKUaPJSF1Wg805ctKQ-1
Received: by mail-qv1-f71.google.com with SMTP id t17so7867600qvv.17
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 11:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BObjur6w5Zyn1iSvTdoLrwThuMrSePyOuptlnRaBSlQ=;
        b=jjBnxkxiqo4FW0QmLpIVGHK2ckKg2bu85u+Ei0MDffPD3sEIqRN1lOW1Tg3FhVgG8C
         Avm9JWpY2Wk8ppeN17JH/1Uy1MHGqEXhDTEYaEF7p9YxiutwTtUD1sfGmCkZzpeczr69
         PlaxCbpirZtdWF8DtGNPBanIh4ZRXjiYBgtzFULoJSjszbclT3g2HVXQm6dphb0sEoXU
         2uABNnqtaZ38a5BvVjt2Sb5XZ5neGFiwl70nuKf0oKHuInO4jlhAhRH53nO5yLeYZHg8
         AeSwOKmxFmxuDzaSjpWFb3n7nws4bGyFF96LHiZuHuBGeu0v6tARzy5TlFuA7S2av59z
         9xJA==
X-Gm-Message-State: AOAM5334WO8cGxzTfht29OhRaIQ4RTzfKFAgrc/StglRITbSz8yakUjK
        szhSBzGektGk6BuGzgNUXVhbwZc2pWW5/vIJMsXRSsP7T0ck5wGYAimeD7dpd0bE49UPJsxASjZ
        Bw6MWSieMXOYjWGuGBn2OeUIF
X-Received: by 2002:a37:a34f:: with SMTP id m76mr2283308qke.89.1611515293125;
        Sun, 24 Jan 2021 11:08:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxieGe00q6W3nNVZzjzXXukregAstLEMA0R4TytIKTfozNtBu6iJHMnLbESe6ZwJ6U65F7Cxw==
X-Received: by 2002:a37:a34f:: with SMTP id m76mr2283292qke.89.1611515292916;
        Sun, 24 Jan 2021 11:08:12 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v8sm10038052qtq.80.2021.01.24.11.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 11:08:12 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, maheshb@google.com,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ipvlan: remove h from printk format specifier
Date:   Sun, 24 Jan 2021 11:08:04 -0800
Message-Id: <20210124190804.1964580-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
  unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Cleanup output to use __func__ over explicit function strings.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 8801d093135c..6cd50106e611 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -651,8 +651,7 @@ int ipvlan_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	/* Should not reach here */
-	WARN_ONCE(true, "ipvlan_queue_xmit() called for mode = [%hx]\n",
-			  port->mode);
+	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, port->mode);
 out:
 	kfree_skb(skb);
 	return NET_XMIT_DROP;
@@ -749,8 +748,7 @@ rx_handler_result_t ipvlan_handle_frame(struct sk_buff **pskb)
 	}
 
 	/* Should not reach here */
-	WARN_ONCE(true, "ipvlan_handle_frame() called for mode = [%hx]\n",
-			  port->mode);
+	WARN_ONCE(true, "%s called for mode = [%x]\n", __func__, port->mode);
 	kfree_skb(skb);
 	return RX_HANDLER_CONSUMED;
 }
-- 
2.27.0

