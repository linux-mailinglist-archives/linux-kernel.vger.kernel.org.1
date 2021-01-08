Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD22EFB69
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAHWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbhAHWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:51:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21AC061757;
        Fri,  8 Jan 2021 14:50:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r7so10407439wrc.5;
        Fri, 08 Jan 2021 14:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCP+UiqivE5Sl8wYg29qb2EI1nN4FyBAZjFb96c2xmg=;
        b=bZ/IBuSBUJ/NvDj43ey+PTXQizDEtnkr7Q/fi5VKyTeDZrBQKRxabC2HSD2d/5GBYa
         wvrd/qXjxCNa+tr+1MLmOYhRK/QpfltThjCm5PMHaJhKbu8wYuNbBP+6WvgDlkBGNn8s
         6evuqp8JltCPV0A421RTun/dsy0+R6mpoI8t8dZHZGOO1VMAssXRHXVKMF2ikCMPgQCu
         fBovZ6qgx4KVuAwSk2OIspYz9WYw38Kd1w5fTDs2Ug7Sgbl3LIBZSUWKUaWb30e2CgR9
         uHv0NoxN3F031ioNrJOTLNgKq15Y8Jvdef9gOu+TTq6uAQidVSj7f6nuOK0NRek+ZYJj
         WQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCP+UiqivE5Sl8wYg29qb2EI1nN4FyBAZjFb96c2xmg=;
        b=PFeLMab4x2wVFGDQ5wz09Rtpnz/rrj/vZfzVXP1mWgn/JbsGmDR84hSME25SA3FsRj
         Pqr1sWxYMuTSLycVRL9qz7PzOxuj+EGw1XWgiFWRTiqyQjshhK0jTQ8bK2GCUnWq85c7
         +sQKmZf3qzWIm1pZ6FrkWSjQ34bqQWqnlMmb4rCfivRPo0g0W0ea80byASj+nOcO1lTq
         ayFMt9vRDchshpENUZX4wtaCBU4S3zKl0S7WUan1wZuzRw33HXiJMfs5Z/oIfpdnrfSi
         qlHn0/OdNSHVbDsmWHIVglP7Oc0myDC1iIjRJTzyrlCz3rSN6/5JAQiZCNjyq7oteaIw
         D5GA==
X-Gm-Message-State: AOAM533hxDiX5mmB5nB3h9LiBXQgifwx+9i/dhk1wjDYtK05fNBFmBr7
        hytoDBGHX71y4yPygWel5J0=
X-Google-Smtp-Source: ABdhPJxZxLOuudJaP6+enCfc8zpXg+QIZEb+aQGA1lhlQO5VPvOSypEFu3TOPlh2S8q649MEpqKUQQ==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr5645875wrx.300.1610146251982;
        Fri, 08 Jan 2021 14:50:51 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:51 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 1/6] regulator: pf8x00: add a doc for the module
Date:   Fri,  8 Jan 2021 23:50:01 +0100
Message-Id: <20210108225006.153700-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108225006.153700-1-adrien.grassein@gmail.com>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pf8x00 module build was not documented.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/regulator/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index eafa13be6e3e..ba8c09d90701 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -846,6 +846,10 @@ config REGULATOR_PF8X00
 	  Say y here to support the regulators found on the NXP
 	  PF8100/PF8121A/PF8200 PMIC.
 
+	  Say M here if you want to support for the regulators found
+	  on the NXP PF8100/PF8121A/PF8200 PMIC. The module will be named
+	  "pf8x00-regulator".
+
 config REGULATOR_PFUZE100
 	tristate "Freescale PFUZE100/200/3000/3001 regulator driver"
 	depends on I2C && OF
-- 
2.25.1

