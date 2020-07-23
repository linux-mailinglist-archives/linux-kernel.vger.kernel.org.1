Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C2D22AF4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgGWM1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgGWMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:24:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3F3C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:24:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so4961419wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80v1DBRW/qsu59LvyeMIeuQFI8l1Hk1nu3w4AijohsI=;
        b=xaBW4zXUzVy6HWSnFb8niReGfzTgkh/3kLRCus5uoYeWHhRGske4Gp63MyS/UpkOHr
         psb63W7tbz5Y4zOZD89k51FPGLkAaRW563Uayx4efO7OrzyZf/0G5CAL/LdlOpGNvUiI
         c7K6A6r3Nu+hwe7BJCJ21MZvB1Bcu7KJNPQzZqTHinItMf6ooHtSuANOGHy99tSDOlBA
         CwAVQJ5DJ9eNb4lyARBB3mNT2C+ZiTIJXgd0vxfit4c7uzWNEejenJAzHvRSr1sC77rh
         kDF8VKXBJ/LbcIn3jDun8mS2RKYuk2C7xGAB7f7byAhsRtYuX9ok27Oj+H3v47XO4lcS
         Dogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80v1DBRW/qsu59LvyeMIeuQFI8l1Hk1nu3w4AijohsI=;
        b=sZxFczVVIWCnEm1qbA9dIPsH+UcXrWKOHz/9moMxonahdaMNB+6CRlATQ/YQ0nOVXt
         DttL2yVTTMlIgeoahZiB9pWMWwteLPqgaKgVWhVAXYjivxWA76ux6k/MxBb0FDLf4bzH
         tBJgQqDHlFINc92I9yxH35lKLHAWIGoTNwcMjcAB2KSdnBpHzHCmGnsOfXqTgFfcQ2Mr
         6MfSltbbfxyPH9JVxwuiXPNmlh8mkJCMULwAW8wodv3s1sa95waMOcltRGZEvHcOgmpC
         NbaQVniaqW+68RlQc8isw45xjs1r5o3rhMXLGM7oYeC/ZWfJu9z/OK1lU3IyZHYWa/ga
         7OXg==
X-Gm-Message-State: AOAM532yqN8l3Ikg47CvWoNZI3txACkhGlD3SV0BB72SzIA9uRoG+29+
        7vJzVMam8uTsNYct60fl6cVfvw==
X-Google-Smtp-Source: ABdhPJzKG1wmpdPfaLhJeYXeq9QB31CvRZqPSXRE5D6MdiQRM6Z5f3c5+XeahU4Q+ztWHyM9SxlqWA==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr3735247wrn.51.1595507098335;
        Thu, 23 Jul 2020 05:24:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:24:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Subject: [PATCH 07/40] scsi: bfa: bfa_port: Staticify local functions
Date:   Thu, 23 Jul 2020 13:24:13 +0100
Message-Id: <20200723122446.1329773-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These calls are not invoked externally.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/bfa/bfa_port.c:760:1: warning: no previous prototype for ‘bfa_cee_isr’ [-Wmissing-prototypes]
 760 | bfa_cee_isr(void *cbarg, struct bfi_mbmsg_s *m)
 | ^~~~~~~~~~~
 drivers/scsi/bfa/bfa_port.c:796:1: warning: no previous prototype for ‘bfa_cee_notify’ [-Wmissing-prototypes]
 796 | bfa_cee_notify(void *arg, enum bfa_ioc_event_e event)
 | ^~~~~~~~~~~~~~

Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>
Cc: Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/bfa/bfa_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_port.c b/drivers/scsi/bfa/bfa_port.c
index 4511ec865f06a..cfe2c9c336bfd 100644
--- a/drivers/scsi/bfa/bfa_port.c
+++ b/drivers/scsi/bfa/bfa_port.c
@@ -756,7 +756,7 @@ bfa_cee_reset_stats(struct bfa_cee_s *cee,
  * @return void
  */
 
-void
+static void
 bfa_cee_isr(void *cbarg, struct bfi_mbmsg_s *m)
 {
 	union bfi_cee_i2h_msg_u *msg;
@@ -792,7 +792,7 @@ bfa_cee_isr(void *cbarg, struct bfi_mbmsg_s *m)
  * @return void
  */
 
-void
+static void
 bfa_cee_notify(void *arg, enum bfa_ioc_event_e event)
 {
 	struct bfa_cee_s *cee = (struct bfa_cee_s *) arg;
-- 
2.25.1

