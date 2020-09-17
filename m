Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6626D919
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIQKc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgIQKcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:32:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F01C06174A;
        Thu, 17 Sep 2020 03:32:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so940879pff.6;
        Thu, 17 Sep 2020 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhMBx9jfoxAPURPNLewxmlx3QPFD3Z6RwgycYRX8SzA=;
        b=Ba22haJT1W7/Vbr74pF3jcOioNIktkbKvuVQxDxVpYb96ELwxDvVCEo4HEKr5U6UmA
         8hRMq4IHqAVxT3tg6qXHLGSIsumkp/AQYnNdqwuY17JLC6E0LZfVNPUaXzVRprRE/jmd
         AI1LHjhRmmjCozzINy84QqczcjPDWhFaMmKLaiNO5cSF7M868tYvDaTfUoCnWBCe/8eO
         wBbdJx6PGvAt2udhwsh7e69E9O3qjMQlWKGt2D2nAx8LU7nj9QXD6lr4q1agFV3r1V3W
         UMhFEao62S1L3A7bKTvJQdloK/UH9r2hqHKK2513nAE+kBI/9IM3JXd/V6Cg6Gd6BePo
         e+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhMBx9jfoxAPURPNLewxmlx3QPFD3Z6RwgycYRX8SzA=;
        b=fWId4u18f1Z5y8J5DxW0Jqn2KYwgbFkuDTjrF0cWDgYiHb5XCJxSWcOj31yFyGpH1Q
         7cykqTXCCoGYrRcOOR5kSVzxSCNqYAB4w06uQg2vVP6vtfRDOR0wscnY86wIxfw8lzeh
         3qxHy0c+enU+IbBE8J/4WkBXXIkRk/2AnJai2CYCsCwRdXmeb7N8CHWGhNhorfd4lnZr
         J243Q93y0SnXDi8o6/bt5Mr++MGEwMZWF73wE6ebrXQ3mKRWNjWwRP0NaDy4mNljyY9g
         34p22hPBYz3A3qrJMBJKrvhqraZfHBJRH7k/YCLcfZSEwNFbF2WQjZFJ+d0gdOaypF39
         Ytaw==
X-Gm-Message-State: AOAM533qJioPpltvh1KLhC7eMnD9uCxA0LV/GPdCieggJ76A4b0j1TvW
        uSak86d2vS6jwAMfGzAuH6k=
X-Google-Smtp-Source: ABdhPJyILRrKSTtQ1bgab2pT7I7zRj/xWS7oe1tVWEPuGz5B1EWveHzNjpkl++qiG6zsKdZ5EIdhSA==
X-Received: by 2002:a63:3246:: with SMTP id y67mr4802140pgy.410.1600338721162;
        Thu, 17 Sep 2020 03:32:01 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id e207sm21781927pfh.171.2020.09.17.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:32:00 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 1/4] docs: fb: Remove framebuffer scrollback boot option
Date:   Thu, 17 Sep 2020 15:56:12 +0530
Message-Id: <436cc046a8ff9cf2a467b633527db77dc7c7de19.1600333774.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1600333774.git.unixbhaskar@gmail.com>
References: <cover.1600333774.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer present, and update the section numbering because of the
removal.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Change since V3:
Following the suggestions from Willy and Greg.In this version remove the not 
relevant commit hash and messages from the changelog. 
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
2.28.0

