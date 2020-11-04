Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084FC2A6B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbgKDQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgKDQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:54:22 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E58C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:54:22 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id p7so22910450ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ete0w7OwwAo9K9sCTazD4Lhb1CP7WOqpnU3tycCjBtY=;
        b=GCPEuo5u+97PfR/DbX86exqPaGJEL+crR2Nzpa8u2MF3uidQFjdgaAy4cacFeybS+S
         RvwTMIw0g3oWlGkyFEoUV+zCtjBQF19Cp1BInzUVrSI1v8XFD4Fl6BvgcPbuOUc+9yac
         oa+epHU9zY8PvYj/qzt0UiqQSLSQBxgDiKPiUfTNZHSD/Jxs1BenFYR4mWusXJveXm/k
         mEtLB29qsZ+waPCpw3y/0Vju0VNfy6Xu+nzwyBEnYmCzL6/N0etLNGmQBPSLNgY/pewD
         B2Y/DXW87vJNpFwBtRHyet48/5z15aMNOdL5dgVCr4gRVipvf38JQep2ZijRrLmPiIiH
         pzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ete0w7OwwAo9K9sCTazD4Lhb1CP7WOqpnU3tycCjBtY=;
        b=hA8lft617nkaZU6/bTzOiwgmmm+opctxK7O663XRHeYPCSzfaXbGPu000mXRN7iRbg
         0dXLeokSOLp+13Wltjx8819grsAnU0ln4yBhsLWm3ix3P7/1Eu+ylrmS8oF+vEyFLTdi
         dBkzjZNLDXtBoWX5kxKI4s7QXXvTHgy+SAKpmMaMFertTwUpdaMHpRiefS35W5Hztgwm
         5AKM0R/MnlzOwn9oSvlPEt7LeuxxMJLqT/UNwiN6sYs019JIAVbYSxhcRqdMv3yRyXmJ
         2VTrOMVu31CU6VSFR/FJV/O0LRk9wP4Eem6yr4ftpPtTTM/zmumGo1y03kxc314WwyVP
         bWWg==
X-Gm-Message-State: AOAM530G55e30V5YO8nZGg/dXXWNNGV8HoTG71KZuuRU8kSHilzWirv2
        e0mOwNnumZMiuLQwzAXUCW8=
X-Google-Smtp-Source: ABdhPJxmHkmXRTX8n7NwHrbzzoypU5LthXvTzoj5Z1yCaSalvhQd1pLJOz/MCw+nrAlLGqzMPInhWg==
X-Received: by 2002:a02:95ea:: with SMTP id b97mr20883178jai.16.1604508862065;
        Wed, 04 Nov 2020 08:54:22 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.246])
        by smtp.gmail.com with ESMTPSA id b191sm1332877iof.29.2020.11.04.08.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:54:21 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: imx: mach-imx6q: correctly identify i.MX6QP SoCs
Date:   Wed,  4 Nov 2020 11:54:18 -0500
Message-Id: <20201104165418.4903-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX6QP rev 1.1 SoC on my board is mis-identified by Linux:
the log (incorrectly) shows "i.MX6Q rev 2.1".

Correct this by assuming that every SoC that identifies as
i.MX6Q with rev >= 2.0 is really an i.MX6QP.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.10-rc2

To: Shawn Guo <shawnguo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

 arch/arm/mach-imx/mach-imx6q.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 85c084a716ab..703998ebb52e 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -245,8 +245,13 @@ static void __init imx6q_axi_init(void)
 
 static void __init imx6q_init_machine(void)
 {
-	if (cpu_is_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_2_0)
-		imx_print_silicon_rev("i.MX6QP", IMX_CHIP_REVISION_1_0);
+	if (cpu_is_imx6q() && imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0)
+		/*
+		 * SoCs that identify as i.MX6Q >= rev 2.0 are really i.MX6QP.
+		 * Quirk: i.MX6QP revision = i.MX6Q revision - (1, 0),
+		 * e.g. i.MX6QP rev 1.1 identifies as i.MX6Q rev 2.1.
+		 */
+		imx_print_silicon_rev("i.MX6QP", imx_get_soc_revision() - 0x10);
 	else
 		imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 				imx_get_soc_revision());
-- 
2.17.1

