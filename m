Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C32A2F6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKBQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgKBQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:14:54 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A9C061A48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:14:53 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n15so15322175wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6oQK3SCG2X0OqS0yyKhp7n4T1apDPtlUAe42OHVNz1g=;
        b=U+Gj6XSRpsl6pLpA+QTmOVmB66RFKQJCOwKzcr+1mFCmixjP+nIVTlQAFEso30z1wz
         O0klYqGgOGCslpkhSP7luB/MllmRBxRCytJslqVn3qVMk13gAd8VKRuLL/cEvxm500JV
         9jpcB8e/V+nSFGnmhTGYGtxBWObnG8pJRmMEu/HOnPQ3j88PO9P4e2S9L7kIBd+7LtYA
         NFtYOpPC/+6JJQAfdMOqMpMeyI3ez0bDILbfJuWEqWfPPxkZ9ExZ4A3rwXFcaWLmHGEO
         xPYazqP83Uq99S1QIRVWEDPbeZR9O2e7k6Pu2xVFSRnx2e2o/86ym/Q0Bgbd0OdDx+Ar
         cu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oQK3SCG2X0OqS0yyKhp7n4T1apDPtlUAe42OHVNz1g=;
        b=XSo/KCUDwORb9G/YEjTAQ1fV/BhxXc2rCk+WK8czXeJUm3gMdAn2nuxNLlvfZ2Dv0w
         l7jW1jAF8RFEmq70+THdJ/iDYwGpWY4KpJv6MwfZYJsdEjfE4VeB7H83ar/O/iSSsHKJ
         ZkhrhhX5duSbOzksZLpm2a9ANGfcbr/+pVcpTAIkZFNvKWrY+/KFKkPkL/IRjtz9/7hQ
         BXtecm7B9eLV5dD8xecKatTtEpJvzImY9zeaEoZioDVoYK/3ASp0ATHBMPTab2XrD+Ez
         AZn/ouNOk++SXDdq7jJ3eDMTGioixrVZEfDm1PKo7fQoBkTeBW8Q1BtKTdXCN4YR6sz+
         2XjQ==
X-Gm-Message-State: AOAM5319M3aVtp6/jn0wZFF2O8mYzNh2eNq1FZkRq5SMWmBTpxyhY4VK
        Z6KhU6szDhD/FTnWeHU4bxikS5xfMKfwT3Iu
X-Google-Smtp-Source: ABdhPJwCEfpj+fMa6liV5sL/DNJ1tclbc/6Zec8uGWaFEja2jNV69ckqw4hFkdzT/4DAxedt7W/r4w==
X-Received: by 2002:adf:9502:: with SMTP id 2mr19336780wrs.5.1604333692119;
        Mon, 02 Nov 2020 08:14:52 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x18sm24127878wrg.4.2020.11.02.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:14:51 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        syzbot+c43831072e7df506a646@syzkaller.appspotmail.com
Subject: [PATCH v2 2/3] xfrm/compat: memset(0) 64-bit padding at right place
Date:   Mon,  2 Nov 2020 16:14:46 +0000
Message-Id: <20201102161447.1266001-3-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102161447.1266001-1-dima@arista.com>
References: <20201102161447.1266001-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit messages translated by xfrm_compat can have attributes attached.
For all, but XFRMA_SA, XFRMA_POLICY the size of payload is the same
in 32-bit UABI and 64-bit UABI. For XFRMA_SA (struct xfrm_usersa_info)
and XFRMA_POLICY (struct xfrm_userpolicy_info) it's only tail-padding
that is present in 64-bit payload, but not in 32-bit.
The proper size for destination nlattr is already calculated by
xfrm_user_rcv_calculate_len64() and allocated with kvmalloc().

xfrm_attr_cpy32() copies 32-bit copy_len into 64-bit attribute
translated payload, zero-filling possible padding for SA/POLICY.
Due to a typo, *pos already has 64-bit payload size, in a result next
memset(0) is called on the memory after the translated attribute, not on
the tail-padding of it.

Fixes: 5106f4a8acff ("xfrm/compat: Add 32=>64-bit messages translator")
Reported-by: syzbot+c43831072e7df506a646@syzkaller.appspotmail.com
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 17edbf935e35..556e9f33b815 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -388,7 +388,7 @@ static int xfrm_attr_cpy32(void *dst, size_t *pos, const struct nlattr *src,
 
 	memcpy(nla, src, nla_attr_size(copy_len));
 	nla->nla_len = nla_attr_size(payload);
-	*pos += nla_attr_size(payload);
+	*pos += nla_attr_size(copy_len);
 	nlmsg->nlmsg_len += nla->nla_len;
 
 	memset(dst + *pos, 0, payload - copy_len);
-- 
2.28.0

