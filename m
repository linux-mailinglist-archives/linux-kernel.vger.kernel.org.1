Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A061D2A1F54
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgKAP6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726730AbgKAP6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604246309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=uGnDR6G7/vPpNC+qZpU8vljrteTG7L+Sb38lV82f6o8=;
        b=H7/1gSeSfJksKesnpUxIwoVWoWLHVqzllOxYHyGiD1042KDI/9C94N/bF1r9iGlJoTVIo4
        8Vv44I8Uia2Nw9exckqx+I/YCtYh8RnW71lLGStNNq9+i30fMf3YNbruqnyp5oa/kTiG+X
        hnu3rKJs3fQStyEL2JHkpUASYX5XH4A=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-TkCn8yv3POutrcmopCbbKg-1; Sun, 01 Nov 2020 10:58:27 -0500
X-MC-Unique: TkCn8yv3POutrcmopCbbKg-1
Received: by mail-ot1-f72.google.com with SMTP id g22so5196634otp.23
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 07:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uGnDR6G7/vPpNC+qZpU8vljrteTG7L+Sb38lV82f6o8=;
        b=o+2rTbi1IbOzGhOpa4I24On4G+3+nvmFqDkzVIDErF7T7huHGhi4ixK505CWAkR/+j
         R+svn+l6/YteAGXKvNMfRYDQh+JrJJb0OT+8R596Nh+8gcxNiCaXhm0NCHCKNWEGtFnh
         3KrNq88m9wf/gjw8j2A+xspGujNmmct9riEUTqmMc9xcIK/t128Ay/oC0DaoGu101JiY
         MigjylzVjHTA65JGvHalXdgtBIwd3rf/BhBfNsTLA7kVQhDee2kaexta5CJrdeXg5va3
         4FQ4UyfedC77pzOAfWyTgZEOQpVax8p0LQ1cZuvlVD2xmEU8kMF9ywXxSF1BaS86WvhE
         //kg==
X-Gm-Message-State: AOAM533W3fOLwyM9myQsfgMXBK0RE/t5THgt2G6nIx4Uf2SGFzRTY0Bs
        ELd6vlh9IzqAutBm5yE0HUmc2ub/uPF4bEikIz6jLVj2Z2ie8qQUGCNI/JcjvONHu4DnBPIMue8
        WQQ2dz8pWr+XSbyofAPV6lCT3
X-Received: by 2002:aca:5285:: with SMTP id g127mr7816633oib.88.1604246307073;
        Sun, 01 Nov 2020 07:58:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0OCbtyASaS0yijWJrsajMPLt1AD4+e8hVYb2K8mGI3EvQYc9N7aiAjDy5zRjHAF0JoHA9vg==
X-Received: by 2002:aca:5285:: with SMTP id g127mr7816623oib.88.1604246306930;
        Sun, 01 Nov 2020 07:58:26 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y8sm2821515oon.16.2020.11.01.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:58:26 -0800 (PST)
From:   trix@redhat.com
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] tipc: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:58:22 -0800
Message-Id: <20201101155822.2294856-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/tipc/link.c | 2 +-
 net/tipc/node.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 06b880da2a8e..97b1c6bd45dc 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1260,7 +1260,7 @@ static bool tipc_data_input(struct tipc_link *l, struct sk_buff *skb,
 		pr_warn("Dropping received illegal msg type\n");
 		kfree_skb(skb);
 		return true;
-	};
+	}
 }
 
 /* tipc_link_input - process packet that has passed link protocol check
diff --git a/net/tipc/node.c b/net/tipc/node.c
index d269ebe382e1..cd67b7d5169f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1638,7 +1638,7 @@ static void tipc_lxc_xmit(struct net *peer_net, struct sk_buff_head *list)
 		return;
 	default:
 		return;
-	};
+	}
 }
 
 /**
-- 
2.18.1

