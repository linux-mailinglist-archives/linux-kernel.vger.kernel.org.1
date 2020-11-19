Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0352B9A18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgKSRxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgKSRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:53:37 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293A9C0613CF;
        Thu, 19 Nov 2020 09:53:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so5223914pfu.1;
        Thu, 19 Nov 2020 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohg0oJ87lTSLWpA2Zkajq7Ec19JHlvcX3mrDjoh7A+4=;
        b=SPWvYU2D1eVcQ+2w65iVGl6q6+jVTpgUw6pDny2n4jrNj7rmt3cUTzZiIQ99HHK91C
         q+2dl9IfxOD/LVL6WfRkI2e7KZ8wFVljPXrACM2voGt0m4glw3em/VZu66t+BIdIUbfW
         aZmUNft6r0lH7XxXvNy3S4L7eqYhsdMoORwW8SsYoleoy/7q/gvqK//hBvZJ1PVE3gFy
         maAy+n2BY4tu+F7gDVvi9VKKpybuRpmL3J0qI1IG+gDe/mgneH+BgmwBijiidvvDxX8X
         ooJYQ9RB8YXOsl+KMtDuqaca3OMQq86YVCuVafECchW+A+E4Q9pkqM3q6LFXiTk8LFRM
         bVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohg0oJ87lTSLWpA2Zkajq7Ec19JHlvcX3mrDjoh7A+4=;
        b=RK/HCpaDx4wuLiHNiVfXlxC4FuuIiY62KfjEeEHQetFZFf+sktIACCuVslK3QSWwCW
         IH52t2cqjJGpqWjPJRFW3qQ73R7srFfjkAftAjUCLs4rNDqY7u5ugyxJUMnlf7Xx3BvP
         FSRusxK/wtwa7AF5edMuw022QF2YdAnoQDKBRLrAh8Y/tBXf3qRYL2cgqXleDlM+xLSj
         hA5cfePvLoezTiF45tfeWMRD+/eE3jihfSOx9l/j2e3BL+vJ96pRFLpGKNvq+k53P0W3
         LHA+br9DuDr48uRmB1TBeUdJ3NDxzc+UGB364D6sJ/YupvKeNaUCqTOjd91PYizDBcT9
         QR+Q==
X-Gm-Message-State: AOAM533gExDgZU46Q96UrXaTUxAMAS7uPHx5rRCPF1eyXCkodNUaFNOO
        26OHVz+JFrGxzgipx60AIvrdPmhDzSz+sTWt
X-Google-Smtp-Source: ABdhPJyBohN3X1dbPoB5yZrMXkCYfOLlvE8+V0Q6voVdgLbu5TjNEaqQp2A9zwKfkl3gKwtJJ1Uc0g==
X-Received: by 2002:a17:90a:940f:: with SMTP id r15mr5639577pjo.219.1605808416714;
        Thu, 19 Nov 2020 09:53:36 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id 144sm482858pfb.71.2020.11.19.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 09:53:36 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com, mikechoi@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 2/2] docs: hwmon: Document max127 driver
Date:   Thu, 19 Nov 2020 09:53:24 -0800
Message-Id: <20201119175324.22472-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119175324.22472-1-rentao.bupt@gmail.com>
References: <20201119175324.22472-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add documentation for the max127 hardware monitoring driver.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
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

