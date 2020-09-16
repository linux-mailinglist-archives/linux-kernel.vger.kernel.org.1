Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6F726CF9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 01:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgIPX3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgIPX3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:29:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB025C06174A;
        Wed, 16 Sep 2020 16:29:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x18so94555pll.6;
        Wed, 16 Sep 2020 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gr2+Z6+0sWcB3eA6Oq0msSuI3l045Aul53uSbjIFCWI=;
        b=KqEOKR0eVfLEClJv4ZIOvrSkN8i4692LrJH78FGJCx8psGWsdfCqzRz/BRLWGuQw1u
         7phgutPhaRtzzC9Rz/arQTffFj5mipxBGuMATFBq/HycDOyzei5bSs6zS0e7WZp6wECH
         Peq6JrggHqQdnGa2XYMIpAnBs370xTpApbpj32lnKV0WDnJPphYdGfY6LgCFTwIoTPWI
         QJA/KT2rI9dWAWWWzCxqI60F6i0ojB35EUsTPKI0y8B/nIdgRX5O0lD8fbuzvBbAXhN2
         ww4gdLrbyhHWuHSI3nvUM7Fw1vmTjnh6P8g47YxmyNn4azChuuVlDKjZb2SXiCQmS577
         3yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gr2+Z6+0sWcB3eA6Oq0msSuI3l045Aul53uSbjIFCWI=;
        b=G5s+roavtDpcofIRAG8zyunGNf30PXYn5tLd5FzvZ0MTiotk7vrSYCMNcZkVxpoRHf
         yM7iuf5CoMK8+mi2KOc7iV+XanFsog0ORx6KJ3vpuXGhaG+zVmAcVzgN4a5TCdg1E0sg
         2qeyoL/a8rcdqmOl0Gkck3KCPR7yoWCO6k+BSnDHJtMKmxLgpuyVkKrXVYhMphpgVw2S
         waG3R3HuL7tSUInqd3F6GOaF8paMjcUNaOmnBUOT2vkP8M/G5uinG1U0sECncHvRvph3
         P07doDK8Vrbbb92/iM2fPlLFITTUBiTxwndEWeqXvbxv6vfQ2xLzkKhinZku4WZ/pV3e
         5jLw==
X-Gm-Message-State: AOAM532Cb4044N3o5BZGRgtYErdXNuf4OKyNXqXqam+Nttr32ne5aUo+
        hBFaXCh3NWluvC68GIKhgAD16cilr4L+tUgD
X-Google-Smtp-Source: ABdhPJzvF7Rw8WJDhwn8fn1xTmjjIN2MCF5L9Zdustn2vI9cxdVB0g5+ZUSidV2kJc+PVBhJd3RcwA==
X-Received: by 2002:a17:90a:ea08:: with SMTP id w8mr5745987pjy.41.1600298973129;
        Wed, 16 Sep 2020 16:29:33 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id u4sm18379321pfk.166.2020.09.16.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 16:29:32 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v3] docs: fb: Remove framebuffer scrollback boot option
Date:   Thu, 17 Sep 2020 04:31:50 +0530
Message-Id: <20200916230150.14516-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove reference to this option in this document and 
renumbered the sections. This is related to below commits.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)
 

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
This version try to correct the previous errors, proper changelog text, subject
Trying to incorporate Willy's & Greg's suggestions
 
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

