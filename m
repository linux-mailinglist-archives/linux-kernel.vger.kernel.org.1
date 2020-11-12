Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADD2B025F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgKLJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgKLJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:23 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFCFC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so5287710wrf.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYp4liH6QtuFMXY8fnKB9zBXABbAMYcv+7gF3AlAZms=;
        b=bdUZdwS1oHyphT4MiY5fuJuSHleFsAMvbaM8db1XRxOT716qg1IRdUoVmUzFlpT+nG
         9gCJlWNx2qumzMjuLRaz6pMapA8jN5KX/onENKyLqd8fmWQVqlLv37M7yNBMdHrkRG8m
         Ce5OzzdiOlLVY5UjDV4pXwSRUItbhrlVDg2LMZJkR3fMJMD8oE5J2qgMS78nCx1CGaSu
         QH/hVQwngfaP/pn80wu7WMQGUpJEHXNzTqFbiT4wzU+ewGsAccit57KiJOKZopKSq/eF
         f1X0STlN0+kct9AkS2v16Wwuo7yx6CR8xbmba8GcKm/9xfrIrx5jEKCM+6P7rSDFqHZO
         l/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYp4liH6QtuFMXY8fnKB9zBXABbAMYcv+7gF3AlAZms=;
        b=P01lYVRrWiuZtQUPl7gk1WE2n4q64R2CoIfje7I6ekhOn1Lgbl5NvBuYy7AwBQHKq+
         l7mfKcN6lJOY+IYYnxpP+yMm/604MnImDTUPZlAjAKw4y0IOgFpsJmMlLmNWNz5uLpnU
         +gIxiHtJNny41ZBwrWftzOYP+8Px9ONcsdyRFgzlyJZSz/sa7YDQLDgTG1GQ5kSDu2aW
         GLVdojE30R/Om+3HVu76pEtmEmOZ4pb5CTiWEJGExcuKmk03iBPfY6UV8yEraMXCiGvS
         IanLyVLnnpe/mHfneQTHUzbj90oPyahxzIpEmL1GPKDUqxkWrWGPtmB2Ztz6QJlPA6xu
         8XAw==
X-Gm-Message-State: AOAM533fswebJOZ9P4CWq5fTGuzozS8op1Yp9V/umJMc7hBlJVWuTPBq
        hjdI1X53K3OiKNEHNpt/zSd6Kg==
X-Google-Smtp-Source: ABdhPJxKfGioiUbjQWMEIpOjWDSlwsWsdf+ZB/gdqtMiJ065DaMLD1p6GwzO8zDSAzKlSqTxRNVq+Q==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr20538303wrq.210.1605175041676;
        Thu, 12 Nov 2020 01:57:21 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n15sm6138792wrq.48.2020.11.12.01.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:57:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] hwmon: ibmpowernv: Silence strncpy() warning
Date:   Thu, 12 Nov 2020 09:57:15 +0000
Message-Id: <20201112095715.1993117-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112095715.1993117-1-lee.jones@linaro.org>
References: <20201112095715.1993117-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/hwmon/ibmpowernv.c:11:
 In function ‘strncpy’,
 inlined from ‘get_sensor_index_attr’ at drivers/hwmon/ibmpowernv.c:243:2,
 inlined from ‘create_device_attrs’ at drivers/hwmon/ibmpowernv.c:280:8:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hwmon/ibmpowernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index a750647e66a47..8e3724728cce0 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -240,7 +240,7 @@ static int get_sensor_index_attr(const char *name, u32 *index, char *attr)
 	if (err)
 		return err;
 
-	strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
+	strscpy(attr, dash_pos + 1, MAX_ATTR_LEN);
 
 	return 0;
 }
-- 
2.25.1

