Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF626B14D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgIOW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgIOW2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 18:28:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8FC06174A;
        Tue, 15 Sep 2020 15:27:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id v14so499285pjd.4;
        Tue, 15 Sep 2020 15:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqPwY8D5/2Rw/0M6IfuCI4L/UKIJJbUOuXp1DTvLlRA=;
        b=BkzjLz5kiB/xuGCmoqqZxpS2LzVFv1Ex8tWMw9Gz3y3tcX9m21lRC8umgl3+FT7tra
         wJplU2JBCidttN5t2XZEhDzFtBvAe0gGMeHhk0bxket7A5Z6DqlqGHh3+PI+8s3bHRv/
         fTtOZJLDkc2B8BTdgCpLLHrIsn5bjYqeBeK/he1gyUUXkXjBMq1fVupqvjFoA9UJ3WXJ
         M9krBtcHhd3NqtiLIkwsM5+MWra38TEUzQJfnbC9F7oTwSpuQi5uGcZqSKk28GtyMepo
         6PYLgbjEtBnNZHDDnZI/8R4lSDTr3gEBr9EJeSrtynU0XWFn87oLzy3UiEVx7dExycjZ
         tGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqPwY8D5/2Rw/0M6IfuCI4L/UKIJJbUOuXp1DTvLlRA=;
        b=hDuvEM7KY1gtm5Ni4zzwVgDtK62u3Zl9WfIrjia2YN5Gn38ZfdjrAdz+HDvXoyF7SV
         PNCGyofJN8L2TmW8y6wVx6DP4+fRLvNFNaZsmuQswV1v4NZ5569b0eVrzlJkU1E4lxbD
         gxBHH5xZu7kJ6XG/UiPpi9xJkUQUVA8u8BHuQ+52Jy7/Ypid1cLrVvbpLRf34e+1mz8Z
         HZxNCjlSB5+W+RFtuPjBQ3mcao/H8YNjGH9p3tIVhzx4rtHy+JE0mmPybLR8T7YfI/nu
         QzgxFbP4lf1IDIH0AH2KgjtByTxlM9bdwi05QNVaDtcHJJJktUw5OTyFiq3igj/lfz62
         GTIw==
X-Gm-Message-State: AOAM533bA2rFnGsiquHGnsFVWC+PuqpBMll0zICCFL/xYyeatdyewe5/
        7fDsOfNDPN74UoShEFryHp8=
X-Google-Smtp-Source: ABdhPJyYpoBwd236OANinSrbO3oKUuVxCwfV5vxtAk5hZv5ChrdZt+X9Z3WxHzAR9HbgvAXYo7UtFQ==
X-Received: by 2002:a17:902:7:b029:d1:e5e7:be08 with SMTP id 7-20020a1709020007b02900d1e5e7be08mr3702095pla.59.1600208877626;
        Tue, 15 Sep 2020 15:27:57 -0700 (PDT)
Received: from localhost.localdomain (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id y6sm472038pji.1.2020.09.15.15.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 15:27:56 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org, gregkh@linuxfoundation.org,
        daniel@ffwll.ch, yuanmingbuaa@gmail.com, w@1wt.eu,
        nopitydays@gmail.com, zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] docs: fb: Remove framebuffer scrollback option for boot
Date:   Wed, 16 Sep 2020 03:55:11 +0530
Message-Id: <20200915222511.17140-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch remove the scrollback option under boot options.
Plus readjust the numbers for the options in that section.

Commit 973c096f6a85(vgacon: remove software scrollback support)
Commit 50145474f6ef(fbcon: remove soft scrollback code)

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

