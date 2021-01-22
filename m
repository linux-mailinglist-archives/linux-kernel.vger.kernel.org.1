Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B3300FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 23:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbhAVWLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbhAVWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 17:07:35 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9156AC061351
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u67so4735824pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 14:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GT4sWub4TdhpfloHMdwlVx7/p8zvFXxcNYxZN4MYQMc=;
        b=InwHRgJC7CcuDMn9l5FeVk1Wz2iTF8JwXhH/noGGnfwF0l6LlVeKbe03XS3JrZMtjP
         5/LNVno8791KwxJFhpBWqgQCMNNd3VrnSHa5vwnFWm2JIOnjFa+oiyV3cWkRRcY6LdV6
         Vpkz73XrYP1QndzgINE4WpuF70i1vLMO1iLO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GT4sWub4TdhpfloHMdwlVx7/p8zvFXxcNYxZN4MYQMc=;
        b=WjzoX4wxfHbdhYaflYhwHmSeKrZYpNYUkOYRQpK/aqNyH0U3UutTDEc5i/8vLRJi1T
         322lcIVZdeBGfkYV5gCnJi20HdH3mpyXKeqLm8ebh3b0VPS5/m9/WjGdzQaT2DnCvp6u
         oU0BoxdG2p+MvJfh+wvrFC+nJiyuyxpjDrOMOh8BBOL9BJeR5KSoXwX8WUkiszi1JFNs
         IxYoRdGQjM9+NKbawW2kXieL8ncis01RJxoc3FvgD6poB2OrI7SJnKm0mtMtXmf+1ixQ
         LEybdKPkA7Fn5EQSzqWLQAWDzdVi3KICvF6zIH2S9HOI1fT63jSQZoJZeOWr72aV3Vd/
         tBQw==
X-Gm-Message-State: AOAM532lN2YLXk0zCQXYRPgCyNKAOVbuTcAmVGU1MgNXBY/jq0Abxbth
        VmVkkCsyeJ9J1LO9X3ZKqO1xyR9Qhj6HOb0Q
X-Google-Smtp-Source: ABdhPJxKctDHtcIG9yzztz1+mm/nthv0dsPMor8ceZTSACCGxbRFYcpZT+5itdN1AaH3IS3Bc+Rk1g==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr6586798pgg.196.1611353200239;
        Fri, 22 Jan 2021 14:06:40 -0800 (PST)
Received: from pc98bx3.roam.corp.google.com (c-73-222-23-249.hsd1.ca.comcast.net. [73.222.23.249])
        by smtp.gmail.com with ESMTPSA id h12sm9863300pgk.70.2021.01.22.14.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 14:06:39 -0800 (PST)
From:   Daisuke Nojiri <dnojiri@chromium.org>
Cc:     vpalatin@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alex Levin <levinale@google.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ching-Kang Yen <chingkang@chromium.org>,
        Vijay Hiremath <vijay.p.hiremath@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] mfd: cros_ec: Add peripheral device charger
Date:   Fri, 22 Jan 2021 13:59:00 -0800
Message-Id: <20210122215900.1168610-2-dnojiri@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122215900.1168610-1-dnojiri@chromium.org>
References: <20210122215900.1168610-1-dnojiri@chromium.org>
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

