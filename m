Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD72A256A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgKBHkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKBHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:40:24 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C837C061A04
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:40:24 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x13so10342958pfa.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZ7qWtE/JagD4wnKQ1Pjzyg8D2gT0S05CFs3Gnd0M1I=;
        b=hi1XUKTo5mfu6hDc7B9CbqJ1S5iHE0fm5BGunRQMa3lG9icp3Z1sq9R+s69NyjUNqM
         7NGV4ctg8GckjBBigieAWW2sJCYPnldsfSCQqY/UYuL/iev+iedpMwrqpikCA05GfOd8
         ATfY1ldEAekqWqV8uRcE1/iJfzP41XIuxe5SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZ7qWtE/JagD4wnKQ1Pjzyg8D2gT0S05CFs3Gnd0M1I=;
        b=X70XxSvABIEEt3QwQv/QSXSmFY+eBeCMINggg/IYxRlwwi1ARQd0v5UeuzLmzfFtZC
         61S8unhBixXkF3UKES89O2z7OS62mCXJ0tpl6jy1KIwy6N+nNza1/TI5qQANeeaGe2cp
         u07vc9am3ileCOktU4xnTHCPp6zl4erBO2tjdIh2OoWSNSqzWTm8AT83HpqD5QoVNSyu
         a7/3I2MhviNBO4cPCiFt7z+Ju2E6hQi6gMkqByOF3+t1IT4WslCVDAg58LCg9iBdWLMa
         29YC5tWVPIyPJOOmq7QVanZ8IxpcF/BAaxLJ6d+Tub0UEp1EOy2nLsa0IlRHcW6xQ351
         qGBQ==
X-Gm-Message-State: AOAM531hzIUHHshKm3AdOkYjXUqjPPbVkmvYV5Gu2+MF1OCv31wRBs9Q
        g4ATp0GQ1LdunkbocfkYTIFkQA==
X-Google-Smtp-Source: ABdhPJwqXHxJ0TlTc7zOsutpjcl3H9A0kwABgaJlyjOtRmUbEPz0lR96rFtEy+ZMSAM0kUJj3hfnQw==
X-Received: by 2002:a17:90a:f2c5:: with SMTP id gt5mr1001428pjb.66.1604302823903;
        Sun, 01 Nov 2020 23:40:23 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id t20sm13067787pfe.123.2020.11.01.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 23:40:23 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] remoteproc/mtk_scp: surround DT device IDs with CONFIG_OF
Date:   Mon,  2 Nov 2020 16:40:07 +0900
Message-Id: <20201102074007.299222-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that this driver can be compiled with COMPILE_TEST, we have no
guarantee that CONFIG_OF will also be defined. When that happens, a
warning about mtk_scp_of_match being defined but unused will be reported
so make sure this variable is only defined if of_match_ptr() actually
uses it.

Fixes: cbd2dca74926c0e4610c40923cc786b732c9e8ef remoteproc: scp: add COMPILE_TEST dependency
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/remoteproc/mtk_scp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 577cbd5d421e..f74f22d4d1ff 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -772,12 +772,14 @@ static const struct mtk_scp_of_data mt8192_of_data = {
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
 };
 
+#if defined(CONFIG_OF)
 static const struct of_device_id mtk_scp_of_match[] = {
 	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
 	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
+#endif
 
 static struct platform_driver mtk_scp_driver = {
 	.probe = scp_probe,
-- 
2.29.1.341.ge80a0c044ae-goog

