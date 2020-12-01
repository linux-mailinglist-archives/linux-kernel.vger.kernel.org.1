Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081752C93F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbgLAAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388351AbgLAAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:32:08 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6718AC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:31:22 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id o24so21096582ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/bKBturRyIf9vMXnB4V35qfxrB0eSEPoc0/x0nF2eU=;
        b=R88iTfRVb4F7Pq1bsAQjgSL7Jfetnmbut1dZQgSQmn8Wk3qzqs4NVHIsDq3ul55xxY
         deQC7k6sMchjPYAf9ZKrsLgbOILTiNNoE5dl3uaCLcZuGyIXPnfYZc4IAuN4Ex915pJQ
         QiLLylgjJihakVxmX0udSjcclnJfbkvM+LvAayR22ITiBsvUgOjGhOKNUi0/Z4WAdpKB
         lXbRBeOzk7tDn+nlOY7TDuvR0ORhz0mwN5bQ01qVKb8NROkmx9OLuxbNMW2PTIo9PQGV
         kbAN/qZ4y+AKdDqbQSOSK0M0wdCvuGHkgilFf+AJ+fJn0An6OX8pfCCidAuEdfKDu8kw
         es3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/bKBturRyIf9vMXnB4V35qfxrB0eSEPoc0/x0nF2eU=;
        b=rJPeFlyGlor4+EKRMbXGC3KmC/InkzbdDxvvth2NRRrxnWAvjWHMXj1lK6QDyklGr6
         KCnCSNFvgSQQr8LtAA9RB4mVC/byrURT+BSWHbOS05HlMVu2v0e2w7O94qBqtSgemrCn
         WwORgYsivwpw0Xp1pNxnd0hF67T6+aLtdGSzMmmgAcQ9uPw5/9rgcwdmKn+0aKawKI7S
         PhzMJlUx6VHVXrsj+iTthrqanlfshzlmyeO9GWJ2+32r/2gt1yM2Ubdrk7mO1GvERQWS
         k33lw79vBKXD0ghhboBWpzRfkqSxf7eS4gKBNnAayIion+bHhPiuynHr38EISrx49BYu
         HlUA==
X-Gm-Message-State: AOAM532EN3uV3YW2lxUhWWr6SCafE4wKPdPcZJ4nRgf823jmHs/UPe0M
        PZw2cNEasUZkl5DCd/0TJ/IyAw==
X-Google-Smtp-Source: ABdhPJzidyDJ/SYMmPFhPBtHSfz2wcKljDTL5MCm/DZKMEPBh4dSfw4K/awKjb+x64TjviAtHEW/sA==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr91604lji.319.1606782680750;
        Mon, 30 Nov 2020 16:31:20 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id f10sm24868ljf.26.2020.11.30.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:31:20 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     b.zolnierkie@samsung.com, jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers: hwmon: pwm-fan: fix warning unused variable 'ctx'
Date:   Tue,  1 Dec 2020 01:31:18 +0100
Message-Id: <20201201003118.2219422-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building hwmon/pwm-fan the following unused-variable warning shows
up:

/tmp/drivers/hwmon/pwm-fan.c: In function ‘pwm_fan_is_visible’:
/tmp/drivers/hwmon/pwm-fan.c:167:22: warning: unused variable ‘ctx’ [-Wunused-variable]

Remove the unneeded variable declaration 'ctx'.

Fixes: 439ed83acc19 ("hwmon: (pwm-fan) Convert to hwmon_device_register_with_info API")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/hwmon/pwm-fan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 57b574837b58..777439f48c14 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -164,8 +164,6 @@ static umode_t pwm_fan_is_visible(const void *data,
 				  enum hwmon_sensor_types type,
 				  u32 attr, int channel)
 {
-	struct pwm_fan_ctx *ctx = (struct pwm_fan_ctx *)data;
-
 	switch (type) {
 	case hwmon_pwm:
 		return 0644;
-- 
2.29.2

