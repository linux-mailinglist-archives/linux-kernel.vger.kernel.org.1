Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0AA2D3009
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 17:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgLHQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 11:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbgLHQnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 11:43:25 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370BC0617B0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 08:42:24 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id u19so18259044edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 08:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8ZqKyFHGH5C+QdIaLYiAJfgSlK2HoPCxGbkd1rkjtU=;
        b=YJGXosdLUTFfXiLJhGUn7kcaKGyWwlL+NNVTDbQa1EmRHBT7VYNdOSoTOo+4/pO7Rv
         f67HYgSUuN/zNwg8creeABtACtEh35QesqX+DtjL7f9RLkZMLQMmOqK/f1LSzENWvRdy
         2RhNgiZznYQaDa34tLeh3z1qy8oUPpp2RMFmqNZs9uSqhsGJfm33k5EwJLjg5NRwCwQX
         e5q9PodIkfLUCoXywx+sArD+xGAC3GhatjyWilLx7BUAFtnIFYeqnodo8s7XG7bvhXeo
         LEeA3SL41D2ENjNej6A8tEzJULIHEhLjNJ598yPvyB0HQMU46EF2LbQFZAoFxYRBz5NL
         08mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8ZqKyFHGH5C+QdIaLYiAJfgSlK2HoPCxGbkd1rkjtU=;
        b=eoVhl19kNeTuffCXgP6mlLh0RViGP+RQpa/L6m+OBsZD+FIwBuWpHrVQiBPKlf86O0
         eZ1oDOhH3jmHHG+Y0EQzyAFqSc2FIIVig/VxlDcWOpnjJmO83CdX/spLW3lC5R/01QYf
         kEr9cnlRP8iYmAOs4P9x6q9KxF0O1xK4PD6IX/S74v44EYWziK/kNuCiD9rkD2FYMsNi
         hKiBk/s/YW2wHRqb1Ifj8OzoPQhJ2r8Lv4eDSLU2c93fo9AZDBscU+q3HZRAmNYFyQOB
         +Ct2YBIwOd+8bVxBmKP4bilPBpfB++1vUpoRnq5zK677ZTHM6nbHvFdbGlnMTt8QcSX1
         j9dQ==
X-Gm-Message-State: AOAM533dnMbRdZE1baEz+aFaLkLvESky77QZeSgC5H8LZ14VECe3QR0z
        lvKIDFvAMr/3g3gzOKFKKAwI6g==
X-Google-Smtp-Source: ABdhPJzsje/g6gUZ+/m6qEO4sipKpj2XfNKA+0bsFwkdBQMj+67enVK+bcuHNopCvhldU3J6mYF1WA==
X-Received: by 2002:a05:6402:139a:: with SMTP id b26mr7346573edv.47.1607445740668;
        Tue, 08 Dec 2020 08:42:20 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-158-132.adsl.proxad.net. [82.252.158.132])
        by smtp.gmail.com with ESMTPSA id t19sm16150546eje.86.2020.12.08.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:42:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v5 1/4] units: Add Watt units
Date:   Tue,  8 Dec 2020 17:41:42 +0100
Message-Id: <20201208164145.19493-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208164145.19493-1-daniel.lezcano@linaro.org>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there are the temperature units, let's add the Watt macros definition.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index aaf716364ec3..92c234e71cab 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/kernel.h>
 
+#define MILLIWATT_PER_WATT	1000L
+#define MICROWATT_PER_MILLIWATT	1000L
+#define MICROWATT_PER_WATT	1000000L
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.17.1

