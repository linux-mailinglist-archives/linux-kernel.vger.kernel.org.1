Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331E82A1F26
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 16:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgKAPg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 10:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbgKAPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 10:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604245014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=hwjkYy0oMIlzhgFEst/3xJBrxsRxNCTNm6w0ht7u03Q=;
        b=BxtOel+WpVE7OEAUURXMmvOZ79ir6QXSGcYgFmmuFjtvW1sjE/FC14qlNOCUETeBUlR1vr
        RtPyt9o33sO5KtKR8rtRQ89dLEGm2w+BPBs1LzYlba2k75/I9A7nbUYkrkAX0iy4sY3xa3
        OkacdI9Bq54XeJbf3kMTCI1Tt0MA1qY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-l-JDoUIlNKiGGIkrT8z9NA-1; Sun, 01 Nov 2020 10:36:53 -0500
X-MC-Unique: l-JDoUIlNKiGGIkrT8z9NA-1
Received: by mail-oo1-f72.google.com with SMTP id t19so4590157ook.18
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 07:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hwjkYy0oMIlzhgFEst/3xJBrxsRxNCTNm6w0ht7u03Q=;
        b=U8C8qc3yT3ypLtznP/Ht4/6tArn+CQxif7R3VStdllVST2SO4aaXRhy+EMiUBgKHwK
         3NCcQMNJu8l1leh6i5o96MC1Gs93V7qKdfAQm/k5wTuOewa9u7cUMuQi3jMLTyaUATGs
         h16XpT5R1gT2VBPLqy55wp9XEDYWjyEAJhAeMPIU3hDreNs+oQ+JUqctAIvu8V3fNn4V
         fxbAVxgKkrDQ758JS0kN9Sh96HYpCLREAVEw3W2qYtUT0HqynzjaT5Nbo1GyunP04bvF
         YV+XpzOcvGapD/LhjmNdkxB7Yk2Le8qykjzyINiXpf6LIjYb3nEDD62UvEgTYgTCXm9a
         LyyQ==
X-Gm-Message-State: AOAM532YMJ5+HU0dxBu0dnaIBaZmMx7nt/b30/sOCDWv70FDKARy284q
        /0ClC7y29kNJiDeBiCGTxYCBEmbECIqVpJEFBx9+9MpsamTtwF3nnPFQibXacfxUSxiSKJ2vSyB
        mvpnV2BW0Bc+ZAlv/5gxHeE3H
X-Received: by 2002:a4a:b40a:: with SMTP id y10mr8958306oon.71.1604245012757;
        Sun, 01 Nov 2020 07:36:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDmgVMwQdGVfOkJr+SFXDfJRq7GUTFZALzFI65I0ihDwrRqBXQudZ/NYikp8OBelhe3WAlSw==
X-Received: by 2002:a4a:b40a:: with SMTP id y10mr8958295oon.71.1604245012597;
        Sun, 01 Nov 2020 07:36:52 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w25sm2902114otq.58.2020.11.01.07.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:36:52 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        andriin@fb.com, edumazet@google.com, ap420073@gmail.com,
        xiyou.wangcong@gmail.com, jiri@mellanox.com, maximmi@mellanox.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: core: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 07:36:47 -0800
Message-Id: <20201101153647.2292322-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 751e5264fd49..10f5d0c3d0d7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8898,7 +8898,7 @@ static bpf_op_t dev_xdp_bpf_op(struct net_device *dev, enum bpf_xdp_mode mode)
 		return dev->netdev_ops->ndo_bpf;
 	default:
 		return NULL;
-	};
+	}
 }
 
 static struct bpf_xdp_link *dev_xdp_link(struct net_device *dev,
-- 
2.18.1

