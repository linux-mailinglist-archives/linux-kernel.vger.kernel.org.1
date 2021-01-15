Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C951A2F8653
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbhAOUKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbhAOUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:10:01 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF554C061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r4so8623247wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aiJUe/D+M6zdYoqU8/tCGnMlqOxFrCNb2GHwWBgB6XE=;
        b=dSqWxy5oJbUPhoGZ0kJkRd2cNEx5u2GKs2BvohoeKfNCcPJhr2Eu60z6vjzxq/40aN
         glgoqChgxqONYcrADHOUNx2SAbmIdyugzHGjcwAfK+IGJbWjyqOFoCOnNrJsRyuZ73GM
         ajB7yxsGQvusQMPlxvi6EQSO7extZO99Jze3AkqqxSQlrR9cBUH7LFx9BHVjWO4NVWZI
         EiRX3iCscVdNpnfjJCMuIQEvt/MdUGmvt9JbNZuSoBP+A2j09IlgIriYQv58JVaXSLpB
         eWTUAgMgNSZG8vtSDnHBneQoIxOiEZXrirrBiXBWfYRfCWc7r1+5ZlnwZDhU1hIS7a/5
         b5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aiJUe/D+M6zdYoqU8/tCGnMlqOxFrCNb2GHwWBgB6XE=;
        b=ZcQHeGA3ayQzUFlQw4Ef9K1N7vNRCaxhL+yEjaj2tVhlGuoWSQp70jvXNkkgRtVMtF
         QCW4N3ModTvX+djD/abEA+j9YqzZOxD+Lq+9X2ixgvFmcMCjDBZs3gK6vaVQzmvnyNFI
         9XltYj0Eaeh7qDfwzOLvyNpm/cNg1y1j/PLq3qJFPsZ1+asg5AKjRDhdJ1d957KSvo5e
         /DAYN9lg+Wh0BqVaYU8T66gG4crUL0vgwdakEXm4A92QjY+/CcbWVTERloi1tfmYhlsx
         +eEjydgUIaFO3NLiptb24xwcvaFG3s0JieFIAKEAcq4xjJqUGmAp1WehyKzLwGEuuPRE
         E/ZA==
X-Gm-Message-State: AOAM532S8EZMqbeCdFX5KSgMIcC434RflPaNgCYUaM0ikuI+efHbKa4j
        ZvSvT9KtQzW0JZM96c27pldelA==
X-Google-Smtp-Source: ABdhPJz6z8ooRqEJMuEtAZ3z0VQGV3ToTw4T17vOw6fkh1inINUIw2LGxPtLCYYvw9uakPUqYWmMKw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr10484579wmj.148.1610741357695;
        Fri, 15 Jan 2021 12:09:17 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id d85sm9187863wmd.2.2021.01.15.12.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:09:16 -0800 (PST)
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
Date:   Fri, 15 Jan 2021 20:09:00 +0000
Message-Id: <20210115200905.3470941-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115200905.3470941-1-lee.jones@linaro.org>
References: <20210115200905.3470941-1-lee.jones@linaro.org>
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

