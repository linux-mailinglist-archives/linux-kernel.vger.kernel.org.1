Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF32F5037
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbhAMQmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbhAMQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:42:49 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E39AC0617A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:41:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r4so2186538wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiJUe/D+M6zdYoqU8/tCGnMlqOxFrCNb2GHwWBgB6XE=;
        b=I2+vBPUo2gCDgiYWasmO1sHtcTTH3xkuV7X1/PG1lVWzqDGzxS+DPTM7vtbs/a3vlF
         AjP4BoPGp2d7XG4o/5xlRDfGl2c4kbqcbY66emR7gtkYV/xFH+50jXYNtemN3ebZfjcq
         C9LGwyAVyxeTnqbX9lnb9cJjm4RAFRmDQF76tFG+luN9mMjhywtY2R4FmhpXQzgTXNoO
         rrPcPeUqUM0jRe0vKlhamn5MjnNtd5wkhyaAtm29D3+T8MDPbUpOk5iY17WAaEEiApX8
         P5iDLC4rQF1wYGOR6WegCf3/XUW87F5Ufdli3BgjXMUMpuKARuTpwoc/H1uxOexECHeG
         xXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiJUe/D+M6zdYoqU8/tCGnMlqOxFrCNb2GHwWBgB6XE=;
        b=T9mZO+h7jfp1jIidHI2hp2cOFVRWs/C8BwW728v7TADIiEvqCVHqz53FBQWKZ2TFmM
         23RnROABAmtsGaGtltVJhNTgvMh86CUecgPAsdSgSBJZ9azLMXVNzViLb1o5PwCC0MFq
         zeyIgX4y2qTsB6SjUiunzATGtsM87jOdIrJWKl7zXNTYA9IbkOMvQQ10IRQLkA87fZW9
         sOyF/J2aBFp9Y9x8gkV5V4Q/42bwGGrGjiEhpip8ciLPkCDOFL5wIipKeI8waGWQgbeI
         OyEi426YbULR7yF923W13E5g5jZe3mmih6EJNpnUXHQpUfBgXexg39m8fS9yr5c6/7i9
         cOew==
X-Gm-Message-State: AOAM531pfiS71nI6eNMurTU5Eq0fYdNKpq4fL3j7gyvw5XDas/To+cUZ
        U+iUPGZBOzLwjs5RQoK04ZhvCQ==
X-Google-Smtp-Source: ABdhPJzZKsF+KFl6JetQF9891E8WXoNT3YtrK5nhBf3OfzOmajMtez683HLPz3xwrwa6JkZW4uFwjw==
X-Received: by 2002:a7b:cc87:: with SMTP id p7mr135849wma.112.1610556090778;
        Wed, 13 Jan 2021 08:41:30 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t16sm3836510wmi.3.2021.01.13.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:41:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/7] net: xen-netback: xenbus: Demote nonconformant kernel-doc headers
Date:   Wed, 13 Jan 2021 16:41:18 +0000
Message-Id: <20210113164123.1334116-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113164123.1334116-1-lee.jones@linaro.org>
References: <20210113164123.1334116-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/xen-netback/xenbus.c:419: warning: Function parameter or member 'dev' not described in 'frontend_changed'
 drivers/net/xen-netback/xenbus.c:419: warning: Function parameter or member 'frontend_state' not described in 'frontend_changed'
 drivers/net/xen-netback/xenbus.c:1001: warning: Function parameter or member 'dev' not described in 'netback_probe'
 drivers/net/xen-netback/xenbus.c:1001: warning: Function parameter or member 'id' not described in 'netback_probe'

Cc: Wei Liu <wei.liu@kernel.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: xen-devel@lists.xenproject.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/xen-netback/xenbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 6f10e0998f1ce..a5439c130130f 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -411,7 +411,7 @@ static void read_xenbus_frontend_xdp(struct backend_info *be,
 	vif->xdp_headroom = headroom;
 }
 
-/**
+/*
  * Callback received when the frontend's state changes.
  */
 static void frontend_changed(struct xenbus_device *dev,
@@ -996,7 +996,7 @@ static int netback_remove(struct xenbus_device *dev)
 	return 0;
 }
 
-/**
+/*
  * Entry point to this code when a new device is created.  Allocate the basic
  * structures and switch to InitWait.
  */
-- 
2.25.1

