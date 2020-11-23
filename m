Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ADC2C141C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390621AbgKWS5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbgKWS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:57:12 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB0C061A4D;
        Mon, 23 Nov 2020 10:57:10 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so9297220plr.9;
        Mon, 23 Nov 2020 10:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGyTIo1G7d0U3CZUJffCDlu9eTw6Qo/mWhnC32TeIPQ=;
        b=LJDYqiwlg6i/r6499eoEQQJ557GyuGTnQjjEKIiKSTuBPpFKsHh9EWDxYdV0vyueS9
         brwtIBcZ0SqWqlQtLjx89ssGZ+6GCdnBlp94rPtIRYcQk/KsS67PjQHoT9EcV/ykjK9N
         1Ch266ZOoHRh3Kfd64wY9X0VMqDi/EHat9NTkevHjbeVq8AGOQR/BBGhRzPWcZ3GsFBX
         /2LB3rhsxcWWgKvSmEUjXyywi4PEABpUNkvTG3JwHtyOsbl1ZUlQWVMzT/yMIJD8mN24
         mDxq2s0nDd47POwIkz2JaQD9fMNDFouwynH/DZA01ZRPOhwjkbgHWBGY03rNPAY2EMq3
         I4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGyTIo1G7d0U3CZUJffCDlu9eTw6Qo/mWhnC32TeIPQ=;
        b=HULpW2r+BIx2+LWf2PeK2lIFTHLMQJLozx+/6V4e3ci0II/SzXriaDB52i/LczMwA8
         hKEU2Q4zyFrJxaA0I5r+0K/FF264Ykhr12Cef1VH4RFx2ZiSj9O9Kamv83rUk26ymN+3
         W05TG28Hn3hw58hh1iM/r7go9Ype9RGJJaFPBi47qAd1pZV7FZf4Rm9MKLPm7TSdA7Wq
         9R4dLsTXGwMtRzJF3jPkq6YqYygslVcvg8wCMCch7Id1K7tVsxfY4PHG1seaMqW40kb3
         /yvjmaYDtR4zwUDiwBGFlUsPe5BIc3HpUG1dhSwmVSIX04FJYfL2ca6orwO5Q1n9wy8g
         hFvw==
X-Gm-Message-State: AOAM532XQeXpkOSr7QPcvvNqIyoD8dr87bWuP4pX9xOtJ6NCzJ3JsujT
        kgiQABQ6tfM2JBBXdoB7/Rk=
X-Google-Smtp-Source: ABdhPJw8JNcyGAoQHESmkKHqaXzYbP9kaRaJ3DOOwMke7AVf/Df85q05BWSUVyyq7VzG63Q7c/imIw==
X-Received: by 2002:a17:902:b103:b029:da:b9a:e9a7 with SMTP id q3-20020a170902b103b02900da0b9ae9a7mr832213plr.45.1606157830358;
        Mon, 23 Nov 2020 10:57:10 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id w15sm11043098pgi.20.2020.11.23.10.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:57:09 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com, mikechoi@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v5 2/2] docs: hwmon: Document max127 driver
Date:   Mon, 23 Nov 2020 10:56:58 -0800
Message-Id: <20201123185658.7632-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123185658.7632-1-rentao.bupt@gmail.com>
References: <20201123185658.7632-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add documentation for the max127 hardware monitoring driver.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Changes in v5:
   - None.
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

