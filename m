Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253882D4D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbgLIWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbgLIWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:04:59 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C73C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 14:04:19 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id i3so2061815pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEqoOzC5zTyGz7eEZ+LrmwqmFTSl6kvuBcvUdQCbqo0=;
        b=jQNJ79+q0aagfLm8zPj4mICYaXK5jiVWKLpNhZh1mXiKBAtVqcz1D2nS57h9UORxmJ
         Zcql58bd0MeY2dv+LdF+iGKYfLZlEa+4a162iLdnb50J+056ft08Ruoz7X8a3ZI6OSI6
         WOCsk5EFTJ0NUK1AvZNsRBDquHd2FBcRNgUv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEqoOzC5zTyGz7eEZ+LrmwqmFTSl6kvuBcvUdQCbqo0=;
        b=ABnAaBaDtv/djKD5bTfM/AhO324iTnBKnzXVMKn7WNfZyu/ucgyBi0/yAvgFo9PBhK
         GldT4HEEj9M1xUlmCuMNc/RNvTE4zjFa+9/GmWxMabnwBSvBjVNkbkB+kZMoOC+cnZAv
         ztGfsyGdt7rYJn0gyrIqWOYTI/1Rz5ZtLxil7Ow/iRt+mNYhoJa894iia7qjVrKWz4ON
         qpw72yqLtInGtJUUcUewmdgES3I6tERgiahsaEs4QT2UcnGNdfhOuHIHzlCINFB/ivNl
         n5lg+pZoMPIlWDghgWnwkZvwYRuHB80RHt717T+Kc9w5e9IlNMDySCcmMF6uUEoh8MQZ
         8ppA==
X-Gm-Message-State: AOAM532t+Ql2ANpUAo9omraNYDsa1Ae/91N+XWOMtGuJkUbQjUONBCy6
        y9Z6NKOSGHz4R1H5RtEJNrL/i4V+L22ZIA==
X-Google-Smtp-Source: ABdhPJyAomJQLIRq8pSoRv71G+jqhMOQxUlkuucdThFnjFbZGQ3Kr6QjzaqhBLeEGRljLT72ehVYSA==
X-Received: by 2002:a17:90a:9502:: with SMTP id t2mr1922742pjo.3.1607551458486;
        Wed, 09 Dec 2020 14:04:18 -0800 (PST)
Received: from linux.australia-southeast1-a.c.zinc-computer-272222.internal. (181.178.197.35.bc.googleusercontent.com. [35.197.178.181])
        by smtp.gmail.com with ESMTPSA id u25sm3361123pfn.170.2020.12.09.14.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:04:17 -0800 (PST)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     briannorris@chromium.org, Evan Benn <evanbenn@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: Use EC_HOST_EVENT_MASK not BIT
Date:   Wed,  9 Dec 2020 22:03:54 +0000
Message-Id: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The host_event_code enum is 1-based, use EC_HOST_EVENT_MASK not BIT to
generate the intended mask. This patch changes the behaviour of the
mask, a following patch will restore the intended behaviour:
'Add LID and BATTERY to default mask'

Fixes: c214e564acb2ad9463293ab9c109bfdae91fbeaf
Signed-off-by: Evan Benn <evanbenn@chromium.org>
---

 drivers/platform/chrome/cros_ec_proto.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 0ecee8b8773d..4e442175612d 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -526,11 +526,11 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 		 * power), not wake up.
 		 */
 		ec_dev->host_event_wake_mask = U32_MAX &
-			~(BIT(EC_HOST_EVENT_AC_DISCONNECTED) |
-			  BIT(EC_HOST_EVENT_BATTERY_LOW) |
-			  BIT(EC_HOST_EVENT_BATTERY_CRITICAL) |
-			  BIT(EC_HOST_EVENT_PD_MCU) |
-			  BIT(EC_HOST_EVENT_BATTERY_STATUS));
+			~(EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_LOW) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_CRITICAL) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU) |
+			  EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_STATUS));
 		/*
 		 * Old ECs may not support this command. Complain about all
 		 * other errors.
-- 
2.20.1

