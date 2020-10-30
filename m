Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9229FEBF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ3HmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgJ3HlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:06 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1188B2415B;
        Fri, 30 Oct 2020 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043664;
        bh=laqfKgYIOZkUNXl8RbAmpD7Q4frs1RmcXkjACWIQfJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FL9ZuXNn8Q9elmy6sIUFm4wj5f/9GQy6wetZUEm3ih4849MQ616Dr0o2iJtEXnD6r
         E66jYp5wti8IGBK524rceDsoPnA31rgoH6ww91ZSW8gDR/5IUkBSzDayXttL3UgCYa
         hoXt1ME6ysZ6pyXUW5Lju93c4hX/zMvXyqL6XeFk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1y-004Ogv-0f; Fri, 30 Oct 2020 08:41:02 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/39] docs: ABI: sysfs-class-backlight: unify ABI documentation
Date:   Fri, 30 Oct 2020 08:40:56 +0100
Message-Id: <342195ad5a819d9bcfcebc133c77ab69b4211672.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both adp8860 and adp8870 define some extensions to the
backlight class. This causes warnings:

	Warning: /sys/class/backlight/<backlight>/ambient_light_level is defined 2 times:  /sys/class/backlight/<backlight>/ambient_light_level:8  /sys/class/backlight/<backlight>/ambient_light_level:30
	Warning: /sys/class/backlight/<backlight>/ambient_light_zone is defined 2 times:  /sys/class/backlight/<backlight>/ambient_light_zone:18  /sys/class/backlight/<backlight>/ambient_light_zone:40

As ABI definitions shouldn't be duplicated.

Unfortunately, the ABI is dependent on the specific device
features. As such, ambient_light_level range is somewhat
different among the supported devices.

The ambient_light_zone is even worse: the meanings of each
preset are different, and there's no ABI to retrieve
the supported types nor their meanins. Unfortunately,
it is too late to fix it without causing regressions,
as this has been used since Kernel v2.6.35.

Rewrite those ABI documentation using the current documentation
as a reference, and double-checking at the datasheets:

	https://www.analog.com/media/en/technical-documentation/data-sheets/ADP8870.pdf
	https://www.analog.com/media/en/technical-documentation/data-sheets/ADP8860.pdf

in order to properly document the differences between those two
drivers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../ABI/testing/sysfs-class-backlight         | 60 +++++++++++++++++++
 .../ABI/testing/sysfs-class-backlight-adp8860 | 21 +------
 .../sysfs-class-backlight-driver-adp8870      | 30 +---------
 3 files changed, 65 insertions(+), 46 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-backlight b/Documentation/ABI/testing/sysfs-class-backlight
index 3ab175a3f5cb..1fc86401bf95 100644
--- a/Documentation/ABI/testing/sysfs-class-backlight
+++ b/Documentation/ABI/testing/sysfs-class-backlight
@@ -24,3 +24,63 @@ Description:
 		non-linear
 		  The brightness changes non-linearly with each step. Brightness
 		  controls should use a linear mapping for a linear perception.
