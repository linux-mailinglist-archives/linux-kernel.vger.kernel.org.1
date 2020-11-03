Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C213E2A380C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKCAwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCAwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:52:03 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41CC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:52:03 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a7so19887949lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQ7vZjbo6jZFwN1qYAVZdyUDHRcRSscJAXv+iG5HiXM=;
        b=gl8l5tT55fC8nLaYKD0ZSaBlsWjMWFVk4K3Xb0aHZhFGYrRFSleDasHkl2iGT2SmMK
         CBTJCPm2tTifW3/Rznj2HdrFiTf/scdLrXmfaS+AtUJdyEa4nfXazx84qLhJi/aZ6XcW
         A+tKbYt05Qzc6SoaolWsCR+Mx6Ood6YuyuOfog7pPq9Di9dXWTHs6Z4kIN1e7gE/47eJ
         gO0AheXxDZATTDIxwsfTIo+44E11IrHxXH/OHjE+bhKYHDT9rAcpe0rWFagBXFpHcTUP
         hOiMjDn/2u0EqBdxeQZEzxZtC3fVrXd/wFmYfN4MJJ7XkC7AsUjctG1EV/Tm8SQGz0op
         jtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQ7vZjbo6jZFwN1qYAVZdyUDHRcRSscJAXv+iG5HiXM=;
        b=PA+8vdbIoXLLpnUNas5kxyYQX3ewPQfpficuwKFordJ4I2niSTrhZHw9URGjg52oap
         XRQGJhh6rW85TPaTHz+DCOdOjgFCBGbdyuBu3GvGpJiAWXWpAgU2W/MLR2RcJYxnRI+B
         FAbFlRlxvn0Gs9R4le0UAxU57qkfPT4Ww87vEe3PkCKIcyQ7WUoMr986JVzGvYwQR3lt
         PeHFQ0wg5W2v33FT43+msrW4aJM51vDBSPpRDug4XC7+Gz/14yEL2B/HLnO2wyPQzsDN
         pFBcE207o8IkywLKGDzBkqJWrZKzh/0/5m5ylGqp/di7sULr5WnJhFiPkSzfmaeSETlI
         CIRA==
X-Gm-Message-State: AOAM530uwgPkB5PLzBoL0CLDs+AkeKnAfU80D7Q5RA9D1PFF7RnUjSmA
        czhUHVkJgDnqiFCdVaj/YdJvvR7ovPyS2g4J
X-Google-Smtp-Source: ABdhPJyn/feu0C2r41t7lbFI1xBKCNQqkD3hDG6ze8hPxgm6zV3Qh8S0rWqo7XMVTAh/mjxPCPS6VQ==
X-Received: by 2002:a19:14f:: with SMTP id 76mr3875517lfb.550.1604364721468;
        Mon, 02 Nov 2020 16:52:01 -0800 (PST)
Received: from eriador.lan ([94.25.229.254])
        by smtp.gmail.com with ESMTPSA id 22sm2957319lfe.113.2020.11.02.16.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 16:52:00 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] mailmap: fix entry for Dmitry Baryshkov/Eremin-Solenikov
Date:   Tue,  3 Nov 2020 03:51:58 +0300
Message-Id: <20201103005158.1181426-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Change back surname to new (old) one. Dmitry Baryshkov -> Dmitry
Eremin-Solenikov -> Dmitry Baryshkov. Map several odd entries to main
identity.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 .mailmap | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a780211468e4..3bcfa33fc268 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,7 +81,10 @@ Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@mips.com>
 <dev.kurt@vandijck-laurijssen.be> <kurt.van.dijck@eia.be>
-Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
+Dmitry Baryshkov <dbaryshkov@gmail.com>
+Dmitry Baryshkov <dbaryshkov@gmail.com> <[dbaryshkov@gmail.com]>
+Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_baryshkov@mentor.com>
+Dmitry Baryshkov <dbaryshkov@gmail.com> <dmitry_eremin@mentor.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dima@arista.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <d.safonov@partner.samsung.com>
 Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
-- 
2.28.0

