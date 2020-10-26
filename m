Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A645298EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781121AbgJZOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:18:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780574AbgJZOSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:18:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id d3so12664943wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/9DP21Y/K7Z/VraeZB1byIXgPmUm3+JNNTaYKuJoag=;
        b=vxGqXy7wNCIUh9+OjOZz0S3AQIqHl536ZddiRstfn5wGdIygsNWwpFCy/DoUZ2hlvN
         vliRvdnj/+eHLFnmAZHHAI5NS2qIyzV+rpBhHhPLUFEcX3sQFs0Jbe5Oy11Jq0AnXemg
         4LpK+NKVrVxSPnR1d/ffl+aSHv6gq1GcnjJFCe2utDprdZ0eRfa9k+WiJypC271hSixj
         XS1lLFyV6HlCDrlwq8HcQsK6BT1aaCQduQhuTHGOlSJGmvZUwFnfEQvUTjpmZMZkKtCo
         tRt32noBkhsBCwmVa8xBjBTNLAoI6i7ebtthg34NJrN3Aq+CEHlwXLXa74at1WdtmjeG
         g0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/9DP21Y/K7Z/VraeZB1byIXgPmUm3+JNNTaYKuJoag=;
        b=AdMXaQlPk8cFQPCRMxxkb2AQqRBlh7wH12hIIEVrQPfng5IuEa+1WYYBoKxtGVq32Y
         RtILlOrFToSIqBbc3+gHrqrDUDVmKVDJGPKdxt9GAYkJg4kV3HQ/IvF3ta5UHjLx2C+J
         7pM5WipwKPTCgQ+ARa5j48fdgEFV8HbyY4vzvvkap41nSASCDsSRs30mRpVu3r342oPE
         geEpHMPuTDy9jfHJC7AMY9DyqzdfPB9KIu+THE+NTFQj2etKqbqfXIhZw1qtqoXj8c2U
         7+uSXuRCkSs7Lw+CR0KVSfomj4Xkah4SEWMLenQOEwbEbB2JD4dmCzXM6PvtN+CoYDm3
         GiYg==
X-Gm-Message-State: AOAM532G0fEMbubxpY1QvgyY2YFstVInlNF25W0u+vunI9Z/b8+JD9bV
        GUFCxX7JKnaBIdyS5zjp0LUopA==
X-Google-Smtp-Source: ABdhPJyHzQu0rWuAi3N0Y1aO8jKTZys8Gp3U7BbMBnmufHm9Y0dWGIIgSKPumsGqk4x0JuxJNMOggw==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr16477484wmj.77.1603721931779;
        Mon, 26 Oct 2020 07:18:51 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id e15sm21920841wro.13.2020.10.26.07.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:18:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/7] gpio: exar: include idr.h
Date:   Mon, 26 Oct 2020 15:18:34 +0100
Message-Id: <20201026141839.28536-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201026141839.28536-1-brgl@bgdev.pl>
References: <20201026141839.28536-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This driver uses IDA APIs but doesn't include the relevant header. This
fixes it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-exar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 4202dd363a11..1941ae533418 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.29.1

