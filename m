Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991CD2C55D1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390475AbgKZNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390465AbgKZNgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:36:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00E8C061A04
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:36:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so2193213wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJZuOyPoke9O1aNcUMwMh4SJuqZZoxbP5+ZVqt4w+RI=;
        b=X+JCQyhrfwOusPtMMbMFFQqy9G3DnrN0Apfg0toduxUQh7QrAPEpyOcrVwrW4GIGOf
         WZO3vAn7iAx/44TweVYH0J+J8iBHKESeAod+9TIG5Ol3Xr3Oey1B6tY21C5nhyjzJqEc
         GSRuryP7dGIjAzaTCsuaWDaDHUV8Px1plwRMkMwh6yZeI/EiLZ+rB1qVgPfozWIfdQ01
         WX5/+bkNu2JwnKYrQijfM/RKsGURD370CI+TpX3yb0nuCi5Z4HDdgFqeM8qRNbSc1W/I
         vSHpIUrn6C0LaCRUj3lhTFyTlm5r2Mby3uov+qbe4t8u3uK2krXnEC37R7SGeZ6L1UIP
         zoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJZuOyPoke9O1aNcUMwMh4SJuqZZoxbP5+ZVqt4w+RI=;
        b=GL3rghSx9newXB+/GjBhxDhGO1F25/Pm7axATPcvONhSnONL7dMy7y47AFB4XBUm7D
         044W3gGchKvI1BaQz1gqcrFeAmXW2hSfD3mli7blKJiwL1Bi3UTO1KsU+WZzqW0r8rJ2
         tpuXyEIM6JE5jlSnqeNOSii1IyclcDvPJXi5Z6awxfrWEYi+o3SS9xGPB0hfwNS2K0MK
         egFUF+fs7kBweGiM101cpGGZrnuzoRuRAUzprkYYym0iWd3wuwsRzWoNuh3Y2mGtRoJh
         XCU+Hk/F4sH8FxInRLj9Zz851FjvU1i8/OEjtN2HyohXI1Pvo6tZLFmRrym+QU+AV9Tv
         Cx6g==
X-Gm-Message-State: AOAM5331y8+BlUpZG+mp+gP6BZUB+6cLfSexpHdfL8cacoi+cSTb/TS7
        +ApmLRsWUnzsModrshrRXEHLwQ==
X-Google-Smtp-Source: ABdhPJxLtvF9xQt6Eye8xlahrZrJol0bdVI8FzxBdv1mrVpSPY40QBjsFnhs3BvAKDV65oEIj6UgcA==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr3511199wmi.88.1606397778263;
        Thu, 26 Nov 2020 05:36:18 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id l3sm9056280wrr.89.2020.11.26.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:36:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v2 4/4] input: touchscreen: surface3_spi: Remove set but unused variable 'timestamp'
Date:   Thu, 26 Nov 2020 13:36:07 +0000
Message-Id: <20201126133607.3212484-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133607.3212484-1-lee.jones@linaro.org>
References: <20201126133607.3212484-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/touchscreen/surface3_spi.c: In function ‘surface3_spi_process_touch’:
 drivers/input/touchscreen/surface3_spi.c:97:6: warning: variable ‘timestamp’ set but not used [-Wunused-but-set-variable]

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/touchscreen/surface3_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index 731454599fcee..1da23e5585a0d 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -94,9 +94,7 @@ static void surface3_spi_report_touch(struct surface3_ts_data *ts_data,
 
 static void surface3_spi_process_touch(struct surface3_ts_data *ts_data, u8 *data)
 {
-	u16 timestamp;
 	unsigned int i;
-	timestamp = get_unaligned_le16(&data[15]);
 
 	for (i = 0; i < 13; i++) {
 		struct surface3_ts_data_finger *finger;
-- 
2.25.1

