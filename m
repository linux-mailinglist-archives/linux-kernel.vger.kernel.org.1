Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93672C00D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 08:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgKWHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgKWHpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:45:44 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AA6C0613CF;
        Sun, 22 Nov 2020 23:45:44 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id l17so3025529pgk.1;
        Sun, 22 Nov 2020 23:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1KXTAJmKVykTQ4vYpPkazbnjLZRCjxHoq4CJnnjX6E4=;
        b=Kr0nPw4bcK0rd9U95IKCxSAHwSTFxryQ17Qd8RzxkKVuTtVmrbxISShI6R3WLTTCGI
         81pmJJMhdaCW7d2FawOiOASvre/xC7joEEMuJ1ZNaN1UaljUFt56+HmcrFBYX6DRNMtW
         NKT3LrTOWFt6o33rIR1s1J24zZpHNQOD4U2U1RBJ6EDX/kK8CMSg4AmH2U/ZFnrMxgpT
         pMjO9C+k3il0mnI1Xb+HaTxUCxf6WiCgylAyDxxTuvqxc03AHNVztJzGQ9O6EibMCbME
         Eclb6jLtqYOruygfcrVAAXk2uWV1+DzDr9W9mOQXl6rdafyiNm1HqYWgMLD0dDO+WL8s
         1RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1KXTAJmKVykTQ4vYpPkazbnjLZRCjxHoq4CJnnjX6E4=;
        b=X4SMAEkiTjZ85wi8asLkr8ykRmkN4lu1NJW/lQvb+4XtcjAI12HPB52jwRdfKE47ZH
         Aoz6WoAIeflvdyblIr7ToGGW6Fc8v3kHWeA2yu0Q3GHM6GQb6DfJ78bwdnR4qQOaiM/C
         b2WUxBM6nbRYYqlwojGB9IQAMvy9vCiqcXfaTkaaGYbyzO7QlWbcD64MHn/O9X15e3QH
         cclCatwJyaulahfRE14c9RB/8FV486X5JL95sACVhMLjVUXZigVQUFCv1ENU5PwRtLWW
         +miZ2ZclZH3lMeYD9GmkSwGjshrcBzMtuk/xpH9vegfKPHvzkn+XwFiIpFf75CgtyEmM
         ltWg==
X-Gm-Message-State: AOAM530Ogu5jDXoyesjWQsgbNQuLzRg0LFKvPqkG+OkV4zldW4RR0nAD
        2Ammyhef7EBL880+k2Uh8IWCKeuLSa5o1F7b
X-Google-Smtp-Source: ABdhPJzkFNLl2LANfugwIBApL49r4vt0i5J3kZswjXeHHLPY74fpkw1cafa1AQM+Aexgej5QxynnpQ==
X-Received: by 2002:a17:90a:5418:: with SMTP id z24mr9780577pjh.139.1606117544387;
        Sun, 22 Nov 2020 23:45:44 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id 12sm13176340pjn.19.2020.11.22.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 23:45:43 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com, mikechoi@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 2/2] docs: hwmon: Document max127 driver
Date:   Sun, 22 Nov 2020 23:45:32 -0800
Message-Id: <20201123074532.3730-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123074532.3730-1-rentao.bupt@gmail.com>
References: <20201123074532.3730-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add documentation for the max127 hardware monitoring driver.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Changes in v4:
   - None.
 Changes in v3:
   - no code change. xdp maintainers were removed from to/cc list.
 Changes in v2:
   - add more description for min/max sysfs nodes.
   - convert values from volt to millivolt in the document.

 Documentation/hwmon/index.rst  |  1 +
 Documentation/hwmon/max127.rst | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/hwmon/max127.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 408760d13813..0a07b6000c20 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -111,6 +111,7 @@ Hardware Monitoring Kernel Drivers
    ltc4245
    ltc4260
    ltc4261
+   max127
    max16064
    max16065
    max1619
diff --git a/Documentation/hwmon/max127.rst b/Documentation/hwmon/max127.rst
new file mode 100644
index 000000000000..dc192dd9c37c
--- /dev/null
+++ b/Documentation/hwmon/max127.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver max127
+====================
+
+Author:
+
+  * Tao Ren <rentao.bupt@gmail.com>
+
+Supported chips:
+
+  * Maxim MAX127
+
+    Prefix: 'max127'
+
+    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX127-MAX128.pdf
+
+Description
+-----------
+
+The MAX127 is a multirange, 12-bit data acquisition system (DAS) providing
+8 analog input channels that are independently software programmable for
+a variety of ranges. The available ranges are {0,5V}, {0,10V}, {-5,5V}
+and {-10,10V}.
+
+The MAX127 features a 2-wire, I2C-compatible serial interface that allows
+communication among multiple devices using SDA and SCL lines.
+
+Sysfs interface
+---------------
+
+  ============== ==============================================================
+  in[0-7]_input  The input voltage (in mV) of the corresponding channel.
+		 RO
+
+  in[0-7]_min    The lower input limit (in mV) for the corresponding channel.
+		 ADC range and LSB will be updated when the limit is changed.
+		 For the MAX127, it will be adjusted to -10000, -5000, or 0.
+		 RW
+
+  in[0-7]_max    The higher input limit (in mV) for the corresponding channel.
+		 ADC range and LSB will be updated when the limit is changed.
+		 For the MAX127, it will be adjusted to 0, 5000, or 10000.
+		 RW
+  ============== ==============================================================
-- 
2.17.1

