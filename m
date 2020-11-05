Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB032A8228
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgKEP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:26:44 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36416C0613CF;
        Thu,  5 Nov 2020 07:26:44 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id v144so2828010lfa.13;
        Thu, 05 Nov 2020 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMt8gSgbsxrejAPAMapfgWEKOe+zOFu98hbRBwXnepg=;
        b=NHDmisLweq6u3v/iIQZG5k7LhCDQ/7W72ecQ/BqJtWJ9eVrO7AnLfYG3VuK4IQuxqm
         LLDCs+AZ3q63YC+U7HMF+GKD4KNqyR10F/ESrvtNk2nR4/xk5s/B68RSKuQJQcGoZfR5
         LVxxdkLMeY14rG+G7pIw7tQQhXtOFS1nfw/aFSzLAoLpunqDdRrNlSYaUtQS7wj+pSlg
         7TqVPfjM7shl0cAiLNUMyPxRMEIdES0y+4nIdmSVH1Kdbzcq1O0XFVDgFwrRqox7iKpL
         /q+DyInuJtmzRRz6EoZ4OADrK62axmUpsvgYDxuYFy+rhWbd6nuji55PF1wdu+yHDynR
         qf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cMt8gSgbsxrejAPAMapfgWEKOe+zOFu98hbRBwXnepg=;
        b=qIvHCdzEiRg/f/nCTkISM7v9/C+Z5o9Q0oMiQ7shB8CjKlIRMUJGdGn7jy7EY7Ihpr
         lt507MCcFGGPF5kw8dfiZuHWoaxE4gjiQKzlHteluvaqQKqIi02DlxPyD51runmhWnQn
         oA7YziEsKstzTV2mssRXFFa4q9Lqod/4w6lI0qYlnM7g9cnPCUrLfXImGMcXA2vkN0Qa
         vdcR53Wc/bVbxrgaTQcNiDsQ4LDSj3wuLYHASmgtvkHFNb4qoqJ57OgcKuvsrLKEgW5Y
         wJLEzuO39p0pm4eKNtH7LADdBc9vtZS2aNro0ix9QKGBmQLcwO5b77e4h7qarIdPPUZu
         ljTQ==
X-Gm-Message-State: AOAM5306TF+2uvq9vzNKL2R1lScDv2j0XcNd2TX7/WKPQXRGOacxCi3L
        hobp8c4Z7VMrhN6VrkPqlP8=
X-Google-Smtp-Source: ABdhPJxQh2Ys2Ong785i+Wp1Z41L/kTd2k5MP7nj25Hhuj3uIaMkpySWM1dVJFpY33gy5Hbzr7JESg==
X-Received: by 2002:ac2:5102:: with SMTP id q2mr1303638lfb.391.1604590001331;
        Thu, 05 Nov 2020 07:26:41 -0800 (PST)
Received: from mememe.local (h83-174-248-116.dyn.bashtel.ru. [83.174.248.116])
        by smtp.gmail.com with ESMTPSA id a7sm213151lfl.2.2020.11.05.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:26:40 -0800 (PST)
From:   Iakov 'Jake' Kirilenko <jake.kirilenko@gmail.com>
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iakov 'Jake' Kirilenko <jake.kirilenko@gmail.com>
Subject: [PATCH] thinkpad_acpi: add P1 gen3 second fan support
Date:   Thu,  5 Nov 2020 18:25:56 +0300
Message-Id: <20201105152556.34073-1-jake.kirilenko@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on my P1 gen3, works fine with `thinkfan`. Since thinkpad_acpi fan
control is off by default, it is safe to add 2nd fan control for brave
overclockers

Signed-off-by: Iakov 'Jake' Kirilenko <jake.kirilenko@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e38106750..4d64ba291 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8776,6 +8776,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '2', 'C', TPACPI_FAN_2CTL),	/* P52 / P72 */
 	TPACPI_Q_LNV3('N', '2', 'E', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (1st gen) */
 	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
+	TPACPI_Q_LNV3('N', '2', 'V', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (3nd gen) */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
-- 
2.29.2

