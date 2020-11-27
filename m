Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5892C6309
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgK0KZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgK0KZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2EC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so4999425wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGtVve4ECktdJJ4Hs060Y8wRF6wOE98zlISK3O9yfv4=;
        b=DMWdgDoN/ZBEUcYGhUOci25uNASQTzV3kGC0REr7qkmtUY/gBR9gJljFIUFJ8OPNQE
         R3KXqVc1nHhAfUysHfk4Z8Cc6RE33rW15rWWSMIrKVRApGYa9J44gmpP9gl2tx0Z0zct
         OH7vgHKOtHXa0uJuKBWZ0eZJBlvdh8wDmCjUwW1jIIWdS53E8s7N+9bm2QtQHS5F8hMc
         UIfO9VEggd5e7ipb+rVJi50CL4Z1uPQbryTDGpzF7peMdKrekgrmf4xCYTKR33vo+Sqe
         Z1OJGN7LYTQgcGI7AWTgDNTt7b0FLeAF63Cq1htXk2LfaLgX6sgF4dfq3kiiQAW/+L1g
         Q5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGtVve4ECktdJJ4Hs060Y8wRF6wOE98zlISK3O9yfv4=;
        b=W1x3PuaRZFpiladUmhMS1RgYGqjFembO5flznVF+0yDW8E3n86KOmH0dKr5rWiqg1N
         +7CHfaaMMlScmwBeV3eDxG1/LGUeD1CwQdUscMQZrSj/FfY4+GAdwikHtoAlUYY0ETUl
         y/3IWv+KCp2ZH0Ewa+VQNb+FCw8MvT+YVRDXGUMGXBqxpwTdSBSHs3MiUEsf5aQrue/H
         FTnqmuuB8d6BUeSiAVFX/B6iqZN9QQyA+5nQERmfgBDgwikUjh8zfJ1vRWMnDhythrWE
         MMUGbwULOPlFSOpCMygf7sFAxM5ZaKwKbN8OsSxZ3TxTRo7S2zIXv5FmiREgU5dEc7TC
         2ygQ==
X-Gm-Message-State: AOAM533NoAn5Q4bvYTFIw772UmHOqLwCvqbsGr04mfnHH3v0SWMzFh1W
        sG6Y3UytN5EYIltxcsXxXexVIg==
X-Google-Smtp-Source: ABdhPJzCrdF4iy9rUT1S7o1T66eWdVPq0X/GDbNC9j5f+pEK47fcPO5HxBmFFF5zJn8YUJJSW5PaIg==
X-Received: by 2002:adf:bb05:: with SMTP id r5mr9568322wrg.295.1606472713991;
        Fri, 27 Nov 2020 02:25:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:13 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/7] slimbus: messaging: Fix fall-through warnings for Clang
Date:   Fri, 27 Nov 2020 10:24:48 +0000
Message-Id: <20201127102451.17114-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
References: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index d5879142dbef..f2b5d347d227 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -258,6 +258,7 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
 	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
 	case SLIM_MSG_MC_CLEAR_INFORMATION:
 		txn->rl += msg->num_bytes;
+		break;
 	default:
 		break;
 	}
-- 
2.21.0

