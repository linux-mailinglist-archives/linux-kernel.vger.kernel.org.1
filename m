Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E036301682
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbhAWPzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 10:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbhAWPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 10:55:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B93C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:54:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q2so2229389plk.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2mtBkjZESyT156xGNaV1KXAli7x013uyZv3rN8+Ze4w=;
        b=Fso86ViIKuG9+aMPCyTdgUMi0x0Tn4c3u2gsswgGr/yI0EE1Oa08yWXmB/iFuj9tXv
         iMWeZ7jnhUZacBavDCM6IcFVzBg3QAQmH2Kr8El6QtEj2/bTqw+Tlzds4ktExqH4Vhpp
         9IDxEwdYYG3sXtfZkerI8ndYeEQLcj4vJSLzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2mtBkjZESyT156xGNaV1KXAli7x013uyZv3rN8+Ze4w=;
        b=Y/srRz0HsLgWyxvF1B05j5I45WhtgA4GBqjrTb6EWdAL+YjL4FGkzsD9Unp++iYeGP
         6rNEC5UKernTEFY3KJ2PmJbUPCWwuTlCraiBRqURn8h6nnsDIASUfcSQdQRD1yHIUsmc
         Pbqy3zYL5/kPUpg5aDq8gzPfEukH04Fjuh8feutT+inJECNyMI9vUPQc9EmLx75oqYRn
         g0FVYxf985GVEx0VSvQcCPAVi7MJ6NkftTPBjfxXJbG2xSBc67gidZ3cqUd2ybpFvXhQ
         Y3DgnmjCuCDvGgusuNgRXmT97Mqb7+3SwLZV4v3UyC/TJa6bKmfNU57u+xKGK/F56QVQ
         YBGQ==
X-Gm-Message-State: AOAM5332JknNEqYzQLO54dvuVdpALzqJDUnjom7vC2G95zhvbNcm+9lR
        sCu9D+NlCGQbLJJ8RBXUp6f9kw==
X-Google-Smtp-Source: ABdhPJwmI2I9B1jyTomjzxc4lAeypyXKU8eIVtsPO+NudME1+Z+012FpRzgC57IXf1VyooJ4syXJuA==
X-Received: by 2002:a17:902:467:b029:da:9ac2:24ee with SMTP id 94-20020a1709020467b02900da9ac224eemr1275828ple.22.1611417272423;
        Sat, 23 Jan 2021 07:54:32 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id c5sm12210407pgt.73.2021.01.23.07.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 07:54:31 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Alex Levin <levinale@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Sat, 23 Jan 2021 07:49:22 -0800
Message-Id: <20210123154922.1309290-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123154922.1309290-1-dnojiri@chromium.org>
References: <20210123154922.1309290-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a cell entry for PCHG (Peripheral CHarGer). PCHG is a
framework managing power supplies for peripheral devices.

Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v1->v2
* None
v2->v3
* None
v3->v4
* None
---
 drivers/mfd/cros_ec_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 6135321592b76c..f3bc1cb6891ba5 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -116,6 +116,7 @@ static const struct mfd_cell cros_ec_platform_cells[] = {
 	{ .name = "cros-ec-pd-sysfs" },
 	{ .name = "cros-ec-sysfs", },
 	{ .name = "cros-ec-pd-update", },
+	{ .name = "cros-ec-pchg", },
 };
 
 static const struct mfd_cell cros_ec_vbc_cells[] = {
-- 
2.30.0.280.ga3ce27912f-goog

