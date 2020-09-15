Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA00E269EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIOGm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgIOGmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:42:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F232EC06174A;
        Mon, 14 Sep 2020 23:42:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y1so1448942pgk.8;
        Mon, 14 Sep 2020 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTeeqsSEnV6Mqefgue2efSOcDigPyshe7Mr8luz0UV4=;
        b=YrO+sKkJVaBWf0hOK0L4xzYYi/qKc/fT5RpsQe3db+U3CDvpDLMdQwzBwG87IuFRRL
         rlN7HqDP5BkEW9orgufjJyFiXgvYi8JMXUtoIBxzJpCZ9xuAOa+mxgGMWL7H5EDGCafQ
         DccTfIKeZCeOxZ3li6PhYJaSeae8bqz8boNEuo5v92+7OUFIedHkdsh2FWsoy/27F5HV
         V9t7CDFA2P2lXCYZhRmOSOHL7HS3fTo8L4Txllg9UmXIpiZGDF1j+QoCbDqnD4hJgCx6
         GxfuaBu2qda9OMDOy/0/xW4pfzIVLUbJ1Dr0vkAM5PP1ej4Peas+gZIvHCEc2IDa9uWc
         pseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTeeqsSEnV6Mqefgue2efSOcDigPyshe7Mr8luz0UV4=;
        b=nSE3AXqrbWT4iHMaHeQYZTELdeYDsAtaOx2r4W8wD9N9QZIPRDfz2FZPtkdBXc1XM9
         ooM6IuZpLSYZhn18t77l2UsLdkjFwyamh+JBup3Rjb727yS9kSGL4DxlilSihuPr7ejX
         JvW6R1QTY6t77rcXQ8jyLV5a6S6XW7kuV0BY3RITJJmVtyGNWGKJvRJrVtqI1Ll3RiEj
         /zj3yWlIN5FQdPg4XatWu1/Ni2PiHMQL9ZjxsfTj0pZHmy1BjgyKgyf99/1DjmbNKnQi
         lGJsXt2/U34w4y06HbWYlC2LYQGzBb06ZmyTuChdFB/SHsgsK2fGTki/kB4mSbDzIpS7
         ttWQ==
X-Gm-Message-State: AOAM53131didUdXMCveQYySdrmlz7wvKxUJpYyoUQGISVCsgxyaUR/N1
        Slh/I/Lq4lSZS1tjm1XNznA=
X-Google-Smtp-Source: ABdhPJwHlEuoOjQnq1KVLdIKD5uuJ01xg+aSHRGA9r10oCtFGxgkyVEydIi+Fzw366Ak6Jvv0TA7uA==
X-Received: by 2002:a62:bd05:0:b029:142:2501:3a02 with SMTP id a5-20020a62bd050000b029014225013a02mr533146pff.81.1600152144513;
        Mon, 14 Sep 2020 23:42:24 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id q5sm12457711pfn.172.2020.09.14.23.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:42:23 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH v2] docs: fb: Remove the stale boot option for framebuffer i.e scrollback
Date:   Tue, 15 Sep 2020 12:07:21 +0530
Message-Id: <20200915063721.30065-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

