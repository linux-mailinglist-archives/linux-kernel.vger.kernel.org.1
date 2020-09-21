Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3A2727C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIUOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgIUOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:37:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63175C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:37:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so12366857wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 07:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnvbdIKWJ6AAgCFtsSP8IkBiUqWqGAGPpu4/dd+164E=;
        b=AFmSSoOqtOuxCv0wZpi+kLpYjxEcU/FEIwJTY+nhtwHw1LjMwY1yGTnkOYNHPR048M
         WSSbQu62SBcXmujLhNjCbyWFneDtDC01b8xLleyumamT0XN3zf5QDaaQtVZJAiLEHl+K
         aP1KnBtqSVmfJR7WhnaqRvbNKYw2qal7p9quGtvVJ7RdyHtmWfReMq8u0hFRYtgcLtE5
         iJ/wsSLKLQSFTB08PvT25vypOAiLCIXjNqXokcw5UQN/kaByfzSrpI7nNMD26Fjf7xYs
         jIEvzQIzGPZf3zf9swZkmLfN9PK811LL2AIEI8sQr+XGJGvP8S81SVDCpJIBVmBcjEYC
         h8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnvbdIKWJ6AAgCFtsSP8IkBiUqWqGAGPpu4/dd+164E=;
        b=qoHGcQcBLT17F2m+HkYxc1d2ehp+Acp3B9wpe41Uqvl3SHfJOTmfmLi5rnio3dLfZA
         DXngnC2fSo+Nd+WAHEcqHKMTvqMKAl7P129D8WZmWg95az2B1B6zxUoOuwXrrAmOAGvO
         oFz3TPRufSir2A6jAawxewUBFmR2VuamuYAVmSiDb4Z65NVUYEr96uZsXMIlA2t3oRcX
         z+oCXsNGtAxwP+hKjgGZnjGMy+0DwhmH72+87+bCQiNjqGeNhDXxBUmhaEZsY6Mqmrxi
         zeZirAkAd3m6BWQMwtIURZ0kob9xvy+i2wBMKZv/uf3i6hUZGw7x9TzQJ0muSGxsaOOx
         XFTQ==
X-Gm-Message-State: AOAM531v4WswMzXTKrve03UGmu9kzJLdmi8J65uG1q2JLt8Sn4Kqbfvk
        M/LNT4kIWsN8xLGR8idD2HsnIiI1mmDd3A==
X-Google-Smtp-Source: ABdhPJxhWimjBReRI+3w+8A7xhCAHZk7JhlMx0En1xqUXN/o59Ux0pL8e0DnWQOqyk9onoYwYp6FuA==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr194666wmm.128.1600699029830;
        Mon, 21 Sep 2020 07:37:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c14sm20370753wrv.12.2020.09.21.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 07:37:03 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 3/7] xfrm/compat: Attach xfrm dumps to 64=>32 bit translator
Date:   Mon, 21 Sep 2020 15:36:53 +0100
Message-Id: <20200921143657.604020-4-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921143657.604020-1-dima@arista.com>
References: <20200921143657.604020-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently nlmsg_unicast() is used by functions that dump structures that
can be different in size for compat tasks, see dump_one_state() and
dump_one_policy().

The following nlmsg_unicast() users exist today in xfrm:

         Function                          |    Message can be different
                                           |       in size on compat
-------------------------------------------|------------------------------
    xfrm_get_spdinfo()                     |               N
    xfrm_get_sadinfo()                     |               N
    xfrm_get_sa()                          |               Y
    xfrm_alloc_userspi()                   |               Y
    xfrm_get_policy()                      |               Y
    xfrm_get_ae()                          |               N

Besides, dump_one_state() and dump_one_policy() can be used by filtered
netlink dump for XFRM_MSG_GETSA, XFRM_MSG_GETPOLICY.

Just as for xfrm multicast, allocate frag_list for compat skb journey
down to recvmsg() which will give user the desired skb according to
syscall bitness.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 3769227ed4e1..7fd7b16a8805 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -975,6 +975,7 @@ static int dump_one_state(struct xfrm_state *x, int count, void *ptr)
 	struct xfrm_dump_info *sp = ptr;
 	struct sk_buff *in_skb = sp->in_skb;
 	struct sk_buff *skb = sp->out_skb;
+	struct xfrm_translator *xtr;
 	struct xfrm_usersa_info *p;
 	struct nlmsghdr *nlh;
 	int err;
@@ -992,6 +993,18 @@ static int dump_one_state(struct xfrm_state *x, int count, void *ptr)
 		return err;
 	}
 	nlmsg_end(skb, nlh);
+
+	xtr = xfrm_get_translator();
+	if (xtr) {
+		err = xtr->alloc_compat(skb, nlh);
+
+		xfrm_put_translator(xtr);
+		if (err) {
+			nlmsg_cancel(skb, nlh);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
@@ -1320,6 +1333,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
 	struct xfrm_userspi_info *p;
+	struct xfrm_translator *xtr;
 	struct sk_buff *resp_skb;
 	xfrm_address_t *daddr;
 	int family;
@@ -1370,6 +1384,17 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
+	xtr = xfrm_get_translator();
+	if (xtr) {
+		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
+
+		xfrm_put_translator(xtr);
+		if (err) {
+			kfree_skb(resp_skb);
+			goto out;
+		}
+	}
+
 	err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
 
 out:
@@ -1776,6 +1801,7 @@ static int dump_one_policy(struct xfrm_policy *xp, int dir, int count, void *ptr
 	struct xfrm_userpolicy_info *p;
 	struct sk_buff *in_skb = sp->in_skb;
 	struct sk_buff *skb = sp->out_skb;
+	struct xfrm_translator *xtr;
 	struct nlmsghdr *nlh;
 	int err;
 
@@ -1800,6 +1826,18 @@ static int dump_one_policy(struct xfrm_policy *xp, int dir, int count, void *ptr
 		return err;
 	}
 	nlmsg_end(skb, nlh);
+
+	xtr = xfrm_get_translator();
+	if (xtr) {
+		err = xtr->alloc_compat(skb, nlh);
+
+		xfrm_put_translator(xtr);
+		if (err) {
+			nlmsg_cancel(skb, nlh);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.28.0