+
+What:		/sys/class/backlight/<backlight>/ambient_light_level
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>
+Description:
+		(RO) Get conversion value of the light sensor.
+
+		The value is automatically updated every 80 ms when the
+		light sensor is enabled.
+
+		The value range is device-driver specific:
+
+		For ADP8870:
+
+		  It returns integer between 0 (dark) and 8000 (max ambient
+		  brightness).
+
+		For ADP8860:
+
+		  It returns a 13-bits integer.
+
+What:		/sys/class/backlight/<backlight>/ambient_light_zone
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	Michael Hennerich <michael.hennerich@analog.com>,
+		device-drivers-devel@blackfin.uclinux.org
+
+Description:
+		(RW) Read or write the specific brightness level at which the
+		backlight operates.
+
+		The value meaning is device-driver specific:
+
+		For ADP8860:
+
+		  ==	==========================
+		   0	Off: Backlight set to 0 mA
+		   1	Level 1: daylight
+		   2	Level 2: bright
+		   3	Level 3: dark
+		  ==	==========================
+
+		For ADP8870:
+
+		  ==	==========================
+		   0	Off: Backlight set to 0 mA
+		   1	Level 1: daylight
+		   2	Level 2: bright
+		   3	Level 3: office
+		   4	Level 4: indoor
+		   5	Level 5: dark
+		  ==	==========================
+
+		Writing 0 returns to normal/automatic ambient light level
+		operation.
+
+		It can be enabled by writing the value stored in
+		/sys/class/backlight/<backlight>/max_brightness to
+		/sys/class/backlight/<backlight>/brightness.
diff --git a/Documentation/ABI/testing/sysfs-class-backlight-adp8860 b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
index 54d61c788b1b..6610ac73f9ba 100644
--- a/Documentation/ABI/testing/sysfs-class-backlight-adp8860
+++ b/Documentation/ABI/testing/sysfs-class-backlight-adp8860
@@ -6,25 +6,8 @@ adp8860, adp8861 and adp8863 devices: daylight (level 1), office (level 2) and
 dark (level 3). By default the brightness operates at the daylight brightness
 level.
 
-What:		/sys/class/backlight/<backlight>/ambient_light_level
-Date:		Apr, 2010
-KernelVersion:	v2.6.35
-Contact:	Michael Hennerich <michael.hennerich@analog.com>
-Description:
-		(RO) 13-bit conversion value for the first light sensor—high
-		byte (Bit 12 to Bit 8). The value is updated every 80 ms (when
-		the light sensor is enabled).
-
-
-What:		/sys/class/backlight/<backlight>/ambient_light_zone
-Date:		Apr, 2010
-KernelVersion:	v2.6.35
-Contact:	Michael Hennerich <michael.hennerich@analog.com>
-Description:
-		(RW) Read or write the specific level at which the backlight
-		operates. Value "0" enables automatic ambient light sensing, and
-		values "1", "2" or "3" set the control to daylight, office or
-		dark respectively.
+See also /sys/class/backlight/<backlight>/ambient_light_level and
+/sys/class/backlight/<backlight>/ambient_light_zone.
 
 
 What:		/sys/class/backlight/<backlight>/l1_daylight_max
diff --git a/Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870 b/Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
index 33e648808117..b08ca912cad4 100644
--- a/Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
+++ b/Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
@@ -1,3 +1,6 @@
+See also /sys/class/backlight/<backlight>/ambient_light_level and
+/sys/class/backlight/<backlight>/ambient_light_zone.
+
 What:		/sys/class/backlight/<backlight>/<ambient light zone>_max
 What:		/sys/class/backlight/<backlight>/l1_daylight_max
 What:		/sys/class/backlight/<backlight>/l2_bright_max
@@ -27,30 +30,3 @@ Description:
 		set to 0. Full off when the backlight is disabled.
 		This file will also show the dim brightness level stored for
 		this <ambient light zone>.
-
-What:		/sys/class/backlight/<backlight>/ambient_light_level
-Date:		May 2011
-KernelVersion:	3.0
-Contact:	device-drivers-devel@blackfin.uclinux.org
-Description:
-		Get conversion value of the light sensor.
-		This value is updated every 80 ms (when the light sensor
-		is enabled). Returns integer between 0 (dark) and
-		8000 (max ambient brightness)
-
-What:		/sys/class/backlight/<backlight>/ambient_light_zone
-Date:		May 2011
-KernelVersion:	3.0
-Contact:	device-drivers-devel@blackfin.uclinux.org
-Description:
-		Get/Set current ambient light zone. Reading returns
-		integer between 1..5 (1 = daylight, 2 = bright, ..., 5 = dark).
-		Writing a value between 1..5 forces the backlight controller
-		to enter the corresponding ambient light zone.
-		Writing 0 returns to normal/automatic ambient light level
-		operation. The ambient light sensing feature on these devices
-		is an extension to the API documented in
-		Documentation/ABI/stable/sysfs-class-backlight.
-		It can be enabled by writing the value stored in
-		/sys/class/backlight/<backlight>/max_brightness to
-		/sys/class/backlight/<backlight>/brightness.
-- 
2.26.2

