Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50397269CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgIODwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIODwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:52:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B713C06174A;
        Mon, 14 Sep 2020 20:52:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f2so1278918pgd.3;
        Mon, 14 Sep 2020 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJPJN5sO3W+sXjSDyG0vP1cfrrf1nDFvy9NDFxP8BC4=;
        b=Icis/6D+2W0lPj6Y27XJFFduwInr03mL886eub4QPJa6xWHLz/zNVAC6NZTTZDPRPZ
         zmgeXOe2euhuQh6H+TFM47fSaYbH7zraLa0jSa/rKKYeGY8B6hTPkJNcV9D+hT5VFvXL
         zSaBXs8gGMflGlIkCSVroHah32T1v+dnx582sCyet6BSVZsIVzVoZEalkZOP9UlGcm2D
         dAik9ZeFXEX/g+BZ9/u2zvFVQ7WXOPrEa9yPet3Xi8FbT962dlCXK0r7XlERS3Sfri4x
         tLcpR8ipYfB1zW/OiNF8IbNHKCXNDzv0IDCaqwY31O0kb7D5Jw584obcHoSXxXrkJv3E
         HKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJPJN5sO3W+sXjSDyG0vP1cfrrf1nDFvy9NDFxP8BC4=;
        b=gqwGnBXtxnGgbmVMKRdPAjlXHtRWc86AuMcVrNeBj+pVfmuLjVIacwlF2qydKsEC16
         e94bIbHOBjkSNE/FW5kQFrqmKmI7YlovmHwwvn+IlIajIY3mljvtLOFvylEOYLSflicP
         DoVp2FTThHvz1tyctImjPL6FkivLSWOT+tQcLifrhdW1L1isFb9ELlz6mzb0uBdq5cfm
         vjC34IZFeEiDY5eid2ydGmxbsf/FEZCtBdCPpwWfCGUgyrz4VYM7Jruz7NBcZ6xsFrch
         T1JiP7Q1WPKPqLCRoEvNpgZCTZ7IJEhKatRGTYhRU70UUdAU88OE8UNkNp0lCLMBiy8H
         MUgg==
X-Gm-Message-State: AOAM530cWu+qlfbNWcfca1WtpoKRjS590qTxoPrlJ5dpdt3nqtwtX/aI
        SbTy3O+kVSbqHR2NWeIWT+mdICL4K19tzkas
X-Google-Smtp-Source: ABdhPJzJMWewP7giq1Y6D68F6T84VnaUkXL0yd1eQJ4GqiY3WCz/rB0qAXdhE9hvi4au1vAkNmqxRQ==
X-Received: by 2002:a63:441a:: with SMTP id r26mr13460205pga.290.1600141934504;
        Mon, 14 Sep 2020 20:52:14 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id d6sm10690356pjw.0.2020.09.14.20.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:52:13 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs:fb:fbcon.rst:Remove the stale boot option for framebuffer i.e scrollback
Date:   Tue, 15 Sep 2020 09:18:57 +0530
Message-Id: <20200915034857.21384-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the effect of commit hashes: 50145474f6ef4a9c19205b173da6264a644c7489 and
973c096f6a85e5b5f2a295126ba6928d9a6afd45 

fbcon: remove soft scrollback code 

And adjusted the numbering for boot options too.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
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

