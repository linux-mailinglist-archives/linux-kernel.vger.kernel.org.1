Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D42A816F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgKEOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbgKEOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:17 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322A7C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:17 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so1864781wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qK4vXzf9k749HbSw+NxCxzFALmYv20LEPAyeYzlRJg=;
        b=DvX+YFq0boewLykq+SRnhh+o0RblVNOCxqwRFP2HW2CfK8Pmx+3clePTBNvWOqiAlo
         6iifsKbFhESVU9JX1Qr5PP3j4dk/WVzjt2wT3rOzCJxtGSfqG4Eydl0yANYEeFhEgO6X
         h8na7H0n4q2V40frBQtsO3lUoXDLl2yfMTqiTyiX7pzXyTwkHKZkku74oLaqgrThJGFI
         ledlIjIxUT9uBm0nugUaAnD4Lpvzr7y5LnZsQUsg+h/5H3vPdpeq59M69qrP+c8tT58U
         62w8Eo6U3pbROKNyR3Mk6PqEF6d3dXVYNVkzALqqNEz84J82wk3bz83cXzHDm8kHLD1f
         qtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qK4vXzf9k749HbSw+NxCxzFALmYv20LEPAyeYzlRJg=;
        b=XXhuUnoStL8/ubebuxNfYeSsTUvgPpQCEuNmHd2oaUjkhVGky5QziyKUaxyoF4awwB
         kGqblJf5d5OJPTHWjwZQB73ua71Id4QlcSeyl09hWGJnJjBhp8YQFNIw77P98OgmXtfC
         nUWoFxPdAiN2DDzX+KICDIgdsMcU3YU/UwkialCPV1IXM7JrehcY80FzItDhbMeS4iJQ
         6GW4CgD6A4LnZsJYKjkmtqtNcAZfMs18hnrGV+TgdMGgZm5cNwdi7Vw4QYUhW9WRD+gf
         fijbNhw/LcsHlwzD8YfaN4N4ycOSuoaNh6jHPo2q1FvMiq24jiwNgtDe9tKBLhhvfuhp
         ELLQ==
X-Gm-Message-State: AOAM531u2rD5xdV35k4tWxUYQtaaNiwTNSBljpCxhknmjGxZt9NRsHdu
        IA2PpTbBNJAJJjpqPSA78HPf+g==
X-Google-Smtp-Source: ABdhPJxI3Hz+xthd1AooFfZRJiYYpYQ7WvLLajU3VZosa9/ukoyhZuoZL8CZ36qLvtZ38khO9VAoCA==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr3136449wmf.122.1604587935853;
        Thu, 05 Nov 2020 06:52:15 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH 01/19] gpu: host1x: bus: Add missing description for 'driver'
Date:   Thu,  5 Nov 2020 14:44:59 +0000
Message-Id: <20201105144517.1826692-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/host1x/bus.c:40: warning: Function parameter or member 'driver' not described in 'host1x_subdev_add'

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/host1x/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index e201f62d62c0c..347fb962b6c93 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -32,6 +32,7 @@ struct host1x_subdev {
 /**
  * host1x_subdev_add() - add a new subdevice with an associated device node
  * @device: host1x device to add the subdevice to
+ * @driver: host1x driver containing the subdevices
  * @np: device node
  */
 static int host1x_subdev_add(struct host1x_device *device,
-- 
2.25.1

