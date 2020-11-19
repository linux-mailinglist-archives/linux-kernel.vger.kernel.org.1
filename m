Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360BB2B9188
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgKSLoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgKSLoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:44:32 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B549C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:44:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so6884450wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UYcdiQ2xTJ++YcP+4Hg54iS9Y17F7v8T/q2I1V5Umo=;
        b=iYw6TDYMP4pKhRcCmt1HPm+oLv2jeNc6hliSUsNiMiUw4TSMm/Dpw4IiQ+z+fzhAKB
         KJMcCrP91iYyNgIwDEFXUolVAqns5Zd8hlh/3ygcMDx7tGgnSD9vyeBwqkU2JEljfxkp
         nyDbJA1A3ClHlBPIkvZvLDLzA525jww5XIGbc6HeIy5g+pA4X/V14+Hyjl/ZLJvKkUn2
         BUjJcCIUQROHtHI8P2mN0XOiK1YygFV5a4XzZPa949zPOz2Lg5KfZYNPJ0jwnP4bpBwi
         xCzcoWOUeoq+LvJCtJi88J0tV3j6GqDWJFwdEfv/HKweTToQzKANiKlWHTHvSwW7h0xN
         azOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7UYcdiQ2xTJ++YcP+4Hg54iS9Y17F7v8T/q2I1V5Umo=;
        b=tn08lpMwZORUwEHv9ed+aoWvLphXaKnaPabDnoJuGcnyIv4PwHku7y+EpUL9t/WyvF
         DAkhB3tnn2x9BeHy0DtywhcQ1SBkNFBQIqdHa/FDz6QwvvjhxQ+ChnBb9OfXSlG/SgZK
         YQEqaQJibJK0g+KOx/YaUIWhpJdcW3s2tmr19DlQ/vd2koqc1Zf9kln4Ov6qd51d10t8
         2rR0LxLX6NHOw63CCjEFnnPq004AQklWfLAnTJKQkXaFgQ9ydpaJ8JVqhf/KRtCuDZDn
         9O6X/pHPWKI2x4HFLr50ZCIYKz+Mi6HGgOAS3d0V9AuuarJG2h9d58N4BPzi70toXQjl
         X/Eg==
X-Gm-Message-State: AOAM532yc06Pu6qGL0FVclBSfBoMJhzkVF5RurAM3oSmpxOx7VmEYdEN
        JzKkShFhm+s9CdoRUNU2GoA=
X-Google-Smtp-Source: ABdhPJzRJzHnoYflTdp3QPSJlWuBZLmT8oPtLDjKcLAEOjH7VnTOsAN1dLCo2JbGipVyVAmoRzywAw==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr4023940wma.75.1605786271171;
        Thu, 19 Nov 2020 03:44:31 -0800 (PST)
Received: from localhost.localdomain (59.red-81-32-35.dynamicip.rima-tde.net. [81.32.35.59])
        by smtp.gmail.com with ESMTPSA id k22sm9395570wmi.34.2020.11.19.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:44:30 -0800 (PST)
From:   Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>
Cc:     Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] staging: trivial: hikey9xx: fix be32<->u32 casting warnings
Date:   Thu, 19 Nov 2020 12:40:30 +0100
Message-Id: <20201119114029.183828-1-juant.aldea@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings reported by sparse by adding
missing __force annotations.

drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32
drivers/staging/hikey9xx/hisi-spmi-controller.c:164:24: warning: cast to restricted __be32

drivers/staging/hikey9xx/hisi-spmi-controller.c:239:25: warning: cast from restricted __be32

Rationale for #164:
data is declared as u32, and it read then converted by means of
be32_to_cpu(). Said function expects a __be32 but data is u32, therefore
there's a type missmatch here.

Rationale for #293:
Is the dualof #164. This time data going to be  written so it
needs to be converted from cpu to be32, but writel() expects u32 and the
output of cpu_to_be32 returns a __be32.

Signed-off-by: Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index f831c43f4783..861aedd5de48 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -161,7 +161,7 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 			     SPMI_SLAVE_OFFSET * slave_id +
 			     SPMI_APB_SPMI_RDATA0_BASE_ADDR +
 			     i * SPMI_PER_DATAREG_BYTE);
-		data = be32_to_cpu((__be32)data);
+		data = be32_to_cpu((__be32 __force)data);
 		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
 			memcpy(buf, &data, sizeof(data));
 			buf += sizeof(data);
@@ -236,7 +236,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 			buf += (bc % SPMI_PER_DATAREG_BYTE);
 		}
 
-		writel((u32)cpu_to_be32(data),
+		writel((u32 __force)cpu_to_be32(data),
 		       spmi_controller->base + chnl_ofst +
 		       SPMI_APB_SPMI_WDATA0_BASE_ADDR +
 		       SPMI_PER_DATAREG_BYTE * i);
-- 
2.28.0

