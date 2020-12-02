Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA85C2CC2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgLBQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 11:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgLBQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 11:57:34 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B997EC061A49
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 08:56:23 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id bn4so1664436qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=C5cH1+u6QihF0HJXhluYkOAp5Dcp6gIMnhnwCWhDyK8=;
        b=wEjjFZwDRrIcR76cg+sG6O0U6N9QbH2Tn+HAfT7TifoZST/nqkVooTuo+JECaT6v16
         4+9sqSBt20RoKZ0THxx1IGevWBzcwtfWtS6xmrWQCDIywaC4puWSRN76rJCtbfVeBA1J
         1FuMFCW00LG86mj6uQhLdR4MezFXDYu03R2X1ApUsGta4lfb+CPKHKvqhsJeJ4z7uM2Z
         GX61rZXutWDzKP5A9VXTh/+JkpuzZM6Hu+CCPf+/2M44FDQhLUt4tXPBQud/1JFM/qKR
         6eY+E5Bdi280/0aL+StKLKuefHI8dCGwDFBvZrUS8CnDWKHhwQdHc/POQpykhZwPZb/5
         n1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C5cH1+u6QihF0HJXhluYkOAp5Dcp6gIMnhnwCWhDyK8=;
        b=UkTjcB3wnL3FGfOOWSuFFKR735COWihk7NUJn7gCb5OpjMa8wYYacdNmRJDlRih2Ef
         wsig0/jmcAsaQZhzKdhL1P1trhbyRe1JKDirlc/Mmhs73x7+zTFhxemDym4AWC0xh0fu
         OQoxi79qFVf4mzqHrRDJqQVGRSSXe2KQ1kDNWuMrX7WWLT7DM5BsKkCZV8Zw827qMyc9
         lvpFmpBdjYdJRhvg0xa+YvXunFzWftJOCMjBQKO9gYjoKi6xTV44yXfuhJyk33AM+vUD
         tsM64zyCtjirt0PmpWTR1Am5fdRK3zD8NT07qWvctGbpRIAB09BKmIsJUSRPH3qpEeIj
         1WyQ==
X-Gm-Message-State: AOAM530XemxvQssWVJgjp90DKkR0C406jL9KAwoB05ByqyY2zMR6s3Zq
        k5smE1F+dISSw9TUN2L89h4eJr8BAw==
X-Google-Smtp-Source: ABdhPJxjTellGg62Ft0dtoF7EbHO59fZZvLSVTJo7d/PZdgwmGf/EuFIpKUmJSX7HwwygZQlnP8HnD8pPQ==
Sender: "kunyi via sendgmr" <kunyi@kunyi0.svl.corp.google.com>
X-Received: from kunyi0.svl.corp.google.com ([2620:15c:2c5:3:9657:a5ff:fef2:53bd])
 (user=kunyi job=sendgmr) by 2002:ad4:4e47:: with SMTP id eb7mr3692938qvb.39.1606928182920;
 Wed, 02 Dec 2020 08:56:22 -0800 (PST)
Date:   Wed,  2 Dec 2020 08:56:00 -0800
In-Reply-To: <20201202165601.1532213-1-kunyi@google.com>
Message-Id: <20201202165601.1532213-3-kunyi@google.com>
Mime-Version: 1.0
References: <20201202165601.1532213-1-kunyi@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH linux hwmon-next v4 2/3] hwmon: (sbtsi) Add documentation
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, supreeth.venkatesh@amd.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SB-TSI sensor interface driver.

Signed-off-by: Kun Yi <kunyi@google.com>
---
 Documentation/hwmon/index.rst      |  1 +
 Documentation/hwmon/sbtsi_temp.rst | 40 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/hwmon/sbtsi_temp.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fd6fae46b99c..509fb3bcafb2 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -151,6 +151,7 @@ Hardware Monitoring Kernel Drivers
    pxe1610
    pwm-fan
    raspberrypi-hwmon
+   sbtsi_temp
    sch5627
    sch5636
    scpi-hwmon
diff --git a/Documentation/hwmon/sbtsi_temp.rst b/Documentation/hwmon/sbtsi_temp.rst
new file mode 100644
index 000000000000..9f0f197c8aa2
--- /dev/null
+++ b/Documentation/hwmon/sbtsi_temp.rst
@@ -0,0 +1,40 @@
+Kernel driver sbtsi_temp
+==================
+
+Supported hardware:
+
+  * Sideband interface (SBI) Temperature Sensor Interface (SB-TSI)
+    compliant AMD SoC temperature device.
+
+    Prefix: 'sbtsi_temp'
+
+    Addresses scanned: This driver doesn't support address scanning.
+
+    To instantiate this driver on an AMD CPU with SB-TSI
+    support, the i2c bus number would be the bus connected from the board
+    management controller (BMC) to the CPU. The i2c address is specified in
+    Section 6.3.1 of the SoC register reference: The SB-TSI address is normally
+    98h for socket 0 and 90h for socket 1, but it could vary based on hardware
+    address select pins.
+
+    Datasheet: The SB-TSI interface and protocol is available as part of
+               the open source SoC register reference at:
+
+	       https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf
+
+               The Advanced Platform Management Link (APML) Specification is
+               available at:
+
+	       http://developer.amd.com/wordpress/media/2012/10/41918.pdf
+
+Author: Kun Yi <kunyi@google.com>
+
+Description
+-----------
+
+The SBI temperature sensor interface (SB-TSI) is an emulation of the software
+and physical interface of a typical 8-pin remote temperature sensor (RTS) on
+AMD SoCs. It implements one temperature sensor with readings and limit
+registers encode the temperature in increments of 0.125 from 0 to 255.875.
+Limits can be set through the writable thresholds, and if reached will trigger
+corresponding alert signals.
-- 
2.29.2.454.gaff20da3a2-goog

