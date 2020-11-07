Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344002AA84F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 23:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgKGWtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 17:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGWtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 17:49:33 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED591C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 14:49:32 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so4949118wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 14:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Z6M7mlid8X1YnF+DHbpm6fmI55KTptuGsUGWswoIgA=;
        b=LGdrMJoJvLwCehIzLeZjfy29pIKCUUE/x/H9M0drcmRCDktbwyD/bSF7nPKn7Ona6c
         GUEm/CytF00+Tl71+IiPBTEhWNvEgxRAkA2tqpI2cXGJ/v+FKGwxC6BdchfwSwZVnb3L
         ub72CwBmD8pngc/E4KfYtDf0alJWxvUUetlfJ8p2a9iBSfYd4DlFgEU2sE2EeB5/l19A
         R3td08ud91NaaKZ0oOfcMw+P+L/p47RYmLrrHYrrDd+q1PhclNZOQEwjuMCivUIRQnR2
         KCs6Z2ZPqZAbONWEosEQWCARBocueI9PYg1r4i47fzComqCp31fjYWwOC59aXAHz8sWZ
         mZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Z6M7mlid8X1YnF+DHbpm6fmI55KTptuGsUGWswoIgA=;
        b=EeVbheM6pUQRxIN7FNAJaVKlbvHA1Un0nNddCICnUXXRNlkDMmKQk2PiWFYHLYKlW7
         eJh4tQ15Tukb8a5XiwnGrzC9y8Z4vE8Td5bUWECSJCa+3Nc3ChpaLYmCU5BIE++O1uqz
         k8494GUC/NaCQ5Mm8VoHc7/RO4AU6A53Ch1NBNXxsd5t23j5ps+Qo1YpEUJydKdjxTwe
         GSM6q8+9hsmw27Eoewc3+R0A1O03XOlnHmkJ6AB5qS8gU8RM3HWWisBe3RCFc8n1jzHF
         odLAgLIlIkJ+SFvECam9wPo7xPN6eKm/MZYu/yPs7RKVibbLpwUsosjn34wtO+YaAcw8
         Xk5Q==
X-Gm-Message-State: AOAM533sF6i7HPabdA2FJIpT9PdRBJPwKSMRxRY2fVPs7AngjnLuJuEt
        CSQQAq+2brVlIkIrfYAw62Ga34iENGEqkw==
X-Google-Smtp-Source: ABdhPJy1DQw/cWQFmKV2wf+BDIgO2KUEsDM6c5blPKa5goFv4dCjYjNWtE42f92Ra4hR00p5qOv2og==
X-Received: by 2002:adf:8382:: with SMTP id 2mr9882140wre.227.1604789371578;
        Sat, 07 Nov 2020 14:49:31 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id e3sm8001875wrn.32.2020.11.07.14.49.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 14:49:30 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH RESEND] driver core: export device_is_bound() to fix build failure
Date:   Sat,  7 Nov 2020 22:47:27 +0000
Message-Id: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
is unable to find device_is_bound(). The error being:
ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
	undefined!

Export the symbol so that the module finds it.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

resending with the Fixes: tag.

 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..a796a57e5efb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
 {
 	return dev->p && klist_node_attached(&dev->p->knode_driver);
 }
+EXPORT_SYMBOL(device_is_bound);
 
 static void driver_bound(struct device *dev)
 {
-- 
2.11.0

