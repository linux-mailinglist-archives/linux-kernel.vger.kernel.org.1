Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC33B269ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgIOGrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgIOGrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:47:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD0C06174A;
        Mon, 14 Sep 2020 23:47:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so1362724pff.6;
        Mon, 14 Sep 2020 23:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eF6xQ/TpzV9WKJdKEDSaTeCchDEZ9b+9XEYTAQF3/4=;
        b=KcDpevz8mZ1TEjgCl4Er2ghuKeOF2FAkyXH+O7JbINYSWV8dCk7ngcU9Mqlpspd25D
         PnlQMTY0KAGUsgsAtru8cIaQopkczk7qW6DbVPkTCYBvwcZcuvCImf84PcN53InoyDJQ
         QHhdUFj+yK498/FefnlT3BMRYqf7whlo2ObL7rrKSjBPjkqgybxc4teujpfIhLjy1XiC
         WVX+fZANYphBNP7tHJGH4SnuajLekMIJGuhek2wwXANNl3Jt+SEOLX3k4WrkrNJRVBXq
         V09JLaYvyfIPpr5l/djUvycWQ6ncgqQFgzIAZ4jD7arDiVsHsoq+oZj11OwFKOe2IFG7
         Q53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eF6xQ/TpzV9WKJdKEDSaTeCchDEZ9b+9XEYTAQF3/4=;
        b=S6v/XWqA30EzDgJOZWEfpHBi6Rro+HG3SJ3lKV04+C/VfXjBDAY6q62monOcu9MUXH
         tcI0xflU16LdSv9L/XMbmszzJzpoZJh1kBqeMjXAVRU9X2OlEI9Llc+Kd8HhBEPLu2cg
         MBG0256IpW7V4hyqpOfcsb8V4mX0R7C05LcEmouBM2Hn635worDFeTNRZ73GwvyNCoX9
         j+xyT4i5I47pJ7w9DRfyw2W9HOywPnBux5q/bzD9Vju7Iv1tDyB1qBlV2urO9SHNexV3
         4a5GJlkKTBXkoIOyVgfjhG9ICat/N0Yhe400LBiBsltQ2OP/ii9CiBXXBXwiwujH/wPW
         zGMw==
X-Gm-Message-State: AOAM532Sb6WewrmzG4jLCZc/uOBrTGm4tUKAXMfczlZKkOTPwIWfhVQw
        unlvW8YINb54O2OZPESWFls=
X-Google-Smtp-Source: ABdhPJxyKmnujO7K2rw4X0o+FFJdvzMayMDU9AjTOYAitoPsvsX7ay7rM+Uhq5l4mI2unwCpmEMhKw==
X-Received: by 2002:a63:4746:: with SMTP id w6mr13800260pgk.412.1600152422476;
        Mon, 14 Sep 2020 23:47:02 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id y25sm12218934pfn.71.2020.09.14.23.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:47:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v2] docs: fb: Remove the stale boot option for framebuffer i.e scrollback
Date:   Tue, 15 Sep 2020 12:14:40 +0530
Message-Id: <20200915064440.31813-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the effect of commit hashes: 
50145474f6ef4(fbcon: remove soft scrollback code)
973c096f6a85e(vgacon: remove software scrollback support)

And adjusted the numbering for boot options too.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
This version corrected the previous version's mistake,subject line fix,more
changelog information.
 Documentation/fb/fbcon.rst | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index e57a3d1d085a..328f6980698c 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -87,15 +87,8 @@ C. Boot options
 	Note, not all drivers can handle font with widths not divisible by 8,
 	such as vga16fb.
 
-2. fbcon=scrollback:<value>[k]
 
-	The scrollback buffer is memory that is used to preserve display
-	contents that has already scrolled past your view.  This is accessed
-	by using the Shift-PageUp key combination.  The value 'value' is any
-	integer. It defaults to 32KB.  The 'k' suffix is optional, and will
-	multiply the 'value' by 1024.
-
-3. fbcon=map:<0123>
+2. fbcon=map:<0123>
 
 	This is an interesting option. It tells which driver gets mapped to
 	which console. The value '0123' is a sequence that gets repeated until
@@ -116,7 +109,7 @@ C. Boot options
 	Later on, when you want to map the console the to the framebuffer
 	device, you can use the con2fbmap utility.
 
-4. fbcon=vc:<n1>-<n2>
+3. fbcon=vc:<n1>-<n2>
 
 	This option tells fbcon to take over only a range of consoles as
 	specified by the values 'n1' and 'n2'. The rest of the consoles
@@ -127,7 +120,7 @@ C. Boot options
 	is typically located on the same video card.  Thus, the consoles that
 	are controlled by the VGA console will be garbled.
 
-5. fbcon=rotate:<n>
+4. fbcon=rotate:<n>
 
 	This option changes the orientation angle of the console display. The
 	value 'n' accepts the following:
@@ -152,21 +145,21 @@ C. Boot options
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
 
-6. fbcon=margin:<color>
+5. fbcon=margin:<color>
 
 	This option specifies the color of the margins. The margins are the
 	leftover area at the right and the bottom of the screen that are not
 	used by text. By default, this area will be black. The 'color' value
 	is an integer number that depends on the framebuffer driver being used.
 
-7. fbcon=nodefer
+6. fbcon=nodefer
 
 	If the kernel is compiled with deferred fbcon takeover support, normally
 	the framebuffer contents, left in place by the firmware/bootloader, will
 	be preserved until there actually is some text is output to the console.
 	This option causes fbcon to bind immediately to the fbdev device.
 
-8. fbcon=logo-pos:<location>
+7. fbcon=logo-pos:<location>
 
 	The only possible 'location' is 'center' (without quotes), and when
 	given, the bootup logo is moved from the default top-left corner
@@ -174,7 +167,7 @@ C. Boot options
 	displayed due to multiple CPUs, the collected line of logos is moved
 	as a whole.
 
-9. fbcon=logo-count:<n>
+8. fbcon=logo-count:<n>
 
 	The value 'n' overrides the number of bootup logos. 0 disables the
 	logo, and -1 gives the default which is the number of online CPUs.
-- 
2.26.2

