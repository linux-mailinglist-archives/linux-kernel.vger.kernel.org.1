Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6A2A2F70
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKBQPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgKBQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:14:55 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE74C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:14:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so9948004wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YP7gpeIdOxquq/TfUCec+7EbTBaII9gjVTUVcNqSjPU=;
        b=AaGBSGvjhehUR423BN+bvavmMxSWC0jcslz8PXWQI1XmoPgaS4nFW1xD9lIqMKt6fJ
         ig21d8KFcShPzUP/t8fEo7pGj0B6s2gUgHYjWwgJIZRyTtpn5h9wG0Qz6FBwkIsLw0bL
         24hUoOXsYRm/C22dDpF7S6ZydHjBZpi11cTodG1Ywc2Ung4P2MtJm6ArmjSLh4qgyO5/
         6+TomzWOaYB/y3a/cU5XSRDD3kOaeVuZHBLe4iIK6rqQz2JfBryqGoi4b1hylhPbAnVa
         rd8uQMwnTQp9b643eLX3ctwUTkzYM5XSL1r6wcHYpGx4zaGq/mZZCS68XmJP+ybcuyqH
         NEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YP7gpeIdOxquq/TfUCec+7EbTBaII9gjVTUVcNqSjPU=;
        b=Q6pbWZJIy+BKtmos2eO3aUCXytXIb04+qrUxQyq6u2oDLu1Zoi5qxFzuRwtIRUAk1U
         Vb80epvX98M8FZs4/GfP/US6E0aHUCwcCLCyr4mHqunszkH8d9WXoJ3Q3vd3uqp6jsZZ
         dne781LI/eJycmIlpA8ZzeYdVVvDwzYpv38bhjBS0xRUBG+m84LJpgT69CZSABJCvFfU
         PN4mp24ddd+1mmWnOfVDqVvCXZaVjupuhZxcpDaT7IhHrEsTJVEp9jcKv6YqCSF9ovEo
         9E/8WKX/iRAT/B8seuv57uBI850jvG+A8JFh4zpVgHkBPJ3iNAUTpzEXg9zj01hfEzfL
         R27A==
X-Gm-Message-State: AOAM5328QLL3C7cbpFWF50TwAlQxrX8TXI2haW1gRGOtvFluLHNf0ySa
        fxx7u4tr6u2W+OpZALy4ah/x7b0ty1lD4RGT
X-Google-Smtp-Source: ABdhPJw3RBVQO147VlnGF8efd93BaENdZO5NDLkR4YamM5z8tQtiVuJe8uc3wyzwHceF473tMBXz3g==
X-Received: by 2002:a05:600c:209:: with SMTP id 9mr18317719wmi.89.1604333693619;
        Mon, 02 Nov 2020 08:14:53 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x18sm24127878wrg.4.2020.11.02.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:14:52 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org
Subject: [PATCH v2 3/3] xfrm/compat: Don't allocate memory with __GFP_ZERO
Date:   Mon,  2 Nov 2020 16:14:47 +0000
Message-Id: <20201102161447.1266001-4-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102161447.1266001-1-dima@arista.com>
References: <20201102161447.1266001-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit to 64-bit messages translator zerofies needed paddings in the
translation, the rest is the actual payload.
Don't allocate zero pages as they are not needed.

Fixes: 5106f4a8acff ("xfrm/compat: Add 32=>64-bit messages translator")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 556e9f33b815..d8e8a11ca845 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -564,7 +564,7 @@ static struct nlmsghdr *xfrm_user_rcv_msg_compat(const struct nlmsghdr *h32,
 		return NULL;
 
 	len += NLMSG_HDRLEN;
-	h64 = kvmalloc(len, GFP_KERNEL | __GFP_ZERO);
+	h64 = kvmalloc(len, GFP_KERNEL);
 	if (!h64)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.28.0

