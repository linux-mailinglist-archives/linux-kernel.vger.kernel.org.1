Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5145229FEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ3Hl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgJ3HlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:08 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374A924179;
        Fri, 30 Oct 2020 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043664;
        bh=G8NKN+8SzFOZSGCVaRBjKDHwzGWLMFf9kyFhlsvTyNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isgogeAPDwso/X8qU/QCSgOojbAKuHKrVEp0TMGO4L3llsf75TuK0Bjs/IK3Uf4oK
         20IHmNti2LDgGEx39Z2SJ/lnojzc9ycO6AQDZMWhEuYxZvpOmiyWJpnYcOUxWT2AC0
         U9CohKXf/CMw7MxeLU1u7fOwIZOmsswug6HEHt2o=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1y-004Ogx-1a; Fri, 30 Oct 2020 08:41:02 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Orson Zhai <orsonzhai@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/39] docs: ABI: sysfs-class-led-trigger-pattern: remove hw_pattern duplication
Date:   Fri, 30 Oct 2020 08:40:57 +0100
Message-Id: <038e57881550550b298e598f8f9b7f20515cbe15.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ABI files are supposed to be unique. Yet,
in the specific case of hw_pattern, there are some duplicated
entries as warned by scripts/get_abi.pl:

	Warning: /sys/class/leds/<led>/hw_pattern is defined 3 times:  Documentation/ABI/testing/sysfs-class-led-trigger-pattern:14  Documentation/ABI/testing/sysfs-class-led-driver-sc27xx:0  Documentation/ABI/testing/sysfs-class-led-driver-el15203000:0

Drop the duplication from the ABI files, moving the specific
definitions to files inside Documentation/leds.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../testing/sysfs-class-led-driver-el15203000 | 135 -----------------
 .../ABI/testing/sysfs-class-led-driver-sc27xx |  22 ---
 .../testing/sysfs-class-led-trigger-pattern   |   4 +-
 Documentation/leds/index.rst                  |   1 +
 Documentation/leds/leds-el15203000.rst        | 140 ++++++++++++++++++
 Documentation/leds/leds-sc27xx.rst            |  27 ++++
 6 files changed, 170 insertions(+), 159 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
 create mode 100644 Documentation/leds/leds-el15203000.rst
 create mode 100644 Documentation/leds/leds-sc27xx.rst

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-el15203000 b/Documentation/ABI/testing/sysfs-class-led-driver-el15203000
index da546e86deb5..04f3ffdc5936 100644
--- a/Documentation/ABI/testing/sysfs-class-led-driver-el15203000
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-el15203000
@@ -1,138 +1,3 @@
-What:		/sys/class/leds/<led>/hw_pattern
-Date:		September 2019
-KernelVersion:	5.5
-Description:
-		Specify a hardware pattern for the EL15203000 LED.
-		The LEDs board supports only predefined patterns by firmware
-		for specific LEDs.
-
-		Breathing mode for Screen frame light tube::
-
-		    "0 4000 1 4000"
-
-			^
-			|
-		    Max-|     ---
-			|    /   \
-			|   /     \
-			|  /       \     /
-			| /         \   /
-		    Min-|-           ---
-			|
-			0------4------8--> time (sec)
-
-		Cascade mode for Pipe LED::
-
-		    "1 800 2 800 4 800 8 800 16 800"
-
-			^
-			|
-		  0 On -|----+                   +----+                   +---
-			|    |                   |    |                   |
-		    Off-|    +-------------------+    +-------------------+
-			|
-		  1 On -|    +----+                   +----+
-			|    |    |                   |    |
-		    Off |----+    +-------------------+    +------------------
-			|
-		  2 On -|         +----+                   +----+
-			|         |    |                   |    |
-		    Off-|---------+    +-------------------+    +-------------
-			|
-		  3 On -|              +----+                   +----+
-			|              |    |                   |    |
-		    Off-|--------------+    +-------------------+    +--------
-			|
-		  4 On -|                   +----+                   +----+
-			|                   |    |                   |    |
-		    Off-|-------------------+    +-------------------+    +---
-			|
-			0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
-
-		Inverted cascade mode for Pipe LED::
-
-		    "30 800 29 800 27 800 23 800 15 800"
-
-			^
-			|
-		  0 On -|    +-------------------+    +-------------------+
-			|    |                   |    |                   |
-		    Off-|----+                   +----+                   +---
-			|
-		  1 On -|----+    +-------------------+    +------------------
-			|    |    |                   |    |
-		    Off |    +----+                   +----+
-			|
-		  2 On -|---------+    +-------------------+    +-------------
-			|         |    |                   |    |
-		    Off-|         +----+                   +----+
-			|
-		  3 On -|--------------+    +-------------------+    +--------
-			|              |    |                   |    |
-		    Off-|              +----+                   +----+
-			|
-		  4 On -|-------------------+    +-------------------+    +---
-			|                   |    |                   |    |
-		    Off-|                   +----+                   +----+
-			|
-			0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
-
-		Bounce mode for Pipe LED::
-
-		    "1 800 2 800 4 800 8 800 16 800 16 800 8 800 4 800 2 800 1 800"
-
-			^
-			|
-		  0 On -|----+                                       +--------
-			|    |                                       |
-		    Off-|    +---------------------------------------+
-			|
-		  1 On -|    +----+                             +----+
-			|    |    |                             |    |
-		    Off |----+    +-----------------------------+    +--------
-			|
-		  2 On -|         +----+                   +----+
-			|         |    |                   |    |
-		    Off-|---------+    +-------------------+    +-------------
-			|
-		  3 On -|              +----+         +----+
-			|              |    |         |    |
-		    Off-|--------------+    +---------+    +------------------
-			|
-		  4 On -|                   +---------+
-			|                   |         |
-		    Off-|-------------------+         +-----------------------
-			|
-			0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
-
-		Inverted bounce mode for Pipe LED::
-
-		    "30 800 29 800 27 800 23 800 15 800 15 800 23 800 27 800 29 800 30 800"
-
-			^
-			|
-		    0 On -|    +---------------------------------------+
-			|    |                                       |
-		    Off-|----+                                       +--------
-			|
-		    1 On -|----+    +-----------------------------+    +--------
-			|    |    |                             |    |
-		    Off |    +----+                             +----+
-			|
-		    2 On -|---------+    +-------------------+    +-------------
-			|         |    |                   |    |
-		    Off-|         +----+                   +----+
-			|
-		    3 On -|--------------+    +---------+    +------------------
-			|              |    |         |    |
-		    Off-|              +----+         +----+
-			|
-		    4 On -|-------------------+         +-----------------------
-			|                   |         |
-		    Off-|                   +---------+
-			|
-			0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
-
 What:		/sys/class/leds/<led>/repeat
 Date:		September 2019
 KernelVersion:	5.5
diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
deleted file mode 100644
index 215482379580..000000000000
--- a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
+++ /dev/null
@@ -1,22 +0,0 @@
-What:		/sys/class/leds/<led>/hw_pattern
-Date:		September 2018
-KernelVersion:	4.20
-Description:
-		Specify a hardware pattern for the SC27XX LED. For the SC27XX
-		LED controller, it only supports 4 stages to make a single
-		hardware pattern, which is used to configure the rise time,
-		high time, fall time and low time for the breathing mode.
-
-		For the breathing mode, the SC27XX LED only expects one brightness
-		for the high stage. To be compatible with the hardware pattern
-		format, we should set brightness as 0 for rise stage, fall
-		stage and low stage.
-
-		- Min stage duration: 125 ms
-		- Max stage duration: 31875 ms
-
-		Since the stage duration step is 125 ms, the duration should be
-		a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
-
-		Thus the format of the hardware pattern values should be:
-		"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index bd92ef9d6faa..d91a07767adf 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -23,8 +23,8 @@ Description:
 
 		Since different LED hardware can have different semantics of
 		hardware patterns, each driver is expected to provide its own
-		description for the hardware patterns in their ABI documentation
-		file.
+		description for the hardware patterns in their documentation
+		file at Documentation/leds/.
 
 What:		/sys/class/leds/<led>/repeat
 Date:		September 2018
diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index bc70c6aa7138..53e6090454af 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -17,6 +17,7 @@ LEDs
    uleds
 
    leds-blinkm
+   leds-el15203000
    leds-lm3556
    leds-lp3944
    leds-lp5521
