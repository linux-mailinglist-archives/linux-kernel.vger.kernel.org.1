Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8C29FB30
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3C0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3C0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:26:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871C2C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:26:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a9so4800552wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1EQkh492Mu2jcFb695EkgyNX5lh9rVoFrBg9UQoeOA=;
        b=gE8wG1tR4G4yLkiIiDSr6+pBvfL9AatK9YzKQjSAvJtAyWl0lohZh3WNinOoZsmfy2
         B2QsH5H9CrDO5Kq50n35BKQQwWdNUG9+arReDbUsG0Cyu0N5Eq4TpN3bcSWqf3cje1pr
         v6i9781D1dreCqxDJOLDihMwRYwqF/7NS46WjlzhePNElyciKkzP6JEVpIQ7jDRReedj
         +74xyh7/drTx5vkcz1SkFh/qP8GqgjC4rTpashBt04QTAQcDtlwshIfXGTZ7mUzIcwI1
         IGbkjoQmUUznnlFElGFHHL+R0mO0XOsyNpCvX0kcHo4/hr2JtduUw8CzyooRbpldXg8G
         gXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1EQkh492Mu2jcFb695EkgyNX5lh9rVoFrBg9UQoeOA=;
        b=bB22lPPiFqYKGM5Hsp5T53qN+Lxn6EG5/cj4Vao81qGK9nsp9dBn4XhutuDv319gZ9
         fZGBJoFsT3EF1hkynmk45x/OZSC3CiWE5AsFwIR88Ip8HP2vMT9GRvFjCSHt3vyB0jT7
         OBHzeWgQpUYBG0XOBGsSNHcyH7qxdy6uU6xBtf0CpR9KkiOGicfMmNcNa0/PyXO/ewWL
         pKBkNktjqy7f3aDtikEszq6qexYCO3XHoKrUu46Id6+DSGjypWjQa4Eq2vNPNIcrXihA
         QmZX6KY1MgZevbb+w33q0yCMLyY5sV8TFm5RVGRIxYLQajNuCqDsLU8vuPsi4CjAj+uu
         UTag==
X-Gm-Message-State: AOAM532ZLc35ZL5QNyq3VbtGLR8pEmARl8kZSlwBZbWAucO4gEADjI0P
        +aS5AM1lv0p0eBHxpLqv2s0HU8D0X9lFnQjf
X-Google-Smtp-Source: ABdhPJx8teNYuAv/WZxQLY7+jwpZuK1G1oCTxaw1VGWqelfSuG3g8UfppXc/mrFT+J0vhY7wV2DlFQ==
X-Received: by 2002:a5d:490a:: with SMTP id x10mr59400wrq.289.1604024764926;
        Thu, 29 Oct 2020 19:26:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i14sm2757170wml.24.2020.10.29.19.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 19:26:04 -0700 (PDT)
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
Subject: [PATCH 2/3] xfrm/compat: memset(0) 64-bit padding at right place
Date:   Fri, 30 Oct 2020 02:25:59 +0000
Message-Id: <20201030022600.724932-3-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030022600.724932-1-dima@arista.com>
References: <20201030022600.724932-1-dima@arista.com>
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

