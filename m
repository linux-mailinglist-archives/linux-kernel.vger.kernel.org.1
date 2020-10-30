Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1062429FEC2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgJ3HmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJ3HlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:06 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0190924137;
        Fri, 30 Oct 2020 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043664;
        bh=azjd4LMKnHzld/lR86fIiziciYsK0v91um4yXBP98hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBvPQNp+ufsxuPXMjS+jcqeE1/GuMC3LE2PMDy1kcWL4CjD+wjb1dKeMi1RqmU1AU
         Xl3z3gd9mdWyf7m2a2gEKsiVY4L5qaqHeafEBv8fN0HgGBI133u5TjdCRpMxHqMvmw
         j8NA9VmlzkEzj91DW7Js+d/j9SEfinic7XFN+dIM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004Ogp-UB; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/39] docs: ABI: unify /sys/class/leds/<led>/brightness documentation
Date:   Fri, 30 Oct 2020 08:40:53 +0100
Message-Id: <1115022e7f172b19ee8610f2ad28cc2f0ca93592.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ABI is defined twice, one for normal leds and another
one for multicolor ones.

Ensure that just one definition is there at ABI.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-led     | 25 ++++++++++++++++---
 .../ABI/testing/sysfs-class-led-multicolor    | 23 +++++------------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index 0ed5c2629c6f..2e24ac3bd7ef 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -3,9 +3,26 @@ Date:		March 2006
 KernelVersion:	2.6.17
 Contact:	Richard Purdie <rpurdie@rpsys.net>
 Description:
-		Set the brightness of the LED. Most LEDs don't
-		have hardware brightness support, so will just be turned on for
-		non-zero brightness settings. The value is between 0 and
+		Set the brightness of the LED.
+
+		Most LEDs don't have hardware brightness support, so will
+		just be turned on for non-zero brightness settings.
+
+		.. Note::
+
+		  For multicolor LEDs, writing to this file will update all
+		  LEDs within the group to a calculated percentage of what
+		  each color LED intensity is set to.
+
+		  The percentage is calculated for each grouped LED via
+		  the equation below::
+
+		    led_brightness = brightness * multi_intensity/max_brightness
+
+		  For additional details please refer to
+		  Documentation/leds/leds-class-multicolor.rst.
+
+		The value is between 0 and
 		/sys/class/leds/<led>/max_brightness.
 
 		Writing 0 to this file clears active trigger.
@@ -13,6 +30,8 @@ Description:
 		Writing non-zero to this file while trigger is active changes the
 		top brightness trigger is going to use.
 
+
+
 What:		/sys/class/leds/<led>/max_brightness
 Date:		March 2006
 KernelVersion:	2.6.17
diff --git a/Documentation/ABI/testing/sysfs-class-led-multicolor b/Documentation/ABI/testing/sysfs-class-led-multicolor
index eeeddcbdbbe3..16fc827b10cb 100644
--- a/Documentation/ABI/testing/sysfs-class-led-multicolor
+++ b/Documentation/ABI/testing/sysfs-class-led-multicolor
@@ -1,20 +1,3 @@
-What:		/sys/class/leds/<led>/brightness
-Date:		March 2020
-KernelVersion:	5.9
-Contact:	Dan Murphy <dmurphy@ti.com>
-Description:	read/write
-		Writing to this file will update all LEDs within the group to a
-		calculated percentage of what each color LED intensity is set
-		to. The percentage is calculated for each grouped LED via the
-		equation below:
-
-		led_brightness = brightness * multi_intensity/max_brightness
-
-		For additional details please refer to
-		Documentation/leds/leds-class-multicolor.rst.
-
-		The value of the LED is from 0 to
-		/sys/class/leds/<led>/max_brightness.
 
 What:		/sys/class/leds/<led>/multi_index
 Date:		March 2020
@@ -25,6 +8,9 @@ Description:	read
 		as an array of strings as they are indexed in the
 		multi_intensity file.
 
+		For additional details please refer to
+		Documentation/leds/leds-class-multicolor.rst.
+
 What:		/sys/class/leds/<led>/multi_intensity
 Date:		March 2020
 KernelVersion:	5.9
@@ -33,3 +19,6 @@ Description:	read/write
 		This file contains array of integers. Order of components is
 		described by the multi_index array. The maximum intensity should
 		not exceed /sys/class/leds/<led>/max_brightness.
+
+		For additional details please refer to
+		Documentation/leds/leds-class-multicolor.rst.
-- 
2.26.2