diff --git a/Documentation/leds/leds-el15203000.rst b/Documentation/leds/leds-el15203000.rst
new file mode 100644
index 000000000000..12c23d79724d
--- /dev/null
+++ b/Documentation/leds/leds-el15203000.rst
@@ -0,0 +1,140 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Kernel driver for Crane EL15203000
+==================================
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for the EL15203000 LED.
+
+The LEDs board supports only predefined patterns by firmware
+for specific LEDs.
+
+Breathing mode for Screen frame light tube::
+
+    "0 4000 1 4000"
+
+	^
+	|
+    Max-|     ---
+	|    /   \
+	|   /     \
+	|  /       \     /
+	| /         \   /
+    Min-|-           ---
+	|
+	0------4------8--> time (sec)
+
+Cascade mode for Pipe LED::
+
+    "1 800 2 800 4 800 8 800 16 800"
+
+	^
+	|
+  0 On -|----+                   +----+                   +---
+	|    |                   |    |                   |
+    Off-|    +-------------------+    +-------------------+
+	|
+  1 On -|    +----+                   +----+
+	|    |    |                   |    |
+    Off |----+    +-------------------+    +------------------
+	|
+  2 On -|         +----+                   +----+
+	|         |    |                   |    |
+    Off-|---------+    +-------------------+    +-------------
+	|
+  3 On -|              +----+                   +----+
+	|              |    |                   |    |
+    Off-|--------------+    +-------------------+    +--------
+	|
+  4 On -|                   +----+                   +----+
+	|                   |    |                   |    |
+    Off-|-------------------+    +-------------------+    +---
+	|
+	0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
+
+Inverted cascade mode for Pipe LED::
+
+    "30 800 29 800 27 800 23 800 15 800"
+
+	^
+	|
+  0 On -|    +-------------------+    +-------------------+
+	|    |                   |    |                   |
+    Off-|----+                   +----+                   +---
+	|
+  1 On -|----+    +-------------------+    +------------------
+	|    |    |                   |    |
+    Off |    +----+                   +----+
+	|
+  2 On -|---------+    +-------------------+    +-------------
+	|         |    |                   |    |
+    Off-|         +----+                   +----+
+	|
+  3 On -|--------------+    +-------------------+    +--------
+	|              |    |                   |    |
+    Off-|              +----+                   +----+
+	|
+  4 On -|-------------------+    +-------------------+    +---
+	|                   |    |                   |    |
+    Off-|                   +----+                   +----+
+	|
+	0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
+
+Bounce mode for Pipe LED::
+
+    "1 800 2 800 4 800 8 800 16 800 16 800 8 800 4 800 2 800 1 800"
+
+	^
+	|
+  0 On -|----+                                       +--------
+	|    |                                       |
+    Off-|    +---------------------------------------+
+	|
+  1 On -|    +----+                             +----+
+	|    |    |                             |    |
+    Off |----+    +-----------------------------+    +--------
+	|
+  2 On -|         +----+                   +----+
+	|         |    |                   |    |
+    Off-|---------+    +-------------------+    +-------------
+	|
+  3 On -|              +----+         +----+
+	|              |    |         |    |
+    Off-|--------------+    +---------+    +------------------
+	|
+  4 On -|                   +---------+
+	|                   |         |
+    Off-|-------------------+         +-----------------------
+	|
+	0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
+
+Inverted bounce mode for Pipe LED::
+
+    "30 800 29 800 27 800 23 800 15 800 15 800 23 800 27 800 29 800 30 800"
+
+	^
+	|
+  0 On -|    +---------------------------------------+
+	|    |                                       |
+    Off-|----+                                       +--------
+	|
+  1 On -|----+    +-----------------------------+    +--------
+	|    |    |                             |    |
+    Off |    +----+                             +----+
+	|
+  2 On -|---------+    +-------------------+    +-------------
+	|         |    |                   |    |
+    Off-|         +----+                   +----+
+	|
+  3 On -|--------------+    +---------+    +------------------
+	|              |    |         |    |
+    Off-|              +----+         +----+
+	|
+  4 On -|-------------------+         +-----------------------
+	|                   |         |
+    Off-|                   +---------+
+	|
+	0---0.8--1.6--2.4--3.2---4---4.8--5.6--6.4--7.2---8--> time (sec)
diff --git a/Documentation/leds/leds-sc27xx.rst b/Documentation/leds/leds-sc27xx.rst
new file mode 100644
index 000000000000..6bdf6ba3c9fd
--- /dev/null
+++ b/Documentation/leds/leds-sc27xx.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+Kernel driver for Spreadtrum SC27XX
+===================================
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for the SC27XX LED. For the SC27XX
+LED controller, it only supports 4 stages to make a single
+hardware pattern, which is used to configure the rise time,
+high time, fall time and low time for the breathing mode.
+
+For the breathing mode, the SC27XX LED only expects one brightness
+for the high stage. To be compatible with the hardware pattern
+format, we should set brightness as 0 for rise stage, fall
+stage and low stage.
+
+- Min stage duration: 125 ms
+- Max stage duration: 31875 ms
+
+Since the stage duration step is 125 ms, the duration should be
+a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
+
+Thus the format of the hardware pattern values should be:
+"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
-- 
2.26.2

