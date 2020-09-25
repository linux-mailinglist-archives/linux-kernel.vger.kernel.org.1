Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7999279060
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 20:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgIYSb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 14:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgIYSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 14:31:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E16C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:31:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn7so2140120pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Y5RxXp0iaV5YzPgj8bZQ+BGveh8M95rtiqfjTgddEs=;
        b=IZ2FVDZvDeO99Hv8BHXMix/EiP0XjTzYu7waGOeZWFpovdc2elAqbSTMTbJgFXuDwP
         czKObHAsqhSpHX2OlaUjqsCjJWxCpNTWPKnd+OKrXFRT1MS2xrR1ckmZHgm9d7FY5vdF
         qGyz0BNTXNbuzpAKHGlME7vqn5lwt7lmQZFXJlwrtNEvDZlzWGtUBI5CV6ZSS+1L1CCK
         +5ZGdggPA04BYt0kyMXgQYdCphdSDloBSh/wxCcqia8FMIUIEDbmypxHo0ISmMmtaJqV
         N8T91TtmwfSC37x/SCmx48Gpy9r9OZSpAxn+zWeGE3+bfxtL6pWfrSBcS4Z9y5zGALVJ
         hZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Y5RxXp0iaV5YzPgj8bZQ+BGveh8M95rtiqfjTgddEs=;
        b=iByoqZ4Hj0+2sRbNKy20VFzOi/DM0B1bJIiux6CQVo0n2oyga+1w2hfd9Ekrwr5EKO
         ziUgM1T2iNheMRLsUHoPPaR59z9JLp3P/20gDdv4ckfHkvqDcH+5ID1sRbdR3h2Q+Tf7
         DT884tgvR+TrzGm3SkbZFEVwOty8ZZjqcGd3/x21dnlXdYv5OLr5yjxWuuuTD2HS0Ni/
         151oRp+Bx6C/aNrHy2DLtlQxIqiMKaKt3HL0UKyqV6UaSTiMDPB629KoCJZ0CoGvHUR0
         T283a6fi0mA2fkHyAd+AYFyfirW05kwQslugJjBSdokW1jRJgzromh/0QLeME7X+54Kz
         xlUg==
X-Gm-Message-State: AOAM530M7aW5ncTGfo0zPynO7Cf4Y2OoCkcOVicNu9ljQPJhse2eAZei
        qU7ptq7qkC7nu2sbwmgyNUSeoQ==
X-Google-Smtp-Source: ABdhPJwItDZKuOc6gZncOey8m9ivCtJWoxn1tzczA/NO7gOpUtIPN5FyFH4Tx41K+pAF8tsB3QfN+Q==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr804928pjv.108.1601058683636;
        Fri, 25 Sep 2020 11:31:23 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id r16sm2554546pjo.19.2020.09.25.11.31.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 11:31:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC v2 01/47] staging: media: Revert "media: zoran: remove deprecated driver"
Date:   Fri, 25 Sep 2020 18:30:11 +0000
Message-Id: <1601058657-14042-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
References: <1601058657-14042-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8dce4b265a5357731058f69645840dabc718c687.
The revert is slighly modified:
- Documentation/media/v4l-drivers/index.rst is ,ot restored since removed from tree
- drivers/staging/media/Makefile is not restored since the zoran driver
  is not compilable yet.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/media/v4l-drivers/zoran.rst  |  583 ++++
 drivers/staging/media/Kconfig              |    2 +
 drivers/staging/media/zoran/Kconfig        |   75 +
 drivers/staging/media/zoran/Makefile       |    7 +
 drivers/staging/media/zoran/TODO           |    4 +
 drivers/staging/media/zoran/videocodec.c   |  391 +++
 drivers/staging/media/zoran/videocodec.h   |  349 +++
 drivers/staging/media/zoran/zoran.h        |  402 +++
 drivers/staging/media/zoran/zoran_card.c   | 1524 +++++++++++
 drivers/staging/media/zoran/zoran_card.h   |   50 +
 drivers/staging/media/zoran/zoran_device.c | 1619 +++++++++++
 drivers/staging/media/zoran/zoran_device.h |   91 +
 drivers/staging/media/zoran/zoran_driver.c | 2850 ++++++++++++++++++++
 drivers/staging/media/zoran/zoran_procfs.c |  221 ++
 drivers/staging/media/zoran/zoran_procfs.h |   32 +
 drivers/staging/media/zoran/zr36016.c      |  516 ++++
 drivers/staging/media/zoran/zr36016.h      |  107 +
 drivers/staging/media/zoran/zr36050.c      |  896 ++++++
 drivers/staging/media/zoran/zr36050.h      |  179 ++
 drivers/staging/media/zoran/zr36057.h      |  164 ++
 drivers/staging/media/zoran/zr36060.c      | 1006 +++++++
 drivers/staging/media/zoran/zr36060.h      |  216 ++
 22 files changed, 11284 insertions(+)
 create mode 100644 Documentation/media/v4l-drivers/zoran.rst
 create mode 100644 drivers/staging/media/zoran/Kconfig
 create mode 100644 drivers/staging/media/zoran/Makefile
 create mode 100644 drivers/staging/media/zoran/TODO
 create mode 100644 drivers/staging/media/zoran/videocodec.c
 create mode 100644 drivers/staging/media/zoran/videocodec.h
 create mode 100644 drivers/staging/media/zoran/zoran.h
 create mode 100644 drivers/staging/media/zoran/zoran_card.c
 create mode 100644 drivers/staging/media/zoran/zoran_card.h
 create mode 100644 drivers/staging/media/zoran/zoran_device.c
 create mode 100644 drivers/staging/media/zoran/zoran_device.h
 create mode 100644 drivers/staging/media/zoran/zoran_driver.c
 create mode 100644 drivers/staging/media/zoran/zoran_procfs.c
 create mode 100644 drivers/staging/media/zoran/zoran_procfs.h
 create mode 100644 drivers/staging/media/zoran/zr36016.c
 create mode 100644 drivers/staging/media/zoran/zr36016.h
 create mode 100644 drivers/staging/media/zoran/zr36050.c
 create mode 100644 drivers/staging/media/zoran/zr36050.h
 create mode 100644 drivers/staging/media/zoran/zr36057.h
 create mode 100644 drivers/staging/media/zoran/zr36060.c
 create mode 100644 drivers/staging/media/zoran/zr36060.h

diff --git a/Documentation/media/v4l-drivers/zoran.rst b/Documentation/media/v4l-drivers/zoran.rst
new file mode 100644
index 000000000000..d2724a863d1d
--- /dev/null
+++ b/Documentation/media/v4l-drivers/zoran.rst
@@ -0,0 +1,583 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+The Zoran driver
+================
+
+unified zoran driver (zr360x7, zoran, buz, dc10(+), dc30(+), lml33)
+
+website: http://mjpeg.sourceforge.net/driver-zoran/
+
+
+Frequently Asked Questions
+--------------------------
+
+What cards are supported
+------------------------
+
+Iomega Buz, Linux Media Labs LML33/LML33R10, Pinnacle/Miro
+DC10/DC10+/DC30/DC30+ and related boards (available under various names).
+
+Iomega Buz
+~~~~~~~~~~
+
+* Zoran zr36067 PCI controller
+* Zoran zr36060 MJPEG codec
+* Philips saa7111 TV decoder
+* Philips saa7185 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, saa7111, saa7185, zr36060, zr36067
+
+Inputs/outputs: Composite and S-video
+
+Norms: PAL, SECAM (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
+
+Card number: 7
+
+AverMedia 6 Eyes AVS6EYES
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36067 PCI controller
+* Zoran zr36060 MJPEG codec
+* Samsung ks0127 TV decoder
+* Conexant bt866  TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, ks0127, bt866, zr36060, zr36067
+
+Inputs/outputs:
+	Six physical inputs. 1-6 are composite,
+	1-2, 3-4, 5-6 doubles as S-video,
+	1-3 triples as component.
+	One composite output.
+
+Norms: PAL, SECAM (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
+
+Card number: 8
+
+.. note::
+
+   Not autodetected, card=8 is necessary.
+
+Linux Media Labs LML33
+~~~~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36067 PCI controller
+* Zoran zr36060 MJPEG codec
+* Brooktree bt819 TV decoder
+* Brooktree bt856 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, bt819, bt856, zr36060, zr36067
+
+Inputs/outputs: Composite and S-video
+
+Norms: PAL (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
+
+Card number: 5
+
+Linux Media Labs LML33R10
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36067 PCI controller
+* Zoran zr36060 MJPEG codec
+* Philips saa7114 TV decoder
+* Analog Devices adv7170 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, saa7114, adv7170, zr36060, zr36067
+
+Inputs/outputs: Composite and S-video
+
+Norms: PAL (720x576 @ 25 fps), NTSC (720x480 @ 29.97 fps)
+
+Card number: 6
+
+Pinnacle/Miro DC10(new)
+~~~~~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36057 PCI controller
+* Zoran zr36060 MJPEG codec
+* Philips saa7110a TV decoder
+* Analog Devices adv7176 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, saa7110, adv7175, zr36060, zr36067
+
+Inputs/outputs: Composite, S-video and Internal
+
+Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
+
+Card number: 1
+
+Pinnacle/Miro DC10+
+~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36067 PCI controller
+* Zoran zr36060 MJPEG codec
+* Philips saa7110a TV decoder
+* Analog Devices adv7176 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, sa7110, adv7175, zr36060, zr36067
+
+Inputs/outputs: Composite, S-video and Internal
+
+Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
+
+Card number: 2
+
+Pinnacle/Miro DC10(old)
+~~~~~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36057 PCI controller
+* Zoran zr36050 MJPEG codec
+* Zoran zr36016 Video Front End or Fuji md0211 Video Front End (clone?)
+* Micronas vpx3220a TV decoder
+* mse3000 TV encoder or Analog Devices adv7176 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, vpx3220, mse3000/adv7175, zr36050, zr36016, zr36067
+
+Inputs/outputs: Composite, S-video and Internal
+
+Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
+
+Card number: 0
+
+Pinnacle/Miro DC30
+~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36057 PCI controller
+* Zoran zr36050 MJPEG codec
+* Zoran zr36016 Video Front End
+* Micronas vpx3225d/vpx3220a/vpx3216b TV decoder
+* Analog Devices adv7176 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, vpx3220/vpx3224, adv7175, zr36050, zr36016, zr36067
+
+Inputs/outputs: Composite, S-video and Internal
+
+Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
+
+Card number: 3
+
+Pinnacle/Miro DC30+
+~~~~~~~~~~~~~~~~~~~
+
+* Zoran zr36067 PCI controller
+* Zoran zr36050 MJPEG codec
+* Zoran zr36016 Video Front End
+* Micronas vpx3225d/vpx3220a/vpx3216b TV decoder
+* Analog Devices adv7176 TV encoder
+
+Drivers to use: videodev, i2c-core, i2c-algo-bit,
+videocodec, vpx3220/vpx3224, adv7175, zr36050, zr36015, zr36067
+
+Inputs/outputs: Composite, S-video and Internal
+
+Norms: PAL, SECAM (768x576 @ 25 fps), NTSC (640x480 @ 29.97 fps)
+
+Card number: 4
+
+.. note::
+
+   #) No module for the mse3000 is available yet
+   #) No module for the vpx3224 is available yet
+
+1.1 What the TV decoder can do an what not
+------------------------------------------
+
+The best know TV standards are NTSC/PAL/SECAM. but for decoding a frame that
+information is not enough. There are several formats of the TV standards.
+And not every TV decoder is able to handle every format. Also the every
+combination is supported by the driver. There are currently 11 different
+tv broadcast formats all aver the world.
+
+The CCIR defines parameters needed for broadcasting the signal.
+The CCIR has defined different standards: A,B,D,E,F,G,D,H,I,K,K1,L,M,N,...
+The CCIR says not much about the colorsystem used !!!
+And talking about a colorsystem says not to much about how it is broadcast.
+
+The CCIR standards A,E,F are not used any more.
+
+When you speak about NTSC, you usually mean the standard: CCIR - M using
+the NTSC colorsystem which is used in the USA, Japan, Mexico, Canada
+and a few others.
+
+When you talk about PAL, you usually mean: CCIR - B/G using the PAL
+colorsystem which is used in many Countries.
+
+When you talk about SECAM, you mean: CCIR - L using the SECAM Colorsystem
+which is used in France, and a few others.
+
+There the other version of SECAM, CCIR - D/K is used in Bulgaria, China,
+Slovakai, Hungary, Korea (Rep.), Poland, Rumania and a others.
+
+The CCIR - H uses the PAL colorsystem (sometimes SECAM) and is used in
+Egypt, Libya, Sri Lanka, Syrain Arab. Rep.
+
+The CCIR - I uses the PAL colorsystem, and is used in Great Britain, Hong Kong,
+Ireland, Nigeria, South Africa.
+
+The CCIR - N uses the PAL colorsystem and PAL frame size but the NTSC framerate,
+and is used in Argentinia, Uruguay, an a few others
+
+We do not talk about how the audio is broadcast !
+
+A rather good sites about the TV standards are:
+http://www.sony.jp/support/
+http://info.electronicwerkstatt.de/bereiche/fernsehtechnik/frequenzen_und_normen/Fernsehnormen/
+and http://www.cabl.com/restaurant/channel.html
+
+Other weird things around: NTSC 4.43 is a modificated NTSC, which is mainly
+used in PAL VCR's that are able to play back NTSC. PAL 60 seems to be the same
+as NTSC 4.43 . The Datasheets also talk about NTSC 44, It seems as if it would
+be the same as NTSC 4.43.
+NTSC Combs seems to be a decoder mode where the decoder uses a comb filter
+to split coma and luma instead of a Delay line.
+
+But I did not defiantly find out what NTSC Comb is.
+
+Philips saa7111 TV decoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1997, is used in the BUZ and
+- can handle: PAL B/G/H/I, PAL N, PAL M, NTSC M, NTSC N, NTSC 4.43 and SECAM
+
+Philips saa7110a TV decoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1995, is used in the Pinnacle/Miro DC10(new), DC10+ and
+- can handle: PAL B/G, NTSC M and SECAM
+
+Philips saa7114 TV decoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 2000, is used in the LML33R10 and
+- can handle: PAL B/G/D/H/I/N, PAL N, PAL M, NTSC M, NTSC 4.43 and SECAM
+
+Brooktree bt819 TV decoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1996, and is used in the LML33 and
+- can handle: PAL B/D/G/H/I, NTSC M
+
+Micronas vpx3220a TV decoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1996, is used in the DC30 and DC30+ and
+- can handle: PAL B/G/H/I, PAL N, PAL M, NTSC M, NTSC 44, PAL 60, SECAM,NTSC Comb
+
+Samsung ks0127 TV decoder
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- is used in the AVS6EYES card and
+- can handle: NTSC-M/N/44, PAL-M/N/B/G/H/I/D/K/L and SECAM
+
+
+What the TV encoder can do an what not
+--------------------------------------
+
+The TV encoder are doing the "same" as the decoder, but in the oder direction.
+You feed them digital data and the generate a Composite or SVHS signal.
+For information about the colorsystems and TV norm take a look in the
+TV decoder section.
+
+Philips saa7185 TV Encoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1996, is used in the BUZ
+- can generate: PAL B/G, NTSC M
+
+Brooktree bt856 TV Encoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1994, is used in the LML33
+- can generate: PAL B/D/G/H/I/N, PAL M, NTSC M, PAL-N (Argentina)
+
+Analog Devices adv7170 TV Encoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 2000, is used in the LML300R10
+- can generate: PAL B/D/G/H/I/N, PAL M, NTSC M, PAL 60
+
+Analog Devices adv7175 TV Encoder
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1996, is used in the DC10, DC10+, DC10 old, DC30, DC30+
+- can generate: PAL B/D/G/H/I/N, PAL M, NTSC M
+
+ITT mse3000 TV encoder
+~~~~~~~~~~~~~~~~~~~~~~
+
+- was introduced in 1991, is used in the DC10 old
+- can generate: PAL , NTSC , SECAM
+
+Conexant bt866 TV encoder
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- is used in AVS6EYES, and
+- can generate: NTSC/PAL, PAL­M, PAL­N
+
+The adv717x, should be able to produce PAL N. But you find nothing PAL N
+specific in the registers. Seem that you have to reuse a other standard
+to generate PAL N, maybe it would work if you use the PAL M settings.
+
+How do I get this damn thing to work
+------------------------------------
+
+Load zr36067.o. If it can't autodetect your card, use the card=X insmod
+option with X being the card number as given in the previous section.
+To have more than one card, use card=X1[,X2[,X3,[X4[..]]]]
+
+To automate this, add the following to your /etc/modprobe.d/zoran.conf:
+
+options zr36067 card=X1[,X2[,X3[,X4[..]]]]
+alias char-major-81-0 zr36067
+
+One thing to keep in mind is that this doesn't load zr36067.o itself yet. It
+just automates loading. If you start using xawtv, the device won't load on
+some systems, since you're trying to load modules as a user, which is not
+allowed ("permission denied"). A quick workaround is to add 'Load "v4l"' to
+XF86Config-4 when you use X by default, or to run 'v4l-conf -c <device>' in
+one of your startup scripts (normally rc.local) if you don't use X. Both
+make sure that the modules are loaded on startup, under the root account.
+
+What mainboard should I use (or why doesn't my card work)
+---------------------------------------------------------
+
+
+<insert lousy disclaimer here>. In short: good=SiS/Intel, bad=VIA.
+
+Experience tells us that people with a Buz, on average, have more problems
+than users with a DC10+/LML33. Also, it tells us that people owning a VIA-
+based mainboard (ktXXX, MVP3) have more problems than users with a mainboard
+based on a different chipset. Here's some notes from Andrew Stevens:
+
+Here's my experience of using LML33 and Buz on various motherboards:
+
+- VIA MVP3
+	- Forget it. Pointless. Doesn't work.
+- Intel 430FX (Pentium 200)
+	- LML33 perfect, Buz tolerable (3 or 4 frames dropped per movie)
+- Intel 440BX (early stepping)
+	- LML33 tolerable. Buz starting to get annoying (6-10 frames/hour)
+- Intel 440BX (late stepping)
+	- Buz tolerable, LML3 almost perfect (occasional single frame drops)
+- SiS735
+	- LML33 perfect, Buz tolerable.
+- VIA KT133(*)
+	- LML33 starting to get annoying, Buz poor enough that I have up.
+
+- Both 440BX boards were dual CPU versions.
+
+Bernhard Praschinger later added:
+
+- AMD 751
+	- Buz perfect-tolerable
+- AMD 760
+	- Buz perfect-tolerable
+
+In general, people on the user mailinglist won't give you much of a chance
+if you have a VIA-based motherboard. They may be cheap, but sometimes, you'd
+rather want to spend some more money on better boards. In general, VIA
+mainboard's IDE/PCI performance will also suck badly compared to others.
+You'll noticed the DC10+/DC30+ aren't mentioned anywhere in the overview.
+Basically, you can assume that if the Buz works, the LML33 will work too. If
+the LML33 works, the DC10+/DC30+ will work too. They're most tolerant to
+different mainboard chipsets from all of the supported cards.
+
+If you experience timeouts during capture, buy a better mainboard or lower
+the quality/buffersize during capture (see 'Concerning buffer sizes, quality,
+output size etc.'). If it hangs, there's little we can do as of now. Check
+your IRQs and make sure the card has its own interrupts.
+
+Programming interface
+---------------------
+
+This driver conforms to video4linux2. Support for V4L1 and for the custom
+zoran ioctls has been removed in kernel 2.6.38.
+
+For programming example, please, look at lavrec.c and lavplay.c code in
+the MJPEG-tools (http://mjpeg.sf.net/).
+
+Additional notes for software developers:
+
+   The driver returns maxwidth and maxheight parameters according to
+   the current TV standard (norm). Therefore, the software which
+   communicates with the driver and "asks" for these parameters should
+   first set the correct norm. Well, it seems logically correct: TV
+   standard is "more constant" for current country than geometry
+   settings of a variety of TV capture cards which may work in ITU or
+   square pixel format.
+
+Applications
+------------
+
+Applications known to work with this driver:
+
+TV viewing:
+
+* xawtv
+* kwintv
+* probably any TV application that supports video4linux or video4linux2.
+
+MJPEG capture/playback:
+
+* mjpegtools/lavtools (or Linux Video Studio)
+* gstreamer
+* mplayer
+
+General raw capture:
+
+* xawtv
+* gstreamer
+* probably any application that supports video4linux or video4linux2
+
+Video editing:
+
+* Cinelerra
+* MainActor
+* mjpegtools (or Linux Video Studio)
+
+
+Concerning buffer sizes, quality, output size etc.
+--------------------------------------------------
+
+
+The zr36060 can do 1:2 JPEG compression. This is really the theoretical
+maximum that the chipset can reach. The driver can, however, limit compression
+to a maximum (size) of 1:4. The reason for this is that some cards (e.g. Buz)
+can't handle 1:2 compression without stopping capture after only a few minutes.
+With 1:4, it'll mostly work. If you have a Buz, use 'low_bitrate=1' to go into
+1:4 max. compression mode.
+
+100% JPEG quality is thus 1:2 compression in practice. So for a full PAL frame
+(size 720x576). The JPEG fields are stored in YUY2 format, so the size of the
+fields are 720x288x16/2 bits/field (2 fields/frame) = 207360 bytes/field x 2 =
+414720 bytes/frame (add some more bytes for headers and DHT (huffman)/DQT
+(quantization) tables, and you'll get to something like 512kB per frame for
+1:2 compression. For 1:4 compression, you'd have frames of half this size.
+
+Some additional explanation by Martin Samuelsson, which also explains the
+importance of buffer sizes:
+--
+> Hmm, I do not think it is really that way. With the current (downloaded
+> at 18:00 Monday) driver I get that output sizes for 10 sec:
+> -q 50 -b 128 : 24.283.332 Bytes
+> -q 50 -b 256 : 48.442.368
+> -q 25 -b 128 : 24.655.992
+> -q 25 -b 256 : 25.859.820
+
+I woke up, and can't go to sleep again. I'll kill some time explaining why
+this doesn't look strange to me.
+
+Let's do some math using a width of 704 pixels. I'm not sure whether the Buz
+actually use that number or not, but that's not too important right now.
+
+704x288 pixels, one field, is 202752 pixels. Divided by 64 pixels per block;
+3168 blocks per field. Each pixel consist of two bytes; 128 bytes per block;
+1024 bits per block. 100% in the new driver mean 1:2 compression; the maximum
+output becomes 512 bits per block. Actually 510, but 512 is simpler to use
+for calculations.
+
+Let's say that we specify d1q50. We thus want 256 bits per block; times 3168
+becomes 811008 bits; 101376 bytes per field. We're talking raw bits and bytes
+here, so we don't need to do any fancy corrections for bits-per-pixel or such
+things. 101376 bytes per field.
+
+d1 video contains two fields per frame. Those sum up to 202752 bytes per
+frame, and one of those frames goes into each buffer.
+
+But wait a second! -b128 gives 128kB buffers! It's not possible to cram
+202752 bytes of JPEG data into 128kB!
+
+This is what the driver notice and automatically compensate for in your
+examples. Let's do some math using this information:
+
+128kB is 131072 bytes. In this buffer, we want to store two fields, which
+leaves 65536 bytes for each field. Using 3168 blocks per field, we get
+20.68686868... available bytes per block; 165 bits. We can't allow the
+request for 256 bits per block when there's only 165 bits available! The -q50
+option is silently overridden, and the -b128 option takes precedence, leaving
+us with the equivalence of -q32.
+
+This gives us a data rate of 165 bits per block, which, times 3168, sums up
+to 65340 bytes per field, out of the allowed 65536. The current driver has
+another level of rate limiting; it won't accept -q values that fill more than
+6/8 of the specified buffers. (I'm not sure why. "Playing it safe" seem to be
+a safe bet. Personally, I think I would have lowered requested-bits-per-block
+by one, or something like that.) We can't use 165 bits per block, but have to
+lower it again, to 6/8 of the available buffer space: We end up with 124 bits
+per block, the equivalence of -q24. With 128kB buffers, you can't use greater
+than -q24 at -d1. (And PAL, and 704 pixels width...)
+
+The third example is limited to -q24 through the same process. The second
+example, using very similar calculations, is limited to -q48. The only
+example that actually grab at the specified -q value is the last one, which
+is clearly visible, looking at the file size.
+--
+
+Conclusion: the quality of the resulting movie depends on buffer size, quality,
+whether or not you use 'low_bitrate=1' as insmod option for the zr36060.c
+module to do 1:4 instead of 1:2 compression, etc.
+
+If you experience timeouts, lowering the quality/buffersize or using
+'low_bitrate=1 as insmod option for zr36060.o might actually help, as is
+proven by the Buz.
+
+It hangs/crashes/fails/whatevers! Help!
+---------------------------------------
+
+Make sure that the card has its own interrupts (see /proc/interrupts), check
+the output of dmesg at high verbosity (load zr36067.o with debug=2,
+load all other modules with debug=1). Check that your mainboard is favorable
+(see question 2) and if not, test the card in another computer. Also see the
+notes given in question 3 and try lowering quality/buffersize/capturesize
+if recording fails after a period of time.
+
+If all this doesn't help, give a clear description of the problem including
+detailed hardware information (memory+brand, mainboard+chipset+brand, which
+MJPEG card, processor, other PCI cards that might be of interest), give the
+system PnP information (/proc/interrupts, /proc/dma, /proc/devices), and give
+the kernel version, driver version, glibc version, gcc version and any other
+information that might possibly be of interest. Also provide the dmesg output
+at high verbosity. See 'Contacting' on how to contact the developers.
+
+Maintainers/Contacting
+----------------------
+
+The driver is currently maintained by Laurent Pinchart and Ronald Bultje
+(<laurent.pinchart@skynet.be> and <rbultje@ronald.bitfreak.net>). For bug
+reports or questions, please contact the mailinglist instead of the developers
+individually. For user questions (i.e. bug reports or how-to questions), send
+an email to <mjpeg-users@lists.sf.net>, for developers (i.e. if you want to
+help programming), send an email to <mjpeg-developer@lists.sf.net>. See
+http://www.sf.net/projects/mjpeg/ for subscription information.
+
+For bug reports, be sure to include all the information as described in
+the section 'It hangs/crashes/fails/whatevers! Help!'. Please make sure
+you're using the latest version (http://mjpeg.sf.net/driver-zoran/).
+
+Previous maintainers/developers of this driver include Serguei Miridonov
+<mirsev@cicese.mx>, Wolfgang Scherr <scherr@net4you.net>, Dave Perks
+<dperks@ibm.net> and Rainer Johanni <Rainer@Johanni.de>.
+
+Driver's License
+----------------
+
+    This driver is distributed under the terms of the General Public License.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+See http://www.gnu.org/ for more information.
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index 5d33d5d9881e..0f9d159a1477 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -38,6 +38,8 @@ source "drivers/staging/media/sunxi/Kconfig"
 
 source "drivers/staging/media/tegra-vde/Kconfig"
 
+source "drivers/staging/media/zoran/Kconfig"
+
 source "drivers/staging/media/tegra-video/Kconfig"
 
 source "drivers/staging/media/ipu3/Kconfig"
diff --git a/drivers/staging/media/zoran/Kconfig b/drivers/staging/media/zoran/Kconfig
new file mode 100644
index 000000000000..34a18135ede0
--- /dev/null
+++ b/drivers/staging/media/zoran/Kconfig
@@ -0,0 +1,75 @@
+config VIDEO_ZORAN
+	tristate "Zoran ZR36057/36067 Video For Linux (Deprecated)"
+	depends on PCI && I2C_ALGOBIT && VIDEO_V4L2 && VIRT_TO_BUS
+	depends on !ALPHA
+	help
+	  Say Y for support for MJPEG capture cards based on the Zoran
+	  36057/36067 PCI controller chipset. This includes the Iomega
+	  Buz, Pinnacle DC10+ and the Linux Media Labs LML33. There is
+	  a driver homepage at <http://mjpeg.sf.net/driver-zoran/>. For
+	  more information, check <file:Documentation/media/v4l-drivers/zoran.rst>.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zr36067.
+
+config VIDEO_ZORAN_DC30
+	tristate "Pinnacle/Miro DC30(+) support"
+	depends on VIDEO_ZORAN
+	select VIDEO_ADV7175 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_VPX3220 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for the Pinnacle/Miro DC30(+) MJPEG capture/playback
+	  card. This also supports really old DC10 cards based on the
+	  zr36050 MJPEG codec and zr36016 VFE.
+
+config VIDEO_ZORAN_ZR36060
+	tristate "Zoran ZR36060"
+	depends on VIDEO_ZORAN
+	help
+	  Say Y to support Zoran boards based on 36060 chips.
+	  This includes Iomega Buz, Pinnacle DC10, Linux media Labs 33
+	  and 33 R10 and AverMedia 6 boards.
+
+config VIDEO_ZORAN_BUZ
+	tristate "Iomega Buz support"
+	depends on VIDEO_ZORAN_ZR36060
+	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_SAA7185 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for the Iomega Buz MJPEG capture/playback card.
+
+config VIDEO_ZORAN_DC10
+	tristate "Pinnacle/Miro DC10(+) support"
+	depends on VIDEO_ZORAN_ZR36060
+	select VIDEO_SAA7110 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_ADV7175 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for the Pinnacle/Miro DC10(+) MJPEG capture/playback
+	  card.
+
+config VIDEO_ZORAN_LML33
+	tristate "Linux Media Labs LML33 support"
+	depends on VIDEO_ZORAN_ZR36060
+	select VIDEO_BT819 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_BT856 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for the Linux Media Labs LML33 MJPEG capture/playback
+	  card.
+
+config VIDEO_ZORAN_LML33R10
+	tristate "Linux Media Labs LML33R10 support"
+	depends on VIDEO_ZORAN_ZR36060
+	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_ADV7170 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  support for the Linux Media Labs LML33R10 MJPEG capture/playback
+	  card.
+
+config VIDEO_ZORAN_AVS6EYES
+	tristate "AverMedia 6 Eyes support"
+	depends on VIDEO_ZORAN_ZR36060
+	select VIDEO_BT856 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_BT866 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_KS0127 if MEDIA_SUBDRV_AUTOSELECT
+	help
+	  Support for the AverMedia 6 Eyes video surveillance card.
diff --git a/drivers/staging/media/zoran/Makefile b/drivers/staging/media/zoran/Makefile
new file mode 100644
index 000000000000..21ac29a71458
--- /dev/null
+++ b/drivers/staging/media/zoran/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+zr36067-objs	:=	zoran_procfs.o zoran_device.o \
+			zoran_driver.o zoran_card.o
+
+obj-$(CONFIG_VIDEO_ZORAN) += zr36067.o videocodec.o
+obj-$(CONFIG_VIDEO_ZORAN_DC30) += zr36050.o zr36016.o
+obj-$(CONFIG_VIDEO_ZORAN_ZR36060) += zr36060.o
diff --git a/drivers/staging/media/zoran/TODO b/drivers/staging/media/zoran/TODO
new file mode 100644
index 000000000000..54464095d0d7
--- /dev/null
+++ b/drivers/staging/media/zoran/TODO
@@ -0,0 +1,4 @@
+The zoran driver is marked deprecated. It will be removed
+around May 2019 unless someone is willing to update this
+driver to the latest V4L2 frameworks (especially the vb2
+framework).
diff --git a/drivers/staging/media/zoran/videocodec.c b/drivers/staging/media/zoran/videocodec.c
new file mode 100644
index 000000000000..044ef8455ba8
--- /dev/null
+++ b/drivers/staging/media/zoran/videocodec.c
@@ -0,0 +1,391 @@
+/*
+ * VIDEO MOTION CODECs internal API for video devices
+ *
+ * Interface for MJPEG (and maybe later MPEG/WAVELETS) codec's
+ * bound to a master device.
+ *
+ * (c) 2002 Wolfgang Scherr <scherr@net4you.at>
+ *
+ * $Id: videocodec.c,v 1.1.2.8 2003/03/29 07:16:04 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#define VIDEOCODEC_VERSION "v0.2"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+
+// kernel config is here (procfs flag)
+
+#ifdef CONFIG_PROC_FS
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#endif
+
+#include "videocodec.h"
+
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0-4)");
+
+#define dprintk(num, format, args...) \
+	do { \
+		if (debug >= num) \
+			printk(format, ##args); \
+	} while (0)
+
+struct attached_list {
+	struct videocodec *codec;
+	struct attached_list *next;
+};
+
+struct codec_list {
+	const struct videocodec *codec;
+	int attached;
+	struct attached_list *list;
+	struct codec_list *next;
+};
+
+static struct codec_list *codeclist_top;
+
+/* ================================================= */
+/* function prototypes of the master/slave interface */
+/* ================================================= */
+
+struct videocodec *
+videocodec_attach (struct videocodec_master *master)
+{
+	struct codec_list *h = codeclist_top;
+	struct attached_list *a, *ptr;
+	struct videocodec *codec;
+	int res;
+
+	if (!master) {
+		dprintk(1, KERN_ERR "videocodec_attach: no data\n");
+		return NULL;
+	}
+
+	dprintk(2,
+		"videocodec_attach: '%s', flags %lx, magic %lx\n",
+		master->name, master->flags, master->magic);
+
+	if (!h) {
+		dprintk(1,
+			KERN_ERR
+			"videocodec_attach: no device available\n");
+		return NULL;
+	}
+
+	while (h) {
+		// attach only if the slave has at least the flags
+		// expected by the master
+		if ((master->flags & h->codec->flags) == master->flags) {
+			dprintk(4, "videocodec_attach: try '%s'\n",
+				h->codec->name);
+
+			if (!try_module_get(h->codec->owner))
+				return NULL;
+
+			codec = kmemdup(h->codec, sizeof(struct videocodec),
+					GFP_KERNEL);
+			if (!codec) {
+				dprintk(1,
+					KERN_ERR
+					"videocodec_attach: no mem\n");
+				goto out_module_put;
+			}
+
+			res = strlen(codec->name);
+			snprintf(codec->name + res, sizeof(codec->name) - res,
+				 "[%d]", h->attached);
+			codec->master_data = master;
+			res = codec->setup(codec);
+			if (res == 0) {
+				dprintk(3, "videocodec_attach '%s'\n",
+					codec->name);
+				ptr = kzalloc(sizeof(struct attached_list), GFP_KERNEL);
+				if (!ptr) {
+					dprintk(1,
+						KERN_ERR
+						"videocodec_attach: no memory\n");
+					goto out_kfree;
+				}
+				ptr->codec = codec;
+
+				a = h->list;
+				if (!a) {
+					h->list = ptr;
+					dprintk(4,
+						"videocodec: first element\n");
+				} else {
+					while (a->next)
+						a = a->next;	// find end
+					a->next = ptr;
+					dprintk(4,
+						"videocodec: in after '%s'\n",
+						h->codec->name);
+				}
+
+				h->attached += 1;
+				return codec;
+			} else {
+				kfree(codec);
+			}
+		}
+		h = h->next;
+	}
+
+	dprintk(1, KERN_ERR "videocodec_attach: no codec found!\n");
+	return NULL;
+
+ out_module_put:
+	module_put(h->codec->owner);
+ out_kfree:
+	kfree(codec);
+	return NULL;
+}
+
+int
+videocodec_detach (struct videocodec *codec)
+{
+	struct codec_list *h = codeclist_top;
+	struct attached_list *a, *prev;
+	int res;
+
+	if (!codec) {
+		dprintk(1, KERN_ERR "videocodec_detach: no data\n");
+		return -EINVAL;
+	}
+
+	dprintk(2,
+		"videocodec_detach: '%s', type: %x, flags %lx, magic %lx\n",
+		codec->name, codec->type, codec->flags, codec->magic);
+
+	if (!h) {
+		dprintk(1,
+			KERN_ERR "videocodec_detach: no device left...\n");
+		return -ENXIO;
+	}
+
+	while (h) {
+		a = h->list;
+		prev = NULL;
+		while (a) {
+			if (codec == a->codec) {
+				res = a->codec->unset(a->codec);
+				if (res >= 0) {
+					dprintk(3,
+						"videocodec_detach: '%s'\n",
+						a->codec->name);
+					a->codec->master_data = NULL;
+				} else {
+					dprintk(1,
+						KERN_ERR
+						"videocodec_detach: '%s'\n",
+						a->codec->name);
+					a->codec->master_data = NULL;
+				}
+				if (prev == NULL) {
+					h->list = a->next;
+					dprintk(4,
+						"videocodec: delete first\n");
+				} else {
+					prev->next = a->next;
+					dprintk(4,
+						"videocodec: delete middle\n");
+				}
+				module_put(a->codec->owner);
+				kfree(a->codec);
+				kfree(a);
+				h->attached -= 1;
+				return 0;
+			}
+			prev = a;
+			a = a->next;
+		}
+		h = h->next;
+	}
+
+	dprintk(1, KERN_ERR "videocodec_detach: given codec not found!\n");
+	return -EINVAL;
+}
+
+int
+videocodec_register (const struct videocodec *codec)
+{
+	struct codec_list *ptr, *h = codeclist_top;
+
+	if (!codec) {
+		dprintk(1, KERN_ERR "videocodec_register: no data!\n");
+		return -EINVAL;
+	}
+
+	dprintk(2,
+		"videocodec: register '%s', type: %x, flags %lx, magic %lx\n",
+		codec->name, codec->type, codec->flags, codec->magic);
+
+	ptr = kzalloc(sizeof(struct codec_list), GFP_KERNEL);
+	if (!ptr) {
+		dprintk(1, KERN_ERR "videocodec_register: no memory\n");
+		return -ENOMEM;
+	}
+	ptr->codec = codec;
+
+	if (!h) {
+		codeclist_top = ptr;
+		dprintk(4, "videocodec: hooked in as first element\n");
+	} else {
+		while (h->next)
+			h = h->next;	// find the end
+		h->next = ptr;
+		dprintk(4, "videocodec: hooked in after '%s'\n",
+			h->codec->name);
+	}
+
+	return 0;
+}
+
+int
+videocodec_unregister (const struct videocodec *codec)
+{
+	struct codec_list *prev = NULL, *h = codeclist_top;
+
+	if (!codec) {
+		dprintk(1, KERN_ERR "videocodec_unregister: no data!\n");
+		return -EINVAL;
+	}
+
+	dprintk(2,
+		"videocodec: unregister '%s', type: %x, flags %lx, magic %lx\n",
+		codec->name, codec->type, codec->flags, codec->magic);
+
+	if (!h) {
+		dprintk(1,
+			KERN_ERR
+			"videocodec_unregister: no device left...\n");
+		return -ENXIO;
+	}
+
+	while (h) {
+		if (codec == h->codec) {
+			if (h->attached) {
+				dprintk(1,
+					KERN_ERR
+					"videocodec: '%s' is used\n",
+					h->codec->name);
+				return -EBUSY;
+			}
+			dprintk(3, "videocodec: unregister '%s' is ok.\n",
+				h->codec->name);
+			if (prev == NULL) {
+				codeclist_top = h->next;
+				dprintk(4,
+					"videocodec: delete first element\n");
+			} else {
+				prev->next = h->next;
+				dprintk(4,
+					"videocodec: delete middle element\n");
+			}
+			kfree(h);
+			return 0;
+		}
+		prev = h;
+		h = h->next;
+	}
+
+	dprintk(1,
+		KERN_ERR
+		"videocodec_unregister: given codec not found!\n");
+	return -EINVAL;
+}
+
+#ifdef CONFIG_PROC_FS
+static int proc_videocodecs_show(struct seq_file *m, void *v)
+{
+	struct codec_list *h = codeclist_top;
+	struct attached_list *a;
+
+	seq_printf(m, "<S>lave or attached <M>aster name  type flags    magic    ");
+	seq_printf(m, "(connected as)\n");
+
+	while (h) {
+		seq_printf(m, "S %32s %04x %08lx %08lx (TEMPLATE)\n",
+			      h->codec->name, h->codec->type,
+			      h->codec->flags, h->codec->magic);
+		a = h->list;
+		while (a) {
+			seq_printf(m, "M %32s %04x %08lx %08lx (%s)\n",
+				      a->codec->master_data->name,
+				      a->codec->master_data->type,
+				      a->codec->master_data->flags,
+				      a->codec->master_data->magic,
+				      a->codec->name);
+			a = a->next;
+		}
+		h = h->next;
+	}
+
+	return 0;
+}
+#endif
+
+/* ===================== */
+/* hook in driver module */
+/* ===================== */
+static int __init
+videocodec_init (void)
+{
+#ifdef CONFIG_PROC_FS
+	static struct proc_dir_entry *videocodec_proc_entry;
+#endif
+
+	printk(KERN_INFO "Linux video codec intermediate layer: %s\n",
+	       VIDEOCODEC_VERSION);
+
+#ifdef CONFIG_PROC_FS
+	videocodec_proc_entry = proc_create_single("videocodecs", 0, NULL,
+			proc_videocodecs_show);
+	if (!videocodec_proc_entry) {
+		dprintk(1, KERN_ERR "videocodec: can't init procfs.\n");
+	}
+#endif
+	return 0;
+}
+
+static void __exit
+videocodec_exit (void)
+{
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("videocodecs", NULL);
+#endif
+}
+
+EXPORT_SYMBOL(videocodec_attach);
+EXPORT_SYMBOL(videocodec_detach);
+EXPORT_SYMBOL(videocodec_register);
+EXPORT_SYMBOL(videocodec_unregister);
+
+module_init(videocodec_init);
+module_exit(videocodec_exit);
+
+MODULE_AUTHOR("Wolfgang Scherr <scherr@net4you.at>");
+MODULE_DESCRIPTION("Intermediate API module for video codecs "
+		   VIDEOCODEC_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
new file mode 100644
index 000000000000..8ed5a0f7ac01
--- /dev/null
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -0,0 +1,349 @@
+/*
+ * VIDEO MOTION CODECs internal API for video devices
+ *
+ * Interface for MJPEG (and maybe later MPEG/WAVELETS) codec's
+ * bound to a master device.
+ *
+ * (c) 2002 Wolfgang Scherr <scherr@net4you.at>
+ *
+ * $Id: videocodec.h,v 1.1.2.4 2003/01/14 21:15:03 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+/* =================== */
+/* general description */
+/* =================== */
+
+/* Should ease the (re-)usage of drivers supporting cards with (different)
+   video codecs. The codecs register to this module their functionality,
+   and the processors (masters) can attach to them if they fit.
+
+   The codecs are typically have a "strong" binding to their master - so I
+   don't think it makes sense to have a full blown interfacing as with e.g.
+   i2c. If you have an other opinion, let's discuss & implement it :-)))
+
+   Usage:
+
+   The slave has just to setup the videocodec structure and use two functions:
+   videocodec_register(codecdata);
+   videocodec_unregister(codecdata);
+   The best is just calling them at module (de-)initialisation.
+
+   The master sets up the structure videocodec_master and calls:
+   codecdata=videocodec_attach(master_codecdata);
+   videocodec_detach(codecdata);
+
+   The slave is called during attach/detach via functions setup previously
+   during register. At that time, the master_data pointer is set up
+   and the slave can access any io registers of the master device (in the case
+   the slave is bound to it). Otherwise it doesn't need this functions and
+   therfor they may not be initialized.
+
+   The other functions are just for convenience, as they are for sure used by
+   most/all of the codecs. The last ones may be omitted, too.
+
+   See the structure declaration below for more information and which data has
+   to be set up for the master and the slave.
+
+   ----------------------------------------------------------------------------
+   The master should have "knowledge" of the slave and vice versa.  So the data
+   structures sent to/from slave via set_data/get_data set_image/get_image are
+   device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
+   ----------------------------------------------------------------------------
+*/
+
+
+/* ========================================== */
+/* description of the videocodec_io structure */
+/* ========================================== */
+
+/*
+   ==== master setup ====
+   name -> name of the device structure for reference and debugging
+   master_data ->  data ref. for the master (e.g. the zr36055,57,67)
+   readreg -> ref. to read-fn from register (setup by master, used by slave)
+   writereg -> ref. to write-fn to register (setup by master, used by slave)
+	       this two functions do the lowlevel I/O job
+
+   ==== slave functionality setup ====
+   slave_data -> data ref. for the slave (e.g. the zr36050,60)
+   check -> fn-ref. checks availability of an device, returns -EIO on failure or
+	    the type on success
+	    this makes espcecially sense if a driver module supports more than
+	    one codec which may be quite similar to access, nevertheless it
+	    is good for a first functionality check
+
+   -- main functions you always need for compression/decompression --
+
+   set_mode -> this fn-ref. resets the entire codec, and sets up the mode
+	       with the last defined norm/size (or device default if not
+	       available) - it returns 0 if the mode is possible
+   set_size -> this fn-ref. sets the norm and image size for
+	       compression/decompression (returns 0 on success)
+	       the norm param is defined in videodev2.h (V4L2_STD_*)
+
+   additional setup may be available, too - but the codec should work with
+   some default values even without this
+
+   set_data -> sets device-specific data (tables, quality etc.)
+   get_data -> query device-specific data (tables, quality etc.)
+
+   if the device delivers interrupts, they may be setup/handled here
+   setup_interrupt -> codec irq setup (not needed for 36050/60)
+   handle_interrupt -> codec irq handling (not needed for 36050/60)
+
+   if the device delivers pictures, they may be handled here
+   put_image -> puts image data to the codec (not needed for 36050/60)
+   get_image -> gets image data from the codec (not needed for 36050/60)
+		the calls include frame numbers and flags (even/odd/...)
+		if needed and a flag which allows blocking until its ready
+*/
+
+/* ============== */
+/* user interface */
+/* ============== */
+
+/*
+   Currently there is only a information display planned, as the layer
+   is not visible for the user space at all.
+
+   Information is available via procfs. The current entry is "/proc/videocodecs"
+   but it makes sense to "hide" it in the /proc/video tree of v4l(2) --TODO--.
+
+A example for such an output is:
+
+<S>lave or attached <M>aster name  type flags    magic    (connected as)
+S                          zr36050 0002 0000d001 00000000 (TEMPLATE)
+M                       zr36055[0] 0001 0000c001 00000000 (zr36050[0])
+M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
+
+*/
+
+
+/* =============================================== */
+/* special defines for the videocodec_io structure */
+/* =============================================== */
+
+#ifndef __LINUX_VIDEOCODEC_H
+#define __LINUX_VIDEOCODEC_H
+
+#include <linux/videodev2.h>
+
+#define CODEC_DO_COMPRESSION 0
+#define CODEC_DO_EXPANSION   1
+
+/* this are the current codec flags I think they are needed */
+/*  -> type value in structure */
+#define CODEC_FLAG_JPEG      0x00000001L	// JPEG codec
+#define CODEC_FLAG_MPEG      0x00000002L	// MPEG1/2/4 codec
+#define CODEC_FLAG_DIVX      0x00000004L	// DIVX codec
+#define CODEC_FLAG_WAVELET   0x00000008L	// WAVELET codec
+					  // room for other types
+
+#define CODEC_FLAG_MAGIC     0x00000800L	// magic key must match
+#define CODEC_FLAG_HARDWARE  0x00001000L	// is a hardware codec
+#define CODEC_FLAG_VFE       0x00002000L	// has direct video frontend
+#define CODEC_FLAG_ENCODER   0x00004000L	// compression capability
+#define CODEC_FLAG_DECODER   0x00008000L	// decompression capability
+#define CODEC_FLAG_NEEDIRQ   0x00010000L	// needs irq handling
+#define CODEC_FLAG_RDWRPIC   0x00020000L	// handles picture I/O
+
+/* a list of modes, some are just examples (is there any HW?) */
+#define CODEC_MODE_BJPG      0x0001	// Baseline JPEG
+#define CODEC_MODE_LJPG      0x0002	// Lossless JPEG
+#define CODEC_MODE_MPEG1     0x0003	// MPEG 1
+#define CODEC_MODE_MPEG2     0x0004	// MPEG 2
+#define CODEC_MODE_MPEG4     0x0005	// MPEG 4
+#define CODEC_MODE_MSDIVX    0x0006	// MS DivX
+#define CODEC_MODE_ODIVX     0x0007	// Open DivX
+#define CODEC_MODE_WAVELET   0x0008	// Wavelet
+
+/* this are the current codec types I want to implement */
+/*  -> type value in structure */
+#define CODEC_TYPE_NONE    0
+#define CODEC_TYPE_L64702  1
+#define CODEC_TYPE_ZR36050 2
+#define CODEC_TYPE_ZR36016 3
+#define CODEC_TYPE_ZR36060 4
+
+/* the type of data may be enhanced by future implementations (data-fn.'s) */
+/*  -> used in command                                                     */
+#define CODEC_G_STATUS         0x0000	/* codec status (query only) */
+#define CODEC_S_CODEC_MODE     0x0001	/* codec mode (baseline JPEG, MPEG1,... */
+#define CODEC_G_CODEC_MODE     0x8001
+#define CODEC_S_VFE            0x0002	/* additional video frontend setup */
+#define CODEC_G_VFE            0x8002
+#define CODEC_S_MMAP           0x0003	/* MMAP setup (if available) */
+
+#define CODEC_S_JPEG_TDS_BYTE  0x0010	/* target data size in bytes */
+#define CODEC_G_JPEG_TDS_BYTE  0x8010
+#define CODEC_S_JPEG_SCALE     0x0011	/* scaling factor for quant. tables */
+#define CODEC_G_JPEG_SCALE     0x8011
+#define CODEC_S_JPEG_HDT_DATA  0x0018	/* huffman-tables */
+#define CODEC_G_JPEG_HDT_DATA  0x8018
+#define CODEC_S_JPEG_QDT_DATA  0x0019	/* quantizing-tables */
+#define CODEC_G_JPEG_QDT_DATA  0x8019
+#define CODEC_S_JPEG_APP_DATA  0x001A	/* APP marker */
+#define CODEC_G_JPEG_APP_DATA  0x801A
+#define CODEC_S_JPEG_COM_DATA  0x001B	/* COM marker */
+#define CODEC_G_JPEG_COM_DATA  0x801B
+
+#define CODEC_S_PRIVATE        0x1000	/* "private" commands start here */
+#define CODEC_G_PRIVATE        0x9000
+
+#define CODEC_G_FLAG           0x8000	/* this is how 'get' is detected */
+
+/* types of transfer, directly user space or a kernel buffer (image-fn.'s) */
+/*  -> used in get_image, put_image                                        */
+#define CODEC_TRANSFER_KERNEL 0	/* use "memcopy" */
+#define CODEC_TRANSFER_USER   1	/* use "to/from_user" */
+
+
+/* ========================= */
+/* the structures itself ... */
+/* ========================= */
+
+struct vfe_polarity {
+	unsigned int vsync_pol:1;
+	unsigned int hsync_pol:1;
+	unsigned int field_pol:1;
+	unsigned int blank_pol:1;
+	unsigned int subimg_pol:1;
+	unsigned int poe_pol:1;
+	unsigned int pvalid_pol:1;
+	unsigned int vclk_pol:1;
+};
+
+struct vfe_settings {
+	__u32 x, y;		/* Offsets into image */
+	__u32 width, height;	/* Area to capture */
+	__u16 decimation;	/* Decimation divider */
+	__u16 flags;		/* Flags for capture */
+	__u16 quality;		/* quality of the video */
+};
+
+struct tvnorm {
+	u16 Wt, Wa, HStart, HSyncStart, Ht, Ha, VStart;
+};
+
+struct jpeg_com_marker {
+	int len; /* number of usable bytes in data */
+	char data[60];
+};
+
+struct jpeg_app_marker {
+	int appn; /* number app segment */
+	int len; /* number of usable bytes in data */
+	char data[60];
+};
+
+struct videocodec {
+	struct module *owner;
+	/* -- filled in by slave device during register -- */
+	char name[32];
+	unsigned long magic;	/* may be used for client<->master attaching */
+	unsigned long flags;	/* functionality flags */
+	unsigned int type;	/* codec type */
+
+	/* -- these is filled in later during master device attach -- */
+
+	struct videocodec_master *master_data;
+
+	/* -- these are filled in by the slave device during register -- */
+
+	void *data;		/* private slave data */
+
+	/* attach/detach client functions (indirect call) */
+	int (*setup) (struct videocodec * codec);
+	int (*unset) (struct videocodec * codec);
+
+	/* main functions, every client needs them for sure! */
+	// set compression or decompression (or freeze, stop, standby, etc)
+	int (*set_mode) (struct videocodec * codec,
+			 int mode);
+	// setup picture size and norm (for the codec's video frontend)
+	int (*set_video) (struct videocodec * codec,
+			  struct tvnorm * norm,
+			  struct vfe_settings * cap,
+			  struct vfe_polarity * pol);
+	// other control commands, also mmap setup etc.
+	int (*control) (struct videocodec * codec,
+			int type,
+			int size,
+			void *data);
+
+	/* additional setup/query/processing (may be NULL pointer) */
+	// interrupt setup / handling (for irq's delivered by master)
+	int (*setup_interrupt) (struct videocodec * codec,
+				long mode);
+	int (*handle_interrupt) (struct videocodec * codec,
+				 int source,
+				 long flag);
+	// picture interface (if any)
+	long (*put_image) (struct videocodec * codec,
+			   int tr_type,
+			   int block,
+			   long *fr_num,
+			   long *flag,
+			   long size,
+			   void *buf);
+	long (*get_image) (struct videocodec * codec,
+			   int tr_type,
+			   int block,
+			   long *fr_num,
+			   long *flag,
+			   long size,
+			   void *buf);
+};
+
+struct videocodec_master {
+	/* -- filled in by master device for registration -- */
+	char name[32];
+	unsigned long magic;	/* may be used for client<->master attaching */
+	unsigned long flags;	/* functionality flags */
+	unsigned int type;	/* master type */
+
+	void *data;		/* private master data */
+
+	 __u32(*readreg) (struct videocodec * codec,
+			  __u16 reg);
+	void (*writereg) (struct videocodec * codec,
+			  __u16 reg,
+			  __u32 value);
+};
+
+
+/* ================================================= */
+/* function prototypes of the master/slave interface */
+/* ================================================= */
+
+/* attach and detach commands for the master */
+// * master structure needs to be kmalloc'ed before calling attach
+//   and free'd after calling detach
+// * returns pointer on success, NULL on failure
+extern struct videocodec *videocodec_attach(struct videocodec_master *);
+// * 0 on success, <0 (errno) on failure
+extern int videocodec_detach(struct videocodec *);
+
+/* register and unregister commands for the slaves */
+// * 0 on success, <0 (errno) on failure
+extern int videocodec_register(const struct videocodec *);
+// * 0 on success, <0 (errno) on failure
+extern int videocodec_unregister(const struct videocodec *);
+
+/* the other calls are directly done via the videocodec structure! */
+
+#endif				/*ifndef __LINUX_VIDEOCODEC_H */
diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
new file mode 100644
index 000000000000..e84fb604a689
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran.h
@@ -0,0 +1,402 @@
+/*
+ * zoran - Iomega Buz driver
+ *
+ * Copyright (C) 1999 Rainer Johanni <Rainer@Johanni.de>
+ *
+ * based on
+ *
+ * zoran.0.0.3 Copyright (C) 1998 Dave Perks <dperks@ibm.net>
+ *
+ * and
+ *
+ * bttv - Bt848 frame grabber driver
+ * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
+ *                        & Marcus Metzler (mocm@thp.uni-koeln.de)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _BUZ_H_
+#define _BUZ_H_
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-fh.h>
+
+struct zoran_sync {
+	unsigned long frame;	/* number of buffer that has been free'd */
+	unsigned long length;	/* number of code bytes in buffer (capture only) */
+	unsigned long seq;	/* frame sequence number */
+	u64 ts;			/* timestamp */
+};
+
+
+#define ZORAN_NAME    "ZORAN"	/* name of the device */
+
+#define ZR_DEVNAME(zr) ((zr)->name)
+
+#define   BUZ_MAX_WIDTH   (zr->timing->Wa)
+#define   BUZ_MAX_HEIGHT  (zr->timing->Ha)
+#define   BUZ_MIN_WIDTH    32	/* never display less than 32 pixels */
+#define   BUZ_MIN_HEIGHT   24	/* never display less than 24 rows */
+
+#define BUZ_NUM_STAT_COM    4
+#define BUZ_MASK_STAT_COM   3
+
+#define BUZ_MAX_FRAME     256	/* Must be a power of 2 */
+#define BUZ_MASK_FRAME    255	/* Must be BUZ_MAX_FRAME-1 */
+
+#define BUZ_MAX_INPUT       16
+
+#if VIDEO_MAX_FRAME <= 32
+#   define   V4L_MAX_FRAME   32
+#elif VIDEO_MAX_FRAME <= 64
+#   define   V4L_MAX_FRAME   64
+#else
+#   error   "Too many video frame buffers to handle"
+#endif
+#define   V4L_MASK_FRAME   (V4L_MAX_FRAME - 1)
+
+#define MAX_FRAME (BUZ_MAX_FRAME > VIDEO_MAX_FRAME ? BUZ_MAX_FRAME : VIDEO_MAX_FRAME)
+
+#include "zr36057.h"
+
+enum card_type {
+	UNKNOWN = -1,
+
+	/* Pinnacle/Miro */
+	DC10_old,		/* DC30 like */
+	DC10_new,		/* DC10plus like */
+	DC10plus,
+	DC30,
+	DC30plus,
+
+	/* Linux Media Labs */
+	LML33,
+	LML33R10,
+
+	/* Iomega */
+	BUZ,
+
+	/* AverMedia */
+	AVS6EYES,
+
+	/* total number of cards */
+	NUM_CARDS
+};
+
+enum zoran_codec_mode {
+	BUZ_MODE_IDLE,		/* nothing going on */
+	BUZ_MODE_MOTION_COMPRESS,	/* grabbing frames */
+	BUZ_MODE_MOTION_DECOMPRESS,	/* playing frames */
+	BUZ_MODE_STILL_COMPRESS,	/* still frame conversion */
+	BUZ_MODE_STILL_DECOMPRESS	/* still frame conversion */
+};
+
+enum zoran_buffer_state {
+	BUZ_STATE_USER,		/* buffer is owned by application */
+	BUZ_STATE_PEND,		/* buffer is queued in pend[] ready to feed to I/O */
+	BUZ_STATE_DMA,		/* buffer is queued in dma[] for I/O */
+	BUZ_STATE_DONE		/* buffer is ready to return to application */
+};
+
+enum zoran_map_mode {
+	ZORAN_MAP_MODE_RAW,
+	ZORAN_MAP_MODE_JPG_REC,
+#define ZORAN_MAP_MODE_JPG ZORAN_MAP_MODE_JPG_REC
+	ZORAN_MAP_MODE_JPG_PLAY,
+};
+
+enum gpio_type {
+	ZR_GPIO_JPEG_SLEEP = 0,
+	ZR_GPIO_JPEG_RESET,
+	ZR_GPIO_JPEG_FRAME,
+	ZR_GPIO_VID_DIR,
+	ZR_GPIO_VID_EN,
+	ZR_GPIO_VID_RESET,
+	ZR_GPIO_CLK_SEL1,
+	ZR_GPIO_CLK_SEL2,
+	ZR_GPIO_MAX,
+};
+
+enum gpcs_type {
+	GPCS_JPEG_RESET = 0,
+	GPCS_JPEG_START,
+	GPCS_MAX,
+};
+
+struct zoran_format {
+	char *name;
+	__u32 fourcc;
+	int colorspace;
+	int depth;
+	__u32 flags;
+	__u32 vfespfr;
+};
+/* flags */
+#define ZORAN_FORMAT_COMPRESSED 1<<0
+#define ZORAN_FORMAT_OVERLAY    1<<1
+#define ZORAN_FORMAT_CAPTURE	1<<2
+#define ZORAN_FORMAT_PLAYBACK	1<<3
+
+/* overlay-settings */
+struct zoran_overlay_settings {
+	int is_set;
+	int x, y, width, height;	/* position */
+	int clipcount;		/* position and number of clips */
+	const struct zoran_format *format;	/* overlay format */
+};
+
+/* v4l-capture settings */
+struct zoran_v4l_settings {
+	int width, height, bytesperline;	/* capture size */
+	const struct zoran_format *format;	/* capture format */
+};
+
+/* jpg-capture/-playback settings */
+struct zoran_jpg_settings {
+	int decimation;		/* this bit is used to set everything to default */
+	int HorDcm, VerDcm, TmpDcm;	/* capture decimation settings (TmpDcm=1 means both fields) */
+	int field_per_buff, odd_even;	/* field-settings (odd_even=1 (+TmpDcm=1) means top-field-first) */
+	int img_x, img_y, img_width, img_height;	/* crop settings (subframe capture) */
+	struct v4l2_jpegcompression jpg_comp;	/* JPEG-specific capture settings */
+};
+
+struct zoran_fh;
+
+struct zoran_mapping {
+	struct zoran_fh *fh;
+	atomic_t count;
+};
+
+struct zoran_buffer {
+	struct zoran_mapping *map;
+	enum zoran_buffer_state state;	/* state: unused/pending/dma/done */
+	struct zoran_sync bs;		/* DONE: info to return to application */
+	union {
+		struct {
+			__le32 *frag_tab;	/* addresses of frag table */
+			u32 frag_tab_bus;	/* same value cached to save time in ISR */
+		} jpg;
+		struct {
+			char *fbuffer;		/* virtual address of frame buffer */
+			unsigned long fbuffer_phys;/* physical address of frame buffer */
+			unsigned long fbuffer_bus;/* bus address of frame buffer */
+		} v4l;
+	};
+};
+
+enum zoran_lock_activity {
+	ZORAN_FREE,		/* free for use */
+	ZORAN_ACTIVE,		/* active but unlocked */
+	ZORAN_LOCKED,		/* locked */
+};
+
+/* buffer collections */
+struct zoran_buffer_col {
+	enum zoran_lock_activity active;	/* feature currently in use? */
+	unsigned int num_buffers, buffer_size;
+	struct zoran_buffer buffer[MAX_FRAME];	/* buffers */
+	u8 allocated;		/* Flag if buffers are allocated  */
+	u8 need_contiguous;	/* Flag if contiguous buffers are needed */
+	/* only applies to jpg buffers, raw buffers are always contiguous */
+};
+
+struct zoran;
+
+/* zoran_fh contains per-open() settings */
+struct zoran_fh {
+	struct v4l2_fh fh;
+	struct zoran *zr;
+
+	enum zoran_map_mode map_mode;		/* Flag which bufferset will map by next mmap() */
+
+	struct zoran_overlay_settings overlay_settings;
+	u32 *overlay_mask;			/* overlay mask */
+	enum zoran_lock_activity overlay_active;/* feature currently in use? */
+
+	struct zoran_buffer_col buffers;	/* buffers' info */
+
+	struct zoran_v4l_settings v4l_settings;	/* structure with a lot of things to play with */
+	struct zoran_jpg_settings jpg_settings;	/* structure with a lot of things to play with */
+};
+
+struct card_info {
+	enum card_type type;
+	char name[32];
+	const char *i2c_decoder;	/* i2c decoder device */
+	const unsigned short *addrs_decoder;
+	const char *i2c_encoder;	/* i2c encoder device */
+	const unsigned short *addrs_encoder;
+	u16 video_vfe, video_codec;			/* videocodec types */
+	u16 audio_chip;					/* audio type */
+
+	int inputs;		/* number of video inputs */
+	struct input {
+		int muxsel;
+		char name[32];
+	} input[BUZ_MAX_INPUT];
+
+	v4l2_std_id norms;
+	struct tvnorm *tvn[3];	/* supported TV norms */
+
+	u32 jpeg_int;		/* JPEG interrupt */
+	u32 vsync_int;		/* VSYNC interrupt */
+	s8 gpio[ZR_GPIO_MAX];
+	u8 gpcs[GPCS_MAX];
+
+	struct vfe_polarity vfe_pol;
+	u8 gpio_pol[ZR_GPIO_MAX];
+
+	/* is the /GWS line connected? */
+	u8 gws_not_connected;
+
+	/* avs6eyes mux setting */
+	u8 input_mux;
+
+	void (*init) (struct zoran * zr);
+};
+
+struct zoran {
+	struct v4l2_device v4l2_dev;
+	struct v4l2_ctrl_handler hdl;
+	struct video_device *video_dev;
+
+	struct i2c_adapter i2c_adapter;	/* */
+	struct i2c_algo_bit_data i2c_algo;	/* */
+	u32 i2cbr;
+
+	struct v4l2_subdev *decoder;	/* video decoder sub-device */
+	struct v4l2_subdev *encoder;	/* video encoder sub-device */
+
+	struct videocodec *codec;	/* video codec */
+	struct videocodec *vfe;	/* video front end */
+
+	struct mutex lock;	/* file ops serialize lock */
+
+	u8 initialized;		/* flag if zoran has been correctly initialized */
+	int user;		/* number of current users */
+	struct card_info card;
+	struct tvnorm *timing;
+
+	unsigned short id;	/* number of this device */
+	char name[32];		/* name of this device */
+	struct pci_dev *pci_dev;	/* PCI device */
+	unsigned char revision;	/* revision of zr36057 */
+	unsigned char __iomem *zr36057_mem;/* pointer to mapped IO memory */
+
+	spinlock_t spinlock;	/* Spinlock */
+
+	/* Video for Linux parameters */
+	int input;	/* card's norm and input */
+	v4l2_std_id norm;
+
+	/* Current buffer params */
+	void    *vbuf_base;
+	int     vbuf_height, vbuf_width;
+	int     vbuf_depth;
+	int     vbuf_bytesperline;
+
+	struct zoran_overlay_settings overlay_settings;
+	u32 *overlay_mask;	/* overlay mask */
+	enum zoran_lock_activity overlay_active;	/* feature currently in use? */
+
+	wait_queue_head_t v4l_capq;
+
+	int v4l_overlay_active;	/* Overlay grab is activated */
+	int v4l_memgrab_active;	/* Memory grab is activated */
+
+	int v4l_grab_frame;	/* Frame number being currently grabbed */
+#define NO_GRAB_ACTIVE (-1)
+	unsigned long v4l_grab_seq;	/* Number of frames grabbed */
+	struct zoran_v4l_settings v4l_settings;	/* structure with a lot of things to play with */
+
+	/* V4L grab queue of frames pending */
+	unsigned long v4l_pend_head;
+	unsigned long v4l_pend_tail;
+	unsigned long v4l_sync_tail;
+	int v4l_pend[V4L_MAX_FRAME];
+	struct zoran_buffer_col v4l_buffers;	/* V4L buffers' info */
+
+	/* Buz MJPEG parameters */
+	enum zoran_codec_mode codec_mode;	/* status of codec */
+	struct zoran_jpg_settings jpg_settings;	/* structure with a lot of things to play with */
+
+	wait_queue_head_t jpg_capq;	/* wait here for grab to finish */
+
+	/* grab queue counts/indices, mask with BUZ_MASK_STAT_COM before using as index */
+	/* (dma_head - dma_tail) is number active in DMA, must be <= BUZ_NUM_STAT_COM */
+	/* (value & BUZ_MASK_STAT_COM) corresponds to index in stat_com table */
+	unsigned long jpg_que_head;	/* Index where to put next buffer which is queued */
+	unsigned long jpg_dma_head;	/* Index of next buffer which goes into stat_com  */
+	unsigned long jpg_dma_tail;	/* Index of last buffer in stat_com               */
+	unsigned long jpg_que_tail;	/* Index of last buffer in queue                  */
+	unsigned long jpg_seq_num;	/* count of frames since grab/play started        */
+	unsigned long jpg_err_seq;	/* last seq_num before error                      */
+	unsigned long jpg_err_shift;
+	unsigned long jpg_queued_num;	/* count of frames queued since grab/play started */
+
+	/* zr36057's code buffer table */
+	__le32 *stat_com;		/* stat_com[i] is indexed by dma_head/tail & BUZ_MASK_STAT_COM */
+
+	/* (value & BUZ_MASK_FRAME) corresponds to index in pend[] queue */
+	int jpg_pend[BUZ_MAX_FRAME];
+
+	/* array indexed by frame number */
+	struct zoran_buffer_col jpg_buffers;	/* MJPEG buffers' info */
+
+	/* Additional stuff for testing */
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *zoran_proc;
+#else
+	void *zoran_proc;
+#endif
+	int testing;
+	int jpeg_error;
+	int intr_counter_GIRQ1;
+	int intr_counter_GIRQ0;
+	int intr_counter_CodRepIRQ;
+	int intr_counter_JPEGRepIRQ;
+	int field_counter;
+	int IRQ1_in;
+	int IRQ1_out;
+	int JPEG_in;
+	int JPEG_out;
+	int JPEG_0;
+	int JPEG_1;
+	int END_event_missed;
+	int JPEG_missed;
+	int JPEG_error;
+	int num_errors;
+	int JPEG_max_missed;
+	int JPEG_min_missed;
+
+	u32 last_isr;
+	unsigned long frame_num;
+
+	wait_queue_head_t test_q;
+};
+
+static inline struct zoran *to_zoran(struct v4l2_device *v4l2_dev)
+{
+	return container_of(v4l2_dev, struct zoran, v4l2_dev);
+}
+
+/* There was something called _ALPHA_BUZ that used the PCI address instead of
+ * the kernel iomapped address for btread/btwrite.  */
+#define btwrite(dat,adr)    writel((dat), zr->zr36057_mem+(adr))
+#define btread(adr)         readl(zr->zr36057_mem+(adr))
+
+#define btand(dat,adr)      btwrite((dat) & btread(adr), adr)
+#define btor(dat,adr)       btwrite((dat) | btread(adr), adr)
+#define btaor(dat,mask,adr) btwrite((dat) | ((mask) & btread(adr)), adr)
+
+#endif
diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
new file mode 100644
index 000000000000..ea10523194e8
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -0,0 +1,1524 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * This part handles card-specific data and detection
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Currently maintained by:
+ *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
+ *   Laurent Pinchart <laurent.pinchart@skynet.be>
+ *   Mailinglist      <mjpeg-users@lists.sf.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
+#include <linux/proc_fs.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/videodev2.h>
+#include <linux/spinlock.h>
+#include <linux/sem.h>
+#include <linux/kmod.h>
+#include <linux/wait.h>
+
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <media/v4l2-common.h>
+#include <media/i2c/bt819.h>
+
+#include "videocodec.h"
+#include "zoran.h"
+#include "zoran_card.h"
+#include "zoran_device.h"
+#include "zoran_procfs.h"
+
+extern const struct zoran_format zoran_formats[];
+
+static int card[BUZ_MAX] = { [0 ... (BUZ_MAX-1)] = -1 };
+module_param_array(card, int, NULL, 0444);
+MODULE_PARM_DESC(card, "Card type");
+
+/*
+   The video mem address of the video card.
+   The driver has a little database for some videocards
+   to determine it from there. If your video card is not in there
+   you have either to give it to the driver as a parameter
+   or set in in a VIDIOCSFBUF ioctl
+ */
+
+static unsigned long vidmem;	/* default = 0 - Video memory base address */
+module_param_hw(vidmem, ulong, iomem, 0444);
+MODULE_PARM_DESC(vidmem, "Default video memory base address");
+
+/*
+   Default input and video norm at startup of the driver.
+*/
+
+static unsigned int default_input;	/* default 0 = Composite, 1 = S-Video */
+module_param(default_input, uint, 0444);
+MODULE_PARM_DESC(default_input,
+		 "Default input (0=Composite, 1=S-Video, 2=Internal)");
+
+static int default_mux = 1;	/* 6 Eyes input selection */
+module_param(default_mux, int, 0644);
+MODULE_PARM_DESC(default_mux,
+		 "Default 6 Eyes mux setting (Input selection)");
+
+static int default_norm;	/* default 0 = PAL, 1 = NTSC 2 = SECAM */
+module_param(default_norm, int, 0444);
+MODULE_PARM_DESC(default_norm, "Default norm (0=PAL, 1=NTSC, 2=SECAM)");
+
+/* /dev/videoN, -1 for autodetect */
+static int video_nr[BUZ_MAX] = { [0 ... (BUZ_MAX-1)] = -1 };
+module_param_array(video_nr, int, NULL, 0444);
+MODULE_PARM_DESC(video_nr, "Video device number (-1=Auto)");
+
+int v4l_nbufs = 4;
+int v4l_bufsize = 864;		/* Everybody should be able to work with this setting */
+module_param(v4l_nbufs, int, 0644);
+MODULE_PARM_DESC(v4l_nbufs, "Maximum number of V4L buffers to use");
+module_param(v4l_bufsize, int, 0644);
+MODULE_PARM_DESC(v4l_bufsize, "Maximum size per V4L buffer (in kB)");
+
+int jpg_nbufs = 32;
+int jpg_bufsize = 512;		/* max size for 100% quality full-PAL frame */
+module_param(jpg_nbufs, int, 0644);
+MODULE_PARM_DESC(jpg_nbufs, "Maximum number of JPG buffers to use");
+module_param(jpg_bufsize, int, 0644);
+MODULE_PARM_DESC(jpg_bufsize, "Maximum size per JPG buffer (in kB)");
+
+int pass_through = 0;		/* 1=Pass through TV signal when device is not used */
+				/* 0=Show color bar when device is not used (LML33: only if lml33dpath=1) */
+module_param(pass_through, int, 0644);
+MODULE_PARM_DESC(pass_through,
+		 "Pass TV signal through to TV-out when idling");
+
+int zr36067_debug = 1;
+module_param_named(debug, zr36067_debug, int, 0644);
+MODULE_PARM_DESC(debug, "Debug level (0-5)");
+
+#define ZORAN_VERSION "0.10.1"
+
+MODULE_DESCRIPTION("Zoran-36057/36067 JPEG codec driver");
+MODULE_AUTHOR("Serguei Miridonov");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(ZORAN_VERSION);
+
+#define ZR_DEVICE(subven, subdev, data)	{ \
+	.vendor = PCI_VENDOR_ID_ZORAN, .device = PCI_DEVICE_ID_ZORAN_36057, \
+	.subvendor = (subven), .subdevice = (subdev), .driver_data = (data) }
+
+static const struct pci_device_id zr36067_pci_tbl[] = {
+	ZR_DEVICE(PCI_VENDOR_ID_MIRO, PCI_DEVICE_ID_MIRO_DC10PLUS, DC10plus),
+	ZR_DEVICE(PCI_VENDOR_ID_MIRO, PCI_DEVICE_ID_MIRO_DC30PLUS, DC30plus),
+	ZR_DEVICE(PCI_VENDOR_ID_ELECTRONICDESIGNGMBH, PCI_DEVICE_ID_LML_33R10, LML33R10),
+	ZR_DEVICE(PCI_VENDOR_ID_IOMEGA, PCI_DEVICE_ID_IOMEGA_BUZ, BUZ),
+	ZR_DEVICE(PCI_ANY_ID, PCI_ANY_ID, NUM_CARDS),
+	{0}
+};
+MODULE_DEVICE_TABLE(pci, zr36067_pci_tbl);
+
+static unsigned int zoran_num;		/* number of cards found */
+
+/* videocodec bus functions ZR36060 */
+static u32
+zr36060_read (struct videocodec *codec,
+	      u16                reg)
+{
+	struct zoran *zr = (struct zoran *) codec->master_data->data;
+	__u32 data;
+
+	if (post_office_wait(zr)
+	    || post_office_write(zr, 0, 1, reg >> 8)
+	    || post_office_write(zr, 0, 2, reg & 0xff)) {
+		return -1;
+	}
+
+	data = post_office_read(zr, 0, 3) & 0xff;
+	return data;
+}
+
+static void
+zr36060_write (struct videocodec *codec,
+	       u16                reg,
+	       u32                val)
+{
+	struct zoran *zr = (struct zoran *) codec->master_data->data;
+
+	if (post_office_wait(zr)
+	    || post_office_write(zr, 0, 1, reg >> 8)
+	    || post_office_write(zr, 0, 2, reg & 0xff)) {
+		return;
+	}
+
+	post_office_write(zr, 0, 3, val & 0xff);
+}
+
+/* videocodec bus functions ZR36050 */
+static u32
+zr36050_read (struct videocodec *codec,
+	      u16                reg)
+{
+	struct zoran *zr = (struct zoran *) codec->master_data->data;
+	__u32 data;
+
+	if (post_office_wait(zr)
+	    || post_office_write(zr, 1, 0, reg >> 2)) {	// reg. HIGHBYTES
+		return -1;
+	}
+
+	data = post_office_read(zr, 0, reg & 0x03) & 0xff;	// reg. LOWBYTES + read
+	return data;
+}
+
+static void
+zr36050_write (struct videocodec *codec,
+	       u16                reg,
+	       u32                val)
+{
+	struct zoran *zr = (struct zoran *) codec->master_data->data;
+
+	if (post_office_wait(zr)
+	    || post_office_write(zr, 1, 0, reg >> 2)) {	// reg. HIGHBYTES
+		return;
+	}
+
+	post_office_write(zr, 0, reg & 0x03, val & 0xff);	// reg. LOWBYTES + wr. data
+}
+
+/* videocodec bus functions ZR36016 */
+static u32
+zr36016_read (struct videocodec *codec,
+	      u16                reg)
+{
+	struct zoran *zr = (struct zoran *) codec->master_data->data;
+	__u32 data;
+
+	if (post_office_wait(zr)) {
+		return -1;
+	}
+
+	data = post_office_read(zr, 2, reg & 0x03) & 0xff;	// read
+	return data;
+}
+
+/* hack for in zoran_device.c */
+void
+zr36016_write (struct videocodec *codec,
+	       u16                reg,
+	       u32                val)
+{
+	struct zoran *zr = (struct zoran *) codec->master_data->data;
+
+	if (post_office_wait(zr)) {
+		return;
+	}
+
+	post_office_write(zr, 2, reg & 0x03, val & 0x0ff);	// wr. data
+}
+
+/*
+ * Board specific information
+ */
+
+static void
+dc10_init (struct zoran *zr)
+{
+	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+
+	/* Pixel clock selection */
+	GPIO(zr, 4, 0);
+	GPIO(zr, 5, 1);
+	/* Enable the video bus sync signals */
+	GPIO(zr, 7, 0);
+}
+
+static void
+dc10plus_init (struct zoran *zr)
+{
+	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+}
+
+static void
+buz_init (struct zoran *zr)
+{
+	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+
+	/* some stuff from Iomega */
+	pci_write_config_dword(zr->pci_dev, 0xfc, 0x90680f15);
+	pci_write_config_dword(zr->pci_dev, 0x0c, 0x00012020);
+	pci_write_config_dword(zr->pci_dev, 0xe8, 0xc0200000);
+}
+
+static void
+lml33_init (struct zoran *zr)
+{
+	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+
+	GPIO(zr, 2, 1);		// Set Composite input/output
+}
+
+static void
+avs6eyes_init (struct zoran *zr)
+{
+	// AverMedia 6-Eyes original driver by Christer Weinigel
+
+	// Lifted straight from Christer's old driver and
+	// modified slightly by Martin Samuelsson.
+
+	int mux = default_mux; /* 1 = BT866, 7 = VID1 */
+
+	GPIO(zr, 4, 1); /* Bt866 SLEEP on */
+	udelay(2);
+
+	GPIO(zr, 0, 1); /* ZR36060 /RESET on */
+	GPIO(zr, 1, 0); /* ZR36060 /SLEEP on */
+	GPIO(zr, 2, mux & 1);   /* MUX S0 */
+	GPIO(zr, 3, 0); /* /FRAME on */
+	GPIO(zr, 4, 0); /* Bt866 SLEEP off */
+	GPIO(zr, 5, mux & 2);   /* MUX S1 */
+	GPIO(zr, 6, 0); /* ? */
+	GPIO(zr, 7, mux & 4);   /* MUX S2 */
+
+}
+
+static char *
+codecid_to_modulename (u16 codecid)
+{
+	char *name = NULL;
+
+	switch (codecid) {
+	case CODEC_TYPE_ZR36060:
+		name = "zr36060";
+		break;
+	case CODEC_TYPE_ZR36050:
+		name = "zr36050";
+		break;
+	case CODEC_TYPE_ZR36016:
+		name = "zr36016";
+		break;
+	}
+
+	return name;
+}
+
+// struct tvnorm {
+//      u16 Wt, Wa, HStart, HSyncStart, Ht, Ha, VStart;
+// };
+
+static struct tvnorm f50sqpixel = { 944, 768, 83, 880, 625, 576, 16 };
+static struct tvnorm f60sqpixel = { 780, 640, 51, 716, 525, 480, 12 };
+static struct tvnorm f50ccir601 = { 864, 720, 75, 804, 625, 576, 18 };
+static struct tvnorm f60ccir601 = { 858, 720, 57, 788, 525, 480, 16 };
+
+static struct tvnorm f50ccir601_lml33 = { 864, 720, 75+34, 804, 625, 576, 18 };
+static struct tvnorm f60ccir601_lml33 = { 858, 720, 57+34, 788, 525, 480, 16 };
+
+/* The DC10 (57/16/50) uses VActive as HSync, so HStart must be 0 */
+static struct tvnorm f50sqpixel_dc10 = { 944, 768, 0, 880, 625, 576, 0 };
+static struct tvnorm f60sqpixel_dc10 = { 780, 640, 0, 716, 525, 480, 12 };
+
+/* FIXME: I cannot swap U and V in saa7114, so i do one
+ * pixel left shift in zoran (75 -> 74)
+ * (Maxim Yevtyushkin <max@linuxmedialabs.com>) */
+static struct tvnorm f50ccir601_lm33r10 = { 864, 720, 74+54, 804, 625, 576, 18 };
+static struct tvnorm f60ccir601_lm33r10 = { 858, 720, 56+54, 788, 525, 480, 16 };
+
+/* FIXME: The ks0127 seem incapable of swapping U and V, too, which is why I
+ * copy Maxim's left shift hack for the 6 Eyes.
+ *
+ * Christer's driver used the unshifted norms, though...
+ * /Sam  */
+static struct tvnorm f50ccir601_avs6eyes = { 864, 720, 74, 804, 625, 576, 18 };
+static struct tvnorm f60ccir601_avs6eyes = { 858, 720, 56, 788, 525, 480, 16 };
+
+static const unsigned short vpx3220_addrs[] = { 0x43, 0x47, I2C_CLIENT_END };
+static const unsigned short saa7110_addrs[] = { 0x4e, 0x4f, I2C_CLIENT_END };
+static const unsigned short saa7111_addrs[] = { 0x25, 0x24, I2C_CLIENT_END };
+static const unsigned short saa7114_addrs[] = { 0x21, 0x20, I2C_CLIENT_END };
+static const unsigned short adv717x_addrs[] = { 0x6a, 0x6b, 0x2a, 0x2b, I2C_CLIENT_END };
+static const unsigned short ks0127_addrs[] = { 0x6c, 0x6d, I2C_CLIENT_END };
+static const unsigned short saa7185_addrs[] = { 0x44, I2C_CLIENT_END };
+static const unsigned short bt819_addrs[] = { 0x45, I2C_CLIENT_END };
+static const unsigned short bt856_addrs[] = { 0x44, I2C_CLIENT_END };
+static const unsigned short bt866_addrs[] = { 0x44, I2C_CLIENT_END };
+
+static struct card_info zoran_cards[NUM_CARDS] = {
+	{
+		.type = DC10_old,
+		.name = "DC10(old)",
+		.i2c_decoder = "vpx3220a",
+		.addrs_decoder = vpx3220_addrs,
+		.video_codec = CODEC_TYPE_ZR36050,
+		.video_vfe = CODEC_TYPE_ZR36016,
+
+		.inputs = 3,
+		.input = {
+			{ 1, "Composite" },
+			{ 2, "S-Video" },
+			{ 0, "Internal/comp" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL|V4L2_STD_SECAM,
+		.tvn = {
+			&f50sqpixel_dc10,
+			&f60sqpixel_dc10,
+			&f50sqpixel_dc10
+		},
+		.jpeg_int = 0,
+		.vsync_int = ZR36057_ISR_GIRQ1,
+		.gpio = { 2, 1, -1, 3, 7, 0, 4, 5 },
+		.gpio_pol = { 0, 0, 0, 1, 0, 0, 0, 0 },
+		.gpcs = { -1, 0 },
+		.vfe_pol = { 0, 0, 0, 0, 0, 0, 0, 0 },
+		.gws_not_connected = 0,
+		.input_mux = 0,
+		.init = &dc10_init,
+	}, {
+		.type = DC10_new,
+		.name = "DC10(new)",
+		.i2c_decoder = "saa7110",
+		.addrs_decoder = saa7110_addrs,
+		.i2c_encoder = "adv7175",
+		.addrs_encoder = adv717x_addrs,
+		.video_codec = CODEC_TYPE_ZR36060,
+
+		.inputs = 3,
+		.input = {
+				{ 0, "Composite" },
+				{ 7, "S-Video" },
+				{ 5, "Internal/comp" }
+			},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL|V4L2_STD_SECAM,
+		.tvn = {
+				&f50sqpixel,
+				&f60sqpixel,
+				&f50sqpixel},
+		.jpeg_int = ZR36057_ISR_GIRQ0,
+		.vsync_int = ZR36057_ISR_GIRQ1,
+		.gpio = { 3, 0, 6, 1, 2, -1, 4, 5 },
+		.gpio_pol = { 0, 0, 0, 0, 0, 0, 0, 0 },
+		.gpcs = { -1, 1},
+		.vfe_pol = { 1, 1, 1, 1, 0, 0, 0, 0 },
+		.gws_not_connected = 0,
+		.input_mux = 0,
+		.init = &dc10plus_init,
+	}, {
+		.type = DC10plus,
+		.name = "DC10plus",
+		.i2c_decoder = "saa7110",
+		.addrs_decoder = saa7110_addrs,
+		.i2c_encoder = "adv7175",
+		.addrs_encoder = adv717x_addrs,
+		.video_codec = CODEC_TYPE_ZR36060,
+
+		.inputs = 3,
+		.input = {
+			{ 0, "Composite" },
+			{ 7, "S-Video" },
+			{ 5, "Internal/comp" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL|V4L2_STD_SECAM,
+		.tvn = {
+			&f50sqpixel,
+			&f60sqpixel,
+			&f50sqpixel
+		},
+		.jpeg_int = ZR36057_ISR_GIRQ0,
+		.vsync_int = ZR36057_ISR_GIRQ1,
+		.gpio = { 3, 0, 6, 1, 2, -1, 4, 5 },
+		.gpio_pol = { 0, 0, 0, 0, 0, 0, 0, 0 },
+		.gpcs = { -1, 1 },
+		.vfe_pol = { 1, 1, 1, 1, 0, 0, 0, 0 },
+		.gws_not_connected = 0,
+		.input_mux = 0,
+		.init = &dc10plus_init,
+	}, {
+		.type = DC30,
+		.name = "DC30",
+		.i2c_decoder = "vpx3220a",
+		.addrs_decoder = vpx3220_addrs,
+		.i2c_encoder = "adv7175",
+		.addrs_encoder = adv717x_addrs,
+		.video_codec = CODEC_TYPE_ZR36050,
+		.video_vfe = CODEC_TYPE_ZR36016,
+
+		.inputs = 3,
+		.input = {
+			{ 1, "Composite" },
+			{ 2, "S-Video" },
+			{ 0, "Internal/comp" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL|V4L2_STD_SECAM,
+		.tvn = {
+			&f50sqpixel_dc10,
+			&f60sqpixel_dc10,
+			&f50sqpixel_dc10
+		},
+		.jpeg_int = 0,
+		.vsync_int = ZR36057_ISR_GIRQ1,
+		.gpio = { 2, 1, -1, 3, 7, 0, 4, 5 },
+		.gpio_pol = { 0, 0, 0, 1, 0, 0, 0, 0 },
+		.gpcs = { -1, 0 },
+		.vfe_pol = { 0, 0, 0, 0, 0, 0, 0, 0 },
+		.gws_not_connected = 0,
+		.input_mux = 0,
+		.init = &dc10_init,
+	}, {
+		.type = DC30plus,
+		.name = "DC30plus",
+		.i2c_decoder = "vpx3220a",
+		.addrs_decoder = vpx3220_addrs,
+		.i2c_encoder = "adv7175",
+		.addrs_encoder = adv717x_addrs,
+		.video_codec = CODEC_TYPE_ZR36050,
+		.video_vfe = CODEC_TYPE_ZR36016,
+
+		.inputs = 3,
+		.input = {
+			{ 1, "Composite" },
+			{ 2, "S-Video" },
+			{ 0, "Internal/comp" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL|V4L2_STD_SECAM,
+		.tvn = {
+			&f50sqpixel_dc10,
+			&f60sqpixel_dc10,
+			&f50sqpixel_dc10
+		},
+		.jpeg_int = 0,
+		.vsync_int = ZR36057_ISR_GIRQ1,
+		.gpio = { 2, 1, -1, 3, 7, 0, 4, 5 },
+		.gpio_pol = { 0, 0, 0, 1, 0, 0, 0, 0 },
+		.gpcs = { -1, 0 },
+		.vfe_pol = { 0, 0, 0, 0, 0, 0, 0, 0 },
+		.gws_not_connected = 0,
+		.input_mux = 0,
+		.init = &dc10_init,
+	}, {
+		.type = LML33,
+		.name = "LML33",
+		.i2c_decoder = "bt819a",
+		.addrs_decoder = bt819_addrs,
+		.i2c_encoder = "bt856",
+		.addrs_encoder = bt856_addrs,
+		.video_codec = CODEC_TYPE_ZR36060,
+
+		.inputs = 2,
+		.input = {
+			{ 0, "Composite" },
+			{ 7, "S-Video" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL,
+		.tvn = {
+			&f50ccir601_lml33,
+			&f60ccir601_lml33,
+			NULL
+		},
+		.jpeg_int = ZR36057_ISR_GIRQ1,
+		.vsync_int = ZR36057_ISR_GIRQ0,
+		.gpio = { 1, -1, 3, 5, 7, -1, -1, -1 },
+		.gpio_pol = { 0, 0, 0, 0, 1, 0, 0, 0 },
+		.gpcs = { 3, 1 },
+		.vfe_pol = { 1, 1, 0, 0, 0, 1, 0, 0 },
+		.gws_not_connected = 1,
+		.input_mux = 0,
+		.init = &lml33_init,
+	}, {
+		.type = LML33R10,
+		.name = "LML33R10",
+		.i2c_decoder = "saa7114",
+		.addrs_decoder = saa7114_addrs,
+		.i2c_encoder = "adv7170",
+		.addrs_encoder = adv717x_addrs,
+		.video_codec = CODEC_TYPE_ZR36060,
+
+		.inputs = 2,
+		.input = {
+			{ 0, "Composite" },
+			{ 7, "S-Video" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL,
+		.tvn = {
+			&f50ccir601_lm33r10,
+			&f60ccir601_lm33r10,
+			NULL
+		},
+		.jpeg_int = ZR36057_ISR_GIRQ1,
+		.vsync_int = ZR36057_ISR_GIRQ0,
+		.gpio = { 1, -1, 3, 5, 7, -1, -1, -1 },
+		.gpio_pol = { 0, 0, 0, 0, 1, 0, 0, 0 },
+		.gpcs = { 3, 1 },
+		.vfe_pol = { 1, 1, 0, 0, 0, 1, 0, 0 },
+		.gws_not_connected = 1,
+		.input_mux = 0,
+		.init = &lml33_init,
+	}, {
+		.type = BUZ,
+		.name = "Buz",
+		.i2c_decoder = "saa7111",
+		.addrs_decoder = saa7111_addrs,
+		.i2c_encoder = "saa7185",
+		.addrs_encoder = saa7185_addrs,
+		.video_codec = CODEC_TYPE_ZR36060,
+
+		.inputs = 2,
+		.input = {
+			{ 3, "Composite" },
+			{ 7, "S-Video" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL|V4L2_STD_SECAM,
+		.tvn = {
+			&f50ccir601,
+			&f60ccir601,
+			&f50ccir601
+		},
+		.jpeg_int = ZR36057_ISR_GIRQ1,
+		.vsync_int = ZR36057_ISR_GIRQ0,
+		.gpio = { 1, -1, 3, -1, -1, -1, -1, -1 },
+		.gpio_pol = { 0, 0, 0, 0, 0, 0, 0, 0 },
+		.gpcs = { 3, 1 },
+		.vfe_pol = { 1, 1, 0, 0, 0, 1, 0, 0 },
+		.gws_not_connected = 1,
+		.input_mux = 0,
+		.init = &buz_init,
+	}, {
+		.type = AVS6EYES,
+		.name = "6-Eyes",
+		/* AverMedia chose not to brand the 6-Eyes. Thus it
+		   can't be autodetected, and requires card=x. */
+		.i2c_decoder = "ks0127",
+		.addrs_decoder = ks0127_addrs,
+		.i2c_encoder = "bt866",
+		.addrs_encoder = bt866_addrs,
+		.video_codec = CODEC_TYPE_ZR36060,
+
+		.inputs = 10,
+		.input = {
+			{ 0, "Composite 1" },
+			{ 1, "Composite 2" },
+			{ 2, "Composite 3" },
+			{ 4, "Composite 4" },
+			{ 5, "Composite 5" },
+			{ 6, "Composite 6" },
+			{ 8, "S-Video 1" },
+			{ 9, "S-Video 2" },
+			{10, "S-Video 3" },
+			{15, "YCbCr" }
+		},
+		.norms = V4L2_STD_NTSC|V4L2_STD_PAL,
+		.tvn = {
+			&f50ccir601_avs6eyes,
+			&f60ccir601_avs6eyes,
+			NULL
+		},
+		.jpeg_int = ZR36057_ISR_GIRQ1,
+		.vsync_int = ZR36057_ISR_GIRQ0,
+		.gpio = { 1, 0, 3, -1, -1, -1, -1, -1 },// Validity unknown /Sam
+		.gpio_pol = { 0, 0, 0, 0, 0, 0, 0, 0 }, // Validity unknown /Sam
+		.gpcs = { 3, 1 },			// Validity unknown /Sam
+		.vfe_pol = { 1, 0, 0, 0, 0, 1, 0, 0 },  // Validity unknown /Sam
+		.gws_not_connected = 1,
+		.input_mux = 1,
+		.init = &avs6eyes_init,
+	}
+
+};
+
+/*
+ * I2C functions
+ */
+/* software I2C functions */
+static int
+zoran_i2c_getsda (void *data)
+{
+	struct zoran *zr = (struct zoran *) data;
+
+	return (btread(ZR36057_I2CBR) >> 1) & 1;
+}
+
+static int
+zoran_i2c_getscl (void *data)
+{
+	struct zoran *zr = (struct zoran *) data;
+
+	return btread(ZR36057_I2CBR) & 1;
+}
+
+static void
+zoran_i2c_setsda (void *data,
+		  int   state)
+{
+	struct zoran *zr = (struct zoran *) data;
+
+	if (state)
+		zr->i2cbr |= 2;
+	else
+		zr->i2cbr &= ~2;
+	btwrite(zr->i2cbr, ZR36057_I2CBR);
+}
+
+static void
+zoran_i2c_setscl (void *data,
+		  int   state)
+{
+	struct zoran *zr = (struct zoran *) data;
+
+	if (state)
+		zr->i2cbr |= 1;
+	else
+		zr->i2cbr &= ~1;
+	btwrite(zr->i2cbr, ZR36057_I2CBR);
+}
+
+static const struct i2c_algo_bit_data zoran_i2c_bit_data_template = {
+	.setsda = zoran_i2c_setsda,
+	.setscl = zoran_i2c_setscl,
+	.getsda = zoran_i2c_getsda,
+	.getscl = zoran_i2c_getscl,
+	.udelay = 10,
+	.timeout = 100,
+};
+
+static int
+zoran_register_i2c (struct zoran *zr)
+{
+	zr->i2c_algo = zoran_i2c_bit_data_template;
+	zr->i2c_algo.data = zr;
+	strscpy(zr->i2c_adapter.name, ZR_DEVNAME(zr),
+		sizeof(zr->i2c_adapter.name));
+	i2c_set_adapdata(&zr->i2c_adapter, &zr->v4l2_dev);
+	zr->i2c_adapter.algo_data = &zr->i2c_algo;
+	zr->i2c_adapter.dev.parent = &zr->pci_dev->dev;
+	return i2c_bit_add_bus(&zr->i2c_adapter);
+}
+
+static void
+zoran_unregister_i2c (struct zoran *zr)
+{
+	i2c_del_adapter(&zr->i2c_adapter);
+}
+
+/* Check a zoran_params struct for correctness, insert default params */
+
+int
+zoran_check_jpg_settings (struct zoran              *zr,
+			  struct zoran_jpg_settings *settings,
+			  int try)
+{
+	int err = 0, err0 = 0;
+
+	dprintk(4,
+		KERN_DEBUG
+		"%s: %s - dec: %d, Hdcm: %d, Vdcm: %d, Tdcm: %d\n",
+		ZR_DEVNAME(zr), __func__, settings->decimation, settings->HorDcm,
+		settings->VerDcm, settings->TmpDcm);
+	dprintk(4,
+		KERN_DEBUG
+		"%s: %s - x: %d, y: %d, w: %d, y: %d\n",
+		ZR_DEVNAME(zr), __func__, settings->img_x, settings->img_y,
+		settings->img_width, settings->img_height);
+	/* Check decimation, set default values for decimation = 1, 2, 4 */
+	switch (settings->decimation) {
+	case 1:
+
+		settings->HorDcm = 1;
+		settings->VerDcm = 1;
+		settings->TmpDcm = 1;
+		settings->field_per_buff = 2;
+		settings->img_x = 0;
+		settings->img_y = 0;
+		settings->img_width = BUZ_MAX_WIDTH;
+		settings->img_height = BUZ_MAX_HEIGHT / 2;
+		break;
+	case 2:
+
+		settings->HorDcm = 2;
+		settings->VerDcm = 1;
+		settings->TmpDcm = 2;
+		settings->field_per_buff = 1;
+		settings->img_x = (BUZ_MAX_WIDTH == 720) ? 8 : 0;
+		settings->img_y = 0;
+		settings->img_width =
+		    (BUZ_MAX_WIDTH == 720) ? 704 : BUZ_MAX_WIDTH;
+		settings->img_height = BUZ_MAX_HEIGHT / 2;
+		break;
+	case 4:
+
+		if (zr->card.type == DC10_new) {
+			dprintk(1,
+				KERN_DEBUG
+				"%s: %s - HDec by 4 is not supported on the DC10\n",
+				ZR_DEVNAME(zr), __func__);
+			err0++;
+			break;
+		}
+
+		settings->HorDcm = 4;
+		settings->VerDcm = 2;
+		settings->TmpDcm = 2;
+		settings->field_per_buff = 1;
+		settings->img_x = (BUZ_MAX_WIDTH == 720) ? 8 : 0;
+		settings->img_y = 0;
+		settings->img_width =
+		    (BUZ_MAX_WIDTH == 720) ? 704 : BUZ_MAX_WIDTH;
+		settings->img_height = BUZ_MAX_HEIGHT / 2;
+		break;
+	case 0:
+
+		/* We have to check the data the user has set */
+
+		if (settings->HorDcm != 1 && settings->HorDcm != 2 &&
+		    (zr->card.type == DC10_new || settings->HorDcm != 4)) {
+			settings->HorDcm = clamp(settings->HorDcm, 1, 2);
+			err0++;
+		}
+		if (settings->VerDcm != 1 && settings->VerDcm != 2) {
+			settings->VerDcm = clamp(settings->VerDcm, 1, 2);
+			err0++;
+		}
+		if (settings->TmpDcm != 1 && settings->TmpDcm != 2) {
+			settings->TmpDcm = clamp(settings->TmpDcm, 1, 2);
+			err0++;
+		}
+		if (settings->field_per_buff != 1 &&
+		    settings->field_per_buff != 2) {
+			settings->field_per_buff = clamp(settings->field_per_buff, 1, 2);
+			err0++;
+		}
+		if (settings->img_x < 0) {
+			settings->img_x = 0;
+			err0++;
+		}
+		if (settings->img_y < 0) {
+			settings->img_y = 0;
+			err0++;
+		}
+		if (settings->img_width < 0 || settings->img_width > BUZ_MAX_WIDTH) {
+			settings->img_width = clamp(settings->img_width, 0, (int)BUZ_MAX_WIDTH);
+			err0++;
+		}
+		if (settings->img_height < 0 || settings->img_height > BUZ_MAX_HEIGHT / 2) {
+			settings->img_height = clamp(settings->img_height, 0, BUZ_MAX_HEIGHT / 2);
+			err0++;
+		}
+		if (settings->img_x + settings->img_width > BUZ_MAX_WIDTH) {
+			settings->img_x = BUZ_MAX_WIDTH - settings->img_width;
+			err0++;
+		}
+		if (settings->img_y + settings->img_height > BUZ_MAX_HEIGHT / 2) {
+			settings->img_y = BUZ_MAX_HEIGHT / 2 - settings->img_height;
+			err0++;
+		}
+		if (settings->img_width % (16 * settings->HorDcm) != 0) {
+			settings->img_width -= settings->img_width % (16 * settings->HorDcm);
+			if (settings->img_width == 0)
+				settings->img_width = 16 * settings->HorDcm;
+			err0++;
+		}
+		if (settings->img_height % (8 * settings->VerDcm) != 0) {
+			settings->img_height -= settings->img_height % (8 * settings->VerDcm);
+			if (settings->img_height == 0)
+				settings->img_height = 8 * settings->VerDcm;
+			err0++;
+		}
+
+		if (!try && err0) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - error in params for decimation = 0\n",
+				ZR_DEVNAME(zr), __func__);
+			err++;
+		}
+		break;
+	default:
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - decimation = %d, must be 0, 1, 2 or 4\n",
+			ZR_DEVNAME(zr), __func__, settings->decimation);
+		err++;
+		break;
+	}
+
+	if (settings->jpg_comp.quality > 100)
+		settings->jpg_comp.quality = 100;
+	if (settings->jpg_comp.quality < 5)
+		settings->jpg_comp.quality = 5;
+	if (settings->jpg_comp.APPn < 0)
+		settings->jpg_comp.APPn = 0;
+	if (settings->jpg_comp.APPn > 15)
+		settings->jpg_comp.APPn = 15;
+	if (settings->jpg_comp.APP_len < 0)
+		settings->jpg_comp.APP_len = 0;
+	if (settings->jpg_comp.APP_len > 60)
+		settings->jpg_comp.APP_len = 60;
+	if (settings->jpg_comp.COM_len < 0)
+		settings->jpg_comp.COM_len = 0;
+	if (settings->jpg_comp.COM_len > 60)
+		settings->jpg_comp.COM_len = 60;
+	if (err)
+		return -EINVAL;
+	return 0;
+}
+
+void
+zoran_open_init_params (struct zoran *zr)
+{
+	int i;
+
+	/* User must explicitly set a window */
+	zr->overlay_settings.is_set = 0;
+	zr->overlay_mask = NULL;
+	zr->overlay_active = ZORAN_FREE;
+
+	zr->v4l_memgrab_active = 0;
+	zr->v4l_overlay_active = 0;
+	zr->v4l_grab_frame = NO_GRAB_ACTIVE;
+	zr->v4l_grab_seq = 0;
+	zr->v4l_settings.width = 192;
+	zr->v4l_settings.height = 144;
+	zr->v4l_settings.format = &zoran_formats[7];	/* YUY2 - YUV-4:2:2 packed */
+	zr->v4l_settings.bytesperline =
+	    zr->v4l_settings.width *
+	    ((zr->v4l_settings.format->depth + 7) / 8);
+
+	/* DMA ring stuff for V4L */
+	zr->v4l_pend_tail = 0;
+	zr->v4l_pend_head = 0;
+	zr->v4l_sync_tail = 0;
+	zr->v4l_buffers.active = ZORAN_FREE;
+	for (i = 0; i < VIDEO_MAX_FRAME; i++) {
+		zr->v4l_buffers.buffer[i].state = BUZ_STATE_USER;	/* nothing going on */
+	}
+	zr->v4l_buffers.allocated = 0;
+
+	for (i = 0; i < BUZ_MAX_FRAME; i++) {
+		zr->jpg_buffers.buffer[i].state = BUZ_STATE_USER;	/* nothing going on */
+	}
+	zr->jpg_buffers.active = ZORAN_FREE;
+	zr->jpg_buffers.allocated = 0;
+	/* Set necessary params and call zoran_check_jpg_settings to set the defaults */
+	zr->jpg_settings.decimation = 1;
+	zr->jpg_settings.jpg_comp.quality = 50;	/* default compression factor 8 */
+	if (zr->card.type != BUZ)
+		zr->jpg_settings.odd_even = 1;
+	else
+		zr->jpg_settings.odd_even = 0;
+	zr->jpg_settings.jpg_comp.APPn = 0;
+	zr->jpg_settings.jpg_comp.APP_len = 0;	/* No APPn marker */
+	memset(zr->jpg_settings.jpg_comp.APP_data, 0,
+	       sizeof(zr->jpg_settings.jpg_comp.APP_data));
+	zr->jpg_settings.jpg_comp.COM_len = 0;	/* No COM marker */
+	memset(zr->jpg_settings.jpg_comp.COM_data, 0,
+	       sizeof(zr->jpg_settings.jpg_comp.COM_data));
+	zr->jpg_settings.jpg_comp.jpeg_markers =
+	    V4L2_JPEG_MARKER_DHT | V4L2_JPEG_MARKER_DQT;
+	i = zoran_check_jpg_settings(zr, &zr->jpg_settings, 0);
+	if (i)
+		dprintk(1, KERN_ERR "%s: %s internal error\n",
+			ZR_DEVNAME(zr), __func__);
+
+	clear_interrupt_counters(zr);
+	zr->testing = 0;
+}
+
+static void test_interrupts (struct zoran *zr)
+{
+	DEFINE_WAIT(wait);
+	int timeout, icr;
+
+	clear_interrupt_counters(zr);
+
+	zr->testing = 1;
+	icr = btread(ZR36057_ICR);
+	btwrite(0x78000000 | ZR36057_ICR_IntPinEn, ZR36057_ICR);
+	prepare_to_wait(&zr->test_q, &wait, TASK_INTERRUPTIBLE);
+	timeout = schedule_timeout(HZ);
+	finish_wait(&zr->test_q, &wait);
+	btwrite(0, ZR36057_ICR);
+	btwrite(0x78000000, ZR36057_ISR);
+	zr->testing = 0;
+	dprintk(5, KERN_INFO "%s: Testing interrupts...\n", ZR_DEVNAME(zr));
+	if (timeout) {
+		dprintk(1, ": time spent: %d\n", 1 * HZ - timeout);
+	}
+	if (zr36067_debug > 1)
+		print_interrupts(zr);
+	btwrite(icr, ZR36057_ICR);
+}
+
+static int zr36057_init (struct zoran *zr)
+{
+	int j, err;
+
+	dprintk(1,
+		KERN_INFO
+		"%s: %s - initializing card[%d], zr=%p\n",
+		ZR_DEVNAME(zr), __func__, zr->id, zr);
+
+	/* default setup of all parameters which will persist between opens */
+	zr->user = 0;
+
+	init_waitqueue_head(&zr->v4l_capq);
+	init_waitqueue_head(&zr->jpg_capq);
+	init_waitqueue_head(&zr->test_q);
+	zr->jpg_buffers.allocated = 0;
+	zr->v4l_buffers.allocated = 0;
+
+	zr->vbuf_base = (void *) vidmem;
+	zr->vbuf_width = 0;
+	zr->vbuf_height = 0;
+	zr->vbuf_depth = 0;
+	zr->vbuf_bytesperline = 0;
+
+	/* Avoid nonsense settings from user for default input/norm */
+	if (default_norm < 0 || default_norm > 2)
+		default_norm = 0;
+	if (default_norm == 0) {
+		zr->norm = V4L2_STD_PAL;
+		zr->timing = zr->card.tvn[0];
+	} else if (default_norm == 1) {
+		zr->norm = V4L2_STD_NTSC;
+		zr->timing = zr->card.tvn[1];
+	} else {
+		zr->norm = V4L2_STD_SECAM;
+		zr->timing = zr->card.tvn[2];
+	}
+	if (zr->timing == NULL) {
+		dprintk(1,
+			KERN_WARNING
+			"%s: %s - default TV standard not supported by hardware. PAL will be used.\n",
+			ZR_DEVNAME(zr), __func__);
+		zr->norm = V4L2_STD_PAL;
+		zr->timing = zr->card.tvn[0];
+	}
+
+	if (default_input > zr->card.inputs-1) {
+		dprintk(1,
+			KERN_WARNING
+			"%s: default_input value %d out of range (0-%d)\n",
+			ZR_DEVNAME(zr), default_input, zr->card.inputs-1);
+		default_input = 0;
+	}
+	zr->input = default_input;
+
+	/* default setup (will be repeated at every open) */
+	zoran_open_init_params(zr);
+
+	/* allocate memory *before* doing anything to the hardware
+	 * in case allocation fails */
+	zr->stat_com = kzalloc(BUZ_NUM_STAT_COM * 4, GFP_KERNEL);
+	zr->video_dev = video_device_alloc();
+	if (!zr->stat_com || !zr->video_dev) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - kmalloc (STAT_COM) failed\n",
+			ZR_DEVNAME(zr), __func__);
+		err = -ENOMEM;
+		goto exit_free;
+	}
+	for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
+		zr->stat_com[j] = cpu_to_le32(1); /* mark as unavailable to zr36057 */
+	}
+
+	/*
+	 *   Now add the template and register the device unit.
+	 */
+	*zr->video_dev = zoran_template;
+	zr->video_dev->v4l2_dev = &zr->v4l2_dev;
+	zr->video_dev->lock = &zr->lock;
+	strscpy(zr->video_dev->name, ZR_DEVNAME(zr), sizeof(zr->video_dev->name));
+	/* It's not a mem2mem device, but you can both capture and output from
+	   one and the same device. This should really be split up into two
+	   device nodes, but that's a job for another day. */
+	zr->video_dev->vfl_dir = VFL_DIR_M2M;
+	err = video_register_device(zr->video_dev, VFL_TYPE_GRABBER, video_nr[zr->id]);
+	if (err < 0)
+		goto exit_free;
+	video_set_drvdata(zr->video_dev, zr);
+
+	zoran_init_hardware(zr);
+	if (zr36067_debug > 2)
+		detect_guest_activity(zr);
+	test_interrupts(zr);
+	if (!pass_through) {
+		decoder_call(zr, video, s_stream, 0);
+		encoder_call(zr, video, s_routing, 2, 0, 0);
+	}
+
+	zr->zoran_proc = NULL;
+	zr->initialized = 1;
+	return 0;
+
+exit_free:
+	kfree(zr->stat_com);
+	kfree(zr->video_dev);
+	return err;
+}
+
+static void zoran_remove(struct pci_dev *pdev)
+{
+	struct v4l2_device *v4l2_dev = dev_get_drvdata(&pdev->dev);
+	struct zoran *zr = to_zoran(v4l2_dev);
+
+	if (!zr->initialized)
+		goto exit_free;
+
+	/* unregister videocodec bus */
+	if (zr->codec) {
+		struct videocodec_master *master = zr->codec->master_data;
+
+		videocodec_detach(zr->codec);
+		kfree(master);
+	}
+	if (zr->vfe) {
+		struct videocodec_master *master = zr->vfe->master_data;
+
+		videocodec_detach(zr->vfe);
+		kfree(master);
+	}
+
+	/* unregister i2c bus */
+	zoran_unregister_i2c(zr);
+	/* disable PCI bus-mastering */
+	zoran_set_pci_master(zr, 0);
+	/* put chip into reset */
+	btwrite(0, ZR36057_SPGPPCR);
+	free_irq(zr->pci_dev->irq, zr);
+	/* unmap and free memory */
+	kfree(zr->stat_com);
+	zoran_proc_cleanup(zr);
+	iounmap(zr->zr36057_mem);
+	pci_disable_device(zr->pci_dev);
+	video_unregister_device(zr->video_dev);
+exit_free:
+	v4l2_ctrl_handler_free(&zr->hdl);
+	v4l2_device_unregister(&zr->v4l2_dev);
+	kfree(zr);
+}
+
+void
+zoran_vdev_release (struct video_device *vdev)
+{
+	kfree(vdev);
+}
+
+static struct videocodec_master *zoran_setup_videocodec(struct zoran *zr,
+							int type)
+{
+	struct videocodec_master *m = NULL;
+
+	m = kmalloc(sizeof(struct videocodec_master), GFP_KERNEL);
+	if (!m) {
+		dprintk(1, KERN_ERR "%s: %s - no memory\n",
+			ZR_DEVNAME(zr), __func__);
+		return m;
+	}
+
+	/* magic and type are unused for master struct. Makes sense only at
+	   codec structs.
+	   In the past, .type were initialized to the old V4L1 .hardware
+	   value, as VID_HARDWARE_ZR36067
+	 */
+	m->magic = 0L;
+	m->type = 0;
+
+	m->flags = CODEC_FLAG_ENCODER | CODEC_FLAG_DECODER;
+	strscpy(m->name, ZR_DEVNAME(zr), sizeof(m->name));
+	m->data = zr;
+
+	switch (type)
+	{
+	case CODEC_TYPE_ZR36060:
+		m->readreg = zr36060_read;
+		m->writereg = zr36060_write;
+		m->flags |= CODEC_FLAG_JPEG | CODEC_FLAG_VFE;
+		break;
+	case CODEC_TYPE_ZR36050:
+		m->readreg = zr36050_read;
+		m->writereg = zr36050_write;
+		m->flags |= CODEC_FLAG_JPEG;
+		break;
+	case CODEC_TYPE_ZR36016:
+		m->readreg = zr36016_read;
+		m->writereg = zr36016_write;
+		m->flags |= CODEC_FLAG_VFE;
+		break;
+	}
+
+	return m;
+}
+
+static void zoran_subdev_notify(struct v4l2_subdev *sd, unsigned int cmd, void *arg)
+{
+	struct zoran *zr = to_zoran(sd->v4l2_dev);
+
+	/* Bt819 needs to reset its FIFO buffer using #FRST pin and
+	   LML33 card uses GPIO(7) for that. */
+	if (cmd == BT819_FIFO_RESET_LOW)
+		GPIO(zr, 7, 0);
+	else if (cmd == BT819_FIFO_RESET_HIGH)
+		GPIO(zr, 7, 1);
+}
+
+/*
+ *   Scan for a Buz card (actually for the PCI controller ZR36057),
+ *   request the irq and map the io memory
+ */
+static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	unsigned char latency, need_latency;
+	struct zoran *zr;
+	int result;
+	struct videocodec_master *master_vfe = NULL;
+	struct videocodec_master *master_codec = NULL;
+	int card_num;
+	char *codec_name, *vfe_name;
+	unsigned int nr;
+
+
+	nr = zoran_num++;
+	if (nr >= BUZ_MAX) {
+		dprintk(1, KERN_ERR "%s: driver limited to %d card(s) maximum\n",
+			ZORAN_NAME, BUZ_MAX);
+		return -ENOENT;
+	}
+
+	zr = kzalloc(sizeof(struct zoran), GFP_KERNEL);
+	if (!zr) {
+		dprintk(1, KERN_ERR "%s: %s - kzalloc failed\n",
+			ZORAN_NAME, __func__);
+		return -ENOMEM;
+	}
+	zr->v4l2_dev.notify = zoran_subdev_notify;
+	if (v4l2_device_register(&pdev->dev, &zr->v4l2_dev))
+		goto zr_free_mem;
+	zr->pci_dev = pdev;
+	zr->id = nr;
+	snprintf(ZR_DEVNAME(zr), sizeof(ZR_DEVNAME(zr)), "MJPEG[%u]", zr->id);
+	if (v4l2_ctrl_handler_init(&zr->hdl, 10))
+		goto zr_unreg;
+	zr->v4l2_dev.ctrl_handler = &zr->hdl;
+	spin_lock_init(&zr->spinlock);
+	mutex_init(&zr->lock);
+	if (pci_enable_device(pdev))
+		goto zr_unreg;
+	zr->revision = zr->pci_dev->revision;
+
+	dprintk(1,
+		KERN_INFO
+		"%s: Zoran ZR360%c7 (rev %d), irq: %d, memory: 0x%08llx\n",
+		ZR_DEVNAME(zr), zr->revision < 2 ? '5' : '6', zr->revision,
+		zr->pci_dev->irq, (uint64_t)pci_resource_start(zr->pci_dev, 0));
+	if (zr->revision >= 2) {
+		dprintk(1,
+			KERN_INFO
+			"%s: Subsystem vendor=0x%04x id=0x%04x\n",
+			ZR_DEVNAME(zr), zr->pci_dev->subsystem_vendor,
+			zr->pci_dev->subsystem_device);
+	}
+
+	/* Use auto-detected card type? */
+	if (card[nr] == -1) {
+		if (zr->revision < 2) {
+			dprintk(1,
+				KERN_ERR
+				"%s: No card type specified, please use the card=X module parameter\n",
+				ZR_DEVNAME(zr));
+			dprintk(1,
+				KERN_ERR
+				"%s: It is not possible to auto-detect ZR36057 based cards\n",
+				ZR_DEVNAME(zr));
+			goto zr_unreg;
+		}
+
+		card_num = ent->driver_data;
+		if (card_num >= NUM_CARDS) {
+			dprintk(1,
+				KERN_ERR
+				"%s: Unknown card, try specifying card=X module parameter\n",
+				ZR_DEVNAME(zr));
+			goto zr_unreg;
+		}
+		dprintk(3,
+			KERN_DEBUG
+			"%s: %s() - card %s detected\n",
+			ZR_DEVNAME(zr), __func__, zoran_cards[card_num].name);
+	} else {
+		card_num = card[nr];
+		if (card_num >= NUM_CARDS || card_num < 0) {
+			dprintk(1,
+				KERN_ERR
+				"%s: User specified card type %d out of range (0 .. %d)\n",
+				ZR_DEVNAME(zr), card_num, NUM_CARDS - 1);
+			goto zr_unreg;
+		}
+	}
+
+	/* even though we make this a non pointer and thus
+	 * theoretically allow for making changes to this struct
+	 * on a per-individual card basis at runtime, this is
+	 * strongly discouraged. This structure is intended to
+	 * keep general card information, no settings or anything */
+	zr->card = zoran_cards[card_num];
+	snprintf(ZR_DEVNAME(zr), sizeof(ZR_DEVNAME(zr)),
+		 "%s[%u]", zr->card.name, zr->id);
+
+	zr->zr36057_mem = pci_ioremap_bar(zr->pci_dev, 0);
+	if (!zr->zr36057_mem) {
+		dprintk(1, KERN_ERR "%s: %s() - ioremap failed\n",
+			ZR_DEVNAME(zr), __func__);
+		goto zr_unreg;
+	}
+
+	result = request_irq(zr->pci_dev->irq, zoran_irq,
+			     IRQF_SHARED, ZR_DEVNAME(zr), zr);
+	if (result < 0) {
+		if (result == -EINVAL) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - bad irq number or handler\n",
+				ZR_DEVNAME(zr), __func__);
+		} else if (result == -EBUSY) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - IRQ %d busy, change your PnP config in BIOS\n",
+				ZR_DEVNAME(zr), __func__, zr->pci_dev->irq);
+		} else {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - can't assign irq, error code %d\n",
+				ZR_DEVNAME(zr), __func__, result);
+		}
+		goto zr_unmap;
+	}
+
+	/* set PCI latency timer */
+	pci_read_config_byte(zr->pci_dev, PCI_LATENCY_TIMER,
+			     &latency);
+	need_latency = zr->revision > 1 ? 32 : 48;
+	if (latency != need_latency) {
+		dprintk(2, KERN_INFO "%s: Changing PCI latency from %d to %d\n",
+			ZR_DEVNAME(zr), latency, need_latency);
+		pci_write_config_byte(zr->pci_dev, PCI_LATENCY_TIMER,
+				      need_latency);
+	}
+
+	zr36057_restart(zr);
+	/* i2c */
+	dprintk(2, KERN_INFO "%s: Initializing i2c bus...\n",
+		ZR_DEVNAME(zr));
+
+	if (zoran_register_i2c(zr) < 0) {
+		dprintk(1, KERN_ERR "%s: %s - can't initialize i2c bus\n",
+			ZR_DEVNAME(zr), __func__);
+		goto zr_free_irq;
+	}
+
+	zr->decoder = v4l2_i2c_new_subdev(&zr->v4l2_dev,
+		&zr->i2c_adapter, zr->card.i2c_decoder,
+		0, zr->card.addrs_decoder);
+
+	if (zr->card.i2c_encoder)
+		zr->encoder = v4l2_i2c_new_subdev(&zr->v4l2_dev,
+			&zr->i2c_adapter, zr->card.i2c_encoder,
+			0, zr->card.addrs_encoder);
+
+	dprintk(2,
+		KERN_INFO "%s: Initializing videocodec bus...\n",
+		ZR_DEVNAME(zr));
+
+	if (zr->card.video_codec) {
+		codec_name = codecid_to_modulename(zr->card.video_codec);
+		if (codec_name) {
+			result = request_module(codec_name);
+			if (result) {
+				dprintk(1,
+					KERN_ERR
+					"%s: failed to load modules %s: %d\n",
+					ZR_DEVNAME(zr), codec_name, result);
+			}
+		}
+	}
+	if (zr->card.video_vfe) {
+		vfe_name = codecid_to_modulename(zr->card.video_vfe);
+		if (vfe_name) {
+			result = request_module(vfe_name);
+			if (result < 0) {
+				dprintk(1,
+					KERN_ERR
+					"%s: failed to load modules %s: %d\n",
+					ZR_DEVNAME(zr), vfe_name, result);
+			}
+		}
+	}
+
+	/* reset JPEG codec */
+	jpeg_codec_sleep(zr, 1);
+	jpeg_codec_reset(zr);
+	/* video bus enabled */
+	/* display codec revision */
+	if (zr->card.video_codec != 0) {
+		master_codec = zoran_setup_videocodec(zr, zr->card.video_codec);
+		if (!master_codec)
+			goto zr_unreg_i2c;
+		zr->codec = videocodec_attach(master_codec);
+		if (!zr->codec) {
+			dprintk(1, KERN_ERR "%s: %s - no codec found\n",
+				ZR_DEVNAME(zr), __func__);
+			goto zr_free_codec;
+		}
+		if (zr->codec->type != zr->card.video_codec) {
+			dprintk(1, KERN_ERR "%s: %s - wrong codec\n",
+				ZR_DEVNAME(zr), __func__);
+			goto zr_detach_codec;
+		}
+	}
+	if (zr->card.video_vfe != 0) {
+		master_vfe = zoran_setup_videocodec(zr, zr->card.video_vfe);
+		if (!master_vfe)
+			goto zr_detach_codec;
+		zr->vfe = videocodec_attach(master_vfe);
+		if (!zr->vfe) {
+			dprintk(1, KERN_ERR "%s: %s - no VFE found\n",
+				ZR_DEVNAME(zr), __func__);
+			goto zr_free_vfe;
+		}
+		if (zr->vfe->type != zr->card.video_vfe) {
+			dprintk(1, KERN_ERR "%s: %s = wrong VFE\n",
+				ZR_DEVNAME(zr), __func__);
+			goto zr_detach_vfe;
+		}
+	}
+
+	/* take care of Natoma chipset and a revision 1 zr36057 */
+	if ((pci_pci_problems & PCIPCI_NATOMA) && zr->revision <= 1) {
+		zr->jpg_buffers.need_contiguous = 1;
+		dprintk(1, KERN_INFO
+			"%s: ZR36057/Natoma bug, max. buffer size is 128K\n",
+			ZR_DEVNAME(zr));
+	}
+
+	if (zr36057_init(zr) < 0)
+		goto zr_detach_vfe;
+
+	zoran_proc_init(zr);
+
+	return 0;
+
+zr_detach_vfe:
+	videocodec_detach(zr->vfe);
+zr_free_vfe:
+	kfree(master_vfe);
+zr_detach_codec:
+	videocodec_detach(zr->codec);
+zr_free_codec:
+	kfree(master_codec);
+zr_unreg_i2c:
+	zoran_unregister_i2c(zr);
+zr_free_irq:
+	btwrite(0, ZR36057_SPGPPCR);
+	free_irq(zr->pci_dev->irq, zr);
+zr_unmap:
+	iounmap(zr->zr36057_mem);
+zr_unreg:
+	v4l2_ctrl_handler_free(&zr->hdl);
+	v4l2_device_unregister(&zr->v4l2_dev);
+zr_free_mem:
+	kfree(zr);
+
+	return -ENODEV;
+}
+
+static struct pci_driver zoran_driver = {
+	.name = "zr36067",
+	.id_table = zr36067_pci_tbl,
+	.probe = zoran_probe,
+	.remove = zoran_remove,
+};
+
+static int __init zoran_init(void)
+{
+	int res;
+
+	printk(KERN_INFO "Zoran MJPEG board driver version %s\n",
+	       ZORAN_VERSION);
+
+	/* check the parameters we have been given, adjust if necessary */
+	if (v4l_nbufs < 2)
+		v4l_nbufs = 2;
+	if (v4l_nbufs > VIDEO_MAX_FRAME)
+		v4l_nbufs = VIDEO_MAX_FRAME;
+	/* The user specifies the in KB, we want them in byte
+	 * (and page aligned) */
+	v4l_bufsize = PAGE_ALIGN(v4l_bufsize * 1024);
+	if (v4l_bufsize < 32768)
+		v4l_bufsize = 32768;
+	/* 2 MB is arbitrary but sufficient for the maximum possible images */
+	if (v4l_bufsize > 2048 * 1024)
+		v4l_bufsize = 2048 * 1024;
+	if (jpg_nbufs < 4)
+		jpg_nbufs = 4;
+	if (jpg_nbufs > BUZ_MAX_FRAME)
+		jpg_nbufs = BUZ_MAX_FRAME;
+	jpg_bufsize = PAGE_ALIGN(jpg_bufsize * 1024);
+	if (jpg_bufsize < 8192)
+		jpg_bufsize = 8192;
+	if (jpg_bufsize > (512 * 1024))
+		jpg_bufsize = 512 * 1024;
+	/* Use parameter for vidmem or try to find a video card */
+	if (vidmem) {
+		dprintk(1,
+			KERN_INFO
+			"%s: Using supplied video memory base address @ 0x%lx\n",
+			ZORAN_NAME, vidmem);
+	}
+
+	/* some mainboards might not do PCI-PCI data transfer well */
+	if (pci_pci_problems & (PCIPCI_FAIL|PCIAGP_FAIL|PCIPCI_ALIMAGIK)) {
+		dprintk(1,
+			KERN_WARNING
+			"%s: chipset does not support reliable PCI-PCI DMA\n",
+			ZORAN_NAME);
+	}
+
+	res = pci_register_driver(&zoran_driver);
+	if (res) {
+		dprintk(1,
+			KERN_ERR
+			"%s: Unable to register ZR36057 driver\n",
+			ZORAN_NAME);
+		return res;
+	}
+
+	return 0;
+}
+
+static void __exit zoran_exit(void)
+{
+	pci_unregister_driver(&zoran_driver);
+}
+
+module_init(zoran_init);
+module_exit(zoran_exit);
diff --git a/drivers/staging/media/zoran/zoran_card.h b/drivers/staging/media/zoran/zoran_card.h
new file mode 100644
index 000000000000..0cdb7d34926d
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_card.h
@@ -0,0 +1,50 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * This part handles card-specific data and detection
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Currently maintained by:
+ *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
+ *   Laurent Pinchart <laurent.pinchart@skynet.be>
+ *   Mailinglist      <mjpeg-users@lists.sf.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ZORAN_CARD_H__
+#define __ZORAN_CARD_H__
+
+extern int zr36067_debug;
+
+#define dprintk(num, format, args...) \
+	do { \
+		if (zr36067_debug >= num) \
+			printk(format, ##args); \
+	} while (0)
+
+/* Anybody who uses more than four? */
+#define BUZ_MAX 4
+
+extern const struct video_device zoran_template;
+
+extern int zoran_check_jpg_settings(struct zoran *zr,
+				    struct zoran_jpg_settings *settings,
+				    int try);
+extern void zoran_open_init_params(struct zoran *zr);
+extern void zoran_vdev_release(struct video_device *vdev);
+
+void zr36016_write(struct videocodec *codec, u16 reg, u32 val);
+
+#endif				/* __ZORAN_CARD_H__ */
diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
new file mode 100644
index 000000000000..22b27632762d
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -0,0 +1,1619 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * This part handles device access (PCI/I2C/codec/...)
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Currently maintained by:
+ *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
+ *   Laurent Pinchart <laurent.pinchart@skynet.be>
+ *   Mailinglist      <mjpeg-users@lists.sf.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/ktime.h>
+#include <linux/sched/signal.h>
+
+#include <linux/interrupt.h>
+#include <linux/proc_fs.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/videodev2.h>
+#include <media/v4l2-common.h>
+#include <linux/spinlock.h>
+#include <linux/sem.h>
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/wait.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+
+#include "videocodec.h"
+#include "zoran.h"
+#include "zoran_device.h"
+#include "zoran_card.h"
+
+#define IRQ_MASK ( ZR36057_ISR_GIRQ0 | \
+		   ZR36057_ISR_GIRQ1 | \
+		   ZR36057_ISR_JPEGRepIRQ )
+
+static bool lml33dpath;		/* default = 0
+				 * 1 will use digital path in capture
+				 * mode instead of analog. It can be
+				 * used for picture adjustments using
+				 * tool like xawtv while watching image
+				 * on TV monitor connected to the output.
+				 * However, due to absence of 75 Ohm
+				 * load on Bt819 input, there will be
+				 * some image imperfections */
+
+module_param(lml33dpath, bool, 0644);
+MODULE_PARM_DESC(lml33dpath,
+		 "Use digital path capture mode (on LML33 cards)");
+
+static void
+zr36057_init_vfe (struct zoran *zr);
+
+/*
+ * General Purpose I/O and Guest bus access
+ */
+
+/*
+ * This is a bit tricky. When a board lacks a GPIO function, the corresponding
+ * GPIO bit number in the card_info structure is set to 0.
+ */
+
+void
+GPIO (struct zoran *zr,
+      int           bit,
+      unsigned int  value)
+{
+	u32 reg;
+	u32 mask;
+
+	/* Make sure the bit number is legal
+	 * A bit number of -1 (lacking) gives a mask of 0,
+	 * making it harmless */
+	mask = (1 << (24 + bit)) & 0xff000000;
+	reg = btread(ZR36057_GPPGCR1) & ~mask;
+	if (value) {
+		reg |= mask;
+	}
+	btwrite(reg, ZR36057_GPPGCR1);
+	udelay(1);
+}
+
+/*
+ * Wait til post office is no longer busy
+ */
+
+int
+post_office_wait (struct zoran *zr)
+{
+	u32 por;
+
+//      while (((por = btread(ZR36057_POR)) & (ZR36057_POR_POPen | ZR36057_POR_POTime)) == ZR36057_POR_POPen) {
+	while ((por = btread(ZR36057_POR)) & ZR36057_POR_POPen) {
+		/* wait for something to happen */
+	}
+	if ((por & ZR36057_POR_POTime) && !zr->card.gws_not_connected) {
+		/* In LML33/BUZ \GWS line is not connected, so it has always timeout set */
+		dprintk(1, KERN_INFO "%s: pop timeout %08x\n", ZR_DEVNAME(zr),
+			por);
+		return -1;
+	}
+
+	return 0;
+}
+
+int
+post_office_write (struct zoran *zr,
+		   unsigned int  guest,
+		   unsigned int  reg,
+		   unsigned int  value)
+{
+	u32 por;
+
+	por =
+	    ZR36057_POR_PODir | ZR36057_POR_POTime | ((guest & 7) << 20) |
+	    ((reg & 7) << 16) | (value & 0xFF);
+	btwrite(por, ZR36057_POR);
+
+	return post_office_wait(zr);
+}
+
+int
+post_office_read (struct zoran *zr,
+		  unsigned int  guest,
+		  unsigned int  reg)
+{
+	u32 por;
+
+	por = ZR36057_POR_POTime | ((guest & 7) << 20) | ((reg & 7) << 16);
+	btwrite(por, ZR36057_POR);
+	if (post_office_wait(zr) < 0) {
+		return -1;
+	}
+
+	return btread(ZR36057_POR) & 0xFF;
+}
+
+/*
+ * detect guests
+ */
+
+static void
+dump_guests (struct zoran *zr)
+{
+	if (zr36067_debug > 2) {
+		int i, guest[8];
+
+		for (i = 1; i < 8; i++) {	// Don't read jpeg codec here
+			guest[i] = post_office_read(zr, i, 0);
+		}
+
+		printk(KERN_INFO "%s: Guests: %*ph\n",
+		       ZR_DEVNAME(zr), 8, guest);
+	}
+}
+
+void
+detect_guest_activity (struct zoran *zr)
+{
+	int timeout, i, j, res, guest[8], guest0[8], change[8][3];
+	ktime_t t0, t1;
+
+	dump_guests(zr);
+	printk(KERN_INFO "%s: Detecting guests activity, please wait...\n",
+	       ZR_DEVNAME(zr));
+	for (i = 1; i < 8; i++) {	// Don't read jpeg codec here
+		guest0[i] = guest[i] = post_office_read(zr, i, 0);
+	}
+
+	timeout = 0;
+	j = 0;
+	t0 = ktime_get();
+	while (timeout < 10000) {
+		udelay(10);
+		timeout++;
+		for (i = 1; (i < 8) && (j < 8); i++) {
+			res = post_office_read(zr, i, 0);
+			if (res != guest[i]) {
+				t1 = ktime_get();
+				change[j][0] = ktime_to_us(ktime_sub(t1, t0));
+				t0 = t1;
+				change[j][1] = i;
+				change[j][2] = res;
+				j++;
+				guest[i] = res;
+			}
+		}
+		if (j >= 8)
+			break;
+	}
+
+	printk(KERN_INFO "%s: Guests: %*ph\n", ZR_DEVNAME(zr), 8, guest0);
+
+	if (j == 0) {
+		printk(KERN_INFO "%s: No activity detected.\n", ZR_DEVNAME(zr));
+		return;
+	}
+	for (i = 0; i < j; i++) {
+		printk(KERN_INFO "%s: %6d: %d => 0x%02x\n", ZR_DEVNAME(zr),
+		       change[i][0], change[i][1], change[i][2]);
+	}
+}
+
+/*
+ * JPEG Codec access
+ */
+
+void
+jpeg_codec_sleep (struct zoran *zr,
+		  int           sleep)
+{
+	GPIO(zr, zr->card.gpio[ZR_GPIO_JPEG_SLEEP], !sleep);
+	if (!sleep) {
+		dprintk(3,
+			KERN_DEBUG
+			"%s: jpeg_codec_sleep() - wake GPIO=0x%08x\n",
+			ZR_DEVNAME(zr), btread(ZR36057_GPPGCR1));
+		udelay(500);
+	} else {
+		dprintk(3,
+			KERN_DEBUG
+			"%s: jpeg_codec_sleep() - sleep GPIO=0x%08x\n",
+			ZR_DEVNAME(zr), btread(ZR36057_GPPGCR1));
+		udelay(2);
+	}
+}
+
+int
+jpeg_codec_reset (struct zoran *zr)
+{
+	/* Take the codec out of sleep */
+	jpeg_codec_sleep(zr, 0);
+
+	if (zr->card.gpcs[GPCS_JPEG_RESET] != 0xff) {
+		post_office_write(zr, zr->card.gpcs[GPCS_JPEG_RESET], 0,
+				  0);
+		udelay(2);
+	} else {
+		GPIO(zr, zr->card.gpio[ZR_GPIO_JPEG_RESET], 0);
+		udelay(2);
+		GPIO(zr, zr->card.gpio[ZR_GPIO_JPEG_RESET], 1);
+		udelay(2);
+	}
+
+	return 0;
+}
+
+/*
+ *   Set the registers for the size we have specified. Don't bother
+ *   trying to understand this without the ZR36057 manual in front of
+ *   you [AC].
+ *
+ *   PS: The manual is free for download in .pdf format from
+ *   www.zoran.com - nicely done those folks.
+ */
+
+static void
+zr36057_adjust_vfe (struct zoran          *zr,
+		    enum zoran_codec_mode  mode)
+{
+	u32 reg;
+
+	switch (mode) {
+	case BUZ_MODE_MOTION_DECOMPRESS:
+		btand(~ZR36057_VFESPFR_ExtFl, ZR36057_VFESPFR);
+		reg = btread(ZR36057_VFEHCR);
+		if ((reg & (1 << 10)) && zr->card.type != LML33R10) {
+			reg += ((1 << 10) | 1);
+		}
+		btwrite(reg, ZR36057_VFEHCR);
+		break;
+	case BUZ_MODE_MOTION_COMPRESS:
+	case BUZ_MODE_IDLE:
+	default:
+		if ((zr->norm & V4L2_STD_NTSC) ||
+		    (zr->card.type == LML33R10 &&
+		     (zr->norm & V4L2_STD_PAL)))
+			btand(~ZR36057_VFESPFR_ExtFl, ZR36057_VFESPFR);
+		else
+			btor(ZR36057_VFESPFR_ExtFl, ZR36057_VFESPFR);
+		reg = btread(ZR36057_VFEHCR);
+		if (!(reg & (1 << 10)) && zr->card.type != LML33R10) {
+			reg -= ((1 << 10) | 1);
+		}
+		btwrite(reg, ZR36057_VFEHCR);
+		break;
+	}
+}
+
+/*
+ * set geometry
+ */
+
+static void
+zr36057_set_vfe (struct zoran              *zr,
+		 int                        video_width,
+		 int                        video_height,
+		 const struct zoran_format *format)
+{
+	struct tvnorm *tvn;
+	unsigned HStart, HEnd, VStart, VEnd;
+	unsigned DispMode;
+	unsigned VidWinWid, VidWinHt;
+	unsigned hcrop1, hcrop2, vcrop1, vcrop2;
+	unsigned Wa, We, Ha, He;
+	unsigned X, Y, HorDcm, VerDcm;
+	u32 reg;
+	unsigned mask_line_size;
+
+	tvn = zr->timing;
+
+	Wa = tvn->Wa;
+	Ha = tvn->Ha;
+
+	dprintk(2, KERN_INFO "%s: set_vfe() - width = %d, height = %d\n",
+		ZR_DEVNAME(zr), video_width, video_height);
+
+	if (video_width < BUZ_MIN_WIDTH ||
+	    video_height < BUZ_MIN_HEIGHT ||
+	    video_width > Wa || video_height > Ha) {
+		dprintk(1, KERN_ERR "%s: set_vfe: w=%d h=%d not valid\n",
+			ZR_DEVNAME(zr), video_width, video_height);
+		return;
+	}
+
+	/**** zr36057 ****/
+
+	/* horizontal */
+	VidWinWid = video_width;
+	X = DIV_ROUND_UP(VidWinWid * 64, tvn->Wa);
+	We = (VidWinWid * 64) / X;
+	HorDcm = 64 - X;
+	hcrop1 = 2 * ((tvn->Wa - We) / 4);
+	hcrop2 = tvn->Wa - We - hcrop1;
+	HStart = tvn->HStart ? tvn->HStart : 1;
+	/* (Ronald) Original comment:
+	 * "| 1 Doesn't have any effect, tested on both a DC10 and a DC10+"
+	 * this is false. It inverses chroma values on the LML33R10 (so Cr
+	 * suddenly is shown as Cb and reverse, really cool effect if you
+	 * want to see blue faces, not useful otherwise). So don't use |1.
+	 * However, the DC10 has '0' as HStart, but does need |1, so we
+	 * use a dirty check...
+	 */
+	HEnd = HStart + tvn->Wa - 1;
+	HStart += hcrop1;
+	HEnd -= hcrop2;
+	reg = ((HStart & ZR36057_VFEHCR_Hmask) << ZR36057_VFEHCR_HStart)
+	    | ((HEnd & ZR36057_VFEHCR_Hmask) << ZR36057_VFEHCR_HEnd);
+	if (zr->card.vfe_pol.hsync_pol)
+		reg |= ZR36057_VFEHCR_HSPol;
+	btwrite(reg, ZR36057_VFEHCR);
+
+	/* Vertical */
+	DispMode = !(video_height > BUZ_MAX_HEIGHT / 2);
+	VidWinHt = DispMode ? video_height : video_height / 2;
+	Y = DIV_ROUND_UP(VidWinHt * 64 * 2, tvn->Ha);
+	He = (VidWinHt * 64) / Y;
+	VerDcm = 64 - Y;
+	vcrop1 = (tvn->Ha / 2 - He) / 2;
+	vcrop2 = tvn->Ha / 2 - He - vcrop1;
+	VStart = tvn->VStart;
+	VEnd = VStart + tvn->Ha / 2;	// - 1; FIXME SnapShot times out with -1 in 768*576 on the DC10 - LP
+	VStart += vcrop1;
+	VEnd -= vcrop2;
+	reg = ((VStart & ZR36057_VFEVCR_Vmask) << ZR36057_VFEVCR_VStart)
+	    | ((VEnd & ZR36057_VFEVCR_Vmask) << ZR36057_VFEVCR_VEnd);
+	if (zr->card.vfe_pol.vsync_pol)
+		reg |= ZR36057_VFEVCR_VSPol;
+	btwrite(reg, ZR36057_VFEVCR);
+
+	/* scaler and pixel format */
+	reg = 0;
+	reg |= (HorDcm << ZR36057_VFESPFR_HorDcm);
+	reg |= (VerDcm << ZR36057_VFESPFR_VerDcm);
+	reg |= (DispMode << ZR36057_VFESPFR_DispMode);
+	/* RJ: I don't know, why the following has to be the opposite
+	 * of the corresponding ZR36060 setting, but only this way
+	 * we get the correct colors when uncompressing to the screen  */
+	//reg |= ZR36057_VFESPFR_VCLKPol; /**/
+	/* RJ: Don't know if that is needed for NTSC also */
+	if (!(zr->norm & V4L2_STD_NTSC))
+		reg |= ZR36057_VFESPFR_ExtFl;	// NEEDED!!!!!!! Wolfgang
+	reg |= ZR36057_VFESPFR_TopField;
+	if (HorDcm >= 48) {
+		reg |= 3 << ZR36057_VFESPFR_HFilter;	/* 5 tap filter */
+	} else if (HorDcm >= 32) {
+		reg |= 2 << ZR36057_VFESPFR_HFilter;	/* 4 tap filter */
+	} else if (HorDcm >= 16) {
+		reg |= 1 << ZR36057_VFESPFR_HFilter;	/* 3 tap filter */
+	}
+	reg |= format->vfespfr;
+	btwrite(reg, ZR36057_VFESPFR);
+
+	/* display configuration */
+	reg = (16 << ZR36057_VDCR_MinPix)
+	    | (VidWinHt << ZR36057_VDCR_VidWinHt)
+	    | (VidWinWid << ZR36057_VDCR_VidWinWid);
+	if (pci_pci_problems & PCIPCI_TRITON)
+		// || zr->revision < 1) // Revision 1 has also Triton support
+		reg &= ~ZR36057_VDCR_Triton;
+	else
+		reg |= ZR36057_VDCR_Triton;
+	btwrite(reg, ZR36057_VDCR);
+
+	/* (Ronald) don't write this if overlay_mask = NULL */
+	if (zr->overlay_mask) {
+		/* Write overlay clipping mask data, but don't enable overlay clipping */
+		/* RJ: since this makes only sense on the screen, we use
+		 * zr->overlay_settings.width instead of video_width */
+
+		mask_line_size = (BUZ_MAX_WIDTH + 31) / 32;
+		reg = virt_to_bus(zr->overlay_mask);
+		btwrite(reg, ZR36057_MMTR);
+		reg = virt_to_bus(zr->overlay_mask + mask_line_size);
+		btwrite(reg, ZR36057_MMBR);
+		reg =
+		    mask_line_size - (zr->overlay_settings.width +
+				      31) / 32;
+		if (DispMode == 0)
+			reg += mask_line_size;
+		reg <<= ZR36057_OCR_MaskStride;
+		btwrite(reg, ZR36057_OCR);
+	}
+
+	zr36057_adjust_vfe(zr, zr->codec_mode);
+}
+
+/*
+ * Switch overlay on or off
+ */
+
+void
+zr36057_overlay (struct zoran *zr,
+		 int           on)
+{
+	u32 reg;
+
+	if (on) {
+		/* do the necessary settings ... */
+		btand(~ZR36057_VDCR_VidEn, ZR36057_VDCR);	/* switch it off first */
+
+		zr36057_set_vfe(zr,
+				zr->overlay_settings.width,
+				zr->overlay_settings.height,
+				zr->overlay_settings.format);
+
+		/* Start and length of each line MUST be 4-byte aligned.
+		 * This should be already checked before the call to this routine.
+		 * All error messages are internal driver checking only! */
+
+		/* video display top and bottom registers */
+		reg = (long) zr->vbuf_base +
+		    zr->overlay_settings.x *
+		    ((zr->overlay_settings.format->depth + 7) / 8) +
+		    zr->overlay_settings.y *
+		    zr->vbuf_bytesperline;
+		btwrite(reg, ZR36057_VDTR);
+		if (reg & 3)
+			dprintk(1,
+				KERN_ERR
+				"%s: zr36057_overlay() - video_address not aligned\n",
+				ZR_DEVNAME(zr));
+		if (zr->overlay_settings.height > BUZ_MAX_HEIGHT / 2)
+			reg += zr->vbuf_bytesperline;
+		btwrite(reg, ZR36057_VDBR);
+
+		/* video stride, status, and frame grab register */
+		reg = zr->vbuf_bytesperline -
+		    zr->overlay_settings.width *
+		    ((zr->overlay_settings.format->depth + 7) / 8);
+		if (zr->overlay_settings.height > BUZ_MAX_HEIGHT / 2)
+			reg += zr->vbuf_bytesperline;
+		if (reg & 3)
+			dprintk(1,
+				KERN_ERR
+				"%s: zr36057_overlay() - video_stride not aligned\n",
+				ZR_DEVNAME(zr));
+		reg = (reg << ZR36057_VSSFGR_DispStride);
+		reg |= ZR36057_VSSFGR_VidOvf;	/* clear overflow status */
+		btwrite(reg, ZR36057_VSSFGR);
+
+		/* Set overlay clipping */
+		if (zr->overlay_settings.clipcount > 0)
+			btor(ZR36057_OCR_OvlEnable, ZR36057_OCR);
+
+		/* ... and switch it on */
+		btor(ZR36057_VDCR_VidEn, ZR36057_VDCR);
+	} else {
+		/* Switch it off */
+		btand(~ZR36057_VDCR_VidEn, ZR36057_VDCR);
+	}
+}
+
+/*
+ * The overlay mask has one bit for each pixel on a scan line,
+ *  and the maximum window size is BUZ_MAX_WIDTH * BUZ_MAX_HEIGHT pixels.
+ */
+
+void write_overlay_mask(struct zoran_fh *fh, struct v4l2_clip *vp, int count)
+{
+	struct zoran *zr = fh->zr;
+	unsigned mask_line_size = (BUZ_MAX_WIDTH + 31) / 32;
+	u32 *mask;
+	int x, y, width, height;
+	unsigned i, j, k;
+
+	/* fill mask with one bits */
+	memset(fh->overlay_mask, ~0, mask_line_size * 4 * BUZ_MAX_HEIGHT);
+
+	for (i = 0; i < count; ++i) {
+		/* pick up local copy of clip */
+		x = vp[i].c.left;
+		y = vp[i].c.top;
+		width = vp[i].c.width;
+		height = vp[i].c.height;
+
+		/* trim clips that extend beyond the window */
+		if (x < 0) {
+			width += x;
+			x = 0;
+		}
+		if (y < 0) {
+			height += y;
+			y = 0;
+		}
+		if (x + width > fh->overlay_settings.width) {
+			width = fh->overlay_settings.width - x;
+		}
+		if (y + height > fh->overlay_settings.height) {
+			height = fh->overlay_settings.height - y;
+		}
+
+		/* ignore degenerate clips */
+		if (height <= 0) {
+			continue;
+		}
+		if (width <= 0) {
+			continue;
+		}
+
+		/* apply clip for each scan line */
+		for (j = 0; j < height; ++j) {
+			/* reset bit for each pixel */
+			/* this can be optimized later if need be */
+			mask = fh->overlay_mask + (y + j) * mask_line_size;
+			for (k = 0; k < width; ++k) {
+				mask[(x + k) / 32] &=
+				    ~((u32) 1 << (x + k) % 32);
+			}
+		}
+	}
+}
+
+/* Enable/Disable uncompressed memory grabbing of the 36057 */
+
+void
+zr36057_set_memgrab (struct zoran *zr,
+		     int           mode)
+{
+	if (mode) {
+		/* We only check SnapShot and not FrameGrab here.  SnapShot==1
+		 * means a capture is already in progress, but FrameGrab==1
+		 * doesn't necessary mean that.  It's more correct to say a 1
+		 * to 0 transition indicates a capture completed.  If a
+		 * capture is pending when capturing is tuned off, FrameGrab
+		 * will be stuck at 1 until capturing is turned back on.
+		 */
+		if (btread(ZR36057_VSSFGR) & ZR36057_VSSFGR_SnapShot)
+			dprintk(1,
+				KERN_WARNING
+				"%s: zr36057_set_memgrab(1) with SnapShot on!?\n",
+				ZR_DEVNAME(zr));
+
+		/* switch on VSync interrupts */
+		btwrite(IRQ_MASK, ZR36057_ISR);	// Clear Interrupts
+		btor(zr->card.vsync_int, ZR36057_ICR);	// SW
+
+		/* enable SnapShot */
+		btor(ZR36057_VSSFGR_SnapShot, ZR36057_VSSFGR);
+
+		/* Set zr36057 video front end  and enable video */
+		zr36057_set_vfe(zr, zr->v4l_settings.width,
+				zr->v4l_settings.height,
+				zr->v4l_settings.format);
+
+		zr->v4l_memgrab_active = 1;
+	} else {
+		/* switch off VSync interrupts */
+		btand(~zr->card.vsync_int, ZR36057_ICR);	// SW
+
+		zr->v4l_memgrab_active = 0;
+		zr->v4l_grab_frame = NO_GRAB_ACTIVE;
+
+		/* re-enable grabbing to screen if it was running */
+		if (zr->v4l_overlay_active) {
+			zr36057_overlay(zr, 1);
+		} else {
+			btand(~ZR36057_VDCR_VidEn, ZR36057_VDCR);
+			btand(~ZR36057_VSSFGR_SnapShot, ZR36057_VSSFGR);
+		}
+	}
+}
+
+int
+wait_grab_pending (struct zoran *zr)
+{
+	unsigned long flags;
+
+	/* wait until all pending grabs are finished */
+
+	if (!zr->v4l_memgrab_active)
+		return 0;
+
+	wait_event_interruptible(zr->v4l_capq,
+			(zr->v4l_pend_tail == zr->v4l_pend_head));
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	spin_lock_irqsave(&zr->spinlock, flags);
+	zr36057_set_memgrab(zr, 0);
+	spin_unlock_irqrestore(&zr->spinlock, flags);
+
+	return 0;
+}
+
+/*****************************************************************************
+ *                                                                           *
+ *  Set up the Buz-specific MJPEG part                                       *
+ *                                                                           *
+ *****************************************************************************/
+
+static inline void
+set_frame (struct zoran *zr,
+	   int           val)
+{
+	GPIO(zr, zr->card.gpio[ZR_GPIO_JPEG_FRAME], val);
+}
+
+static void
+set_videobus_dir (struct zoran *zr,
+		  int           val)
+{
+	switch (zr->card.type) {
+	case LML33:
+	case LML33R10:
+		if (!lml33dpath)
+			GPIO(zr, 5, val);
+		else
+			GPIO(zr, 5, 1);
+		break;
+	default:
+		GPIO(zr, zr->card.gpio[ZR_GPIO_VID_DIR],
+		     zr->card.gpio_pol[ZR_GPIO_VID_DIR] ? !val : val);
+		break;
+	}
+}
+
+static void
+init_jpeg_queue (struct zoran *zr)
+{
+	int i;
+
+	/* re-initialize DMA ring stuff */
+	zr->jpg_que_head = 0;
+	zr->jpg_dma_head = 0;
+	zr->jpg_dma_tail = 0;
+	zr->jpg_que_tail = 0;
+	zr->jpg_seq_num = 0;
+	zr->JPEG_error = 0;
+	zr->num_errors = 0;
+	zr->jpg_err_seq = 0;
+	zr->jpg_err_shift = 0;
+	zr->jpg_queued_num = 0;
+	for (i = 0; i < zr->jpg_buffers.num_buffers; i++) {
+		zr->jpg_buffers.buffer[i].state = BUZ_STATE_USER;	/* nothing going on */
+	}
+	for (i = 0; i < BUZ_NUM_STAT_COM; i++) {
+		zr->stat_com[i] = cpu_to_le32(1);	/* mark as unavailable to zr36057 */
+	}
+}
+
+static void
+zr36057_set_jpg (struct zoran          *zr,
+		 enum zoran_codec_mode  mode)
+{
+	struct tvnorm *tvn;
+	u32 reg;
+
+	tvn = zr->timing;
+
+	/* assert P_Reset, disable code transfer, deassert Active */
+	btwrite(0, ZR36057_JPC);
+
+	/* MJPEG compression mode */
+	switch (mode) {
+
+	case BUZ_MODE_MOTION_COMPRESS:
+	default:
+		reg = ZR36057_JMC_MJPGCmpMode;
+		break;
+
+	case BUZ_MODE_MOTION_DECOMPRESS:
+		reg = ZR36057_JMC_MJPGExpMode;
+		reg |= ZR36057_JMC_SyncMstr;
+		/* RJ: The following is experimental - improves the output to screen */
+		//if(zr->jpg_settings.VFIFO_FB) reg |= ZR36057_JMC_VFIFO_FB; // No, it doesn't. SM
+		break;
+
+	case BUZ_MODE_STILL_COMPRESS:
+		reg = ZR36057_JMC_JPGCmpMode;
+		break;
+
+	case BUZ_MODE_STILL_DECOMPRESS:
+		reg = ZR36057_JMC_JPGExpMode;
+		break;
+
+	}
+	reg |= ZR36057_JMC_JPG;
+	if (zr->jpg_settings.field_per_buff == 1)
+		reg |= ZR36057_JMC_Fld_per_buff;
+	btwrite(reg, ZR36057_JMC);
+
+	/* vertical */
+	btor(ZR36057_VFEVCR_VSPol, ZR36057_VFEVCR);
+	reg = (6 << ZR36057_VSP_VsyncSize) |
+	      (tvn->Ht << ZR36057_VSP_FrmTot);
+	btwrite(reg, ZR36057_VSP);
+	reg = ((zr->jpg_settings.img_y + tvn->VStart) << ZR36057_FVAP_NAY) |
+	      (zr->jpg_settings.img_height << ZR36057_FVAP_PAY);
+	btwrite(reg, ZR36057_FVAP);
+
+	/* horizontal */
+	if (zr->card.vfe_pol.hsync_pol)
+		btor(ZR36057_VFEHCR_HSPol, ZR36057_VFEHCR);
+	else
+		btand(~ZR36057_VFEHCR_HSPol, ZR36057_VFEHCR);
+	reg = ((tvn->HSyncStart) << ZR36057_HSP_HsyncStart) |
+	      (tvn->Wt << ZR36057_HSP_LineTot);
+	btwrite(reg, ZR36057_HSP);
+	reg = ((zr->jpg_settings.img_x +
+		tvn->HStart + 4) << ZR36057_FHAP_NAX) |
+	      (zr->jpg_settings.img_width << ZR36057_FHAP_PAX);
+	btwrite(reg, ZR36057_FHAP);
+
+	/* field process parameters */
+	if (zr->jpg_settings.odd_even)
+		reg = ZR36057_FPP_Odd_Even;
+	else
+		reg = 0;
+
+	btwrite(reg, ZR36057_FPP);
+
+	/* Set proper VCLK Polarity, else colors will be wrong during playback */
+	//btor(ZR36057_VFESPFR_VCLKPol, ZR36057_VFESPFR);
+
+	/* code base address */
+	reg = virt_to_bus(zr->stat_com);
+	btwrite(reg, ZR36057_JCBA);
+
+	/* FIFO threshold (FIFO is 160. double words) */
+	/* NOTE: decimal values here */
+	switch (mode) {
+
+	case BUZ_MODE_STILL_COMPRESS:
+	case BUZ_MODE_MOTION_COMPRESS:
+		if (zr->card.type != BUZ)
+			reg = 140;
+		else
+			reg = 60;
+		break;
+
+	case BUZ_MODE_STILL_DECOMPRESS:
+	case BUZ_MODE_MOTION_DECOMPRESS:
+		reg = 20;
+		break;
+
+	default:
+		reg = 80;
+		break;
+
+	}
+	btwrite(reg, ZR36057_JCFT);
+	zr36057_adjust_vfe(zr, mode);
+
+}
+
+void
+print_interrupts (struct zoran *zr)
+{
+	int res, noerr = 0;
+
+	printk(KERN_INFO "%s: interrupts received:", ZR_DEVNAME(zr));
+	if ((res = zr->field_counter) < -1 || res > 1) {
+		printk(KERN_CONT " FD:%d", res);
+	}
+	if ((res = zr->intr_counter_GIRQ1) != 0) {
+		printk(KERN_CONT " GIRQ1:%d", res);
+		noerr++;
+	}
+	if ((res = zr->intr_counter_GIRQ0) != 0) {
+		printk(KERN_CONT " GIRQ0:%d", res);
+		noerr++;
+	}
+	if ((res = zr->intr_counter_CodRepIRQ) != 0) {
+		printk(KERN_CONT " CodRepIRQ:%d", res);
+		noerr++;
+	}
+	if ((res = zr->intr_counter_JPEGRepIRQ) != 0) {
+		printk(KERN_CONT " JPEGRepIRQ:%d", res);
+		noerr++;
+	}
+	if (zr->JPEG_max_missed) {
+		printk(KERN_CONT " JPEG delays: max=%d min=%d", zr->JPEG_max_missed,
+		       zr->JPEG_min_missed);
+	}
+	if (zr->END_event_missed) {
+		printk(KERN_CONT " ENDs missed: %d", zr->END_event_missed);
+	}
+	//if (zr->jpg_queued_num) {
+	printk(KERN_CONT " queue_state=%ld/%ld/%ld/%ld", zr->jpg_que_tail,
+	       zr->jpg_dma_tail, zr->jpg_dma_head, zr->jpg_que_head);
+	//}
+	if (!noerr) {
+		printk(KERN_CONT ": no interrupts detected.");
+	}
+	printk(KERN_CONT "\n");
+}
+
+void
+clear_interrupt_counters (struct zoran *zr)
+{
+	zr->intr_counter_GIRQ1 = 0;
+	zr->intr_counter_GIRQ0 = 0;
+	zr->intr_counter_CodRepIRQ = 0;
+	zr->intr_counter_JPEGRepIRQ = 0;
+	zr->field_counter = 0;
+	zr->IRQ1_in = 0;
+	zr->IRQ1_out = 0;
+	zr->JPEG_in = 0;
+	zr->JPEG_out = 0;
+	zr->JPEG_0 = 0;
+	zr->JPEG_1 = 0;
+	zr->END_event_missed = 0;
+	zr->JPEG_missed = 0;
+	zr->JPEG_max_missed = 0;
+	zr->JPEG_min_missed = 0x7fffffff;
+}
+
+static u32
+count_reset_interrupt (struct zoran *zr)
+{
+	u32 isr;
+
+	if ((isr = btread(ZR36057_ISR) & 0x78000000)) {
+		if (isr & ZR36057_ISR_GIRQ1) {
+			btwrite(ZR36057_ISR_GIRQ1, ZR36057_ISR);
+			zr->intr_counter_GIRQ1++;
+		}
+		if (isr & ZR36057_ISR_GIRQ0) {
+			btwrite(ZR36057_ISR_GIRQ0, ZR36057_ISR);
+			zr->intr_counter_GIRQ0++;
+		}
+		if (isr & ZR36057_ISR_CodRepIRQ) {
+			btwrite(ZR36057_ISR_CodRepIRQ, ZR36057_ISR);
+			zr->intr_counter_CodRepIRQ++;
+		}
+		if (isr & ZR36057_ISR_JPEGRepIRQ) {
+			btwrite(ZR36057_ISR_JPEGRepIRQ, ZR36057_ISR);
+			zr->intr_counter_JPEGRepIRQ++;
+		}
+	}
+	return isr;
+}
+
+void
+jpeg_start (struct zoran *zr)
+{
+	int reg;
+
+	zr->frame_num = 0;
+
+	/* deassert P_reset, disable code transfer, deassert Active */
+	btwrite(ZR36057_JPC_P_Reset, ZR36057_JPC);
+	/* stop flushing the internal code buffer */
+	btand(~ZR36057_MCTCR_CFlush, ZR36057_MCTCR);
+	/* enable code transfer */
+	btor(ZR36057_JPC_CodTrnsEn, ZR36057_JPC);
+
+	/* clear IRQs */
+	btwrite(IRQ_MASK, ZR36057_ISR);
+	/* enable the JPEG IRQs */
+	btwrite(zr->card.jpeg_int |
+			ZR36057_ICR_JPEGRepIRQ |
+			ZR36057_ICR_IntPinEn,
+		ZR36057_ICR);
+
+	set_frame(zr, 0);	// \FRAME
+
+	/* set the JPEG codec guest ID */
+	reg = (zr->card.gpcs[1] << ZR36057_JCGI_JPEGuestID) |
+	       (0 << ZR36057_JCGI_JPEGuestReg);
+	btwrite(reg, ZR36057_JCGI);
+
+	if (zr->card.video_vfe == CODEC_TYPE_ZR36016 &&
+	    zr->card.video_codec == CODEC_TYPE_ZR36050) {
+		/* Enable processing on the ZR36016 */
+		if (zr->vfe)
+			zr36016_write(zr->vfe, 0, 1);
+
+		/* load the address of the GO register in the ZR36050 latch */
+		post_office_write(zr, 0, 0, 0);
+	}
+
+	/* assert Active */
+	btor(ZR36057_JPC_Active, ZR36057_JPC);
+
+	/* enable the Go generation */
+	btor(ZR36057_JMC_Go_en, ZR36057_JMC);
+	udelay(30);
+
+	set_frame(zr, 1);	// /FRAME
+
+	dprintk(3, KERN_DEBUG "%s: jpeg_start\n", ZR_DEVNAME(zr));
+}
+
+void
+zr36057_enable_jpg (struct zoran          *zr,
+		    enum zoran_codec_mode  mode)
+{
+	struct vfe_settings cap;
+	int field_size =
+	    zr->jpg_buffers.buffer_size / zr->jpg_settings.field_per_buff;
+
+	zr->codec_mode = mode;
+
+	cap.x = zr->jpg_settings.img_x;
+	cap.y = zr->jpg_settings.img_y;
+	cap.width = zr->jpg_settings.img_width;
+	cap.height = zr->jpg_settings.img_height;
+	cap.decimation =
+	    zr->jpg_settings.HorDcm | (zr->jpg_settings.VerDcm << 8);
+	cap.quality = zr->jpg_settings.jpg_comp.quality;
+
+	switch (mode) {
+
+	case BUZ_MODE_MOTION_COMPRESS: {
+		struct jpeg_app_marker app;
+		struct jpeg_com_marker com;
+
+		/* In motion compress mode, the decoder output must be enabled, and
+		 * the video bus direction set to input.
+		 */
+		set_videobus_dir(zr, 0);
+		decoder_call(zr, video, s_stream, 1);
+		encoder_call(zr, video, s_routing, 0, 0, 0);
+
+		/* Take the JPEG codec and the VFE out of sleep */
+		jpeg_codec_sleep(zr, 0);
+
+		/* set JPEG app/com marker */
+		app.appn = zr->jpg_settings.jpg_comp.APPn;
+		app.len = zr->jpg_settings.jpg_comp.APP_len;
+		memcpy(app.data, zr->jpg_settings.jpg_comp.APP_data, 60);
+		zr->codec->control(zr->codec, CODEC_S_JPEG_APP_DATA,
+				   sizeof(struct jpeg_app_marker), &app);
+
+		com.len = zr->jpg_settings.jpg_comp.COM_len;
+		memcpy(com.data, zr->jpg_settings.jpg_comp.COM_data, 60);
+		zr->codec->control(zr->codec, CODEC_S_JPEG_COM_DATA,
+				   sizeof(struct jpeg_com_marker), &com);
+
+		/* Setup the JPEG codec */
+		zr->codec->control(zr->codec, CODEC_S_JPEG_TDS_BYTE,
+				   sizeof(int), &field_size);
+		zr->codec->set_video(zr->codec, zr->timing, &cap,
+				     &zr->card.vfe_pol);
+		zr->codec->set_mode(zr->codec, CODEC_DO_COMPRESSION);
+
+		/* Setup the VFE */
+		if (zr->vfe) {
+			zr->vfe->control(zr->vfe, CODEC_S_JPEG_TDS_BYTE,
+					 sizeof(int), &field_size);
+			zr->vfe->set_video(zr->vfe, zr->timing, &cap,
+					   &zr->card.vfe_pol);
+			zr->vfe->set_mode(zr->vfe, CODEC_DO_COMPRESSION);
+		}
+
+		init_jpeg_queue(zr);
+		zr36057_set_jpg(zr, mode);	// \P_Reset, ... Video param, FIFO
+
+		clear_interrupt_counters(zr);
+		dprintk(2, KERN_INFO "%s: enable_jpg(MOTION_COMPRESS)\n",
+			ZR_DEVNAME(zr));
+		break;
+	}
+
+	case BUZ_MODE_MOTION_DECOMPRESS:
+		/* In motion decompression mode, the decoder output must be disabled, and
+		 * the video bus direction set to output.
+		 */
+		decoder_call(zr, video, s_stream, 0);
+		set_videobus_dir(zr, 1);
+		encoder_call(zr, video, s_routing, 1, 0, 0);
+
+		/* Take the JPEG codec and the VFE out of sleep */
+		jpeg_codec_sleep(zr, 0);
+		/* Setup the VFE */
+		if (zr->vfe) {
+			zr->vfe->set_video(zr->vfe, zr->timing, &cap,
+					   &zr->card.vfe_pol);
+			zr->vfe->set_mode(zr->vfe, CODEC_DO_EXPANSION);
+		}
+		/* Setup the JPEG codec */
+		zr->codec->set_video(zr->codec, zr->timing, &cap,
+				     &zr->card.vfe_pol);
+		zr->codec->set_mode(zr->codec, CODEC_DO_EXPANSION);
+
+		init_jpeg_queue(zr);
+		zr36057_set_jpg(zr, mode);	// \P_Reset, ... Video param, FIFO
+
+		clear_interrupt_counters(zr);
+		dprintk(2, KERN_INFO "%s: enable_jpg(MOTION_DECOMPRESS)\n",
+			ZR_DEVNAME(zr));
+		break;
+
+	case BUZ_MODE_IDLE:
+	default:
+		/* shut down processing */
+		btand(~(zr->card.jpeg_int | ZR36057_ICR_JPEGRepIRQ),
+		      ZR36057_ICR);
+		btwrite(zr->card.jpeg_int | ZR36057_ICR_JPEGRepIRQ,
+			ZR36057_ISR);
+		btand(~ZR36057_JMC_Go_en, ZR36057_JMC);	// \Go_en
+
+		msleep(50);
+
+		set_videobus_dir(zr, 0);
+		set_frame(zr, 1);	// /FRAME
+		btor(ZR36057_MCTCR_CFlush, ZR36057_MCTCR);	// /CFlush
+		btwrite(0, ZR36057_JPC);	// \P_Reset,\CodTrnsEn,\Active
+		btand(~ZR36057_JMC_VFIFO_FB, ZR36057_JMC);
+		btand(~ZR36057_JMC_SyncMstr, ZR36057_JMC);
+		jpeg_codec_reset(zr);
+		jpeg_codec_sleep(zr, 1);
+		zr36057_adjust_vfe(zr, mode);
+
+		decoder_call(zr, video, s_stream, 1);
+		encoder_call(zr, video, s_routing, 0, 0, 0);
+
+		dprintk(2, KERN_INFO "%s: enable_jpg(IDLE)\n", ZR_DEVNAME(zr));
+		break;
+
+	}
+}
+
+/* when this is called the spinlock must be held */
+void
+zoran_feed_stat_com (struct zoran *zr)
+{
+	/* move frames from pending queue to DMA */
+
+	int frame, i, max_stat_com;
+
+	max_stat_com =
+	    (zr->jpg_settings.TmpDcm ==
+	     1) ? BUZ_NUM_STAT_COM : (BUZ_NUM_STAT_COM >> 1);
+
+	while ((zr->jpg_dma_head - zr->jpg_dma_tail) < max_stat_com &&
+	       zr->jpg_dma_head < zr->jpg_que_head) {
+
+		frame = zr->jpg_pend[zr->jpg_dma_head & BUZ_MASK_FRAME];
+		if (zr->jpg_settings.TmpDcm == 1) {
+			/* fill 1 stat_com entry */
+			i = (zr->jpg_dma_head -
+			     zr->jpg_err_shift) & BUZ_MASK_STAT_COM;
+			if (!(zr->stat_com[i] & cpu_to_le32(1)))
+				break;
+			zr->stat_com[i] =
+			    cpu_to_le32(zr->jpg_buffers.buffer[frame].jpg.frag_tab_bus);
+		} else {
+			/* fill 2 stat_com entries */
+			i = ((zr->jpg_dma_head -
+			      zr->jpg_err_shift) & 1) * 2;
+			if (!(zr->stat_com[i] & cpu_to_le32(1)))
+				break;
+			zr->stat_com[i] =
+			    cpu_to_le32(zr->jpg_buffers.buffer[frame].jpg.frag_tab_bus);
+			zr->stat_com[i + 1] =
+			    cpu_to_le32(zr->jpg_buffers.buffer[frame].jpg.frag_tab_bus);
+		}
+		zr->jpg_buffers.buffer[frame].state = BUZ_STATE_DMA;
+		zr->jpg_dma_head++;
+
+	}
+	if (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS)
+		zr->jpg_queued_num++;
+}
+
+/* when this is called the spinlock must be held */
+static void
+zoran_reap_stat_com (struct zoran *zr)
+{
+	/* move frames from DMA queue to done queue */
+
+	int i;
+	u32 stat_com;
+	unsigned int seq;
+	unsigned int dif;
+	struct zoran_buffer *buffer;
+	int frame;
+
+	/* In motion decompress we don't have a hardware frame counter,
+	 * we just count the interrupts here */
+
+	if (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS) {
+		zr->jpg_seq_num++;
+	}
+	while (zr->jpg_dma_tail < zr->jpg_dma_head) {
+		if (zr->jpg_settings.TmpDcm == 1)
+			i = (zr->jpg_dma_tail -
+			     zr->jpg_err_shift) & BUZ_MASK_STAT_COM;
+		else
+			i = ((zr->jpg_dma_tail -
+			      zr->jpg_err_shift) & 1) * 2 + 1;
+
+		stat_com = le32_to_cpu(zr->stat_com[i]);
+
+		if ((stat_com & 1) == 0) {
+			return;
+		}
+		frame = zr->jpg_pend[zr->jpg_dma_tail & BUZ_MASK_FRAME];
+		buffer = &zr->jpg_buffers.buffer[frame];
+		buffer->bs.ts = ktime_get_ns();
+
+		if (zr->codec_mode == BUZ_MODE_MOTION_COMPRESS) {
+			buffer->bs.length = (stat_com & 0x7fffff) >> 1;
+
+			/* update sequence number with the help of the counter in stat_com */
+
+			seq = ((stat_com >> 24) + zr->jpg_err_seq) & 0xff;
+			dif = (seq - zr->jpg_seq_num) & 0xff;
+			zr->jpg_seq_num += dif;
+		} else {
+			buffer->bs.length = 0;
+		}
+		buffer->bs.seq =
+		    zr->jpg_settings.TmpDcm ==
+		    2 ? (zr->jpg_seq_num >> 1) : zr->jpg_seq_num;
+		buffer->state = BUZ_STATE_DONE;
+
+		zr->jpg_dma_tail++;
+	}
+}
+
+static void zoran_restart(struct zoran *zr)
+{
+	/* Now the stat_comm buffer is ready for restart */
+	unsigned int status = 0;
+	int mode;
+
+	if (zr->codec_mode == BUZ_MODE_MOTION_COMPRESS) {
+		decoder_call(zr, video, g_input_status, &status);
+		mode = CODEC_DO_COMPRESSION;
+	} else {
+		status = V4L2_IN_ST_NO_SIGNAL;
+		mode = CODEC_DO_EXPANSION;
+	}
+	if (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS ||
+	    !(status & V4L2_IN_ST_NO_SIGNAL)) {
+		/********** RESTART code *************/
+		jpeg_codec_reset(zr);
+		zr->codec->set_mode(zr->codec, mode);
+		zr36057_set_jpg(zr, zr->codec_mode);
+		jpeg_start(zr);
+
+		if (zr->num_errors <= 8)
+			dprintk(2, KERN_INFO "%s: Restart\n",
+				ZR_DEVNAME(zr));
+
+		zr->JPEG_missed = 0;
+		zr->JPEG_error = 2;
+		/********** End RESTART code ***********/
+	}
+}
+
+static void
+error_handler (struct zoran *zr,
+	       u32           astat,
+	       u32           stat)
+{
+	int i;
+
+	/* This is JPEG error handling part */
+	if (zr->codec_mode != BUZ_MODE_MOTION_COMPRESS &&
+	    zr->codec_mode != BUZ_MODE_MOTION_DECOMPRESS) {
+		return;
+	}
+
+	if ((stat & 1) == 0 &&
+	    zr->codec_mode == BUZ_MODE_MOTION_COMPRESS &&
+	    zr->jpg_dma_tail - zr->jpg_que_tail >= zr->jpg_buffers.num_buffers) {
+		/* No free buffers... */
+		zoran_reap_stat_com(zr);
+		zoran_feed_stat_com(zr);
+		wake_up_interruptible(&zr->jpg_capq);
+		zr->JPEG_missed = 0;
+		return;
+	}
+
+	if (zr->JPEG_error == 1) {
+		zoran_restart(zr);
+		return;
+	}
+
+	/*
+	 * First entry: error just happened during normal operation
+	 *
+	 * In BUZ_MODE_MOTION_COMPRESS:
+	 *
+	 * Possible glitch in TV signal. In this case we should
+	 * stop the codec and wait for good quality signal before
+	 * restarting it to avoid further problems
+	 *
+	 * In BUZ_MODE_MOTION_DECOMPRESS:
+	 *
+	 * Bad JPEG frame: we have to mark it as processed (codec crashed
+	 * and was not able to do it itself), and to remove it from queue.
+	 */
+	btand(~ZR36057_JMC_Go_en, ZR36057_JMC);
+	udelay(1);
+	stat = stat | (post_office_read(zr, 7, 0) & 3) << 8;
+	btwrite(0, ZR36057_JPC);
+	btor(ZR36057_MCTCR_CFlush, ZR36057_MCTCR);
+	jpeg_codec_reset(zr);
+	jpeg_codec_sleep(zr, 1);
+	zr->JPEG_error = 1;
+	zr->num_errors++;
+
+	/* Report error */
+	if (zr36067_debug > 1 && zr->num_errors <= 8) {
+		long frame;
+		int j;
+
+		frame = zr->jpg_pend[zr->jpg_dma_tail & BUZ_MASK_FRAME];
+		printk(KERN_ERR
+		       "%s: JPEG error stat=0x%08x(0x%08x) queue_state=%ld/%ld/%ld/%ld seq=%ld frame=%ld. Codec stopped. ",
+		       ZR_DEVNAME(zr), stat, zr->last_isr,
+		       zr->jpg_que_tail, zr->jpg_dma_tail,
+		       zr->jpg_dma_head, zr->jpg_que_head,
+		       zr->jpg_seq_num, frame);
+		printk(KERN_INFO "stat_com frames:");
+		for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
+			for (i = 0; i < zr->jpg_buffers.num_buffers; i++) {
+				if (le32_to_cpu(zr->stat_com[j]) == zr->jpg_buffers.buffer[i].jpg.frag_tab_bus)
+					printk(KERN_CONT "% d->%d", j, i);
+			}
+		}
+		printk(KERN_CONT "\n");
+	}
+	/* Find an entry in stat_com and rotate contents */
+	if (zr->jpg_settings.TmpDcm == 1)
+		i = (zr->jpg_dma_tail - zr->jpg_err_shift) & BUZ_MASK_STAT_COM;
+	else
+		i = ((zr->jpg_dma_tail - zr->jpg_err_shift) & 1) * 2;
+	if (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS) {
+		/* Mimic zr36067 operation */
+		zr->stat_com[i] |= cpu_to_le32(1);
+		if (zr->jpg_settings.TmpDcm != 1)
+			zr->stat_com[i + 1] |= cpu_to_le32(1);
+		/* Refill */
+		zoran_reap_stat_com(zr);
+		zoran_feed_stat_com(zr);
+		wake_up_interruptible(&zr->jpg_capq);
+		/* Find an entry in stat_com again after refill */
+		if (zr->jpg_settings.TmpDcm == 1)
+			i = (zr->jpg_dma_tail - zr->jpg_err_shift) & BUZ_MASK_STAT_COM;
+		else
+			i = ((zr->jpg_dma_tail - zr->jpg_err_shift) & 1) * 2;
+	}
+	if (i) {
+		/* Rotate stat_comm entries to make current entry first */
+		int j;
+		__le32 bus_addr[BUZ_NUM_STAT_COM];
+
+		/* Here we are copying the stat_com array, which
+		 * is already in little endian format, so
+		 * no endian conversions here
+		 */
+		memcpy(bus_addr, zr->stat_com, sizeof(bus_addr));
+
+		for (j = 0; j < BUZ_NUM_STAT_COM; j++)
+			zr->stat_com[j] = bus_addr[(i + j) & BUZ_MASK_STAT_COM];
+
+		zr->jpg_err_shift += i;
+		zr->jpg_err_shift &= BUZ_MASK_STAT_COM;
+	}
+	if (zr->codec_mode == BUZ_MODE_MOTION_COMPRESS)
+		zr->jpg_err_seq = zr->jpg_seq_num;	/* + 1; */
+	zoran_restart(zr);
+}
+
+irqreturn_t
+zoran_irq (int             irq,
+	   void           *dev_id)
+{
+	u32 stat, astat;
+	int count;
+	struct zoran *zr;
+	unsigned long flags;
+
+	zr = dev_id;
+	count = 0;
+
+	if (zr->testing) {
+		/* Testing interrupts */
+		spin_lock_irqsave(&zr->spinlock, flags);
+		while ((stat = count_reset_interrupt(zr))) {
+			if (count++ > 100) {
+				btand(~ZR36057_ICR_IntPinEn, ZR36057_ICR);
+				dprintk(1,
+					KERN_ERR
+					"%s: IRQ lockup while testing, isr=0x%08x, cleared int mask\n",
+					ZR_DEVNAME(zr), stat);
+				wake_up_interruptible(&zr->test_q);
+			}
+		}
+		zr->last_isr = stat;
+		spin_unlock_irqrestore(&zr->spinlock, flags);
+		return IRQ_HANDLED;
+	}
+
+	spin_lock_irqsave(&zr->spinlock, flags);
+	while (1) {
+		/* get/clear interrupt status bits */
+		stat = count_reset_interrupt(zr);
+		astat = stat & IRQ_MASK;
+		if (!astat) {
+			break;
+		}
+		dprintk(4,
+			KERN_DEBUG
+			"zoran_irq: astat: 0x%08x, mask: 0x%08x\n",
+			astat, btread(ZR36057_ICR));
+		if (astat & zr->card.vsync_int) {	// SW
+
+			if (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS ||
+			    zr->codec_mode == BUZ_MODE_MOTION_COMPRESS) {
+				/* count missed interrupts */
+				zr->JPEG_missed++;
+			}
+			//post_office_read(zr,1,0);
+			/* Interrupts may still happen when
+			 * zr->v4l_memgrab_active is switched off.
+			 * We simply ignore them */
+
+			if (zr->v4l_memgrab_active) {
+				/* A lot more checks should be here ... */
+				if ((btread(ZR36057_VSSFGR) & ZR36057_VSSFGR_SnapShot) == 0)
+					dprintk(1,
+						KERN_WARNING
+						"%s: BuzIRQ with SnapShot off ???\n",
+						ZR_DEVNAME(zr));
+
+				if (zr->v4l_grab_frame != NO_GRAB_ACTIVE) {
+					/* There is a grab on a frame going on, check if it has finished */
+					if ((btread(ZR36057_VSSFGR) & ZR36057_VSSFGR_FrameGrab) == 0) {
+						/* it is finished, notify the user */
+
+						zr->v4l_buffers.buffer[zr->v4l_grab_frame].state = BUZ_STATE_DONE;
+						zr->v4l_buffers.buffer[zr->v4l_grab_frame].bs.seq = zr->v4l_grab_seq;
+						zr->v4l_buffers.buffer[zr->v4l_grab_frame].bs.ts = ktime_get_ns();
+						zr->v4l_grab_frame = NO_GRAB_ACTIVE;
+						zr->v4l_pend_tail++;
+					}
+				}
+
+				if (zr->v4l_grab_frame == NO_GRAB_ACTIVE)
+					wake_up_interruptible(&zr->v4l_capq);
+
+				/* Check if there is another grab queued */
+
+				if (zr->v4l_grab_frame == NO_GRAB_ACTIVE &&
+				    zr->v4l_pend_tail != zr->v4l_pend_head) {
+					int frame = zr->v4l_pend[zr->v4l_pend_tail & V4L_MASK_FRAME];
+					u32 reg;
+
+					zr->v4l_grab_frame = frame;
+
+					/* Set zr36057 video front end and enable video */
+
+					/* Buffer address */
+
+					reg = zr->v4l_buffers.buffer[frame].v4l.fbuffer_bus;
+					btwrite(reg, ZR36057_VDTR);
+					if (zr->v4l_settings.height > BUZ_MAX_HEIGHT / 2)
+						reg += zr->v4l_settings.bytesperline;
+					btwrite(reg, ZR36057_VDBR);
+
+					/* video stride, status, and frame grab register */
+					reg = 0;
+					if (zr->v4l_settings.height > BUZ_MAX_HEIGHT / 2)
+						reg += zr->v4l_settings.bytesperline;
+					reg = (reg << ZR36057_VSSFGR_DispStride);
+					reg |= ZR36057_VSSFGR_VidOvf;
+					reg |= ZR36057_VSSFGR_SnapShot;
+					reg |= ZR36057_VSSFGR_FrameGrab;
+					btwrite(reg, ZR36057_VSSFGR);
+
+					btor(ZR36057_VDCR_VidEn,
+					     ZR36057_VDCR);
+				}
+			}
+
+			/* even if we don't grab, we do want to increment
+			 * the sequence counter to see lost frames */
+			zr->v4l_grab_seq++;
+		}
+#if (IRQ_MASK & ZR36057_ISR_CodRepIRQ)
+		if (astat & ZR36057_ISR_CodRepIRQ) {
+			zr->intr_counter_CodRepIRQ++;
+			IDEBUG(printk(KERN_DEBUG "%s: ZR36057_ISR_CodRepIRQ\n",
+				ZR_DEVNAME(zr)));
+			btand(~ZR36057_ICR_CodRepIRQ, ZR36057_ICR);
+		}
+#endif				/* (IRQ_MASK & ZR36057_ISR_CodRepIRQ) */
+
+#if (IRQ_MASK & ZR36057_ISR_JPEGRepIRQ)
+		if ((astat & ZR36057_ISR_JPEGRepIRQ) &&
+		    (zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS ||
+		     zr->codec_mode == BUZ_MODE_MOTION_COMPRESS)) {
+			if (zr36067_debug > 1 && (!zr->frame_num || zr->JPEG_error)) {
+				char sv[BUZ_NUM_STAT_COM + 1];
+				int i;
+
+				printk(KERN_INFO
+				       "%s: first frame ready: state=0x%08x odd_even=%d field_per_buff=%d delay=%d\n",
+				       ZR_DEVNAME(zr), stat,
+				       zr->jpg_settings.odd_even,
+				       zr->jpg_settings.field_per_buff,
+				       zr->JPEG_missed);
+
+				for (i = 0; i < BUZ_NUM_STAT_COM; i++)
+					sv[i] = le32_to_cpu(zr->stat_com[i]) & 1 ? '1' : '0';
+				sv[BUZ_NUM_STAT_COM] = 0;
+				printk(KERN_INFO
+				       "%s: stat_com=%s queue_state=%ld/%ld/%ld/%ld\n",
+				       ZR_DEVNAME(zr), sv,
+				       zr->jpg_que_tail,
+				       zr->jpg_dma_tail,
+				       zr->jpg_dma_head,
+				       zr->jpg_que_head);
+			} else {
+				/* Get statistics */
+				if (zr->JPEG_missed > zr->JPEG_max_missed)
+					zr->JPEG_max_missed = zr->JPEG_missed;
+				if (zr->JPEG_missed < zr->JPEG_min_missed)
+					zr->JPEG_min_missed = zr->JPEG_missed;
+			}
+
+			if (zr36067_debug > 2 && zr->frame_num < 6) {
+				int i;
+
+				printk(KERN_INFO "%s: seq=%ld stat_com:",
+				       ZR_DEVNAME(zr), zr->jpg_seq_num);
+				for (i = 0; i < 4; i++) {
+					printk(KERN_CONT " %08x",
+					       le32_to_cpu(zr->stat_com[i]));
+				}
+				printk(KERN_CONT "\n");
+			}
+			zr->frame_num++;
+			zr->JPEG_missed = 0;
+			zr->JPEG_error = 0;
+			zoran_reap_stat_com(zr);
+			zoran_feed_stat_com(zr);
+			wake_up_interruptible(&zr->jpg_capq);
+		}
+#endif				/* (IRQ_MASK & ZR36057_ISR_JPEGRepIRQ) */
+
+		/* DATERR, too many fields missed, error processing */
+		if ((astat & zr->card.jpeg_int) ||
+		    zr->JPEG_missed > 25 ||
+		    zr->JPEG_error == 1	||
+		    ((zr->codec_mode == BUZ_MODE_MOTION_DECOMPRESS) &&
+		     (zr->frame_num && (zr->JPEG_missed > zr->jpg_settings.field_per_buff)))) {
+			error_handler(zr, astat, stat);
+		}
+
+		count++;
+		if (count > 10) {
+			dprintk(2, KERN_WARNING "%s: irq loop %d\n",
+				ZR_DEVNAME(zr), count);
+			if (count > 20) {
+				btand(~ZR36057_ICR_IntPinEn, ZR36057_ICR);
+				dprintk(2,
+					KERN_ERR
+					"%s: IRQ lockup, cleared int mask\n",
+					ZR_DEVNAME(zr));
+				break;
+			}
+		}
+		zr->last_isr = stat;
+	}
+	spin_unlock_irqrestore(&zr->spinlock, flags);
+
+	return IRQ_HANDLED;
+}
+
+void
+zoran_set_pci_master (struct zoran *zr,
+		      int           set_master)
+{
+	if (set_master) {
+		pci_set_master(zr->pci_dev);
+	} else {
+		u16 command;
+
+		pci_read_config_word(zr->pci_dev, PCI_COMMAND, &command);
+		command &= ~PCI_COMMAND_MASTER;
+		pci_write_config_word(zr->pci_dev, PCI_COMMAND, command);
+	}
+}
+
+void
+zoran_init_hardware (struct zoran *zr)
+{
+	/* Enable bus-mastering */
+	zoran_set_pci_master(zr, 1);
+
+	/* Initialize the board */
+	if (zr->card.init) {
+		zr->card.init(zr);
+	}
+
+	decoder_call(zr, core, init, 0);
+	decoder_call(zr, video, s_std, zr->norm);
+	decoder_call(zr, video, s_routing,
+		zr->card.input[zr->input].muxsel, 0, 0);
+
+	encoder_call(zr, core, init, 0);
+	encoder_call(zr, video, s_std_output, zr->norm);
+	encoder_call(zr, video, s_routing, 0, 0, 0);
+
+	/* toggle JPEG codec sleep to sync PLL */
+	jpeg_codec_sleep(zr, 1);
+	jpeg_codec_sleep(zr, 0);
+
+	/*
+	 * set individual interrupt enables (without GIRQ1)
+	 * but don't global enable until zoran_open()
+	 */
+	zr36057_init_vfe(zr);
+
+	zr36057_enable_jpg(zr, BUZ_MODE_IDLE);
+
+	btwrite(IRQ_MASK, ZR36057_ISR);	// Clears interrupts
+}
+
+void
+zr36057_restart (struct zoran *zr)
+{
+	btwrite(0, ZR36057_SPGPPCR);
+	mdelay(1);
+	btor(ZR36057_SPGPPCR_SoftReset, ZR36057_SPGPPCR);
+	mdelay(1);
+
+	/* assert P_Reset */
+	btwrite(0, ZR36057_JPC);
+	/* set up GPIO direction - all output */
+	btwrite(ZR36057_SPGPPCR_SoftReset | 0, ZR36057_SPGPPCR);
+
+	/* set up GPIO pins and guest bus timing */
+	btwrite((0x81 << 24) | 0x8888, ZR36057_GPPGCR1);
+}
+
+/*
+ * initialize video front end
+ */
+
+static void
+zr36057_init_vfe (struct zoran *zr)
+{
+	u32 reg;
+
+	reg = btread(ZR36057_VFESPFR);
+	reg |= ZR36057_VFESPFR_LittleEndian;
+	reg &= ~ZR36057_VFESPFR_VCLKPol;
+	reg |= ZR36057_VFESPFR_ExtFl;
+	reg |= ZR36057_VFESPFR_TopField;
+	btwrite(reg, ZR36057_VFESPFR);
+	reg = btread(ZR36057_VDCR);
+	if (pci_pci_problems & PCIPCI_TRITON)
+		// || zr->revision < 1) // Revision 1 has also Triton support
+		reg &= ~ZR36057_VDCR_Triton;
+	else
+		reg |= ZR36057_VDCR_Triton;
+	btwrite(reg, ZR36057_VDCR);
+}
diff --git a/drivers/staging/media/zoran/zoran_device.h b/drivers/staging/media/zoran/zoran_device.h
new file mode 100644
index 000000000000..a507aaad4ebb
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_device.h
@@ -0,0 +1,91 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * This part handles card-specific data and detection
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Currently maintained by:
+ *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
+ *   Laurent Pinchart <laurent.pinchart@skynet.be>
+ *   Mailinglist      <mjpeg-users@lists.sf.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ZORAN_DEVICE_H__
+#define __ZORAN_DEVICE_H__
+
+/* general purpose I/O */
+extern void GPIO(struct zoran *zr,
+		 int bit,
+		 unsigned int value);
+
+/* codec (or actually: guest bus) access */
+extern int post_office_wait(struct zoran *zr);
+extern int post_office_write(struct zoran *zr,
+			     unsigned guest,
+			     unsigned reg,
+			     unsigned value);
+extern int post_office_read(struct zoran *zr,
+			    unsigned guest,
+			    unsigned reg);
+
+extern void detect_guest_activity(struct zoran *zr);
+
+extern void jpeg_codec_sleep(struct zoran *zr,
+			     int sleep);
+extern int jpeg_codec_reset(struct zoran *zr);
+
+/* zr360x7 access to raw capture */
+extern void zr36057_overlay(struct zoran *zr,
+			    int on);
+extern void write_overlay_mask(struct zoran_fh *fh,
+			       struct v4l2_clip *vp,
+			       int count);
+extern void zr36057_set_memgrab(struct zoran *zr,
+				int mode);
+extern int wait_grab_pending(struct zoran *zr);
+
+/* interrupts */
+extern void print_interrupts(struct zoran *zr);
+extern void clear_interrupt_counters(struct zoran *zr);
+extern irqreturn_t zoran_irq(int irq, void *dev_id);
+
+/* JPEG codec access */
+extern void jpeg_start(struct zoran *zr);
+extern void zr36057_enable_jpg(struct zoran *zr,
+			       enum zoran_codec_mode mode);
+extern void zoran_feed_stat_com(struct zoran *zr);
+
+/* general */
+extern void zoran_set_pci_master(struct zoran *zr,
+				 int set_master);
+extern void zoran_init_hardware(struct zoran *zr);
+extern void zr36057_restart(struct zoran *zr);
+
+extern const struct zoran_format zoran_formats[];
+
+extern int v4l_nbufs;
+extern int v4l_bufsize;
+extern int jpg_nbufs;
+extern int jpg_bufsize;
+extern int pass_through;
+
+/* i2c */
+#define decoder_call(zr, o, f, args...) \
+	v4l2_subdev_call(zr->decoder, o, f, ##args)
+#define encoder_call(zr, o, f, args...) \
+	v4l2_subdev_call(zr->encoder, o, f, ##args)
+
+#endif				/* __ZORAN_DEVICE_H__ */
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
new file mode 100644
index 000000000000..c998aa4dc73b
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -0,0 +1,2850 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Changes for BUZ by Wolfgang Scherr <scherr@net4you.net>
+ *
+ * Changes for DC10/DC30 by Laurent Pinchart <laurent.pinchart@skynet.be>
+ *
+ * Changes for LML33R10 by Maxim Yevtyushkin <max@linuxmedialabs.com>
+ *
+ * Changes for videodev2/v4l2 by Ronald Bultje <rbultje@ronald.bitfreak.net>
+ *
+ * Based on
+ *
+ * Miro DC10 driver
+ * Copyright (C) 1999 Wolfgang Scherr <scherr@net4you.net>
+ *
+ * Iomega Buz driver version 1.0
+ * Copyright (C) 1999 Rainer Johanni <Rainer@Johanni.de>
+ *
+ * buz.0.0.3
+ * Copyright (C) 1998 Dave Perks <dperks@ibm.net>
+ *
+ * bttv - Bt848 frame grabber driver
+ * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
+ *                        & Marcus Metzler (mocm@thp.uni-koeln.de)
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <linux/wait.h>
+
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <linux/spinlock.h>
+
+#include <linux/videodev2.h>
+#include <media/v4l2-common.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-event.h>
+#include "videocodec.h"
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <linux/uaccess.h>
+#include <linux/proc_fs.h>
+
+#include <linux/mutex.h>
+#include "zoran.h"
+#include "zoran_device.h"
+#include "zoran_card.h"
+
+
+const struct zoran_format zoran_formats[] = {
+	{
+		.name = "15-bit RGB LE",
+		.fourcc = V4L2_PIX_FMT_RGB555,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 15,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB555|ZR36057_VFESPFR_ErrDif|
+			   ZR36057_VFESPFR_LittleEndian,
+	}, {
+		.name = "15-bit RGB BE",
+		.fourcc = V4L2_PIX_FMT_RGB555X,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 15,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB555|ZR36057_VFESPFR_ErrDif,
+	}, {
+		.name = "16-bit RGB LE",
+		.fourcc = V4L2_PIX_FMT_RGB565,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 16,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB565|ZR36057_VFESPFR_ErrDif|
+			   ZR36057_VFESPFR_LittleEndian,
+	}, {
+		.name = "16-bit RGB BE",
+		.fourcc = V4L2_PIX_FMT_RGB565X,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 16,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB565|ZR36057_VFESPFR_ErrDif,
+	}, {
+		.name = "24-bit RGB",
+		.fourcc = V4L2_PIX_FMT_BGR24,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 24,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB888|ZR36057_VFESPFR_Pack24,
+	}, {
+		.name = "32-bit RGB LE",
+		.fourcc = V4L2_PIX_FMT_BGR32,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 32,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB888|ZR36057_VFESPFR_LittleEndian,
+	}, {
+		.name = "32-bit RGB BE",
+		.fourcc = V4L2_PIX_FMT_RGB32,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.depth = 32,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_RGB888,
+	}, {
+		.name = "4:2:2, packed, YUYV",
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.colorspace = V4L2_COLORSPACE_SMPTE170M,
+		.depth = 16,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_YUV422,
+	}, {
+		.name = "4:2:2, packed, UYVY",
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.colorspace = V4L2_COLORSPACE_SMPTE170M,
+		.depth = 16,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_OVERLAY,
+		.vfespfr = ZR36057_VFESPFR_YUV422|ZR36057_VFESPFR_LittleEndian,
+	}, {
+		.name = "Hardware-encoded Motion-JPEG",
+		.fourcc = V4L2_PIX_FMT_MJPEG,
+		.colorspace = V4L2_COLORSPACE_SMPTE170M,
+		.depth = 0,
+		.flags = ZORAN_FORMAT_CAPTURE |
+			 ZORAN_FORMAT_PLAYBACK |
+			 ZORAN_FORMAT_COMPRESSED,
+	}
+};
+#define NUM_FORMATS ARRAY_SIZE(zoran_formats)
+
+	/* small helper function for calculating buffersizes for v4l2
+	 * we calculate the nearest higher power-of-two, which
+	 * will be the recommended buffersize */
+static __u32
+zoran_v4l2_calc_bufsize (struct zoran_jpg_settings *settings)
+{
+	__u8 div = settings->VerDcm * settings->HorDcm * settings->TmpDcm;
+	__u32 num = (1024 * 512) / (div);
+	__u32 result = 2;
+
+	num--;
+	while (num) {
+		num >>= 1;
+		result <<= 1;
+	}
+
+	if (result > jpg_bufsize)
+		return jpg_bufsize;
+	if (result < 8192)
+		return 8192;
+	return result;
+}
+
+/* forward references */
+static void v4l_fbuffer_free(struct zoran_fh *fh);
+static void jpg_fbuffer_free(struct zoran_fh *fh);
+
+/* Set mapping mode */
+static void map_mode_raw(struct zoran_fh *fh)
+{
+	fh->map_mode = ZORAN_MAP_MODE_RAW;
+	fh->buffers.buffer_size = v4l_bufsize;
+	fh->buffers.num_buffers = v4l_nbufs;
+}
+static void map_mode_jpg(struct zoran_fh *fh, int play)
+{
+	fh->map_mode = play ? ZORAN_MAP_MODE_JPG_PLAY : ZORAN_MAP_MODE_JPG_REC;
+	fh->buffers.buffer_size = jpg_bufsize;
+	fh->buffers.num_buffers = jpg_nbufs;
+}
+static inline const char *mode_name(enum zoran_map_mode mode)
+{
+	return mode == ZORAN_MAP_MODE_RAW ? "V4L" : "JPG";
+}
+
+/*
+ *   Allocate the V4L grab buffers
+ *
+ *   These have to be pysically contiguous.
+ */
+
+static int v4l_fbuffer_alloc(struct zoran_fh *fh)
+{
+	struct zoran *zr = fh->zr;
+	int i, off;
+	unsigned char *mem;
+
+	for (i = 0; i < fh->buffers.num_buffers; i++) {
+		if (fh->buffers.buffer[i].v4l.fbuffer)
+			dprintk(2,
+				KERN_WARNING
+				"%s: %s - buffer %d already allocated!?\n",
+				ZR_DEVNAME(zr), __func__, i);
+
+		//udelay(20);
+		mem = kmalloc(fh->buffers.buffer_size,
+			      GFP_KERNEL | __GFP_NOWARN);
+		if (!mem) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - kmalloc for V4L buf %d failed\n",
+				ZR_DEVNAME(zr), __func__, i);
+			v4l_fbuffer_free(fh);
+			return -ENOBUFS;
+		}
+		fh->buffers.buffer[i].v4l.fbuffer = mem;
+		fh->buffers.buffer[i].v4l.fbuffer_phys = virt_to_phys(mem);
+		fh->buffers.buffer[i].v4l.fbuffer_bus = virt_to_bus(mem);
+		for (off = 0; off < fh->buffers.buffer_size;
+		     off += PAGE_SIZE)
+			SetPageReserved(virt_to_page(mem + off));
+		dprintk(4,
+			KERN_INFO
+			"%s: %s - V4L frame %d mem %p (bus: 0x%llx)\n",
+			ZR_DEVNAME(zr), __func__, i, mem,
+			(unsigned long long)virt_to_bus(mem));
+	}
+
+	fh->buffers.allocated = 1;
+
+	return 0;
+}
+
+/* free the V4L grab buffers */
+static void v4l_fbuffer_free(struct zoran_fh *fh)
+{
+	struct zoran *zr = fh->zr;
+	int i, off;
+	unsigned char *mem;
+
+	dprintk(4, KERN_INFO "%s: %s\n", ZR_DEVNAME(zr), __func__);
+
+	for (i = 0; i < fh->buffers.num_buffers; i++) {
+		if (!fh->buffers.buffer[i].v4l.fbuffer)
+			continue;
+
+		mem = fh->buffers.buffer[i].v4l.fbuffer;
+		for (off = 0; off < fh->buffers.buffer_size;
+		     off += PAGE_SIZE)
+			ClearPageReserved(virt_to_page(mem + off));
+		kfree(fh->buffers.buffer[i].v4l.fbuffer);
+		fh->buffers.buffer[i].v4l.fbuffer = NULL;
+	}
+
+	fh->buffers.allocated = 0;
+}
+
+/*
+ *   Allocate the MJPEG grab buffers.
+ *
+ *   If a Natoma chipset is present and this is a revision 1 zr36057,
+ *   each MJPEG buffer needs to be physically contiguous.
+ *   (RJ: This statement is from Dave Perks' original driver,
+ *   I could never check it because I have a zr36067)
+ *
+ *   RJ: The contents grab buffers needs never be accessed in the driver.
+ *       Therefore there is no need to allocate them with vmalloc in order
+ *       to get a contiguous virtual memory space.
+ *       I don't understand why many other drivers first allocate them with
+ *       vmalloc (which uses internally also get_zeroed_page, but delivers you
+ *       virtual addresses) and then again have to make a lot of efforts
+ *       to get the physical address.
+ *
+ *   Ben Capper:
+ *       On big-endian architectures (such as ppc) some extra steps
+ *       are needed. When reading and writing to the stat_com array
+ *       and fragment buffers, the device expects to see little-
+ *       endian values. The use of cpu_to_le32() and le32_to_cpu()
+ *       in this function (and one or two others in zoran_device.c)
+ *       ensure that these values are always stored in little-endian
+ *       form, regardless of architecture. The zr36057 does Very Bad
+ *       Things on big endian architectures if the stat_com array
+ *       and fragment buffers are not little-endian.
+ */
+
+static int jpg_fbuffer_alloc(struct zoran_fh *fh)
+{
+	struct zoran *zr = fh->zr;
+	int i, j, off;
+	u8 *mem;
+
+	for (i = 0; i < fh->buffers.num_buffers; i++) {
+		if (fh->buffers.buffer[i].jpg.frag_tab)
+			dprintk(2,
+				KERN_WARNING
+				"%s: %s - buffer %d already allocated!?\n",
+				ZR_DEVNAME(zr), __func__, i);
+
+		/* Allocate fragment table for this buffer */
+
+		mem = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!mem) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - get_zeroed_page (frag_tab) failed for buffer %d\n",
+				ZR_DEVNAME(zr), __func__, i);
+			jpg_fbuffer_free(fh);
+			return -ENOBUFS;
+		}
+		fh->buffers.buffer[i].jpg.frag_tab = (__le32 *)mem;
+		fh->buffers.buffer[i].jpg.frag_tab_bus = virt_to_bus(mem);
+
+		if (fh->buffers.need_contiguous) {
+			mem = kmalloc(fh->buffers.buffer_size, GFP_KERNEL);
+			if (mem == NULL) {
+				dprintk(1,
+					KERN_ERR
+					"%s: %s - kmalloc failed for buffer %d\n",
+					ZR_DEVNAME(zr), __func__, i);
+				jpg_fbuffer_free(fh);
+				return -ENOBUFS;
+			}
+			fh->buffers.buffer[i].jpg.frag_tab[0] =
+				cpu_to_le32(virt_to_bus(mem));
+			fh->buffers.buffer[i].jpg.frag_tab[1] =
+				cpu_to_le32((fh->buffers.buffer_size >> 1) | 1);
+			for (off = 0; off < fh->buffers.buffer_size; off += PAGE_SIZE)
+				SetPageReserved(virt_to_page(mem + off));
+		} else {
+			/* jpg_bufsize is already page aligned */
+			for (j = 0; j < fh->buffers.buffer_size / PAGE_SIZE; j++) {
+				mem = (void *)get_zeroed_page(GFP_KERNEL);
+				if (mem == NULL) {
+					dprintk(1,
+						KERN_ERR
+						"%s: %s - get_zeroed_page failed for buffer %d\n",
+						ZR_DEVNAME(zr), __func__, i);
+					jpg_fbuffer_free(fh);
+					return -ENOBUFS;
+				}
+
+				fh->buffers.buffer[i].jpg.frag_tab[2 * j] =
+					cpu_to_le32(virt_to_bus(mem));
+				fh->buffers.buffer[i].jpg.frag_tab[2 * j + 1] =
+					cpu_to_le32((PAGE_SIZE >> 2) << 1);
+				SetPageReserved(virt_to_page(mem));
+			}
+
+			fh->buffers.buffer[i].jpg.frag_tab[2 * j - 1] |= cpu_to_le32(1);
+		}
+	}
+
+	dprintk(4,
+		KERN_DEBUG "%s: %s - %d KB allocated\n",
+		ZR_DEVNAME(zr), __func__,
+		(fh->buffers.num_buffers * fh->buffers.buffer_size) >> 10);
+
+	fh->buffers.allocated = 1;
+
+	return 0;
+}
+
+/* free the MJPEG grab buffers */
+static void jpg_fbuffer_free(struct zoran_fh *fh)
+{
+	struct zoran *zr = fh->zr;
+	int i, j, off;
+	unsigned char *mem;
+	__le32 frag_tab;
+	struct zoran_buffer *buffer;
+
+	dprintk(4, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+
+	for (i = 0, buffer = &fh->buffers.buffer[0];
+	     i < fh->buffers.num_buffers; i++, buffer++) {
+		if (!buffer->jpg.frag_tab)
+			continue;
+
+		if (fh->buffers.need_contiguous) {
+			frag_tab = buffer->jpg.frag_tab[0];
+
+			if (frag_tab) {
+				mem = bus_to_virt(le32_to_cpu(frag_tab));
+				for (off = 0; off < fh->buffers.buffer_size; off += PAGE_SIZE)
+					ClearPageReserved(virt_to_page(mem + off));
+				kfree(mem);
+				buffer->jpg.frag_tab[0] = 0;
+				buffer->jpg.frag_tab[1] = 0;
+			}
+		} else {
+			for (j = 0; j < fh->buffers.buffer_size / PAGE_SIZE; j++) {
+				frag_tab = buffer->jpg.frag_tab[2 * j];
+
+				if (!frag_tab)
+					break;
+				ClearPageReserved(virt_to_page(bus_to_virt(le32_to_cpu(frag_tab))));
+				free_page((unsigned long)bus_to_virt(le32_to_cpu(frag_tab)));
+				buffer->jpg.frag_tab[2 * j] = 0;
+				buffer->jpg.frag_tab[2 * j + 1] = 0;
+			}
+		}
+
+		free_page((unsigned long)buffer->jpg.frag_tab);
+		buffer->jpg.frag_tab = NULL;
+	}
+
+	fh->buffers.allocated = 0;
+}
+
+/*
+ *   V4L Buffer grabbing
+ */
+
+static int
+zoran_v4l_set_format (struct zoran_fh           *fh,
+		      int                        width,
+		      int                        height,
+		      const struct zoran_format *format)
+{
+	struct zoran *zr = fh->zr;
+	int bpp;
+
+	/* Check size and format of the grab wanted */
+
+	if (height < BUZ_MIN_HEIGHT || width < BUZ_MIN_WIDTH ||
+	    height > BUZ_MAX_HEIGHT || width > BUZ_MAX_WIDTH) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - wrong frame size (%dx%d)\n",
+			ZR_DEVNAME(zr), __func__, width, height);
+		return -EINVAL;
+	}
+
+	bpp = (format->depth + 7) / 8;
+
+	/* Check against available buffer size */
+	if (height * width * bpp > fh->buffers.buffer_size) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - video buffer size (%d kB) is too small\n",
+			ZR_DEVNAME(zr), __func__, fh->buffers.buffer_size >> 10);
+		return -EINVAL;
+	}
+
+	/* The video front end needs 4-byte alinged line sizes */
+
+	if ((bpp == 2 && (width & 1)) || (bpp == 3 && (width & 3))) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - wrong frame alignment\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	fh->v4l_settings.width = width;
+	fh->v4l_settings.height = height;
+	fh->v4l_settings.format = format;
+	fh->v4l_settings.bytesperline = bpp * fh->v4l_settings.width;
+
+	return 0;
+}
+
+static int zoran_v4l_queue_frame(struct zoran_fh *fh, int num)
+{
+	struct zoran *zr = fh->zr;
+	unsigned long flags;
+	int res = 0;
+
+	if (!fh->buffers.allocated) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - buffers not yet allocated\n",
+			ZR_DEVNAME(zr), __func__);
+		res = -ENOMEM;
+	}
+
+	/* No grabbing outside the buffer range! */
+	if (num >= fh->buffers.num_buffers || num < 0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - buffer %d is out of range\n",
+			ZR_DEVNAME(zr), __func__, num);
+		res = -EINVAL;
+	}
+
+	spin_lock_irqsave(&zr->spinlock, flags);
+
+	if (fh->buffers.active == ZORAN_FREE) {
+		if (zr->v4l_buffers.active == ZORAN_FREE) {
+			zr->v4l_buffers = fh->buffers;
+			fh->buffers.active = ZORAN_ACTIVE;
+		} else {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - another session is already capturing\n",
+				ZR_DEVNAME(zr), __func__);
+			res = -EBUSY;
+		}
+	}
+
+	/* make sure a grab isn't going on currently with this buffer */
+	if (!res) {
+		switch (zr->v4l_buffers.buffer[num].state) {
+		default:
+		case BUZ_STATE_PEND:
+			if (zr->v4l_buffers.active == ZORAN_FREE) {
+				fh->buffers.active = ZORAN_FREE;
+				zr->v4l_buffers.allocated = 0;
+			}
+			res = -EBUSY;	/* what are you doing? */
+			break;
+		case BUZ_STATE_DONE:
+			dprintk(2,
+				KERN_WARNING
+				"%s: %s - queueing buffer %d in state DONE!?\n",
+				ZR_DEVNAME(zr), __func__, num);
+			/* fall through */
+		case BUZ_STATE_USER:
+			/* since there is at least one unused buffer there's room for at least
+			 * one more pend[] entry */
+			zr->v4l_pend[zr->v4l_pend_head++ & V4L_MASK_FRAME] = num;
+			zr->v4l_buffers.buffer[num].state = BUZ_STATE_PEND;
+			zr->v4l_buffers.buffer[num].bs.length =
+			    fh->v4l_settings.bytesperline *
+			    zr->v4l_settings.height;
+			fh->buffers.buffer[num] = zr->v4l_buffers.buffer[num];
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&zr->spinlock, flags);
+
+	if (!res && zr->v4l_buffers.active == ZORAN_FREE)
+		zr->v4l_buffers.active = fh->buffers.active;
+
+	return res;
+}
+
+/*
+ * Sync on a V4L buffer
+ */
+
+static int v4l_sync(struct zoran_fh *fh, int frame)
+{
+	struct zoran *zr = fh->zr;
+	unsigned long flags;
+
+	if (fh->buffers.active == ZORAN_FREE) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - no grab active for this session\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	/* check passed-in frame number */
+	if (frame >= fh->buffers.num_buffers || frame < 0) {
+		dprintk(1,
+			KERN_ERR "%s: %s - frame %d is invalid\n",
+			ZR_DEVNAME(zr), __func__, frame);
+		return -EINVAL;
+	}
+
+	/* Check if is buffer was queued at all */
+	if (zr->v4l_buffers.buffer[frame].state == BUZ_STATE_USER) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - attempt to sync on a buffer which was not queued?\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EPROTO;
+	}
+
+	mutex_unlock(&zr->lock);
+	/* wait on this buffer to get ready */
+	if (!wait_event_interruptible_timeout(zr->v4l_capq,
+		(zr->v4l_buffers.buffer[frame].state != BUZ_STATE_PEND), 10*HZ)) {
+		mutex_lock(&zr->lock);
+		return -ETIME;
+	}
+	mutex_lock(&zr->lock);
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	/* buffer should now be in BUZ_STATE_DONE */
+	if (zr->v4l_buffers.buffer[frame].state != BUZ_STATE_DONE)
+		dprintk(2,
+			KERN_ERR "%s: %s - internal state error\n",
+			ZR_DEVNAME(zr), __func__);
+
+	zr->v4l_buffers.buffer[frame].state = BUZ_STATE_USER;
+	fh->buffers.buffer[frame] = zr->v4l_buffers.buffer[frame];
+
+	spin_lock_irqsave(&zr->spinlock, flags);
+
+	/* Check if streaming capture has finished */
+	if (zr->v4l_pend_tail == zr->v4l_pend_head) {
+		zr36057_set_memgrab(zr, 0);
+		if (zr->v4l_buffers.active == ZORAN_ACTIVE) {
+			fh->buffers.active = zr->v4l_buffers.active = ZORAN_FREE;
+			zr->v4l_buffers.allocated = 0;
+		}
+	}
+
+	spin_unlock_irqrestore(&zr->spinlock, flags);
+
+	return 0;
+}
+
+/*
+ *   Queue a MJPEG buffer for capture/playback
+ */
+
+static int zoran_jpg_queue_frame(struct zoran_fh *fh, int num,
+				 enum zoran_codec_mode mode)
+{
+	struct zoran *zr = fh->zr;
+	unsigned long flags;
+	int res = 0;
+
+	/* Check if buffers are allocated */
+	if (!fh->buffers.allocated) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - buffers not yet allocated\n",
+			ZR_DEVNAME(zr), __func__);
+		return -ENOMEM;
+	}
+
+	/* No grabbing outside the buffer range! */
+	if (num >= fh->buffers.num_buffers || num < 0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - buffer %d out of range\n",
+			ZR_DEVNAME(zr), __func__, num);
+		return -EINVAL;
+	}
+
+	/* what is the codec mode right now? */
+	if (zr->codec_mode == BUZ_MODE_IDLE) {
+		zr->jpg_settings = fh->jpg_settings;
+	} else if (zr->codec_mode != mode) {
+		/* wrong codec mode active - invalid */
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - codec in wrong mode\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	if (fh->buffers.active == ZORAN_FREE) {
+		if (zr->jpg_buffers.active == ZORAN_FREE) {
+			zr->jpg_buffers = fh->buffers;
+			fh->buffers.active = ZORAN_ACTIVE;
+		} else {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - another session is already capturing\n",
+				ZR_DEVNAME(zr), __func__);
+			res = -EBUSY;
+		}
+	}
+
+	if (!res && zr->codec_mode == BUZ_MODE_IDLE) {
+		/* Ok load up the jpeg codec */
+		zr36057_enable_jpg(zr, mode);
+	}
+
+	spin_lock_irqsave(&zr->spinlock, flags);
+
+	if (!res) {
+		switch (zr->jpg_buffers.buffer[num].state) {
+		case BUZ_STATE_DONE:
+			dprintk(2,
+				KERN_WARNING
+				"%s: %s - queuing frame in BUZ_STATE_DONE state!?\n",
+				ZR_DEVNAME(zr), __func__);
+			/* fall through */
+		case BUZ_STATE_USER:
+			/* since there is at least one unused buffer there's room for at
+			 *least one more pend[] entry */
+			zr->jpg_pend[zr->jpg_que_head++ & BUZ_MASK_FRAME] = num;
+			zr->jpg_buffers.buffer[num].state = BUZ_STATE_PEND;
+			fh->buffers.buffer[num] = zr->jpg_buffers.buffer[num];
+			zoran_feed_stat_com(zr);
+			break;
+		default:
+		case BUZ_STATE_DMA:
+		case BUZ_STATE_PEND:
+			if (zr->jpg_buffers.active == ZORAN_FREE) {
+				fh->buffers.active = ZORAN_FREE;
+				zr->jpg_buffers.allocated = 0;
+			}
+			res = -EBUSY;	/* what are you doing? */
+			break;
+		}
+	}
+
+	spin_unlock_irqrestore(&zr->spinlock, flags);
+
+	if (!res && zr->jpg_buffers.active == ZORAN_FREE)
+		zr->jpg_buffers.active = fh->buffers.active;
+
+	return res;
+}
+
+static int jpg_qbuf(struct zoran_fh *fh, int frame, enum zoran_codec_mode mode)
+{
+	struct zoran *zr = fh->zr;
+	int res = 0;
+
+	/* Does the user want to stop streaming? */
+	if (frame < 0) {
+		if (zr->codec_mode == mode) {
+			if (fh->buffers.active == ZORAN_FREE) {
+				dprintk(1,
+					KERN_ERR
+					"%s: %s(-1) - session not active\n",
+					ZR_DEVNAME(zr), __func__);
+				return -EINVAL;
+			}
+			fh->buffers.active = zr->jpg_buffers.active = ZORAN_FREE;
+			zr->jpg_buffers.allocated = 0;
+			zr36057_enable_jpg(zr, BUZ_MODE_IDLE);
+			return 0;
+		} else {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - stop streaming but not in streaming mode\n",
+				ZR_DEVNAME(zr), __func__);
+			return -EINVAL;
+		}
+	}
+
+	if ((res = zoran_jpg_queue_frame(fh, frame, mode)))
+		return res;
+
+	/* Start the jpeg codec when the first frame is queued  */
+	if (!res && zr->jpg_que_head == 1)
+		jpeg_start(zr);
+
+	return res;
+}
+
+/*
+ *   Sync on a MJPEG buffer
+ */
+
+static int jpg_sync(struct zoran_fh *fh, struct zoran_sync *bs)
+{
+	struct zoran *zr = fh->zr;
+	unsigned long flags;
+	int frame;
+
+	if (fh->buffers.active == ZORAN_FREE) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - capture is not currently active\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+	if (zr->codec_mode != BUZ_MODE_MOTION_DECOMPRESS &&
+	    zr->codec_mode != BUZ_MODE_MOTION_COMPRESS) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - codec not in streaming mode\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+	mutex_unlock(&zr->lock);
+	if (!wait_event_interruptible_timeout(zr->jpg_capq,
+			(zr->jpg_que_tail != zr->jpg_dma_tail ||
+			 zr->jpg_dma_tail == zr->jpg_dma_head),
+			10*HZ)) {
+		int isr;
+
+		btand(~ZR36057_JMC_Go_en, ZR36057_JMC);
+		udelay(1);
+		zr->codec->control(zr->codec, CODEC_G_STATUS,
+					   sizeof(isr), &isr);
+		mutex_lock(&zr->lock);
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - timeout: codec isr=0x%02x\n",
+			ZR_DEVNAME(zr), __func__, isr);
+
+		return -ETIME;
+
+	}
+	mutex_lock(&zr->lock);
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+
+	spin_lock_irqsave(&zr->spinlock, flags);
+
+	if (zr->jpg_dma_tail != zr->jpg_dma_head)
+		frame = zr->jpg_pend[zr->jpg_que_tail++ & BUZ_MASK_FRAME];
+	else
+		frame = zr->jpg_pend[zr->jpg_que_tail & BUZ_MASK_FRAME];
+
+	/* buffer should now be in BUZ_STATE_DONE */
+	if (zr->jpg_buffers.buffer[frame].state != BUZ_STATE_DONE)
+		dprintk(2,
+			KERN_ERR "%s: %s - internal state error\n",
+			ZR_DEVNAME(zr), __func__);
+
+	*bs = zr->jpg_buffers.buffer[frame].bs;
+	bs->frame = frame;
+	zr->jpg_buffers.buffer[frame].state = BUZ_STATE_USER;
+	fh->buffers.buffer[frame] = zr->jpg_buffers.buffer[frame];
+
+	spin_unlock_irqrestore(&zr->spinlock, flags);
+
+	return 0;
+}
+
+static void zoran_open_init_session(struct zoran_fh *fh)
+{
+	int i;
+	struct zoran *zr = fh->zr;
+
+	/* Per default, map the V4L Buffers */
+	map_mode_raw(fh);
+
+	/* take over the card's current settings */
+	fh->overlay_settings = zr->overlay_settings;
+	fh->overlay_settings.is_set = 0;
+	fh->overlay_settings.format = zr->overlay_settings.format;
+	fh->overlay_active = ZORAN_FREE;
+
+	/* v4l settings */
+	fh->v4l_settings = zr->v4l_settings;
+	/* jpg settings */
+	fh->jpg_settings = zr->jpg_settings;
+
+	/* buffers */
+	memset(&fh->buffers, 0, sizeof(fh->buffers));
+	for (i = 0; i < MAX_FRAME; i++) {
+		fh->buffers.buffer[i].state = BUZ_STATE_USER;	/* nothing going on */
+		fh->buffers.buffer[i].bs.frame = i;
+	}
+	fh->buffers.allocated = 0;
+	fh->buffers.active = ZORAN_FREE;
+}
+
+static void zoran_close_end_session(struct zoran_fh *fh)
+{
+	struct zoran *zr = fh->zr;
+
+	/* overlay */
+	if (fh->overlay_active != ZORAN_FREE) {
+		fh->overlay_active = zr->overlay_active = ZORAN_FREE;
+		zr->v4l_overlay_active = 0;
+		if (!zr->v4l_memgrab_active)
+			zr36057_overlay(zr, 0);
+		zr->overlay_mask = NULL;
+	}
+
+	if (fh->map_mode == ZORAN_MAP_MODE_RAW) {
+		/* v4l capture */
+		if (fh->buffers.active != ZORAN_FREE) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&zr->spinlock, flags);
+			zr36057_set_memgrab(zr, 0);
+			zr->v4l_buffers.allocated = 0;
+			zr->v4l_buffers.active = fh->buffers.active = ZORAN_FREE;
+			spin_unlock_irqrestore(&zr->spinlock, flags);
+		}
+
+		/* v4l buffers */
+		if (fh->buffers.allocated)
+			v4l_fbuffer_free(fh);
+	} else {
+		/* jpg capture */
+		if (fh->buffers.active != ZORAN_FREE) {
+			zr36057_enable_jpg(zr, BUZ_MODE_IDLE);
+			zr->jpg_buffers.allocated = 0;
+			zr->jpg_buffers.active = fh->buffers.active = ZORAN_FREE;
+		}
+
+		/* jpg buffers */
+		if (fh->buffers.allocated)
+			jpg_fbuffer_free(fh);
+	}
+}
+
+/*
+ *   Open a zoran card. Right now the flags stuff is just playing
+ */
+
+static int zoran_open(struct file *file)
+{
+	struct zoran *zr = video_drvdata(file);
+	struct zoran_fh *fh;
+	int res, first_open = 0;
+
+	dprintk(2, KERN_INFO "%s: %s(%s, pid=[%d]), users(-)=%d\n",
+		ZR_DEVNAME(zr), __func__, current->comm, task_pid_nr(current), zr->user + 1);
+
+	mutex_lock(&zr->lock);
+
+	if (zr->user >= 2048) {
+		dprintk(1, KERN_ERR "%s: too many users (%d) on device\n",
+			ZR_DEVNAME(zr), zr->user);
+		res = -EBUSY;
+		goto fail_unlock;
+	}
+
+	/* now, create the open()-specific file_ops struct */
+	fh = kzalloc(sizeof(struct zoran_fh), GFP_KERNEL);
+	if (!fh) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - allocation of zoran_fh failed\n",
+			ZR_DEVNAME(zr), __func__);
+		res = -ENOMEM;
+		goto fail_unlock;
+	}
+	v4l2_fh_init(&fh->fh, video_devdata(file));
+
+	/* used to be BUZ_MAX_WIDTH/HEIGHT, but that gives overflows
+	 * on norm-change! */
+	fh->overlay_mask =
+	    kmalloc(array3_size((768 + 31) / 32, 576, 4), GFP_KERNEL);
+	if (!fh->overlay_mask) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - allocation of overlay_mask failed\n",
+			ZR_DEVNAME(zr), __func__);
+		res = -ENOMEM;
+		goto fail_fh;
+	}
+
+	if (zr->user++ == 0)
+		first_open = 1;
+
+	/* default setup - TODO: look at flags */
+	if (first_open) {	/* First device open */
+		zr36057_restart(zr);
+		zoran_open_init_params(zr);
+		zoran_init_hardware(zr);
+
+		btor(ZR36057_ICR_IntPinEn, ZR36057_ICR);
+	}
+
+	/* set file_ops stuff */
+	file->private_data = fh;
+	fh->zr = zr;
+	zoran_open_init_session(fh);
+	v4l2_fh_add(&fh->fh);
+	mutex_unlock(&zr->lock);
+
+	return 0;
+
+fail_fh:
+	v4l2_fh_exit(&fh->fh);
+	kfree(fh);
+fail_unlock:
+	mutex_unlock(&zr->lock);
+
+	dprintk(2, KERN_INFO "%s: open failed (%d), users(-)=%d\n",
+		ZR_DEVNAME(zr), res, zr->user);
+
+	return res;
+}
+
+static int
+zoran_close(struct file  *file)
+{
+	struct zoran_fh *fh = file->private_data;
+	struct zoran *zr = fh->zr;
+
+	dprintk(2, KERN_INFO "%s: %s(%s, pid=[%d]), users(+)=%d\n",
+		ZR_DEVNAME(zr), __func__, current->comm, task_pid_nr(current), zr->user - 1);
+
+	/* kernel locks (fs/device.c), so don't do that ourselves
+	 * (prevents deadlocks) */
+	mutex_lock(&zr->lock);
+
+	zoran_close_end_session(fh);
+
+	if (zr->user-- == 1) {	/* Last process */
+		/* Clean up JPEG process */
+		wake_up_interruptible(&zr->jpg_capq);
+		zr36057_enable_jpg(zr, BUZ_MODE_IDLE);
+		zr->jpg_buffers.allocated = 0;
+		zr->jpg_buffers.active = ZORAN_FREE;
+
+		/* disable interrupts */
+		btand(~ZR36057_ICR_IntPinEn, ZR36057_ICR);
+
+		if (zr36067_debug > 1)
+			print_interrupts(zr);
+
+		/* Overlay off */
+		zr->v4l_overlay_active = 0;
+		zr36057_overlay(zr, 0);
+		zr->overlay_mask = NULL;
+
+		/* capture off */
+		wake_up_interruptible(&zr->v4l_capq);
+		zr36057_set_memgrab(zr, 0);
+		zr->v4l_buffers.allocated = 0;
+		zr->v4l_buffers.active = ZORAN_FREE;
+		zoran_set_pci_master(zr, 0);
+
+		if (!pass_through) {	/* Switch to color bar */
+			decoder_call(zr, video, s_stream, 0);
+			encoder_call(zr, video, s_routing, 2, 0, 0);
+		}
+	}
+	mutex_unlock(&zr->lock);
+
+	v4l2_fh_del(&fh->fh);
+	v4l2_fh_exit(&fh->fh);
+	kfree(fh->overlay_mask);
+	kfree(fh);
+
+	dprintk(4, KERN_INFO "%s: %s done\n", ZR_DEVNAME(zr), __func__);
+
+	return 0;
+}
+
+static int setup_fbuffer(struct zoran_fh *fh,
+	       void                      *base,
+	       const struct zoran_format *fmt,
+	       int                        width,
+	       int                        height,
+	       int                        bytesperline)
+{
+	struct zoran *zr = fh->zr;
+
+	/* (Ronald) v4l/v4l2 guidelines */
+	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	/* Don't allow frame buffer overlay if PCI or AGP is buggy, or on
+	   ALi Magik (that needs very low latency while the card needs a
+	   higher value always) */
+
+	if (pci_pci_problems & (PCIPCI_FAIL | PCIAGP_FAIL | PCIPCI_ALIMAGIK))
+		return -ENXIO;
+
+	/* we need a bytesperline value, even if not given */
+	if (!bytesperline)
+		bytesperline = width * ((fmt->depth + 7) & ~7) / 8;
+
+#if 0
+	if (zr->overlay_active) {
+		/* dzjee... stupid users... don't even bother to turn off
+		 * overlay before changing the memory location...
+		 * normally, we would return errors here. However, one of
+		 * the tools that does this is... xawtv! and since xawtv
+		 * is used by +/- 99% of the users, we'd rather be user-
+		 * friendly and silently do as if nothing went wrong */
+		dprintk(3,
+			KERN_ERR
+			"%s: %s - forced overlay turnoff because framebuffer changed\n",
+			ZR_DEVNAME(zr), __func__);
+		zr36057_overlay(zr, 0);
+	}
+#endif
+
+	if (!(fmt->flags & ZORAN_FORMAT_OVERLAY)) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - no valid overlay format given\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+	if (height <= 0 || width <= 0 || bytesperline <= 0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - invalid height/width/bpl value (%d|%d|%d)\n",
+			ZR_DEVNAME(zr), __func__, width, height, bytesperline);
+		return -EINVAL;
+	}
+	if (bytesperline & 3) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - bytesperline (%d) must be 4-byte aligned\n",
+			ZR_DEVNAME(zr), __func__, bytesperline);
+		return -EINVAL;
+	}
+
+	zr->vbuf_base = (void *) ((unsigned long) base & ~3);
+	zr->vbuf_height = height;
+	zr->vbuf_width = width;
+	zr->vbuf_depth = fmt->depth;
+	zr->overlay_settings.format = fmt;
+	zr->vbuf_bytesperline = bytesperline;
+
+	/* The user should set new window parameters */
+	zr->overlay_settings.is_set = 0;
+
+	return 0;
+}
+
+
+static int setup_window(struct zoran_fh *fh,
+			int x,
+			int y,
+			int width,
+			int height,
+			struct v4l2_clip __user *clips,
+			unsigned int clipcount,
+			void __user *bitmap)
+{
+	struct zoran *zr = fh->zr;
+	struct v4l2_clip *vcp = NULL;
+	int on, end;
+
+
+	if (!zr->vbuf_base) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - frame buffer has to be set first\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	if (!fh->overlay_settings.format) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - no overlay format set\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	if (clipcount > 2048) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - invalid clipcount\n",
+			 ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	/*
+	 * The video front end needs 4-byte alinged line sizes, we correct that
+	 * silently here if necessary
+	 */
+	if (zr->vbuf_depth == 15 || zr->vbuf_depth == 16) {
+		end = (x + width) & ~1;	/* round down */
+		x = (x + 1) & ~1;	/* round up */
+		width = end - x;
+	}
+
+	if (zr->vbuf_depth == 24) {
+		end = (x + width) & ~3;	/* round down */
+		x = (x + 3) & ~3;	/* round up */
+		width = end - x;
+	}
+
+	if (width > BUZ_MAX_WIDTH)
+		width = BUZ_MAX_WIDTH;
+	if (height > BUZ_MAX_HEIGHT)
+		height = BUZ_MAX_HEIGHT;
+
+	/* Check for invalid parameters */
+	if (width < BUZ_MIN_WIDTH || height < BUZ_MIN_HEIGHT ||
+	    width > BUZ_MAX_WIDTH || height > BUZ_MAX_HEIGHT) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - width = %d or height = %d invalid\n",
+			ZR_DEVNAME(zr), __func__, width, height);
+		return -EINVAL;
+	}
+
+	fh->overlay_settings.x = x;
+	fh->overlay_settings.y = y;
+	fh->overlay_settings.width = width;
+	fh->overlay_settings.height = height;
+	fh->overlay_settings.clipcount = clipcount;
+
+	/*
+	 * If an overlay is running, we have to switch it off
+	 * and switch it on again in order to get the new settings in effect.
+	 *
+	 * We also want to avoid that the overlay mask is written
+	 * when an overlay is running.
+	 */
+
+	on = zr->v4l_overlay_active && !zr->v4l_memgrab_active &&
+	    zr->overlay_active != ZORAN_FREE &&
+	    fh->overlay_active != ZORAN_FREE;
+	if (on)
+		zr36057_overlay(zr, 0);
+
+	/*
+	 *   Write the overlay mask if clips are wanted.
+	 *   We prefer a bitmap.
+	 */
+	if (bitmap) {
+		/* fake value - it just means we want clips */
+		fh->overlay_settings.clipcount = 1;
+
+		if (copy_from_user(fh->overlay_mask, bitmap,
+				   (width * height + 7) / 8)) {
+			return -EFAULT;
+		}
+	} else if (clipcount) {
+		/* write our own bitmap from the clips */
+		vcp = vmalloc(array_size(sizeof(struct v4l2_clip),
+					 clipcount + 4));
+		if (vcp == NULL) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - Alloc of clip mask failed\n",
+				ZR_DEVNAME(zr), __func__);
+			return -ENOMEM;
+		}
+		if (copy_from_user
+		    (vcp, clips, sizeof(struct v4l2_clip) * clipcount)) {
+			vfree(vcp);
+			return -EFAULT;
+		}
+		write_overlay_mask(fh, vcp, clipcount);
+		vfree(vcp);
+	}
+
+	fh->overlay_settings.is_set = 1;
+	if (fh->overlay_active != ZORAN_FREE &&
+	    zr->overlay_active != ZORAN_FREE)
+		zr->overlay_settings = fh->overlay_settings;
+
+	if (on)
+		zr36057_overlay(zr, 1);
+
+	/* Make sure the changes come into effect */
+	return wait_grab_pending(zr);
+}
+
+static int setup_overlay(struct zoran_fh *fh, int on)
+{
+	struct zoran *zr = fh->zr;
+
+	/* If there is nothing to do, return immediately */
+	if ((on && fh->overlay_active != ZORAN_FREE) ||
+	    (!on && fh->overlay_active == ZORAN_FREE))
+		return 0;
+
+	/* check whether we're touching someone else's overlay */
+	if (on && zr->overlay_active != ZORAN_FREE &&
+	    fh->overlay_active == ZORAN_FREE) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - overlay is already active for another session\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EBUSY;
+	}
+	if (!on && zr->overlay_active != ZORAN_FREE &&
+	    fh->overlay_active == ZORAN_FREE) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - you cannot cancel someone else's session\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EPERM;
+	}
+
+	if (on == 0) {
+		zr->overlay_active = fh->overlay_active = ZORAN_FREE;
+		zr->v4l_overlay_active = 0;
+		/* When a grab is running, the video simply
+		 * won't be switched on any more */
+		if (!zr->v4l_memgrab_active)
+			zr36057_overlay(zr, 0);
+		zr->overlay_mask = NULL;
+	} else {
+		if (!zr->vbuf_base || !fh->overlay_settings.is_set) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - buffer or window not set\n",
+				ZR_DEVNAME(zr), __func__);
+			return -EINVAL;
+		}
+		if (!fh->overlay_settings.format) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - no overlay format set\n",
+				ZR_DEVNAME(zr), __func__);
+			return -EINVAL;
+		}
+		zr->overlay_active = fh->overlay_active = ZORAN_LOCKED;
+		zr->v4l_overlay_active = 1;
+		zr->overlay_mask = fh->overlay_mask;
+		zr->overlay_settings = fh->overlay_settings;
+		if (!zr->v4l_memgrab_active)
+			zr36057_overlay(zr, 1);
+		/* When a grab is running, the video will be
+		 * switched on when grab is finished */
+	}
+
+	/* Make sure the changes come into effect */
+	return wait_grab_pending(zr);
+}
+
+/* get the status of a buffer in the clients buffer queue */
+static int zoran_v4l2_buffer_status(struct zoran_fh *fh,
+				    struct v4l2_buffer *buf, int num)
+{
+	struct zoran *zr = fh->zr;
+	unsigned long flags;
+
+	buf->flags = V4L2_BUF_FLAG_MAPPED | V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+
+	switch (fh->map_mode) {
+	case ZORAN_MAP_MODE_RAW:
+		/* check range */
+		if (num < 0 || num >= fh->buffers.num_buffers ||
+		    !fh->buffers.allocated) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - wrong number or buffers not allocated\n",
+				ZR_DEVNAME(zr), __func__);
+			return -EINVAL;
+		}
+
+		spin_lock_irqsave(&zr->spinlock, flags);
+		dprintk(3,
+			KERN_DEBUG
+			"%s: %s() - raw active=%c, buffer %d: state=%c, map=%c\n",
+			ZR_DEVNAME(zr), __func__,
+			"FAL"[fh->buffers.active], num,
+			"UPMD"[zr->v4l_buffers.buffer[num].state],
+			fh->buffers.buffer[num].map ? 'Y' : 'N');
+		spin_unlock_irqrestore(&zr->spinlock, flags);
+
+		buf->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+		buf->length = fh->buffers.buffer_size;
+
+		/* get buffer */
+		buf->bytesused = fh->buffers.buffer[num].bs.length;
+		if (fh->buffers.buffer[num].state == BUZ_STATE_DONE ||
+		    fh->buffers.buffer[num].state == BUZ_STATE_USER) {
+			buf->sequence = fh->buffers.buffer[num].bs.seq;
+			buf->flags |= V4L2_BUF_FLAG_DONE;
+			buf->timestamp = ns_to_timeval(fh->buffers.buffer[num].bs.ts);
+		} else {
+			buf->flags |= V4L2_BUF_FLAG_QUEUED;
+		}
+
+		if (fh->v4l_settings.height <= BUZ_MAX_HEIGHT / 2)
+			buf->field = V4L2_FIELD_TOP;
+		else
+			buf->field = V4L2_FIELD_INTERLACED;
+
+		break;
+
+	case ZORAN_MAP_MODE_JPG_REC:
+	case ZORAN_MAP_MODE_JPG_PLAY:
+
+		/* check range */
+		if (num < 0 || num >= fh->buffers.num_buffers ||
+		    !fh->buffers.allocated) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s - wrong number or buffers not allocated\n",
+				ZR_DEVNAME(zr), __func__);
+			return -EINVAL;
+		}
+
+		buf->type = (fh->map_mode == ZORAN_MAP_MODE_JPG_REC) ?
+			      V4L2_BUF_TYPE_VIDEO_CAPTURE :
+			      V4L2_BUF_TYPE_VIDEO_OUTPUT;
+		buf->length = fh->buffers.buffer_size;
+
+		/* these variables are only written after frame has been captured */
+		if (fh->buffers.buffer[num].state == BUZ_STATE_DONE ||
+		    fh->buffers.buffer[num].state == BUZ_STATE_USER) {
+			buf->sequence = fh->buffers.buffer[num].bs.seq;
+			buf->timestamp = ns_to_timeval(fh->buffers.buffer[num].bs.ts);
+			buf->bytesused = fh->buffers.buffer[num].bs.length;
+			buf->flags |= V4L2_BUF_FLAG_DONE;
+		} else {
+			buf->flags |= V4L2_BUF_FLAG_QUEUED;
+		}
+
+		/* which fields are these? */
+		if (fh->jpg_settings.TmpDcm != 1)
+			buf->field = fh->jpg_settings.odd_even ?
+				V4L2_FIELD_TOP : V4L2_FIELD_BOTTOM;
+		else
+			buf->field = fh->jpg_settings.odd_even ?
+				V4L2_FIELD_SEQ_TB : V4L2_FIELD_SEQ_BT;
+
+		break;
+
+	default:
+
+		dprintk(5,
+			KERN_ERR
+			"%s: %s - invalid buffer type|map_mode (%d|%d)\n",
+			ZR_DEVNAME(zr), __func__, buf->type, fh->map_mode);
+		return -EINVAL;
+	}
+
+	buf->memory = V4L2_MEMORY_MMAP;
+	buf->index = num;
+	buf->m.offset = buf->length * num;
+
+	return 0;
+}
+
+static int
+zoran_set_norm (struct zoran *zr,
+		v4l2_std_id norm)
+{
+	int on;
+
+	if (zr->v4l_buffers.active != ZORAN_FREE ||
+	    zr->jpg_buffers.active != ZORAN_FREE) {
+		dprintk(1,
+			KERN_WARNING
+			"%s: %s called while in playback/capture mode\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EBUSY;
+	}
+
+	if (!(norm & zr->card.norms)) {
+		dprintk(1,
+			KERN_ERR "%s: %s - unsupported norm %llx\n",
+			ZR_DEVNAME(zr), __func__, norm);
+		return -EINVAL;
+	}
+
+	if (norm & V4L2_STD_SECAM)
+		zr->timing = zr->card.tvn[2];
+	else if (norm & V4L2_STD_NTSC)
+		zr->timing = zr->card.tvn[1];
+	else
+		zr->timing = zr->card.tvn[0];
+
+	/* We switch overlay off and on since a change in the
+	 * norm needs different VFE settings */
+	on = zr->overlay_active && !zr->v4l_memgrab_active;
+	if (on)
+		zr36057_overlay(zr, 0);
+
+	decoder_call(zr, video, s_std, norm);
+	encoder_call(zr, video, s_std_output, norm);
+
+	if (on)
+		zr36057_overlay(zr, 1);
+
+	/* Make sure the changes come into effect */
+	zr->norm = norm;
+
+	return 0;
+}
+
+static int
+zoran_set_input (struct zoran *zr,
+		 int           input)
+{
+	if (input == zr->input) {
+		return 0;
+	}
+
+	if (zr->v4l_buffers.active != ZORAN_FREE ||
+	    zr->jpg_buffers.active != ZORAN_FREE) {
+		dprintk(1,
+			KERN_WARNING
+			"%s: %s called while in playback/capture mode\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EBUSY;
+	}
+
+	if (input < 0 || input >= zr->card.inputs) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - unsupported input %d\n",
+			ZR_DEVNAME(zr), __func__, input);
+		return -EINVAL;
+	}
+
+	zr->input = input;
+
+	decoder_call(zr, video, s_routing,
+			zr->card.input[input].muxsel, 0, 0);
+
+	return 0;
+}
+
+/*
+ *   ioctl routine
+ */
+
+static int zoran_querycap(struct file *file, void *__fh, struct v4l2_capability *cap)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	strscpy(cap->card, ZR_DEVNAME(zr), sizeof(cap->card));
+	strscpy(cap->driver, "zoran", sizeof(cap->driver));
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
+		 pci_name(zr->pci_dev));
+	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE |
+			   V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OVERLAY;
+	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
+	return 0;
+}
+
+static int zoran_enum_fmt(struct zoran *zr, struct v4l2_fmtdesc *fmt, int flag)
+{
+	unsigned int num, i;
+
+	for (num = i = 0; i < NUM_FORMATS; i++) {
+		if (zoran_formats[i].flags & flag && num++ == fmt->index) {
+			strscpy(fmt->description, zoran_formats[i].name,
+				sizeof(fmt->description));
+			/* fmt struct pre-zeroed, so adding '\0' not needed */
+			fmt->pixelformat = zoran_formats[i].fourcc;
+			if (zoran_formats[i].flags & ZORAN_FORMAT_COMPRESSED)
+				fmt->flags |= V4L2_FMT_FLAG_COMPRESSED;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int zoran_enum_fmt_vid_cap(struct file *file, void *__fh,
+					    struct v4l2_fmtdesc *f)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	return zoran_enum_fmt(zr, f, ZORAN_FORMAT_CAPTURE);
+}
+
+static int zoran_enum_fmt_vid_out(struct file *file, void *__fh,
+					    struct v4l2_fmtdesc *f)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	return zoran_enum_fmt(zr, f, ZORAN_FORMAT_PLAYBACK);
+}
+
+static int zoran_enum_fmt_vid_overlay(struct file *file, void *__fh,
+					    struct v4l2_fmtdesc *f)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	return zoran_enum_fmt(zr, f, ZORAN_FORMAT_OVERLAY);
+}
+
+static int zoran_g_fmt_vid_out(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+
+	fmt->fmt.pix.width = fh->jpg_settings.img_width / fh->jpg_settings.HorDcm;
+	fmt->fmt.pix.height = fh->jpg_settings.img_height * 2 /
+		(fh->jpg_settings.VerDcm * fh->jpg_settings.TmpDcm);
+	fmt->fmt.pix.sizeimage = zoran_v4l2_calc_bufsize(&fh->jpg_settings);
+	fmt->fmt.pix.pixelformat = V4L2_PIX_FMT_MJPEG;
+	if (fh->jpg_settings.TmpDcm == 1)
+		fmt->fmt.pix.field = (fh->jpg_settings.odd_even ?
+				V4L2_FIELD_SEQ_TB : V4L2_FIELD_SEQ_BT);
+	else
+		fmt->fmt.pix.field = (fh->jpg_settings.odd_even ?
+				V4L2_FIELD_TOP : V4L2_FIELD_BOTTOM);
+	fmt->fmt.pix.bytesperline = 0;
+	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+
+	return 0;
+}
+
+static int zoran_g_fmt_vid_cap(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	if (fh->map_mode != ZORAN_MAP_MODE_RAW)
+		return zoran_g_fmt_vid_out(file, fh, fmt);
+
+	fmt->fmt.pix.width = fh->v4l_settings.width;
+	fmt->fmt.pix.height = fh->v4l_settings.height;
+	fmt->fmt.pix.sizeimage = fh->v4l_settings.bytesperline *
+					fh->v4l_settings.height;
+	fmt->fmt.pix.pixelformat = fh->v4l_settings.format->fourcc;
+	fmt->fmt.pix.colorspace = fh->v4l_settings.format->colorspace;
+	fmt->fmt.pix.bytesperline = fh->v4l_settings.bytesperline;
+	if (BUZ_MAX_HEIGHT < (fh->v4l_settings.height * 2))
+		fmt->fmt.pix.field = V4L2_FIELD_INTERLACED;
+	else
+		fmt->fmt.pix.field = V4L2_FIELD_TOP;
+	return 0;
+}
+
+static int zoran_g_fmt_vid_overlay(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	fmt->fmt.win.w.left = fh->overlay_settings.x;
+	fmt->fmt.win.w.top = fh->overlay_settings.y;
+	fmt->fmt.win.w.width = fh->overlay_settings.width;
+	fmt->fmt.win.w.height = fh->overlay_settings.height;
+	if (fh->overlay_settings.width * 2 > BUZ_MAX_HEIGHT)
+		fmt->fmt.win.field = V4L2_FIELD_INTERLACED;
+	else
+		fmt->fmt.win.field = V4L2_FIELD_TOP;
+
+	return 0;
+}
+
+static int zoran_try_fmt_vid_overlay(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	if (fmt->fmt.win.w.width > BUZ_MAX_WIDTH)
+		fmt->fmt.win.w.width = BUZ_MAX_WIDTH;
+	if (fmt->fmt.win.w.width < BUZ_MIN_WIDTH)
+		fmt->fmt.win.w.width = BUZ_MIN_WIDTH;
+	if (fmt->fmt.win.w.height > BUZ_MAX_HEIGHT)
+		fmt->fmt.win.w.height = BUZ_MAX_HEIGHT;
+	if (fmt->fmt.win.w.height < BUZ_MIN_HEIGHT)
+		fmt->fmt.win.w.height = BUZ_MIN_HEIGHT;
+
+	return 0;
+}
+
+static int zoran_try_fmt_vid_out(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	struct zoran_jpg_settings settings;
+	int res = 0;
+
+	if (fmt->fmt.pix.pixelformat != V4L2_PIX_FMT_MJPEG)
+		return -EINVAL;
+
+	settings = fh->jpg_settings;
+
+	/* we actually need to set 'real' parameters now */
+	if ((fmt->fmt.pix.height * 2) > BUZ_MAX_HEIGHT)
+		settings.TmpDcm = 1;
+	else
+		settings.TmpDcm = 2;
+	settings.decimation = 0;
+	if (fmt->fmt.pix.height <= fh->jpg_settings.img_height / 2)
+		settings.VerDcm = 2;
+	else
+		settings.VerDcm = 1;
+	if (fmt->fmt.pix.width <= fh->jpg_settings.img_width / 4)
+		settings.HorDcm = 4;
+	else if (fmt->fmt.pix.width <= fh->jpg_settings.img_width / 2)
+		settings.HorDcm = 2;
+	else
+		settings.HorDcm = 1;
+	if (settings.TmpDcm == 1)
+		settings.field_per_buff = 2;
+	else
+		settings.field_per_buff = 1;
+
+	if (settings.HorDcm > 1) {
+		settings.img_x = (BUZ_MAX_WIDTH == 720) ? 8 : 0;
+		settings.img_width = (BUZ_MAX_WIDTH == 720) ? 704 : BUZ_MAX_WIDTH;
+	} else {
+		settings.img_x = 0;
+		settings.img_width = BUZ_MAX_WIDTH;
+	}
+
+	/* check */
+	res = zoran_check_jpg_settings(zr, &settings, 1);
+	if (res)
+		return res;
+
+	/* tell the user what we actually did */
+	fmt->fmt.pix.width = settings.img_width / settings.HorDcm;
+	fmt->fmt.pix.height = settings.img_height * 2 /
+		(settings.TmpDcm * settings.VerDcm);
+	if (settings.TmpDcm == 1)
+		fmt->fmt.pix.field = (fh->jpg_settings.odd_even ?
+				V4L2_FIELD_SEQ_TB : V4L2_FIELD_SEQ_BT);
+	else
+		fmt->fmt.pix.field = (fh->jpg_settings.odd_even ?
+				V4L2_FIELD_TOP : V4L2_FIELD_BOTTOM);
+
+	fmt->fmt.pix.sizeimage = zoran_v4l2_calc_bufsize(&settings);
+	fmt->fmt.pix.bytesperline = 0;
+	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+	return res;
+}
+
+static int zoran_try_fmt_vid_cap(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int bpp;
+	int i;
+
+	if (fmt->fmt.pix.pixelformat == V4L2_PIX_FMT_MJPEG)
+		return zoran_try_fmt_vid_out(file, fh, fmt);
+
+	for (i = 0; i < NUM_FORMATS; i++)
+		if (zoran_formats[i].fourcc == fmt->fmt.pix.pixelformat)
+			break;
+
+	if (i == NUM_FORMATS)
+		return -EINVAL;
+
+	bpp = DIV_ROUND_UP(zoran_formats[i].depth, 8);
+	v4l_bound_align_image(
+		&fmt->fmt.pix.width, BUZ_MIN_WIDTH, BUZ_MAX_WIDTH, bpp == 2 ? 1 : 2,
+		&fmt->fmt.pix.height, BUZ_MIN_HEIGHT, BUZ_MAX_HEIGHT, 0, 0);
+	return 0;
+}
+
+static int zoran_s_fmt_vid_overlay(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	int res;
+
+	dprintk(3, "x=%d, y=%d, w=%d, h=%d, cnt=%d, map=0x%p\n",
+			fmt->fmt.win.w.left, fmt->fmt.win.w.top,
+			fmt->fmt.win.w.width,
+			fmt->fmt.win.w.height,
+			fmt->fmt.win.clipcount,
+			fmt->fmt.win.bitmap);
+	res = setup_window(fh, fmt->fmt.win.w.left, fmt->fmt.win.w.top,
+			   fmt->fmt.win.w.width, fmt->fmt.win.w.height,
+			   (struct v4l2_clip __user *)fmt->fmt.win.clips,
+			   fmt->fmt.win.clipcount, fmt->fmt.win.bitmap);
+	return res;
+}
+
+static int zoran_s_fmt_vid_out(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	__le32 printformat = __cpu_to_le32(fmt->fmt.pix.pixelformat);
+	struct zoran_jpg_settings settings;
+	int res = 0;
+
+	dprintk(3, "size=%dx%d, fmt=0x%x (%4.4s)\n",
+			fmt->fmt.pix.width, fmt->fmt.pix.height,
+			fmt->fmt.pix.pixelformat,
+			(char *) &printformat);
+	if (fmt->fmt.pix.pixelformat != V4L2_PIX_FMT_MJPEG)
+		return -EINVAL;
+
+	if (fh->buffers.allocated) {
+		dprintk(1, KERN_ERR "%s: VIDIOC_S_FMT - cannot change capture mode\n",
+			ZR_DEVNAME(zr));
+		res = -EBUSY;
+		return res;
+	}
+
+	settings = fh->jpg_settings;
+
+	/* we actually need to set 'real' parameters now */
+	if (fmt->fmt.pix.height * 2 > BUZ_MAX_HEIGHT)
+		settings.TmpDcm = 1;
+	else
+		settings.TmpDcm = 2;
+	settings.decimation = 0;
+	if (fmt->fmt.pix.height <= fh->jpg_settings.img_height / 2)
+		settings.VerDcm = 2;
+	else
+		settings.VerDcm = 1;
+	if (fmt->fmt.pix.width <= fh->jpg_settings.img_width / 4)
+		settings.HorDcm = 4;
+	else if (fmt->fmt.pix.width <= fh->jpg_settings.img_width / 2)
+		settings.HorDcm = 2;
+	else
+		settings.HorDcm = 1;
+	if (settings.TmpDcm == 1)
+		settings.field_per_buff = 2;
+	else
+		settings.field_per_buff = 1;
+
+	if (settings.HorDcm > 1) {
+		settings.img_x = (BUZ_MAX_WIDTH == 720) ? 8 : 0;
+		settings.img_width = (BUZ_MAX_WIDTH == 720) ? 704 : BUZ_MAX_WIDTH;
+	} else {
+		settings.img_x = 0;
+		settings.img_width = BUZ_MAX_WIDTH;
+	}
+
+	/* check */
+	res = zoran_check_jpg_settings(zr, &settings, 0);
+	if (res)
+		return res;
+
+	/* it's ok, so set them */
+	fh->jpg_settings = settings;
+
+	map_mode_jpg(fh, fmt->type == V4L2_BUF_TYPE_VIDEO_OUTPUT);
+	fh->buffers.buffer_size = zoran_v4l2_calc_bufsize(&fh->jpg_settings);
+
+	/* tell the user what we actually did */
+	fmt->fmt.pix.width = settings.img_width / settings.HorDcm;
+	fmt->fmt.pix.height = settings.img_height * 2 /
+		(settings.TmpDcm * settings.VerDcm);
+	if (settings.TmpDcm == 1)
+		fmt->fmt.pix.field = (fh->jpg_settings.odd_even ?
+				V4L2_FIELD_SEQ_TB : V4L2_FIELD_SEQ_BT);
+	else
+		fmt->fmt.pix.field = (fh->jpg_settings.odd_even ?
+				V4L2_FIELD_TOP : V4L2_FIELD_BOTTOM);
+	fmt->fmt.pix.bytesperline = 0;
+	fmt->fmt.pix.sizeimage = fh->buffers.buffer_size;
+	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SMPTE170M;
+	return res;
+}
+
+static int zoran_s_fmt_vid_cap(struct file *file, void *__fh,
+					struct v4l2_format *fmt)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int i;
+	int res = 0;
+
+	if (fmt->fmt.pix.pixelformat == V4L2_PIX_FMT_MJPEG)
+		return zoran_s_fmt_vid_out(file, fh, fmt);
+
+	for (i = 0; i < NUM_FORMATS; i++)
+		if (fmt->fmt.pix.pixelformat == zoran_formats[i].fourcc)
+			break;
+	if (i == NUM_FORMATS) {
+		dprintk(1, KERN_ERR "%s: VIDIOC_S_FMT - unknown/unsupported format 0x%x\n",
+			ZR_DEVNAME(zr), fmt->fmt.pix.pixelformat);
+		return -EINVAL;
+	}
+
+	if ((fh->map_mode != ZORAN_MAP_MODE_RAW && fh->buffers.allocated) ||
+	    fh->buffers.active != ZORAN_FREE) {
+		dprintk(1, KERN_ERR "%s: VIDIOC_S_FMT - cannot change capture mode\n",
+				ZR_DEVNAME(zr));
+		res = -EBUSY;
+		return res;
+	}
+	if (fmt->fmt.pix.height > BUZ_MAX_HEIGHT)
+		fmt->fmt.pix.height = BUZ_MAX_HEIGHT;
+	if (fmt->fmt.pix.width > BUZ_MAX_WIDTH)
+		fmt->fmt.pix.width = BUZ_MAX_WIDTH;
+
+	map_mode_raw(fh);
+
+	res = zoran_v4l_set_format(fh, fmt->fmt.pix.width, fmt->fmt.pix.height,
+				   &zoran_formats[i]);
+	if (res)
+		return res;
+
+	/* tell the user the results/missing stuff */
+	fmt->fmt.pix.bytesperline = fh->v4l_settings.bytesperline;
+	fmt->fmt.pix.sizeimage = fh->v4l_settings.height * fh->v4l_settings.bytesperline;
+	fmt->fmt.pix.colorspace = fh->v4l_settings.format->colorspace;
+	if (BUZ_MAX_HEIGHT < (fh->v4l_settings.height * 2))
+		fmt->fmt.pix.field = V4L2_FIELD_INTERLACED;
+	else
+		fmt->fmt.pix.field = V4L2_FIELD_TOP;
+	return res;
+}
+
+static int zoran_g_fbuf(struct file *file, void *__fh,
+		struct v4l2_framebuffer *fb)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	memset(fb, 0, sizeof(*fb));
+	fb->base = zr->vbuf_base;
+	fb->fmt.width = zr->vbuf_width;
+	fb->fmt.height = zr->vbuf_height;
+	if (zr->overlay_settings.format)
+		fb->fmt.pixelformat = fh->overlay_settings.format->fourcc;
+	fb->fmt.bytesperline = zr->vbuf_bytesperline;
+	fb->fmt.colorspace = V4L2_COLORSPACE_SRGB;
+	fb->fmt.field = V4L2_FIELD_INTERLACED;
+	fb->capability = V4L2_FBUF_CAP_LIST_CLIPPING;
+
+	return 0;
+}
+
+static int zoran_s_fbuf(struct file *file, void *__fh,
+		const struct v4l2_framebuffer *fb)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int i, res = 0;
+	__le32 printformat = __cpu_to_le32(fb->fmt.pixelformat);
+
+	for (i = 0; i < NUM_FORMATS; i++)
+		if (zoran_formats[i].fourcc == fb->fmt.pixelformat)
+			break;
+	if (i == NUM_FORMATS) {
+		dprintk(1, KERN_ERR "%s: VIDIOC_S_FBUF - format=0x%x (%4.4s) not allowed\n",
+			ZR_DEVNAME(zr), fb->fmt.pixelformat,
+			(char *)&printformat);
+		return -EINVAL;
+	}
+
+	res = setup_fbuffer(fh, fb->base, &zoran_formats[i], fb->fmt.width,
+			    fb->fmt.height, fb->fmt.bytesperline);
+
+	return res;
+}
+
+static int zoran_overlay(struct file *file, void *__fh, unsigned int on)
+{
+	struct zoran_fh *fh = __fh;
+	int res;
+
+	res = setup_overlay(fh, on);
+
+	return res;
+}
+
+static int zoran_streamoff(struct file *file, void *__fh, enum v4l2_buf_type type);
+
+static int zoran_reqbufs(struct file *file, void *__fh, struct v4l2_requestbuffers *req)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res = 0;
+
+	if (req->memory != V4L2_MEMORY_MMAP) {
+		dprintk(2,
+				KERN_ERR
+				"%s: only MEMORY_MMAP capture is supported, not %d\n",
+				ZR_DEVNAME(zr), req->memory);
+		return -EINVAL;
+	}
+
+	if (req->count == 0)
+		return zoran_streamoff(file, fh, req->type);
+
+	if (fh->buffers.allocated) {
+		dprintk(2,
+				KERN_ERR
+				"%s: VIDIOC_REQBUFS - buffers already allocated\n",
+				ZR_DEVNAME(zr));
+		res = -EBUSY;
+		return res;
+	}
+
+	if (fh->map_mode == ZORAN_MAP_MODE_RAW &&
+	    req->type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+		/* control user input */
+		if (req->count < 2)
+			req->count = 2;
+		if (req->count > v4l_nbufs)
+			req->count = v4l_nbufs;
+
+		/* The next mmap will map the V4L buffers */
+		map_mode_raw(fh);
+		fh->buffers.num_buffers = req->count;
+
+		if (v4l_fbuffer_alloc(fh)) {
+			res = -ENOMEM;
+			return res;
+		}
+	} else if (fh->map_mode == ZORAN_MAP_MODE_JPG_REC ||
+		   fh->map_mode == ZORAN_MAP_MODE_JPG_PLAY) {
+		/* we need to calculate size ourselves now */
+		if (req->count < 4)
+			req->count = 4;
+		if (req->count > jpg_nbufs)
+			req->count = jpg_nbufs;
+
+		/* The next mmap will map the MJPEG buffers */
+		map_mode_jpg(fh, req->type == V4L2_BUF_TYPE_VIDEO_OUTPUT);
+		fh->buffers.num_buffers = req->count;
+		fh->buffers.buffer_size = zoran_v4l2_calc_bufsize(&fh->jpg_settings);
+
+		if (jpg_fbuffer_alloc(fh)) {
+			res = -ENOMEM;
+			return res;
+		}
+	} else {
+		dprintk(1,
+				KERN_ERR
+				"%s: VIDIOC_REQBUFS - unknown type %d\n",
+				ZR_DEVNAME(zr), req->type);
+		res = -EINVAL;
+		return res;
+	}
+	return res;
+}
+
+static int zoran_querybuf(struct file *file, void *__fh, struct v4l2_buffer *buf)
+{
+	struct zoran_fh *fh = __fh;
+	int res;
+
+	res = zoran_v4l2_buffer_status(fh, buf, buf->index);
+
+	return res;
+}
+
+static int zoran_qbuf(struct file *file, void *__fh, struct v4l2_buffer *buf)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res = 0, codec_mode, buf_type;
+
+	switch (fh->map_mode) {
+	case ZORAN_MAP_MODE_RAW:
+		if (buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+			dprintk(1, KERN_ERR
+				"%s: VIDIOC_QBUF - invalid buf->type=%d for map_mode=%d\n",
+				ZR_DEVNAME(zr), buf->type, fh->map_mode);
+			res = -EINVAL;
+			return res;
+		}
+
+		res = zoran_v4l_queue_frame(fh, buf->index);
+		if (res)
+			return res;
+		if (!zr->v4l_memgrab_active && fh->buffers.active == ZORAN_LOCKED)
+			zr36057_set_memgrab(zr, 1);
+		break;
+
+	case ZORAN_MAP_MODE_JPG_REC:
+	case ZORAN_MAP_MODE_JPG_PLAY:
+		if (fh->map_mode == ZORAN_MAP_MODE_JPG_PLAY) {
+			buf_type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
+			codec_mode = BUZ_MODE_MOTION_DECOMPRESS;
+		} else {
+			buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+			codec_mode = BUZ_MODE_MOTION_COMPRESS;
+		}
+
+		if (buf->type != buf_type) {
+			dprintk(1, KERN_ERR
+				"%s: VIDIOC_QBUF - invalid buf->type=%d for map_mode=%d\n",
+				ZR_DEVNAME(zr), buf->type, fh->map_mode);
+			res = -EINVAL;
+			return res;
+		}
+
+		res = zoran_jpg_queue_frame(fh, buf->index, codec_mode);
+		if (res != 0)
+			return res;
+		if (zr->codec_mode == BUZ_MODE_IDLE &&
+		    fh->buffers.active == ZORAN_LOCKED)
+			zr36057_enable_jpg(zr, codec_mode);
+
+		break;
+
+	default:
+		dprintk(1, KERN_ERR
+			"%s: VIDIOC_QBUF - unsupported type %d\n",
+			ZR_DEVNAME(zr), buf->type);
+		res = -EINVAL;
+		break;
+	}
+	return res;
+}
+
+static int zoran_dqbuf(struct file *file, void *__fh, struct v4l2_buffer *buf)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res = 0, buf_type, num = -1;	/* compiler borks here (?) */
+
+	switch (fh->map_mode) {
+	case ZORAN_MAP_MODE_RAW:
+		if (buf->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+			dprintk(1, KERN_ERR
+				"%s: VIDIOC_QBUF - invalid buf->type=%d for map_mode=%d\n",
+				ZR_DEVNAME(zr), buf->type, fh->map_mode);
+			res = -EINVAL;
+			return res;
+		}
+
+		num = zr->v4l_pend[zr->v4l_sync_tail & V4L_MASK_FRAME];
+		if (file->f_flags & O_NONBLOCK &&
+		    zr->v4l_buffers.buffer[num].state != BUZ_STATE_DONE) {
+			res = -EAGAIN;
+			return res;
+		}
+		res = v4l_sync(fh, num);
+		if (res)
+			return res;
+		zr->v4l_sync_tail++;
+		res = zoran_v4l2_buffer_status(fh, buf, num);
+		break;
+
+	case ZORAN_MAP_MODE_JPG_REC:
+	case ZORAN_MAP_MODE_JPG_PLAY:
+	{
+		struct zoran_sync bs;
+
+		if (fh->map_mode == ZORAN_MAP_MODE_JPG_PLAY)
+			buf_type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
+		else
+			buf_type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+
+		if (buf->type != buf_type) {
+			dprintk(1, KERN_ERR
+				"%s: VIDIOC_QBUF - invalid buf->type=%d for map_mode=%d\n",
+				ZR_DEVNAME(zr), buf->type, fh->map_mode);
+			res = -EINVAL;
+			return res;
+		}
+
+		num = zr->jpg_pend[zr->jpg_que_tail & BUZ_MASK_FRAME];
+
+		if (file->f_flags & O_NONBLOCK &&
+		    zr->jpg_buffers.buffer[num].state != BUZ_STATE_DONE) {
+			res = -EAGAIN;
+			return res;
+		}
+		bs.frame = 0; /* suppress compiler warning */
+		res = jpg_sync(fh, &bs);
+		if (res)
+			return res;
+		res = zoran_v4l2_buffer_status(fh, buf, bs.frame);
+		break;
+	}
+
+	default:
+		dprintk(1, KERN_ERR
+			"%s: VIDIOC_DQBUF - unsupported type %d\n",
+			ZR_DEVNAME(zr), buf->type);
+		res = -EINVAL;
+		break;
+	}
+	return res;
+}
+
+static int zoran_streamon(struct file *file, void *__fh, enum v4l2_buf_type type)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res = 0;
+
+	switch (fh->map_mode) {
+	case ZORAN_MAP_MODE_RAW:	/* raw capture */
+		if (zr->v4l_buffers.active != ZORAN_ACTIVE ||
+		    fh->buffers.active != ZORAN_ACTIVE) {
+			res = -EBUSY;
+			return res;
+		}
+
+		zr->v4l_buffers.active = fh->buffers.active = ZORAN_LOCKED;
+		zr->v4l_settings = fh->v4l_settings;
+
+		zr->v4l_sync_tail = zr->v4l_pend_tail;
+		if (!zr->v4l_memgrab_active &&
+		    zr->v4l_pend_head != zr->v4l_pend_tail) {
+			zr36057_set_memgrab(zr, 1);
+		}
+		break;
+
+	case ZORAN_MAP_MODE_JPG_REC:
+	case ZORAN_MAP_MODE_JPG_PLAY:
+		/* what is the codec mode right now? */
+		if (zr->jpg_buffers.active != ZORAN_ACTIVE ||
+		    fh->buffers.active != ZORAN_ACTIVE) {
+			res = -EBUSY;
+			return res;
+		}
+
+		zr->jpg_buffers.active = fh->buffers.active = ZORAN_LOCKED;
+
+		if (zr->jpg_que_head != zr->jpg_que_tail) {
+			/* Start the jpeg codec when the first frame is queued  */
+			jpeg_start(zr);
+		}
+		break;
+
+	default:
+		dprintk(1,
+			KERN_ERR
+			"%s: VIDIOC_STREAMON - invalid map mode %d\n",
+			ZR_DEVNAME(zr), fh->map_mode);
+		res = -EINVAL;
+		break;
+	}
+	return res;
+}
+
+static int zoran_streamoff(struct file *file, void *__fh, enum v4l2_buf_type type)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int i, res = 0;
+	unsigned long flags;
+
+	switch (fh->map_mode) {
+	case ZORAN_MAP_MODE_RAW:	/* raw capture */
+		if (fh->buffers.active == ZORAN_FREE &&
+		    zr->v4l_buffers.active != ZORAN_FREE) {
+			res = -EPERM;	/* stay off other's settings! */
+			return res;
+		}
+		if (zr->v4l_buffers.active == ZORAN_FREE)
+			return res;
+
+		spin_lock_irqsave(&zr->spinlock, flags);
+		/* unload capture */
+		if (zr->v4l_memgrab_active) {
+
+			zr36057_set_memgrab(zr, 0);
+		}
+
+		for (i = 0; i < fh->buffers.num_buffers; i++)
+			zr->v4l_buffers.buffer[i].state = BUZ_STATE_USER;
+		fh->buffers = zr->v4l_buffers;
+
+		zr->v4l_buffers.active = fh->buffers.active = ZORAN_FREE;
+
+		zr->v4l_grab_seq = 0;
+		zr->v4l_pend_head = zr->v4l_pend_tail = 0;
+		zr->v4l_sync_tail = 0;
+
+		spin_unlock_irqrestore(&zr->spinlock, flags);
+
+		break;
+
+	case ZORAN_MAP_MODE_JPG_REC:
+	case ZORAN_MAP_MODE_JPG_PLAY:
+		if (fh->buffers.active == ZORAN_FREE &&
+		    zr->jpg_buffers.active != ZORAN_FREE) {
+			res = -EPERM;	/* stay off other's settings! */
+			return res;
+		}
+		if (zr->jpg_buffers.active == ZORAN_FREE)
+			return res;
+
+		res = jpg_qbuf(fh, -1,
+			     (fh->map_mode == ZORAN_MAP_MODE_JPG_REC) ?
+			     BUZ_MODE_MOTION_COMPRESS :
+			     BUZ_MODE_MOTION_DECOMPRESS);
+		if (res)
+			return res;
+		break;
+	default:
+		dprintk(1, KERN_ERR
+			"%s: VIDIOC_STREAMOFF - invalid map mode %d\n",
+			ZR_DEVNAME(zr), fh->map_mode);
+		res = -EINVAL;
+		break;
+	}
+	return res;
+}
+static int zoran_g_std(struct file *file, void *__fh, v4l2_std_id *std)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	*std = zr->norm;
+	return 0;
+}
+
+static int zoran_s_std(struct file *file, void *__fh, v4l2_std_id std)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res = 0;
+
+	res = zoran_set_norm(zr, std);
+	if (res)
+		return res;
+
+	res = wait_grab_pending(zr);
+	return res;
+}
+
+static int zoran_enum_input(struct file *file, void *__fh,
+				 struct v4l2_input *inp)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	if (inp->index >= zr->card.inputs)
+		return -EINVAL;
+
+	strscpy(inp->name, zr->card.input[inp->index].name,
+		sizeof(inp->name));
+	inp->type = V4L2_INPUT_TYPE_CAMERA;
+	inp->std = V4L2_STD_ALL;
+
+	/* Get status of video decoder */
+	decoder_call(zr, video, g_input_status, &inp->status);
+	return 0;
+}
+
+static int zoran_g_input(struct file *file, void *__fh, unsigned int *input)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	*input = zr->input;
+
+	return 0;
+}
+
+static int zoran_s_input(struct file *file, void *__fh, unsigned int input)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res;
+
+	res = zoran_set_input(zr, input);
+	if (res)
+		return res;
+
+	/* Make sure the changes come into effect */
+	res = wait_grab_pending(zr);
+	return res;
+}
+
+static int zoran_enum_output(struct file *file, void *__fh,
+				  struct v4l2_output *outp)
+{
+	if (outp->index != 0)
+		return -EINVAL;
+
+	outp->index = 0;
+	outp->type = V4L2_OUTPUT_TYPE_ANALOGVGAOVERLAY;
+	strscpy(outp->name, "Autodetect", sizeof(outp->name));
+
+	return 0;
+}
+
+static int zoran_g_output(struct file *file, void *__fh, unsigned int *output)
+{
+	*output = 0;
+
+	return 0;
+}
+
+static int zoran_s_output(struct file *file, void *__fh, unsigned int output)
+{
+	if (output != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* cropping (sub-frame capture) */
+static int zoran_g_selection(struct file *file, void *__fh, struct v4l2_selection *sel)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+
+	if (sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
+	    sel->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	if (fh->map_mode == ZORAN_MAP_MODE_RAW) {
+		dprintk(1, KERN_ERR
+			"%s: VIDIOC_G_SELECTION - subcapture only supported for compressed capture\n",
+			ZR_DEVNAME(zr));
+		return -EINVAL;
+	}
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+		sel->r.top = fh->jpg_settings.img_y;
+		sel->r.left = fh->jpg_settings.img_x;
+		sel->r.width = fh->jpg_settings.img_width;
+		sel->r.height = fh->jpg_settings.img_height;
+		break;
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		sel->r.top = sel->r.left = 0;
+		sel->r.width = BUZ_MIN_WIDTH;
+		sel->r.height = BUZ_MIN_HEIGHT;
+		break;
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = sel->r.left = 0;
+		sel->r.width = BUZ_MAX_WIDTH;
+		sel->r.height = BUZ_MAX_HEIGHT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int zoran_s_selection(struct file *file, void *__fh, struct v4l2_selection *sel)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	struct zoran_jpg_settings settings;
+	int res;
+
+	if (sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
+	    sel->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		return -EINVAL;
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	if (fh->map_mode == ZORAN_MAP_MODE_RAW) {
+		dprintk(1, KERN_ERR
+			"%s: VIDIOC_S_SELECTION - subcapture only supported for compressed capture\n",
+			ZR_DEVNAME(zr));
+		return -EINVAL;
+	}
+
+	settings = fh->jpg_settings;
+
+	if (fh->buffers.allocated) {
+		dprintk(1, KERN_ERR
+			"%s: VIDIOC_S_SELECTION - cannot change settings while active\n",
+			ZR_DEVNAME(zr));
+		return -EBUSY;
+	}
+
+	/* move into a form that we understand */
+	settings.img_x = sel->r.left;
+	settings.img_y = sel->r.top;
+	settings.img_width = sel->r.width;
+	settings.img_height = sel->r.height;
+
+	/* check validity */
+	res = zoran_check_jpg_settings(zr, &settings, 0);
+	if (res)
+		return res;
+
+	/* accept */
+	fh->jpg_settings = settings;
+	return res;
+}
+
+static int zoran_g_jpegcomp(struct file *file, void *__fh,
+					struct v4l2_jpegcompression *params)
+{
+	struct zoran_fh *fh = __fh;
+	memset(params, 0, sizeof(*params));
+
+	params->quality = fh->jpg_settings.jpg_comp.quality;
+	params->APPn = fh->jpg_settings.jpg_comp.APPn;
+	memcpy(params->APP_data,
+	       fh->jpg_settings.jpg_comp.APP_data,
+	       fh->jpg_settings.jpg_comp.APP_len);
+	params->APP_len = fh->jpg_settings.jpg_comp.APP_len;
+	memcpy(params->COM_data,
+	       fh->jpg_settings.jpg_comp.COM_data,
+	       fh->jpg_settings.jpg_comp.COM_len);
+	params->COM_len = fh->jpg_settings.jpg_comp.COM_len;
+	params->jpeg_markers =
+	    fh->jpg_settings.jpg_comp.jpeg_markers;
+
+	return 0;
+}
+
+static int zoran_s_jpegcomp(struct file *file, void *__fh,
+					const struct v4l2_jpegcompression *params)
+{
+	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
+	int res = 0;
+	struct zoran_jpg_settings settings;
+
+	settings = fh->jpg_settings;
+
+	settings.jpg_comp = *params;
+
+	if (fh->buffers.active != ZORAN_FREE) {
+		dprintk(1, KERN_WARNING
+			"%s: VIDIOC_S_JPEGCOMP called while in playback/capture mode\n",
+			ZR_DEVNAME(zr));
+		res = -EBUSY;
+		return res;
+	}
+
+	res = zoran_check_jpg_settings(zr, &settings, 0);
+	if (res)
+		return res;
+	if (!fh->buffers.allocated)
+		fh->buffers.buffer_size =
+			zoran_v4l2_calc_bufsize(&fh->jpg_settings);
+	fh->jpg_settings.jpg_comp = settings.jpg_comp;
+	return res;
+}
+
+static __poll_t
+zoran_poll (struct file *file,
+	    poll_table  *wait)
+{
+	struct zoran_fh *fh = file->private_data;
+	struct zoran *zr = fh->zr;
+	__poll_t res = v4l2_ctrl_poll(file, wait);
+	int frame;
+	unsigned long flags;
+
+	/* we should check whether buffers are ready to be synced on
+	 * (w/o waits - O_NONBLOCK) here
+	 * if ready for read (sync), return EPOLLIN|EPOLLRDNORM,
+	 * if ready for write (sync), return EPOLLOUT|EPOLLWRNORM,
+	 * if error, return EPOLLERR,
+	 * if no buffers queued or so, return EPOLLNVAL
+	 */
+
+	switch (fh->map_mode) {
+	case ZORAN_MAP_MODE_RAW:
+		poll_wait(file, &zr->v4l_capq, wait);
+		frame = zr->v4l_pend[zr->v4l_sync_tail & V4L_MASK_FRAME];
+
+		spin_lock_irqsave(&zr->spinlock, flags);
+		dprintk(3,
+			KERN_DEBUG
+			"%s: %s() raw - active=%c, sync_tail=%lu/%c, pend_tail=%lu, pend_head=%lu\n",
+			ZR_DEVNAME(zr), __func__,
+			"FAL"[fh->buffers.active], zr->v4l_sync_tail,
+			"UPMD"[zr->v4l_buffers.buffer[frame].state],
+			zr->v4l_pend_tail, zr->v4l_pend_head);
+		/* Process is the one capturing? */
+		if (fh->buffers.active != ZORAN_FREE &&
+		    /* Buffer ready to DQBUF? */
+		    zr->v4l_buffers.buffer[frame].state == BUZ_STATE_DONE)
+			res |= EPOLLIN | EPOLLRDNORM;
+		spin_unlock_irqrestore(&zr->spinlock, flags);
+
+		break;
+
+	case ZORAN_MAP_MODE_JPG_REC:
+	case ZORAN_MAP_MODE_JPG_PLAY:
+		poll_wait(file, &zr->jpg_capq, wait);
+		frame = zr->jpg_pend[zr->jpg_que_tail & BUZ_MASK_FRAME];
+
+		spin_lock_irqsave(&zr->spinlock, flags);
+		dprintk(3,
+			KERN_DEBUG
+			"%s: %s() jpg - active=%c, que_tail=%lu/%c, que_head=%lu, dma=%lu/%lu\n",
+			ZR_DEVNAME(zr), __func__,
+			"FAL"[fh->buffers.active], zr->jpg_que_tail,
+			"UPMD"[zr->jpg_buffers.buffer[frame].state],
+			zr->jpg_que_head, zr->jpg_dma_tail, zr->jpg_dma_head);
+		if (fh->buffers.active != ZORAN_FREE &&
+		    zr->jpg_buffers.buffer[frame].state == BUZ_STATE_DONE) {
+			if (fh->map_mode == ZORAN_MAP_MODE_JPG_REC)
+				res |= EPOLLIN | EPOLLRDNORM;
+			else
+				res |= EPOLLOUT | EPOLLWRNORM;
+		}
+		spin_unlock_irqrestore(&zr->spinlock, flags);
+
+		break;
+
+	default:
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - internal error, unknown map_mode=%d\n",
+			ZR_DEVNAME(zr), __func__, fh->map_mode);
+		res |= EPOLLERR;
+	}
+
+	return res;
+}
+
+
+/*
+ * This maps the buffers to user space.
+ *
+ * Depending on the state of fh->map_mode
+ * the V4L or the MJPEG buffers are mapped
+ * per buffer or all together
+ *
+ * Note that we need to connect to some
+ * unmap signal event to unmap the de-allocate
+ * the buffer accordingly (zoran_vm_close())
+ */
+
+static void
+zoran_vm_open (struct vm_area_struct *vma)
+{
+	struct zoran_mapping *map = vma->vm_private_data;
+	atomic_inc(&map->count);
+}
+
+static void
+zoran_vm_close (struct vm_area_struct *vma)
+{
+	struct zoran_mapping *map = vma->vm_private_data;
+	struct zoran_fh *fh = map->fh;
+	struct zoran *zr = fh->zr;
+	int i;
+
+	dprintk(3, KERN_INFO "%s: %s - munmap(%s)\n", ZR_DEVNAME(zr),
+		__func__, mode_name(fh->map_mode));
+
+	for (i = 0; i < fh->buffers.num_buffers; i++) {
+		if (fh->buffers.buffer[i].map == map)
+			fh->buffers.buffer[i].map = NULL;
+	}
+	kfree(map);
+
+	/* Any buffers still mapped? */
+	for (i = 0; i < fh->buffers.num_buffers; i++) {
+		if (fh->buffers.buffer[i].map) {
+			return;
+		}
+	}
+
+	dprintk(3, KERN_INFO "%s: %s - free %s buffers\n", ZR_DEVNAME(zr),
+		__func__, mode_name(fh->map_mode));
+
+	if (fh->map_mode == ZORAN_MAP_MODE_RAW) {
+		if (fh->buffers.active != ZORAN_FREE) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&zr->spinlock, flags);
+			zr36057_set_memgrab(zr, 0);
+			zr->v4l_buffers.allocated = 0;
+			zr->v4l_buffers.active = fh->buffers.active = ZORAN_FREE;
+			spin_unlock_irqrestore(&zr->spinlock, flags);
+		}
+		v4l_fbuffer_free(fh);
+	} else {
+		if (fh->buffers.active != ZORAN_FREE) {
+			jpg_qbuf(fh, -1, zr->codec_mode);
+			zr->jpg_buffers.allocated = 0;
+			zr->jpg_buffers.active = fh->buffers.active = ZORAN_FREE;
+		}
+		jpg_fbuffer_free(fh);
+	}
+}
+
+static const struct vm_operations_struct zoran_vm_ops = {
+	.open = zoran_vm_open,
+	.close = zoran_vm_close,
+};
+
+static int
+zoran_mmap (struct file           *file,
+	    struct vm_area_struct *vma)
+{
+	struct zoran_fh *fh = file->private_data;
+	struct zoran *zr = fh->zr;
+	unsigned long size = (vma->vm_end - vma->vm_start);
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	int i, j;
+	unsigned long page, start = vma->vm_start, todo, pos, fraglen;
+	int first, last;
+	struct zoran_mapping *map;
+	int res = 0;
+
+	dprintk(3,
+		KERN_INFO "%s: %s(%s) of 0x%08lx-0x%08lx (size=%lu)\n",
+		ZR_DEVNAME(zr), __func__,
+		mode_name(fh->map_mode), vma->vm_start, vma->vm_end, size);
+
+	if (!(vma->vm_flags & VM_SHARED) || !(vma->vm_flags & VM_READ) ||
+	    !(vma->vm_flags & VM_WRITE)) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s - no MAP_SHARED/PROT_{READ,WRITE} given\n",
+			ZR_DEVNAME(zr), __func__);
+		return -EINVAL;
+	}
+
+	if (!fh->buffers.allocated) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s(%s) - buffers not yet allocated\n",
+			ZR_DEVNAME(zr), __func__, mode_name(fh->map_mode));
+		res = -ENOMEM;
+		return res;
+	}
+
+	first = offset / fh->buffers.buffer_size;
+	last = first - 1 + size / fh->buffers.buffer_size;
+	if (offset % fh->buffers.buffer_size != 0 ||
+	    size % fh->buffers.buffer_size != 0 || first < 0 ||
+	    last < 0 || first >= fh->buffers.num_buffers ||
+	    last >= fh->buffers.buffer_size) {
+		dprintk(1,
+			KERN_ERR
+			"%s: %s(%s) - offset=%lu or size=%lu invalid for bufsize=%d and numbufs=%d\n",
+			ZR_DEVNAME(zr), __func__, mode_name(fh->map_mode), offset, size,
+			fh->buffers.buffer_size,
+			fh->buffers.num_buffers);
+		res = -EINVAL;
+		return res;
+	}
+
+	/* Check if any buffers are already mapped */
+	for (i = first; i <= last; i++) {
+		if (fh->buffers.buffer[i].map) {
+			dprintk(1,
+				KERN_ERR
+				"%s: %s(%s) - buffer %d already mapped\n",
+				ZR_DEVNAME(zr), __func__, mode_name(fh->map_mode), i);
+			res = -EBUSY;
+			return res;
+		}
+	}
+
+	/* map these buffers */
+	map = kmalloc(sizeof(struct zoran_mapping), GFP_KERNEL);
+	if (!map) {
+		res = -ENOMEM;
+		return res;
+	}
+	map->fh = fh;
+	atomic_set(&map->count, 1);
+
+	vma->vm_ops = &zoran_vm_ops;
+	vma->vm_flags |= VM_DONTEXPAND;
+	vma->vm_private_data = map;
+
+	if (fh->map_mode == ZORAN_MAP_MODE_RAW) {
+		for (i = first; i <= last; i++) {
+			todo = size;
+			if (todo > fh->buffers.buffer_size)
+				todo = fh->buffers.buffer_size;
+			page = fh->buffers.buffer[i].v4l.fbuffer_phys;
+			if (remap_pfn_range(vma, start, page >> PAGE_SHIFT,
+							todo, PAGE_SHARED)) {
+				dprintk(1,
+					KERN_ERR
+					"%s: %s(V4L) - remap_pfn_range failed\n",
+					ZR_DEVNAME(zr), __func__);
+				res = -EAGAIN;
+				return res;
+			}
+			size -= todo;
+			start += todo;
+			fh->buffers.buffer[i].map = map;
+			if (size == 0)
+				break;
+		}
+	} else {
+		for (i = first; i <= last; i++) {
+			for (j = 0;
+			     j < fh->buffers.buffer_size / PAGE_SIZE;
+			     j++) {
+				fraglen =
+				    (le32_to_cpu(fh->buffers.buffer[i].jpg.
+				     frag_tab[2 * j + 1]) & ~1) << 1;
+				todo = size;
+				if (todo > fraglen)
+					todo = fraglen;
+				pos =
+				    le32_to_cpu(fh->buffers.
+				    buffer[i].jpg.frag_tab[2 * j]);
+				/* should just be pos on i386 */
+				page = virt_to_phys(bus_to_virt(pos))
+								>> PAGE_SHIFT;
+				if (remap_pfn_range(vma, start, page,
+							todo, PAGE_SHARED)) {
+					dprintk(1,
+						KERN_ERR
+						"%s: %s(V4L) - remap_pfn_range failed\n",
+						ZR_DEVNAME(zr), __func__);
+					res = -EAGAIN;
+					return res;
+				}
+				size -= todo;
+				start += todo;
+				if (size == 0)
+					break;
+				if (le32_to_cpu(fh->buffers.buffer[i].jpg.
+				    frag_tab[2 * j + 1]) & 1)
+					break;	/* was last fragment */
+			}
+			fh->buffers.buffer[i].map = map;
+			if (size == 0)
+				break;
+
+		}
+	}
+	return res;
+}
+
+static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
+	.vidioc_querycap		    = zoran_querycap,
+	.vidioc_s_selection		    = zoran_s_selection,
+	.vidioc_g_selection		    = zoran_g_selection,
+	.vidioc_enum_input		    = zoran_enum_input,
+	.vidioc_g_input			    = zoran_g_input,
+	.vidioc_s_input			    = zoran_s_input,
+	.vidioc_enum_output		    = zoran_enum_output,
+	.vidioc_g_output		    = zoran_g_output,
+	.vidioc_s_output		    = zoran_s_output,
+	.vidioc_g_fbuf			    = zoran_g_fbuf,
+	.vidioc_s_fbuf			    = zoran_s_fbuf,
+	.vidioc_g_std			    = zoran_g_std,
+	.vidioc_s_std			    = zoran_s_std,
+	.vidioc_g_jpegcomp		    = zoran_g_jpegcomp,
+	.vidioc_s_jpegcomp		    = zoran_s_jpegcomp,
+	.vidioc_overlay			    = zoran_overlay,
+	.vidioc_reqbufs			    = zoran_reqbufs,
+	.vidioc_querybuf		    = zoran_querybuf,
+	.vidioc_qbuf			    = zoran_qbuf,
+	.vidioc_dqbuf			    = zoran_dqbuf,
+	.vidioc_streamon		    = zoran_streamon,
+	.vidioc_streamoff		    = zoran_streamoff,
+	.vidioc_enum_fmt_vid_cap	    = zoran_enum_fmt_vid_cap,
+	.vidioc_enum_fmt_vid_out	    = zoran_enum_fmt_vid_out,
+	.vidioc_enum_fmt_vid_overlay	    = zoran_enum_fmt_vid_overlay,
+	.vidioc_g_fmt_vid_cap		    = zoran_g_fmt_vid_cap,
+	.vidioc_g_fmt_vid_out               = zoran_g_fmt_vid_out,
+	.vidioc_g_fmt_vid_overlay           = zoran_g_fmt_vid_overlay,
+	.vidioc_s_fmt_vid_cap		    = zoran_s_fmt_vid_cap,
+	.vidioc_s_fmt_vid_out               = zoran_s_fmt_vid_out,
+	.vidioc_s_fmt_vid_overlay           = zoran_s_fmt_vid_overlay,
+	.vidioc_try_fmt_vid_cap		    = zoran_try_fmt_vid_cap,
+	.vidioc_try_fmt_vid_out		    = zoran_try_fmt_vid_out,
+	.vidioc_try_fmt_vid_overlay	    = zoran_try_fmt_vid_overlay,
+	.vidioc_subscribe_event             = v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event           = v4l2_event_unsubscribe,
+};
+
+static const struct v4l2_file_operations zoran_fops = {
+	.owner = THIS_MODULE,
+	.open = zoran_open,
+	.release = zoran_close,
+	.unlocked_ioctl = video_ioctl2,
+	.mmap = zoran_mmap,
+	.poll = zoran_poll,
+};
+
+const struct video_device zoran_template = {
+	.name = ZORAN_NAME,
+	.fops = &zoran_fops,
+	.ioctl_ops = &zoran_ioctl_ops,
+	.release = &zoran_vdev_release,
+	.tvnorms = V4L2_STD_NTSC | V4L2_STD_PAL | V4L2_STD_SECAM,
+};
+
diff --git a/drivers/staging/media/zoran/zoran_procfs.c b/drivers/staging/media/zoran/zoran_procfs.c
new file mode 100644
index 000000000000..78ac8f853748
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_procfs.c
@@ -0,0 +1,221 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * This part handles the procFS entries (/proc/ZORAN[%d])
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Currently maintained by:
+ *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
+ *   Laurent Pinchart <laurent.pinchart@skynet.be>
+ *   Mailinglist      <mjpeg-users@lists.sf.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+
+#include <linux/proc_fs.h>
+#include <linux/pci.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/videodev2.h>
+#include <linux/spinlock.h>
+#include <linux/sem.h>
+#include <linux/seq_file.h>
+
+#include <linux/ctype.h>
+#include <linux/poll.h>
+#include <asm/io.h>
+
+#include "videocodec.h"
+#include "zoran.h"
+#include "zoran_procfs.h"
+#include "zoran_card.h"
+
+#ifdef CONFIG_PROC_FS
+struct procfs_params_zr36067 {
+	char *name;
+	short reg;
+	u32 mask;
+	short bit;
+};
+
+static const struct procfs_params_zr36067 zr67[] = {
+	{"HSPol", 0x000, 1, 30},
+	{"HStart", 0x000, 0x3ff, 10},
+	{"HEnd", 0x000, 0x3ff, 0},
+
+	{"VSPol", 0x004, 1, 30},
+	{"VStart", 0x004, 0x3ff, 10},
+	{"VEnd", 0x004, 0x3ff, 0},
+
+	{"ExtFl", 0x008, 1, 26},
+	{"TopField", 0x008, 1, 25},
+	{"VCLKPol", 0x008, 1, 24},
+	{"DupFld", 0x008, 1, 20},
+	{"LittleEndian", 0x008, 1, 0},
+
+	{"HsyncStart", 0x10c, 0xffff, 16},
+	{"LineTot", 0x10c, 0xffff, 0},
+
+	{"NAX", 0x110, 0xffff, 16},
+	{"PAX", 0x110, 0xffff, 0},
+
+	{"NAY", 0x114, 0xffff, 16},
+	{"PAY", 0x114, 0xffff, 0},
+
+	/* {"",,,}, */
+
+	{NULL, 0, 0, 0},
+};
+
+static void
+setparam (struct zoran *zr,
+	  char         *name,
+	  char         *sval)
+{
+	int i = 0, reg0, reg, val;
+
+	while (zr67[i].name != NULL) {
+		if (!strncmp(name, zr67[i].name, strlen(zr67[i].name))) {
+			reg = reg0 = btread(zr67[i].reg);
+			reg &= ~(zr67[i].mask << zr67[i].bit);
+			if (!isdigit(sval[0]))
+				break;
+			val = simple_strtoul(sval, NULL, 0);
+			if ((val & ~zr67[i].mask))
+				break;
+			reg |= (val & zr67[i].mask) << zr67[i].bit;
+			dprintk(4,
+				KERN_INFO
+				"%s: setparam: setting ZR36067 register 0x%03x: 0x%08x=>0x%08x %s=%d\n",
+				ZR_DEVNAME(zr), zr67[i].reg, reg0, reg,
+				zr67[i].name, val);
+			btwrite(reg, zr67[i].reg);
+			break;
+		}
+		i++;
+	}
+}
+
+static int zoran_show(struct seq_file *p, void *v)
+{
+	struct zoran *zr = p->private;
+	int i;
+
+	seq_printf(p, "ZR36067 registers:\n");
+	for (i = 0; i < 0x130; i += 16)
+		seq_printf(p, "%03X %08X  %08X  %08X  %08X \n", i,
+			   btread(i), btread(i+4), btread(i+8), btread(i+12));
+	return 0;
+}
+
+static int zoran_open(struct inode *inode, struct file *file)
+{
+	struct zoran *data = PDE_DATA(inode);
+	return single_open(file, zoran_show, data);
+}
+
+static ssize_t zoran_write(struct file *file, const char __user *buffer,
+			size_t count, loff_t *ppos)
+{
+	struct zoran *zr = PDE_DATA(file_inode(file));
+	char *string, *sp;
+	char *line, *ldelim, *varname, *svar, *tdelim;
+
+	if (count > 32768)	/* Stupidity filter */
+		return -EINVAL;
+
+	string = sp = vmalloc(count + 1);
+	if (!string) {
+		dprintk(1,
+			KERN_ERR
+			"%s: write_proc: can not allocate memory\n",
+			ZR_DEVNAME(zr));
+		return -ENOMEM;
+	}
+	if (copy_from_user(string, buffer, count)) {
+		vfree (string);
+		return -EFAULT;
+	}
+	string[count] = 0;
+	dprintk(4, KERN_INFO "%s: write_proc: name=%pD count=%zu zr=%p\n",
+		ZR_DEVNAME(zr), file, count, zr);
+	ldelim = " \t\n";
+	tdelim = "=";
+	line = strpbrk(sp, ldelim);
+	while (line) {
+		*line = 0;
+		svar = strpbrk(sp, tdelim);
+		if (svar) {
+			*svar = 0;
+			varname = sp;
+			svar++;
+			setparam(zr, varname, svar);
+		}
+		sp = line + 1;
+		line = strpbrk(sp, ldelim);
+	}
+	vfree(string);
+
+	return count;
+}
+
+static const struct file_operations zoran_operations = {
+	.owner		= THIS_MODULE,
+	.open		= zoran_open,
+	.read		= seq_read,
+	.write		= zoran_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif
+
+int
+zoran_proc_init (struct zoran *zr)
+{
+#ifdef CONFIG_PROC_FS
+	char name[8];
+
+	snprintf(name, 7, "zoran%d", zr->id);
+	zr->zoran_proc = proc_create_data(name, 0, NULL, &zoran_operations, zr);
+	if (zr->zoran_proc != NULL) {
+		dprintk(2,
+			KERN_INFO
+			"%s: procfs entry /proc/%s allocated. data=%p\n",
+			ZR_DEVNAME(zr), name, zr);
+	} else {
+		dprintk(1, KERN_ERR "%s: Unable to initialise /proc/%s\n",
+			ZR_DEVNAME(zr), name);
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+void
+zoran_proc_cleanup (struct zoran *zr)
+{
+#ifdef CONFIG_PROC_FS
+	char name[8];
+
+	snprintf(name, 7, "zoran%d", zr->id);
+	if (zr->zoran_proc)
+		remove_proc_entry(name, NULL);
+	zr->zoran_proc = NULL;
+#endif
+}
diff --git a/drivers/staging/media/zoran/zoran_procfs.h b/drivers/staging/media/zoran/zoran_procfs.h
new file mode 100644
index 000000000000..0ac7cb0011f2
--- /dev/null
+++ b/drivers/staging/media/zoran/zoran_procfs.h
@@ -0,0 +1,32 @@
+/*
+ * Zoran zr36057/zr36067 PCI controller driver, for the
+ * Pinnacle/Miro DC10/DC10+/DC30/DC30+, Iomega Buz, Linux
+ * Media Labs LML33/LML33R10.
+ *
+ * This part handles card-specific data and detection
+ *
+ * Copyright (C) 2000 Serguei Miridonov <mirsev@cicese.mx>
+ *
+ * Currently maintained by:
+ *   Ronald Bultje    <rbultje@ronald.bitfreak.net>
+ *   Laurent Pinchart <laurent.pinchart@skynet.be>
+ *   Mailinglist      <mjpeg-users@lists.sf.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ZORAN_PROCFS_H__
+#define __ZORAN_PROCFS_H__
+
+extern int zoran_proc_init(struct zoran *zr);
+extern void zoran_proc_cleanup(struct zoran *zr);
+
+#endif				/* __ZORAN_PROCFS_H__ */
diff --git a/drivers/staging/media/zoran/zr36016.c b/drivers/staging/media/zoran/zr36016.c
new file mode 100644
index 000000000000..8736b9d8d97e
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36016.c
@@ -0,0 +1,516 @@
+/*
+ * Zoran ZR36016 basic configuration functions
+ *
+ * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
+ *
+ * $Id: zr36016.c,v 1.1.2.14 2003/08/20 19:46:55 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#define ZR016_VERSION "v0.7"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <linux/types.h>
+#include <linux/wait.h>
+
+/* I/O commands, error codes */
+#include <asm/io.h>
+
+/* v4l  API */
+
+/* headerfile of this module */
+#include "zr36016.h"
+
+/* codec io API */
+#include "videocodec.h"
+
+/* it doesn't make sense to have more than 20 or so,
+  just to prevent some unwanted loops */
+#define MAX_CODECS 20
+
+/* amount of chips attached via this driver */
+static int zr36016_codecs;
+
+/* debugging is available via module parameter */
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0-4)");
+
+#define dprintk(num, format, args...) \
+	do { \
+		if (debug >= num) \
+			printk(format, ##args); \
+	} while (0)
+
+/* =========================================================================
+   Local hardware I/O functions:
+
+   read/write via codec layer (registers are located in the master device)
+   ========================================================================= */
+
+/* read and write functions */
+static u8
+zr36016_read (struct zr36016 *ptr,
+	      u16             reg)
+{
+	u8 value = 0;
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->readreg)
+		value =
+		    (ptr->codec->master_data->
+		     readreg(ptr->codec, reg)) & 0xFF;
+	else
+		dprintk(1,
+			KERN_ERR "%s: invalid I/O setup, nothing read!\n",
+			ptr->name);
+
+	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg,
+		value);
+
+	return value;
+}
+
+static void
+zr36016_write (struct zr36016 *ptr,
+	       u16             reg,
+	       u8              value)
+{
+	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value,
+		reg);
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->writereg) {
+		ptr->codec->master_data->writereg(ptr->codec, reg, value);
+	} else
+		dprintk(1,
+			KERN_ERR
+			"%s: invalid I/O setup, nothing written!\n",
+			ptr->name);
+}
+
+/* indirect read and write functions */
+/* the 016 supports auto-addr-increment, but
+ * writing it all time cost not much and is safer... */
+static u8
+zr36016_readi (struct zr36016 *ptr,
+	       u16             reg)
+{
+	u8 value = 0;
+
+	// just in case something is wrong...
+	if ((ptr->codec->master_data->writereg) &&
+	    (ptr->codec->master_data->readreg)) {
+		ptr->codec->master_data->writereg(ptr->codec, ZR016_IADDR, reg & 0x0F);	// ADDR
+		value = (ptr->codec->master_data->readreg(ptr->codec, ZR016_IDATA)) & 0xFF;	// DATA
+	} else
+		dprintk(1,
+			KERN_ERR
+			"%s: invalid I/O setup, nothing read (i)!\n",
+			ptr->name);
+
+	dprintk(4, "%s: reading indirect from 0x%04x: %02x\n", ptr->name,
+		reg, value);
+	return value;
+}
+
+static void
+zr36016_writei (struct zr36016 *ptr,
+		u16             reg,
+		u8              value)
+{
+	dprintk(4, "%s: writing indirect 0x%02x to 0x%04x\n", ptr->name,
+		value, reg);
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->writereg) {
+		ptr->codec->master_data->writereg(ptr->codec, ZR016_IADDR, reg & 0x0F);	// ADDR
+		ptr->codec->master_data->writereg(ptr->codec, ZR016_IDATA, value & 0x0FF);	// DATA
+	} else
+		dprintk(1,
+			KERN_ERR
+			"%s: invalid I/O setup, nothing written (i)!\n",
+			ptr->name);
+}
+
+/* =========================================================================
+   Local helper function:
+
+   version read
+   ========================================================================= */
+
+/* version kept in datastructure */
+static u8
+zr36016_read_version (struct zr36016 *ptr)
+{
+	ptr->version = zr36016_read(ptr, 0) >> 4;
+	return ptr->version;
+}
+
+/* =========================================================================
+   Local helper function:
+
+   basic test of "connectivity", writes/reads to/from PAX-Lo register
+   ========================================================================= */
+
+static int
+zr36016_basic_test (struct zr36016 *ptr)
+{
+	if (debug) {
+		int i;
+		zr36016_writei(ptr, ZR016I_PAX_LO, 0x55);
+		dprintk(1, KERN_INFO "%s: registers: ", ptr->name);
+		for (i = 0; i <= 0x0b; i++)
+			dprintk(1, "%02x ", zr36016_readi(ptr, i));
+		dprintk(1, "\n");
+	}
+	// for testing just write 0, then the default value to a register and read
+	// it back in both cases
+	zr36016_writei(ptr, ZR016I_PAX_LO, 0x00);
+	if (zr36016_readi(ptr, ZR016I_PAX_LO) != 0x0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, can't connect to vfe processor!\n",
+			ptr->name);
+		return -ENXIO;
+	}
+	zr36016_writei(ptr, ZR016I_PAX_LO, 0x0d0);
+	if (zr36016_readi(ptr, ZR016I_PAX_LO) != 0x0d0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, can't connect to vfe processor!\n",
+			ptr->name);
+		return -ENXIO;
+	}
+	// we allow version numbers from 0-3, should be enough, though
+	zr36016_read_version(ptr);
+	if (ptr->version & 0x0c) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, suspicious version %d found...\n",
+			ptr->name, ptr->version);
+		return -ENXIO;
+	}
+
+	return 0;		/* looks good! */
+}
+
+/* =========================================================================
+   Local helper function:
+
+   simple loop for pushing the init datasets - NO USE --
+   ========================================================================= */
+
+#if 0
+static int zr36016_pushit (struct zr36016 *ptr,
+			   u16             startreg,
+			   u16             len,
+			   const char     *data)
+{
+	int i=0;
+
+	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n",
+		ptr->name, startreg,len);
+	while (i<len) {
+		zr36016_writei(ptr, startreg++,  data[i++]);
+	}
+
+	return i;
+}
+#endif
+
+/* =========================================================================
+   Basic datasets & init:
+
+   //TODO//
+   ========================================================================= */
+
+static void
+zr36016_init (struct zr36016 *ptr)
+{
+	// stop any processing
+	zr36016_write(ptr, ZR016_GOSTOP, 0);
+
+	// mode setup (yuv422 in and out, compression/expansuon due to mode)
+	zr36016_write(ptr, ZR016_MODE,
+		      ZR016_YUV422 | ZR016_YUV422_YUV422 |
+		      (ptr->mode == CODEC_DO_COMPRESSION ?
+		       ZR016_COMPRESSION : ZR016_EXPANSION));
+
+	// misc setup
+	zr36016_writei(ptr, ZR016I_SETUP1,
+		       (ptr->xdec ? (ZR016_HRFL | ZR016_HORZ) : 0) |
+		       (ptr->ydec ? ZR016_VERT : 0) | ZR016_CNTI);
+	zr36016_writei(ptr, ZR016I_SETUP2, ZR016_CCIR);
+
+	// Window setup
+	// (no extra offset for now, norm defines offset, default width height)
+	zr36016_writei(ptr, ZR016I_PAX_HI, ptr->width >> 8);
+	zr36016_writei(ptr, ZR016I_PAX_LO, ptr->width & 0xFF);
+	zr36016_writei(ptr, ZR016I_PAY_HI, ptr->height >> 8);
+	zr36016_writei(ptr, ZR016I_PAY_LO, ptr->height & 0xFF);
+	zr36016_writei(ptr, ZR016I_NAX_HI, ptr->xoff >> 8);
+	zr36016_writei(ptr, ZR016I_NAX_LO, ptr->xoff & 0xFF);
+	zr36016_writei(ptr, ZR016I_NAY_HI, ptr->yoff >> 8);
+	zr36016_writei(ptr, ZR016I_NAY_LO, ptr->yoff & 0xFF);
+
+	/* shall we continue now, please? */
+	zr36016_write(ptr, ZR016_GOSTOP, 1);
+}
+
+/* =========================================================================
+   CODEC API FUNCTIONS
+
+   this functions are accessed by the master via the API structure
+   ========================================================================= */
+
+/* set compression/expansion mode and launches codec -
+   this should be the last call from the master before starting processing */
+static int
+zr36016_set_mode (struct videocodec *codec,
+		  int                mode)
+{
+	struct zr36016 *ptr = (struct zr36016 *) codec->data;
+
+	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
+
+	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
+		return -EINVAL;
+
+	ptr->mode = mode;
+	zr36016_init(ptr);
+
+	return 0;
+}
+
+/* set picture size */
+static int
+zr36016_set_video (struct videocodec   *codec,
+		   struct tvnorm       *norm,
+		   struct vfe_settings *cap,
+		   struct vfe_polarity *pol)
+{
+	struct zr36016 *ptr = (struct zr36016 *) codec->data;
+
+	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) call\n",
+		ptr->name, norm->HStart, norm->VStart,
+		cap->x, cap->y, cap->width, cap->height,
+		cap->decimation);
+
+	/* if () return -EINVAL;
+	 * trust the master driver that it knows what it does - so
+	 * we allow invalid startx/y for now ... */
+	ptr->width = cap->width;
+	ptr->height = cap->height;
+	/* (Ronald) This is ugly. zoran_device.c, line 387
+	 * already mentions what happens if HStart is even
+	 * (blue faces, etc., cr/cb inversed). There's probably
+	 * some good reason why HStart is 0 instead of 1, so I'm
+	 * leaving it to this for now, but really... This can be
+	 * done a lot simpler */
+	ptr->xoff = (norm->HStart ? norm->HStart : 1) + cap->x;
+	/* Something to note here (I don't understand it), setting
+	 * VStart too high will cause the codec to 'not work'. I
+	 * really don't get it. values of 16 (VStart) already break
+	 * it here. Just '0' seems to work. More testing needed! */
+	ptr->yoff = norm->VStart + cap->y;
+	/* (Ronald) dzjeeh, can't this thing do hor_decimation = 4? */
+	ptr->xdec = ((cap->decimation & 0xff) == 1) ? 0 : 1;
+	ptr->ydec = (((cap->decimation >> 8) & 0xff) == 1) ? 0 : 1;
+
+	return 0;
+}
+
+/* additional control functions */
+static int
+zr36016_control (struct videocodec *codec,
+		 int                type,
+		 int                size,
+		 void              *data)
+{
+	struct zr36016 *ptr = (struct zr36016 *) codec->data;
+	int *ival = (int *) data;
+
+	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
+		size);
+
+	switch (type) {
+	case CODEC_G_STATUS:	/* get last status - we don't know it ... */
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = 0;
+		break;
+
+	case CODEC_G_CODEC_MODE:
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = 0;
+		break;
+
+	case CODEC_S_CODEC_MODE:
+		if (size != sizeof(int))
+			return -EFAULT;
+		if (*ival != 0)
+			return -EINVAL;
+		/* not needed, do nothing */
+		return 0;
+
+	case CODEC_G_VFE:
+	case CODEC_S_VFE:
+		return 0;
+
+	case CODEC_S_MMAP:
+		/* not available, give an error */
+		return -ENXIO;
+
+	default:
+		return -EINVAL;
+	}
+
+	return size;
+}
+
+/* =========================================================================
+   Exit and unregister function:
+
+   Deinitializes Zoran's JPEG processor
+   ========================================================================= */
+
+static int
+zr36016_unset (struct videocodec *codec)
+{
+	struct zr36016 *ptr = codec->data;
+
+	if (ptr) {
+		/* do wee need some codec deinit here, too ???? */
+
+		dprintk(1, "%s: finished codec #%d\n", ptr->name,
+			ptr->num);
+		kfree(ptr);
+		codec->data = NULL;
+
+		zr36016_codecs--;
+		return 0;
+	}
+
+	return -EFAULT;
+}
+
+/* =========================================================================
+   Setup and registry function:
+
+   Initializes Zoran's JPEG processor
+
+   Also sets pixel size, average code size, mode (compr./decompr.)
+   (the given size is determined by the processor with the video interface)
+   ========================================================================= */
+
+static int
+zr36016_setup (struct videocodec *codec)
+{
+	struct zr36016 *ptr;
+	int res;
+
+	dprintk(2, "zr36016: initializing VFE subsystem #%d.\n",
+		zr36016_codecs);
+
+	if (zr36016_codecs == MAX_CODECS) {
+		dprintk(1,
+			KERN_ERR "zr36016: Can't attach more codecs!\n");
+		return -ENOSPC;
+	}
+	//mem structure init
+	codec->data = ptr = kzalloc(sizeof(struct zr36016), GFP_KERNEL);
+	if (NULL == ptr) {
+		dprintk(1, KERN_ERR "zr36016: Can't get enough memory!\n");
+		return -ENOMEM;
+	}
+
+	snprintf(ptr->name, sizeof(ptr->name), "zr36016[%d]",
+		 zr36016_codecs);
+	ptr->num = zr36016_codecs++;
+	ptr->codec = codec;
+
+	//testing
+	res = zr36016_basic_test(ptr);
+	if (res < 0) {
+		zr36016_unset(codec);
+		return res;
+	}
+	//final setup
+	ptr->mode = CODEC_DO_COMPRESSION;
+	ptr->width = 768;
+	ptr->height = 288;
+	ptr->xdec = 1;
+	ptr->ydec = 0;
+	zr36016_init(ptr);
+
+	dprintk(1, KERN_INFO "%s: codec v%d attached and running\n",
+		ptr->name, ptr->version);
+
+	return 0;
+}
+
+static const struct videocodec zr36016_codec = {
+	.owner = THIS_MODULE,
+	.name = "zr36016",
+	.magic = 0L,		// magic not used
+	.flags =
+	    CODEC_FLAG_HARDWARE | CODEC_FLAG_VFE | CODEC_FLAG_ENCODER |
+	    CODEC_FLAG_DECODER,
+	.type = CODEC_TYPE_ZR36016,
+	.setup = zr36016_setup,	// functionality
+	.unset = zr36016_unset,
+	.set_mode = zr36016_set_mode,
+	.set_video = zr36016_set_video,
+	.control = zr36016_control,
+	// others are not used
+};
+
+/* =========================================================================
+   HOOK IN DRIVER AS KERNEL MODULE
+   ========================================================================= */
+
+static int __init
+zr36016_init_module (void)
+{
+	//dprintk(1, "ZR36016 driver %s\n",ZR016_VERSION);
+	zr36016_codecs = 0;
+	return videocodec_register(&zr36016_codec);
+}
+
+static void __exit
+zr36016_cleanup_module (void)
+{
+	if (zr36016_codecs) {
+		dprintk(1,
+			"zr36016: something's wrong - %d codecs left somehow.\n",
+			zr36016_codecs);
+	}
+	videocodec_unregister(&zr36016_codec);
+}
+
+module_init(zr36016_init_module);
+module_exit(zr36016_cleanup_module);
+
+MODULE_AUTHOR("Wolfgang Scherr <scherr@net4you.at>");
+MODULE_DESCRIPTION("Driver module for ZR36016 video frontends "
+		   ZR016_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/zr36016.h b/drivers/staging/media/zoran/zr36016.h
new file mode 100644
index 000000000000..784bcf5727b8
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36016.h
@@ -0,0 +1,107 @@
+/*
+ * Zoran ZR36016 basic configuration functions - header file
+ *
+ * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
+ *
+ * $Id: zr36016.h,v 1.1.2.3 2003/01/14 21:18:07 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#ifndef ZR36016_H
+#define ZR36016_H
+
+/* data stored for each zoran jpeg codec chip */
+struct zr36016 {
+	char name[32];
+	int num;
+	/* io datastructure */
+	struct videocodec *codec;
+	// coder status
+	__u8 version;
+	// actual coder setup
+	int mode;
+
+	__u16 xoff;
+	__u16 yoff;
+	__u16 width;
+	__u16 height;
+	__u16 xdec;
+	__u16 ydec;
+};
+
+/* direct  register addresses */
+#define ZR016_GOSTOP      0x00
+#define ZR016_MODE        0x01
+#define ZR016_IADDR       0x02
+#define ZR016_IDATA       0x03
+
+/* indirect  register addresses */
+#define ZR016I_SETUP1     0x00
+#define ZR016I_SETUP2     0x01
+#define ZR016I_NAX_LO     0x02
+#define ZR016I_NAX_HI     0x03
+#define ZR016I_PAX_LO     0x04
+#define ZR016I_PAX_HI     0x05
+#define ZR016I_NAY_LO     0x06
+#define ZR016I_NAY_HI     0x07
+#define ZR016I_PAY_LO     0x08
+#define ZR016I_PAY_HI     0x09
+#define ZR016I_NOL_LO     0x0a
+#define ZR016I_NOL_HI     0x0b
+
+/* possible values for mode register */
+#define ZR016_RGB444_YUV444  0x00
+#define ZR016_RGB444_YUV422  0x01
+#define ZR016_RGB444_YUV411  0x02
+#define ZR016_RGB444_Y400    0x03
+#define ZR016_RGB444_RGB444  0x04
+#define ZR016_YUV444_YUV444  0x08
+#define ZR016_YUV444_YUV422  0x09
+#define ZR016_YUV444_YUV411  0x0a
+#define ZR016_YUV444_Y400    0x0b
+#define ZR016_YUV444_RGB444  0x0c
+#define ZR016_YUV422_YUV422  0x11
+#define ZR016_YUV422_YUV411  0x12
+#define ZR016_YUV422_Y400    0x13
+#define ZR016_YUV411_YUV411  0x16
+#define ZR016_YUV411_Y400    0x17
+#define ZR016_4444_4444      0x19
+#define ZR016_100_100        0x1b
+
+#define ZR016_RGB444         0x00
+#define ZR016_YUV444         0x20
+#define ZR016_YUV422         0x40
+
+#define ZR016_COMPRESSION    0x80
+#define ZR016_EXPANSION      0x80
+
+/* possible values for setup 1 register */
+#define ZR016_CKRT           0x80
+#define ZR016_VERT           0x40
+#define ZR016_HORZ           0x20
+#define ZR016_HRFL           0x10
+#define ZR016_DSFL           0x08
+#define ZR016_SBFL           0x04
+#define ZR016_RSTR           0x02
+#define ZR016_CNTI           0x01
+
+/* possible values for setup 2 register */
+#define ZR016_SYEN           0x40
+#define ZR016_CCIR           0x04
+#define ZR016_SIGN           0x02
+#define ZR016_YMCS           0x01
+
+#endif				/*fndef ZR36016_H */
diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
new file mode 100644
index 000000000000..5ebfc16672f3
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -0,0 +1,896 @@
+/*
+ * Zoran ZR36050 basic configuration functions
+ *
+ * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
+ *
+ * $Id: zr36050.c,v 1.1.2.11 2003/08/03 14:54:53 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#define ZR050_VERSION "v0.7.1"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <linux/types.h>
+#include <linux/wait.h>
+
+/* I/O commands, error codes */
+#include <asm/io.h>
+
+/* headerfile of this module */
+#include "zr36050.h"
+
+/* codec io API */
+#include "videocodec.h"
+
+/* it doesn't make sense to have more than 20 or so,
+  just to prevent some unwanted loops */
+#define MAX_CODECS 20
+
+/* amount of chips attached via this driver */
+static int zr36050_codecs;
+
+/* debugging is available via module parameter */
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0-4)");
+
+#define dprintk(num, format, args...) \
+	do { \
+		if (debug >= num) \
+			printk(format, ##args); \
+	} while (0)
+
+/* =========================================================================
+   Local hardware I/O functions:
+
+   read/write via codec layer (registers are located in the master device)
+   ========================================================================= */
+
+/* read and write functions */
+static u8
+zr36050_read (struct zr36050 *ptr,
+	      u16             reg)
+{
+	u8 value = 0;
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->readreg)
+		value = (ptr->codec->master_data->readreg(ptr->codec,
+							  reg)) & 0xFF;
+	else
+		dprintk(1,
+			KERN_ERR "%s: invalid I/O setup, nothing read!\n",
+			ptr->name);
+
+	dprintk(4, "%s: reading from 0x%04x: %02x\n", ptr->name, reg,
+		value);
+
+	return value;
+}
+
+static void
+zr36050_write (struct zr36050 *ptr,
+	       u16             reg,
+	       u8              value)
+{
+	dprintk(4, "%s: writing 0x%02x to 0x%04x\n", ptr->name, value,
+		reg);
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->writereg)
+		ptr->codec->master_data->writereg(ptr->codec, reg, value);
+	else
+		dprintk(1,
+			KERN_ERR
+			"%s: invalid I/O setup, nothing written!\n",
+			ptr->name);
+}
+
+/* =========================================================================
+   Local helper function:
+
+   status read
+   ========================================================================= */
+
+/* status is kept in datastructure */
+static u8
+zr36050_read_status1 (struct zr36050 *ptr)
+{
+	ptr->status1 = zr36050_read(ptr, ZR050_STATUS_1);
+
+	zr36050_read(ptr, 0);
+	return ptr->status1;
+}
+
+/* =========================================================================
+   Local helper function:
+
+   scale factor read
+   ========================================================================= */
+
+/* scale factor is kept in datastructure */
+static u16
+zr36050_read_scalefactor (struct zr36050 *ptr)
+{
+	ptr->scalefact = (zr36050_read(ptr, ZR050_SF_HI) << 8) |
+			 (zr36050_read(ptr, ZR050_SF_LO) & 0xFF);
+
+	/* leave 0 selected for an eventually GO from master */
+	zr36050_read(ptr, 0);
+	return ptr->scalefact;
+}
+
+/* =========================================================================
+   Local helper function:
+
+   wait if codec is ready to proceed (end of processing) or time is over
+   ========================================================================= */
+
+static void
+zr36050_wait_end (struct zr36050 *ptr)
+{
+	int i = 0;
+
+	while (!(zr36050_read_status1(ptr) & 0x4)) {
+		udelay(1);
+		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
+			dprintk(1,
+				"%s: timeout at wait_end (last status: 0x%02x)\n",
+				ptr->name, ptr->status1);
+			break;
+		}
+	}
+}
+
+/* =========================================================================
+   Local helper function:
+
+   basic test of "connectivity", writes/reads to/from memory the SOF marker
+   ========================================================================= */
+
+static int
+zr36050_basic_test (struct zr36050 *ptr)
+{
+	zr36050_write(ptr, ZR050_SOF_IDX, 0x00);
+	zr36050_write(ptr, ZR050_SOF_IDX + 1, 0x00);
+	if ((zr36050_read(ptr, ZR050_SOF_IDX) |
+	     zr36050_read(ptr, ZR050_SOF_IDX + 1)) != 0x0000) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, can't connect to jpeg processor!\n",
+			ptr->name);
+		return -ENXIO;
+	}
+	zr36050_write(ptr, ZR050_SOF_IDX, 0xff);
+	zr36050_write(ptr, ZR050_SOF_IDX + 1, 0xc0);
+	if (((zr36050_read(ptr, ZR050_SOF_IDX) << 8) |
+	     zr36050_read(ptr, ZR050_SOF_IDX + 1)) != 0xffc0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, can't connect to jpeg processor!\n",
+			ptr->name);
+		return -ENXIO;
+	}
+
+	zr36050_wait_end(ptr);
+	if ((ptr->status1 & 0x4) == 0) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, jpeg processor failed (end flag)!\n",
+			ptr->name);
+		return -EBUSY;
+	}
+
+	return 0;		/* looks good! */
+}
+
+/* =========================================================================
+   Local helper function:
+
+   simple loop for pushing the init datasets
+   ========================================================================= */
+
+static int
+zr36050_pushit (struct zr36050 *ptr,
+		u16             startreg,
+		u16             len,
+		const char     *data)
+{
+	int i = 0;
+
+	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
+		startreg, len);
+	while (i < len) {
+		zr36050_write(ptr, startreg++, data[i++]);
+	}
+
+	return i;
+}
+
+/* =========================================================================
+   Basic datasets:
+
+   jpeg baseline setup data (you find it on lots places in internet, or just
+   extract it from any regular .jpg image...)
+
+   Could be variable, but until it's not needed it they are just fixed to save
+   memory. Otherwise expand zr36050 structure with arrays, push the values to
+   it and initialize from there, as e.g. the linux zr36057/60 driver does it.
+   ========================================================================= */
+
+static const char zr36050_dqt[0x86] = {
+	0xff, 0xdb,		//Marker: DQT
+	0x00, 0x84,		//Length: 2*65+2
+	0x00,			//Pq,Tq first table
+	0x10, 0x0b, 0x0c, 0x0e, 0x0c, 0x0a, 0x10, 0x0e,
+	0x0d, 0x0e, 0x12, 0x11, 0x10, 0x13, 0x18, 0x28,
+	0x1a, 0x18, 0x16, 0x16, 0x18, 0x31, 0x23, 0x25,
+	0x1d, 0x28, 0x3a, 0x33, 0x3d, 0x3c, 0x39, 0x33,
+	0x38, 0x37, 0x40, 0x48, 0x5c, 0x4e, 0x40, 0x44,
+	0x57, 0x45, 0x37, 0x38, 0x50, 0x6d, 0x51, 0x57,
+	0x5f, 0x62, 0x67, 0x68, 0x67, 0x3e, 0x4d, 0x71,
+	0x79, 0x70, 0x64, 0x78, 0x5c, 0x65, 0x67, 0x63,
+	0x01,			//Pq,Tq second table
+	0x11, 0x12, 0x12, 0x18, 0x15, 0x18, 0x2f, 0x1a,
+	0x1a, 0x2f, 0x63, 0x42, 0x38, 0x42, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63
+};
+
+static const char zr36050_dht[0x1a4] = {
+	0xff, 0xc4,		//Marker: DHT
+	0x01, 0xa2,		//Length: 2*AC, 2*DC
+	0x00,			//DC first table
+	0x00, 0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,
+	0x01,			//DC second table
+	0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,
+	0x10,			//AC first table
+	0x00, 0x02, 0x01, 0x03, 0x03, 0x02, 0x04, 0x03,
+	0x05, 0x05, 0x04, 0x04, 0x00, 0x00,
+	0x01, 0x7D, 0x01, 0x02, 0x03, 0x00, 0x04, 0x11,
+	0x05, 0x12, 0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61,
+	0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1,
+	0x08, 0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52, 0xD1, 0xF0, 0x24,
+	0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16, 0x17,
+	0x18, 0x19, 0x1A, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x34,
+	0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44,
+	0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56,
+	0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66,
+	0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
+	0x79, 0x7A, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88,
+	0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99,
+	0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8,
+	0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9,
+	0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8,
+	0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9,
+	0xDA, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7,
+	0xE8, 0xE9, 0xEA, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,
+	0xF8, 0xF9, 0xFA,
+	0x11,			//AC second table
+	0x00, 0x02, 0x01, 0x02, 0x04, 0x04, 0x03, 0x04,
+	0x07, 0x05, 0x04, 0x04, 0x00, 0x01,
+	0x02, 0x77, 0x00, 0x01, 0x02, 0x03, 0x11, 0x04,
+	0x05, 0x21, 0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61, 0x71,
+	0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91,
+	0xA1, 0xB1, 0xC1, 0x09, 0x23, 0x33, 0x52, 0xF0, 0x15, 0x62,
+	0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34, 0xE1, 0x25,
+	0xF1, 0x17, 0x18, 0x19, 0x1A, 0x26, 0x27, 0x28, 0x29, 0x2A,
+	0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44,
+	0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56,
+	0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66,
+	0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
+	0x79, 0x7A, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98,
+	0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
+	0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8,
+	0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7,
+	0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8,
+	0xD9, 0xDA, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7,
+	0xE8, 0xE9, 0xEA, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8,
+	0xF9, 0xFA
+};
+
+/* jpeg baseline setup, this is just fixed in this driver (YUV pictures) */
+#define NO_OF_COMPONENTS          0x3	//Y,U,V
+#define BASELINE_PRECISION        0x8	//MCU size (?)
+static const char zr36050_tq[8] = { 0, 1, 1, 0, 0, 0, 0, 0 };	//table idx's QT
+static const char zr36050_td[8] = { 0, 1, 1, 0, 0, 0, 0, 0 };	//table idx's DC
+static const char zr36050_ta[8] = { 0, 1, 1, 0, 0, 0, 0, 0 };	//table idx's AC
+
+/* horizontal 422 decimation setup (maybe we support 411 or so later, too) */
+static const char zr36050_decimation_h[8] = { 2, 1, 1, 0, 0, 0, 0, 0 };
+static const char zr36050_decimation_v[8] = { 1, 1, 1, 0, 0, 0, 0, 0 };
+
+/* =========================================================================
+   Local helper functions:
+
+   calculation and setup of parameter-dependent JPEG baseline segments
+   (needed for compression only)
+   ========================================================================= */
+
+/* ------------------------------------------------------------------------- */
+
+/* SOF (start of frame) segment depends on width, height and sampling ratio
+			 of each color component */
+
+static int
+zr36050_set_sof (struct zr36050 *ptr)
+{
+	char sof_data[34];	// max. size of register set
+	int i;
+
+	dprintk(3, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
+		ptr->width, ptr->height, NO_OF_COMPONENTS);
+	sof_data[0] = 0xff;
+	sof_data[1] = 0xc0;
+	sof_data[2] = 0x00;
+	sof_data[3] = (3 * NO_OF_COMPONENTS) + 8;
+	sof_data[4] = BASELINE_PRECISION;	// only '8' possible with zr36050
+	sof_data[5] = (ptr->height) >> 8;
+	sof_data[6] = (ptr->height) & 0xff;
+	sof_data[7] = (ptr->width) >> 8;
+	sof_data[8] = (ptr->width) & 0xff;
+	sof_data[9] = NO_OF_COMPONENTS;
+	for (i = 0; i < NO_OF_COMPONENTS; i++) {
+		sof_data[10 + (i * 3)] = i;	// index identifier
+		sof_data[11 + (i * 3)] = (ptr->h_samp_ratio[i] << 4) | (ptr->v_samp_ratio[i]);	// sampling ratios
+		sof_data[12 + (i * 3)] = zr36050_tq[i];	// Q table selection
+	}
+	return zr36050_pushit(ptr, ZR050_SOF_IDX,
+			      (3 * NO_OF_COMPONENTS) + 10, sof_data);
+}
+
+/* ------------------------------------------------------------------------- */
+
+/* SOS (start of scan) segment depends on the used scan components
+			of each color component */
+
+static int
+zr36050_set_sos (struct zr36050 *ptr)
+{
+	char sos_data[16];	// max. size of register set
+	int i;
+
+	dprintk(3, "%s: write SOS\n", ptr->name);
+	sos_data[0] = 0xff;
+	sos_data[1] = 0xda;
+	sos_data[2] = 0x00;
+	sos_data[3] = 2 + 1 + (2 * NO_OF_COMPONENTS) + 3;
+	sos_data[4] = NO_OF_COMPONENTS;
+	for (i = 0; i < NO_OF_COMPONENTS; i++) {
+		sos_data[5 + (i * 2)] = i;	// index
+		sos_data[6 + (i * 2)] = (zr36050_td[i] << 4) | zr36050_ta[i];	// AC/DC tbl.sel.
+	}
+	sos_data[2 + 1 + (2 * NO_OF_COMPONENTS) + 2] = 00;	// scan start
+	sos_data[2 + 1 + (2 * NO_OF_COMPONENTS) + 3] = 0x3F;
+	sos_data[2 + 1 + (2 * NO_OF_COMPONENTS) + 4] = 00;
+	return zr36050_pushit(ptr, ZR050_SOS1_IDX,
+			      4 + 1 + (2 * NO_OF_COMPONENTS) + 3,
+			      sos_data);
+}
+
+/* ------------------------------------------------------------------------- */
+
+/* DRI (define restart interval) */
+
+static int
+zr36050_set_dri (struct zr36050 *ptr)
+{
+	char dri_data[6];	// max. size of register set
+
+	dprintk(3, "%s: write DRI\n", ptr->name);
+	dri_data[0] = 0xff;
+	dri_data[1] = 0xdd;
+	dri_data[2] = 0x00;
+	dri_data[3] = 0x04;
+	dri_data[4] = ptr->dri >> 8;
+	dri_data[5] = ptr->dri & 0xff;
+	return zr36050_pushit(ptr, ZR050_DRI_IDX, 6, dri_data);
+}
+
+/* =========================================================================
+   Setup function:
+
+   Setup compression/decompression of Zoran's JPEG processor
+   ( see also zoran 36050 manual )
+
+   ... sorry for the spaghetti code ...
+   ========================================================================= */
+static void
+zr36050_init (struct zr36050 *ptr)
+{
+	int sum = 0;
+	long bitcnt, tmp;
+
+	if (ptr->mode == CODEC_DO_COMPRESSION) {
+		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
+
+		/* 050 communicates with 057 in master mode */
+		zr36050_write(ptr, ZR050_HARDWARE, ZR050_HW_MSTR);
+
+		/* encoding table preload for compression */
+		zr36050_write(ptr, ZR050_MODE,
+			      ZR050_MO_COMP | ZR050_MO_TLM);
+		zr36050_write(ptr, ZR050_OPTIONS, 0);
+
+		/* disable all IRQs */
+		zr36050_write(ptr, ZR050_INT_REQ_0, 0);
+		zr36050_write(ptr, ZR050_INT_REQ_1, 3);	// low 2 bits always 1
+
+		/* volume control settings */
+		/*zr36050_write(ptr, ZR050_MBCV, ptr->max_block_vol);*/
+		zr36050_write(ptr, ZR050_SF_HI, ptr->scalefact >> 8);
+		zr36050_write(ptr, ZR050_SF_LO, ptr->scalefact & 0xff);
+
+		zr36050_write(ptr, ZR050_AF_HI, 0xff);
+		zr36050_write(ptr, ZR050_AF_M, 0xff);
+		zr36050_write(ptr, ZR050_AF_LO, 0xff);
+
+		/* setup the variable jpeg tables */
+		sum += zr36050_set_sof(ptr);
+		sum += zr36050_set_sos(ptr);
+		sum += zr36050_set_dri(ptr);
+
+		/* setup the fixed jpeg tables - maybe variable, though -
+		 * (see table init section above) */
+		dprintk(3, "%s: write DQT, DHT, APP\n", ptr->name);
+		sum += zr36050_pushit(ptr, ZR050_DQT_IDX,
+				      sizeof(zr36050_dqt), zr36050_dqt);
+		sum += zr36050_pushit(ptr, ZR050_DHT_IDX,
+				      sizeof(zr36050_dht), zr36050_dht);
+		zr36050_write(ptr, ZR050_APP_IDX, 0xff);
+		zr36050_write(ptr, ZR050_APP_IDX + 1, 0xe0 + ptr->app.appn);
+		zr36050_write(ptr, ZR050_APP_IDX + 2, 0x00);
+		zr36050_write(ptr, ZR050_APP_IDX + 3, ptr->app.len + 2);
+		sum += zr36050_pushit(ptr, ZR050_APP_IDX + 4, 60,
+				      ptr->app.data) + 4;
+		zr36050_write(ptr, ZR050_COM_IDX, 0xff);
+		zr36050_write(ptr, ZR050_COM_IDX + 1, 0xfe);
+		zr36050_write(ptr, ZR050_COM_IDX + 2, 0x00);
+		zr36050_write(ptr, ZR050_COM_IDX + 3, ptr->com.len + 2);
+		sum += zr36050_pushit(ptr, ZR050_COM_IDX + 4, 60,
+				      ptr->com.data) + 4;
+
+		/* do the internal huffman table preload */
+		zr36050_write(ptr, ZR050_MARKERS_EN, ZR050_ME_DHTI);
+
+		zr36050_write(ptr, ZR050_GO, 1);	// launch codec
+		zr36050_wait_end(ptr);
+		dprintk(2, "%s: Status after table preload: 0x%02x\n",
+			ptr->name, ptr->status1);
+
+		if ((ptr->status1 & 0x4) == 0) {
+			dprintk(1, KERN_ERR "%s: init aborted!\n",
+				ptr->name);
+			return;	// something is wrong, its timed out!!!!
+		}
+
+		/* setup misc. data for compression (target code sizes) */
+
+		/* size of compressed code to reach without header data */
+		sum = ptr->real_code_vol - sum;
+		bitcnt = sum << 3;	/* need the size in bits */
+
+		tmp = bitcnt >> 16;
+		dprintk(3,
+			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
+			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
+		zr36050_write(ptr, ZR050_TCV_NET_HI, tmp >> 8);
+		zr36050_write(ptr, ZR050_TCV_NET_MH, tmp & 0xff);
+		tmp = bitcnt & 0xffff;
+		zr36050_write(ptr, ZR050_TCV_NET_ML, tmp >> 8);
+		zr36050_write(ptr, ZR050_TCV_NET_LO, tmp & 0xff);
+
+		bitcnt -= bitcnt >> 7;	// bits without stuffing
+		bitcnt -= ((bitcnt * 5) >> 6);	// bits without eob
+
+		tmp = bitcnt >> 16;
+		dprintk(3, "%s: code: nettobit=%ld, highnettobits=%ld\n",
+			ptr->name, bitcnt, tmp);
+		zr36050_write(ptr, ZR050_TCV_DATA_HI, tmp >> 8);
+		zr36050_write(ptr, ZR050_TCV_DATA_MH, tmp & 0xff);
+		tmp = bitcnt & 0xffff;
+		zr36050_write(ptr, ZR050_TCV_DATA_ML, tmp >> 8);
+		zr36050_write(ptr, ZR050_TCV_DATA_LO, tmp & 0xff);
+
+		/* compression setup with or without bitrate control */
+		zr36050_write(ptr, ZR050_MODE,
+			      ZR050_MO_COMP | ZR050_MO_PASS2 |
+			      (ptr->bitrate_ctrl ? ZR050_MO_BRC : 0));
+
+		/* this headers seem to deliver "valid AVI" jpeg frames */
+		zr36050_write(ptr, ZR050_MARKERS_EN,
+			      ZR050_ME_DQT | ZR050_ME_DHT |
+			      ((ptr->app.len > 0) ? ZR050_ME_APP : 0) |
+			      ((ptr->com.len > 0) ? ZR050_ME_COM : 0));
+	} else {
+		dprintk(2, "%s: EXPANSION SETUP\n", ptr->name);
+
+		/* 050 communicates with 055 in master mode */
+		zr36050_write(ptr, ZR050_HARDWARE,
+			      ZR050_HW_MSTR | ZR050_HW_CFIS_2_CLK);
+
+		/* encoding table preload */
+		zr36050_write(ptr, ZR050_MODE, ZR050_MO_TLM);
+
+		/* disable all IRQs */
+		zr36050_write(ptr, ZR050_INT_REQ_0, 0);
+		zr36050_write(ptr, ZR050_INT_REQ_1, 3);	// low 2 bits always 1
+
+		dprintk(3, "%s: write DHT\n", ptr->name);
+		zr36050_pushit(ptr, ZR050_DHT_IDX, sizeof(zr36050_dht),
+			       zr36050_dht);
+
+		/* do the internal huffman table preload */
+		zr36050_write(ptr, ZR050_MARKERS_EN, ZR050_ME_DHTI);
+
+		zr36050_write(ptr, ZR050_GO, 1);	// launch codec
+		zr36050_wait_end(ptr);
+		dprintk(2, "%s: Status after table preload: 0x%02x\n",
+			ptr->name, ptr->status1);
+
+		if ((ptr->status1 & 0x4) == 0) {
+			dprintk(1, KERN_ERR "%s: init aborted!\n",
+				ptr->name);
+			return;	// something is wrong, its timed out!!!!
+		}
+
+		/* setup misc. data for expansion */
+		zr36050_write(ptr, ZR050_MODE, 0);
+		zr36050_write(ptr, ZR050_MARKERS_EN, 0);
+	}
+
+	/* adr on selected, to allow GO from master */
+	zr36050_read(ptr, 0);
+}
+
+/* =========================================================================
+   CODEC API FUNCTIONS
+
+   this functions are accessed by the master via the API structure
+   ========================================================================= */
+
+/* set compression/expansion mode and launches codec -
+   this should be the last call from the master before starting processing */
+static int
+zr36050_set_mode (struct videocodec *codec,
+		  int                mode)
+{
+	struct zr36050 *ptr = (struct zr36050 *) codec->data;
+
+	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
+
+	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
+		return -EINVAL;
+
+	ptr->mode = mode;
+	zr36050_init(ptr);
+
+	return 0;
+}
+
+/* set picture size (norm is ignored as the codec doesn't know about it) */
+static int
+zr36050_set_video (struct videocodec   *codec,
+		   struct tvnorm       *norm,
+		   struct vfe_settings *cap,
+		   struct vfe_polarity *pol)
+{
+	struct zr36050 *ptr = (struct zr36050 *) codec->data;
+	int size;
+
+	dprintk(2, "%s: set_video %d.%d, %d/%d-%dx%d (0x%x) q%d call\n",
+		ptr->name, norm->HStart, norm->VStart,
+		cap->x, cap->y, cap->width, cap->height,
+		cap->decimation, cap->quality);
+	/* if () return -EINVAL;
+	 * trust the master driver that it knows what it does - so
+	 * we allow invalid startx/y and norm for now ... */
+	ptr->width = cap->width / (cap->decimation & 0xff);
+	ptr->height = cap->height / ((cap->decimation >> 8) & 0xff);
+
+	/* (KM) JPEG quality */
+	size = ptr->width * ptr->height;
+	size *= 16; /* size in bits */
+	/* apply quality setting */
+	size = size * cap->quality / 200;
+
+	/* Minimum: 1kb */
+	if (size < 8192)
+		size = 8192;
+	/* Maximum: 7/8 of code buffer */
+	if (size > ptr->total_code_vol * 7)
+		size = ptr->total_code_vol * 7;
+
+	ptr->real_code_vol = size >> 3; /* in bytes */
+
+	/* Set max_block_vol here (previously in zr36050_init, moved
+	 * here for consistency with zr36060 code */
+	zr36050_write(ptr, ZR050_MBCV, ptr->max_block_vol);
+
+	return 0;
+}
+
+/* additional control functions */
+static int
+zr36050_control (struct videocodec *codec,
+		 int                type,
+		 int                size,
+		 void              *data)
+{
+	struct zr36050 *ptr = (struct zr36050 *) codec->data;
+	int *ival = (int *) data;
+
+	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
+		size);
+
+	switch (type) {
+	case CODEC_G_STATUS:	/* get last status */
+		if (size != sizeof(int))
+			return -EFAULT;
+		zr36050_read_status1(ptr);
+		*ival = ptr->status1;
+		break;
+
+	case CODEC_G_CODEC_MODE:
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = CODEC_MODE_BJPG;
+		break;
+
+	case CODEC_S_CODEC_MODE:
+		if (size != sizeof(int))
+			return -EFAULT;
+		if (*ival != CODEC_MODE_BJPG)
+			return -EINVAL;
+		/* not needed, do nothing */
+		return 0;
+
+	case CODEC_G_VFE:
+	case CODEC_S_VFE:
+		/* not needed, do nothing */
+		return 0;
+
+	case CODEC_S_MMAP:
+		/* not available, give an error */
+		return -ENXIO;
+
+	case CODEC_G_JPEG_TDS_BYTE:	/* get target volume in byte */
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = ptr->total_code_vol;
+		break;
+
+	case CODEC_S_JPEG_TDS_BYTE:	/* get target volume in byte */
+		if (size != sizeof(int))
+			return -EFAULT;
+		ptr->total_code_vol = *ival;
+		/* (Kieran Morrissey)
+		 * code copied from zr36060.c to ensure proper bitrate */
+		ptr->real_code_vol = (ptr->total_code_vol * 6) >> 3;
+		break;
+
+	case CODEC_G_JPEG_SCALE:	/* get scaling factor */
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = zr36050_read_scalefactor(ptr);
+		break;
+
+	case CODEC_S_JPEG_SCALE:	/* set scaling factor */
+		if (size != sizeof(int))
+			return -EFAULT;
+		ptr->scalefact = *ival;
+		break;
+
+	case CODEC_G_JPEG_APP_DATA: {	/* get appn marker data */
+		struct jpeg_app_marker *app = data;
+
+		if (size != sizeof(struct jpeg_app_marker))
+			return -EFAULT;
+
+		*app = ptr->app;
+		break;
+	}
+
+	case CODEC_S_JPEG_APP_DATA: {	 /* set appn marker data */
+		struct jpeg_app_marker *app = data;
+
+		if (size != sizeof(struct jpeg_app_marker))
+			return -EFAULT;
+
+		ptr->app = *app;
+		break;
+	}
+
+	case CODEC_G_JPEG_COM_DATA: {	/* get comment marker data */
+		struct jpeg_com_marker *com = data;
+
+		if (size != sizeof(struct jpeg_com_marker))
+			return -EFAULT;
+
+		*com = ptr->com;
+		break;
+	}
+
+	case CODEC_S_JPEG_COM_DATA: {	/* set comment marker data */
+		struct jpeg_com_marker *com = data;
+
+		if (size != sizeof(struct jpeg_com_marker))
+			return -EFAULT;
+
+		ptr->com = *com;
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+
+	return size;
+}
+
+/* =========================================================================
+   Exit and unregister function:
+
+   Deinitializes Zoran's JPEG processor
+   ========================================================================= */
+
+static int
+zr36050_unset (struct videocodec *codec)
+{
+	struct zr36050 *ptr = codec->data;
+
+	if (ptr) {
+		/* do wee need some codec deinit here, too ???? */
+
+		dprintk(1, "%s: finished codec #%d\n", ptr->name,
+			ptr->num);
+		kfree(ptr);
+		codec->data = NULL;
+
+		zr36050_codecs--;
+		return 0;
+	}
+
+	return -EFAULT;
+}
+
+/* =========================================================================
+   Setup and registry function:
+
+   Initializes Zoran's JPEG processor
+
+   Also sets pixel size, average code size, mode (compr./decompr.)
+   (the given size is determined by the processor with the video interface)
+   ========================================================================= */
+
+static int
+zr36050_setup (struct videocodec *codec)
+{
+	struct zr36050 *ptr;
+	int res;
+
+	dprintk(2, "zr36050: initializing MJPEG subsystem #%d.\n",
+		zr36050_codecs);
+
+	if (zr36050_codecs == MAX_CODECS) {
+		dprintk(1,
+			KERN_ERR "zr36050: Can't attach more codecs!\n");
+		return -ENOSPC;
+	}
+	//mem structure init
+	codec->data = ptr = kzalloc(sizeof(struct zr36050), GFP_KERNEL);
+	if (NULL == ptr) {
+		dprintk(1, KERN_ERR "zr36050: Can't get enough memory!\n");
+		return -ENOMEM;
+	}
+
+	snprintf(ptr->name, sizeof(ptr->name), "zr36050[%d]",
+		 zr36050_codecs);
+	ptr->num = zr36050_codecs++;
+	ptr->codec = codec;
+
+	//testing
+	res = zr36050_basic_test(ptr);
+	if (res < 0) {
+		zr36050_unset(codec);
+		return res;
+	}
+	//final setup
+	memcpy(ptr->h_samp_ratio, zr36050_decimation_h, 8);
+	memcpy(ptr->v_samp_ratio, zr36050_decimation_v, 8);
+
+	ptr->bitrate_ctrl = 0;	/* 0 or 1 - fixed file size flag
+				 * (what is the difference?) */
+	ptr->mode = CODEC_DO_COMPRESSION;
+	ptr->width = 384;
+	ptr->height = 288;
+	ptr->total_code_vol = 16000;
+	ptr->max_block_vol = 240;
+	ptr->scalefact = 0x100;
+	ptr->dri = 1;
+
+	/* no app/com marker by default */
+	ptr->app.appn = 0;
+	ptr->app.len = 0;
+	ptr->com.len = 0;
+
+	zr36050_init(ptr);
+
+	dprintk(1, KERN_INFO "%s: codec attached and running\n",
+		ptr->name);
+
+	return 0;
+}
+
+static const struct videocodec zr36050_codec = {
+	.owner = THIS_MODULE,
+	.name = "zr36050",
+	.magic = 0L,		// magic not used
+	.flags =
+	    CODEC_FLAG_JPEG | CODEC_FLAG_HARDWARE | CODEC_FLAG_ENCODER |
+	    CODEC_FLAG_DECODER,
+	.type = CODEC_TYPE_ZR36050,
+	.setup = zr36050_setup,	// functionality
+	.unset = zr36050_unset,
+	.set_mode = zr36050_set_mode,
+	.set_video = zr36050_set_video,
+	.control = zr36050_control,
+	// others are not used
+};
+
+/* =========================================================================
+   HOOK IN DRIVER AS KERNEL MODULE
+   ========================================================================= */
+
+static int __init
+zr36050_init_module (void)
+{
+	//dprintk(1, "ZR36050 driver %s\n",ZR050_VERSION);
+	zr36050_codecs = 0;
+	return videocodec_register(&zr36050_codec);
+}
+
+static void __exit
+zr36050_cleanup_module (void)
+{
+	if (zr36050_codecs) {
+		dprintk(1,
+			"zr36050: something's wrong - %d codecs left somehow.\n",
+			zr36050_codecs);
+	}
+	videocodec_unregister(&zr36050_codec);
+}
+
+module_init(zr36050_init_module);
+module_exit(zr36050_cleanup_module);
+
+MODULE_AUTHOR("Wolfgang Scherr <scherr@net4you.at>");
+MODULE_DESCRIPTION("Driver module for ZR36050 jpeg processors "
+		   ZR050_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/zr36050.h b/drivers/staging/media/zoran/zr36050.h
new file mode 100644
index 000000000000..9236486d3c2b
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36050.h
@@ -0,0 +1,179 @@
+/*
+ * Zoran ZR36050 basic configuration functions - header file
+ *
+ * Copyright (C) 2001 Wolfgang Scherr <scherr@net4you.at>
+ *
+ * $Id: zr36050.h,v 1.1.2.2 2003/01/14 21:18:22 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#ifndef ZR36050_H
+#define ZR36050_H
+
+#include "videocodec.h"
+
+/* data stored for each zoran jpeg codec chip */
+struct zr36050 {
+	char name[32];
+	int num;
+	/* io datastructure */
+	struct videocodec *codec;
+	// last coder status
+	__u8 status1;
+	// actual coder setup
+	int mode;
+
+	__u16 width;
+	__u16 height;
+
+	__u16 bitrate_ctrl;
+
+	__u32 total_code_vol;
+	__u32 real_code_vol;
+	__u16 max_block_vol;
+
+	__u8 h_samp_ratio[8];
+	__u8 v_samp_ratio[8];
+	__u16 scalefact;
+	__u16 dri;
+
+	/* com/app marker */
+	struct jpeg_com_marker com;
+	struct jpeg_app_marker app;
+};
+
+/* zr36050 register addresses */
+#define ZR050_GO                  0x000
+#define ZR050_HARDWARE            0x002
+#define ZR050_MODE                0x003
+#define ZR050_OPTIONS             0x004
+#define ZR050_MBCV                0x005
+#define ZR050_MARKERS_EN          0x006
+#define ZR050_INT_REQ_0           0x007
+#define ZR050_INT_REQ_1           0x008
+#define ZR050_TCV_NET_HI          0x009
+#define ZR050_TCV_NET_MH          0x00a
+#define ZR050_TCV_NET_ML          0x00b
+#define ZR050_TCV_NET_LO          0x00c
+#define ZR050_TCV_DATA_HI         0x00d
+#define ZR050_TCV_DATA_MH         0x00e
+#define ZR050_TCV_DATA_ML         0x00f
+#define ZR050_TCV_DATA_LO         0x010
+#define ZR050_SF_HI               0x011
+#define ZR050_SF_LO               0x012
+#define ZR050_AF_HI               0x013
+#define ZR050_AF_M                0x014
+#define ZR050_AF_LO               0x015
+#define ZR050_ACV_HI              0x016
+#define ZR050_ACV_MH              0x017
+#define ZR050_ACV_ML              0x018
+#define ZR050_ACV_LO              0x019
+#define ZR050_ACT_HI              0x01a
+#define ZR050_ACT_MH              0x01b
+#define ZR050_ACT_ML              0x01c
+#define ZR050_ACT_LO              0x01d
+#define ZR050_ACV_TRUN_HI         0x01e
+#define ZR050_ACV_TRUN_MH         0x01f
+#define ZR050_ACV_TRUN_ML         0x020
+#define ZR050_ACV_TRUN_LO         0x021
+#define ZR050_STATUS_0            0x02e
+#define ZR050_STATUS_1            0x02f
+
+#define ZR050_SOF_IDX             0x040
+#define ZR050_SOS1_IDX            0x07a
+#define ZR050_SOS2_IDX            0x08a
+#define ZR050_SOS3_IDX            0x09a
+#define ZR050_SOS4_IDX            0x0aa
+#define ZR050_DRI_IDX             0x0c0
+#define ZR050_DNL_IDX             0x0c6
+#define ZR050_DQT_IDX             0x0cc
+#define ZR050_DHT_IDX             0x1d4
+#define ZR050_APP_IDX             0x380
+#define ZR050_COM_IDX             0x3c0
+
+/* zr36050 hardware register bits */
+
+#define ZR050_HW_BSWD                0x80
+#define ZR050_HW_MSTR                0x40
+#define ZR050_HW_DMA                 0x20
+#define ZR050_HW_CFIS_1_CLK          0x00
+#define ZR050_HW_CFIS_2_CLK          0x04
+#define ZR050_HW_CFIS_3_CLK          0x08
+#define ZR050_HW_CFIS_4_CLK          0x0C
+#define ZR050_HW_CFIS_5_CLK          0x10
+#define ZR050_HW_CFIS_6_CLK          0x14
+#define ZR050_HW_CFIS_7_CLK          0x18
+#define ZR050_HW_CFIS_8_CLK          0x1C
+#define ZR050_HW_BELE                0x01
+
+/* zr36050 mode register bits */
+
+#define ZR050_MO_COMP                0x80
+#define ZR050_MO_ATP                 0x40
+#define ZR050_MO_PASS2               0x20
+#define ZR050_MO_TLM                 0x10
+#define ZR050_MO_DCONLY              0x08
+#define ZR050_MO_BRC                 0x04
+
+#define ZR050_MO_ATP                 0x40
+#define ZR050_MO_PASS2               0x20
+#define ZR050_MO_TLM                 0x10
+#define ZR050_MO_DCONLY              0x08
+
+/* zr36050 option register bits */
+
+#define ZR050_OP_NSCN_1              0x00
+#define ZR050_OP_NSCN_2              0x20
+#define ZR050_OP_NSCN_3              0x40
+#define ZR050_OP_NSCN_4              0x60
+#define ZR050_OP_NSCN_5              0x80
+#define ZR050_OP_NSCN_6              0xA0
+#define ZR050_OP_NSCN_7              0xC0
+#define ZR050_OP_NSCN_8              0xE0
+#define ZR050_OP_OVF                 0x10
+
+
+/* zr36050 markers-enable register bits */
+
+#define ZR050_ME_APP                 0x80
+#define ZR050_ME_COM                 0x40
+#define ZR050_ME_DRI                 0x20
+#define ZR050_ME_DQT                 0x10
+#define ZR050_ME_DHT                 0x08
+#define ZR050_ME_DNL                 0x04
+#define ZR050_ME_DQTI                0x02
+#define ZR050_ME_DHTI                0x01
+
+/* zr36050 status0/1 register bit masks */
+
+#define ZR050_ST_RST_MASK            0x20
+#define ZR050_ST_SOF_MASK            0x02
+#define ZR050_ST_SOS_MASK            0x02
+#define ZR050_ST_DATRDY_MASK         0x80
+#define ZR050_ST_MRKDET_MASK         0x40
+#define ZR050_ST_RFM_MASK            0x10
+#define ZR050_ST_RFD_MASK            0x08
+#define ZR050_ST_END_MASK            0x04
+#define ZR050_ST_TCVOVF_MASK         0x02
+#define ZR050_ST_DATOVF_MASK         0x01
+
+/* pixel component idx */
+
+#define ZR050_Y_COMPONENT         0
+#define ZR050_U_COMPONENT         1
+#define ZR050_V_COMPONENT         2
+
+#endif				/*fndef ZR36050_H */
diff --git a/drivers/staging/media/zoran/zr36057.h b/drivers/staging/media/zoran/zr36057.h
new file mode 100644
index 000000000000..c8acb21dcb5c
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36057.h
@@ -0,0 +1,164 @@
+/*
+ * zr36057.h - zr36057 register offsets
+ *
+ * Copyright (C) 1998 Dave Perks <dperks@ibm.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ZR36057_H_
+#define _ZR36057_H_
+
+
+/* Zoran ZR36057 registers */
+
+#define ZR36057_VFEHCR          0x000	/* Video Front End, Horizontal Configuration Register */
+#define ZR36057_VFEHCR_HSPol            (1<<30)
+#define ZR36057_VFEHCR_HStart           10
+#define ZR36057_VFEHCR_HEnd		0
+#define ZR36057_VFEHCR_Hmask		0x3ff
+
+#define ZR36057_VFEVCR          0x004	/* Video Front End, Vertical Configuration Register */
+#define ZR36057_VFEVCR_VSPol            (1<<30)
+#define ZR36057_VFEVCR_VStart           10
+#define ZR36057_VFEVCR_VEnd		0
+#define ZR36057_VFEVCR_Vmask		0x3ff
+
+#define ZR36057_VFESPFR         0x008	/* Video Front End, Scaler and Pixel Format Register */
+#define ZR36057_VFESPFR_ExtFl           (1<<26)
+#define ZR36057_VFESPFR_TopField        (1<<25)
+#define ZR36057_VFESPFR_VCLKPol         (1<<24)
+#define ZR36057_VFESPFR_HFilter         21
+#define ZR36057_VFESPFR_HorDcm          14
+#define ZR36057_VFESPFR_VerDcm          8
+#define ZR36057_VFESPFR_DispMode        6
+#define ZR36057_VFESPFR_YUV422          (0<<3)
+#define ZR36057_VFESPFR_RGB888          (1<<3)
+#define ZR36057_VFESPFR_RGB565          (2<<3)
+#define ZR36057_VFESPFR_RGB555          (3<<3)
+#define ZR36057_VFESPFR_ErrDif          (1<<2)
+#define ZR36057_VFESPFR_Pack24          (1<<1)
+#define ZR36057_VFESPFR_LittleEndian    (1<<0)
+
+#define ZR36057_VDTR            0x00c	/* Video Display "Top" Register */
+
+#define ZR36057_VDBR            0x010	/* Video Display "Bottom" Register */
+
+#define ZR36057_VSSFGR          0x014	/* Video Stride, Status, and Frame Grab Register */
+#define ZR36057_VSSFGR_DispStride       16
+#define ZR36057_VSSFGR_VidOvf           (1<<8)
+#define ZR36057_VSSFGR_SnapShot         (1<<1)
+#define ZR36057_VSSFGR_FrameGrab        (1<<0)
+
+#define ZR36057_VDCR            0x018	/* Video Display Configuration Register */
+#define ZR36057_VDCR_VidEn              (1<<31)
+#define ZR36057_VDCR_MinPix             24
+#define ZR36057_VDCR_Triton             (1<<24)
+#define ZR36057_VDCR_VidWinHt           12
+#define ZR36057_VDCR_VidWinWid          0
+
+#define ZR36057_MMTR            0x01c	/* Masking Map "Top" Register */
+
+#define ZR36057_MMBR            0x020	/* Masking Map "Bottom" Register */
+
+#define ZR36057_OCR             0x024	/* Overlay Control Register */
+#define ZR36057_OCR_OvlEnable           (1 << 15)
+#define ZR36057_OCR_MaskStride          0
+
+#define ZR36057_SPGPPCR         0x028	/* System, PCI, and General Purpose Pins Control Register */
+#define ZR36057_SPGPPCR_SoftReset	(1<<24)
+
+#define ZR36057_GPPGCR1         0x02c	/* General Purpose Pins and GuestBus Control Register (1) */
+
+#define ZR36057_MCSAR           0x030	/* MPEG Code Source Address Register */
+
+#define ZR36057_MCTCR           0x034	/* MPEG Code Transfer Control Register */
+#define ZR36057_MCTCR_CodTime           (1 << 30)
+#define ZR36057_MCTCR_CEmpty            (1 << 29)
+#define ZR36057_MCTCR_CFlush            (1 << 28)
+#define ZR36057_MCTCR_CodGuestID	20
+#define ZR36057_MCTCR_CodGuestReg	16
+
+#define ZR36057_MCMPR           0x038	/* MPEG Code Memory Pointer Register */
+
+#define ZR36057_ISR             0x03c	/* Interrupt Status Register */
+#define ZR36057_ISR_GIRQ1               (1<<30)
+#define ZR36057_ISR_GIRQ0               (1<<29)
+#define ZR36057_ISR_CodRepIRQ           (1<<28)
+#define ZR36057_ISR_JPEGRepIRQ          (1<<27)
+
+#define ZR36057_ICR             0x040	/* Interrupt Control Register */
+#define ZR36057_ICR_GIRQ1               (1<<30)
+#define ZR36057_ICR_GIRQ0               (1<<29)
+#define ZR36057_ICR_CodRepIRQ           (1<<28)
+#define ZR36057_ICR_JPEGRepIRQ          (1<<27)
+#define ZR36057_ICR_IntPinEn            (1<<24)
+
+#define ZR36057_I2CBR           0x044	/* I2C Bus Register */
+#define ZR36057_I2CBR_SDA		(1<<1)
+#define ZR36057_I2CBR_SCL		(1<<0)
+
+#define ZR36057_JMC             0x100	/* JPEG Mode and Control */
+#define ZR36057_JMC_JPG                 (1 << 31)
+#define ZR36057_JMC_JPGExpMode          (0 << 29)
+#define ZR36057_JMC_JPGCmpMode          (1 << 29)
+#define ZR36057_JMC_MJPGExpMode         (2 << 29)
+#define ZR36057_JMC_MJPGCmpMode         (3 << 29)
+#define ZR36057_JMC_RTBUSY_FB           (1 << 6)
+#define ZR36057_JMC_Go_en               (1 << 5)
+#define ZR36057_JMC_SyncMstr            (1 << 4)
+#define ZR36057_JMC_Fld_per_buff        (1 << 3)
+#define ZR36057_JMC_VFIFO_FB            (1 << 2)
+#define ZR36057_JMC_CFIFO_FB            (1 << 1)
+#define ZR36057_JMC_Stll_LitEndian      (1 << 0)
+
+#define ZR36057_JPC             0x104	/* JPEG Process Control */
+#define ZR36057_JPC_P_Reset             (1 << 7)
+#define ZR36057_JPC_CodTrnsEn           (1 << 5)
+#define ZR36057_JPC_Active              (1 << 0)
+
+#define ZR36057_VSP             0x108	/* Vertical Sync Parameters */
+#define ZR36057_VSP_VsyncSize           16
+#define ZR36057_VSP_FrmTot              0
+
+#define ZR36057_HSP             0x10c	/* Horizontal Sync Parameters */
+#define ZR36057_HSP_HsyncStart          16
+#define ZR36057_HSP_LineTot             0
+
+#define ZR36057_FHAP            0x110	/* Field Horizontal Active Portion */
+#define ZR36057_FHAP_NAX                16
+#define ZR36057_FHAP_PAX                0
+
+#define ZR36057_FVAP            0x114	/* Field Vertical Active Portion */
+#define ZR36057_FVAP_NAY                16
+#define ZR36057_FVAP_PAY                0
+
+#define ZR36057_FPP             0x118	/* Field Process Parameters */
+#define ZR36057_FPP_Odd_Even            (1 << 0)
+
+#define ZR36057_JCBA            0x11c	/* JPEG Code Base Address */
+
+#define ZR36057_JCFT            0x120	/* JPEG Code FIFO Threshold */
+
+#define ZR36057_JCGI            0x124	/* JPEG Codec Guest ID */
+#define ZR36057_JCGI_JPEGuestID         4
+#define ZR36057_JCGI_JPEGuestReg        0
+
+#define ZR36057_GCR2            0x12c	/* GuestBus Control Register (2) */
+
+#define ZR36057_POR             0x200	/* Post Office Register */
+#define ZR36057_POR_POPen               (1<<25)
+#define ZR36057_POR_POTime              (1<<24)
+#define ZR36057_POR_PODir               (1<<23)
+
+#define ZR36057_STR             0x300	/* "Still" Transfer Register */
+
+#endif
diff --git a/drivers/staging/media/zoran/zr36060.c b/drivers/staging/media/zoran/zr36060.c
new file mode 100644
index 000000000000..2c2e8130fc96
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36060.c
@@ -0,0 +1,1006 @@
+/*
+ * Zoran ZR36060 basic configuration functions
+ *
+ * Copyright (C) 2002 Laurent Pinchart <laurent.pinchart@skynet.be>
+ *
+ * $Id: zr36060.c,v 1.1.2.22 2003/05/06 09:35:36 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#define ZR060_VERSION "v0.7"
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <linux/types.h>
+#include <linux/wait.h>
+
+/* I/O commands, error codes */
+#include <asm/io.h>
+
+/* headerfile of this module */
+#include "zr36060.h"
+
+/* codec io API */
+#include "videocodec.h"
+
+/* it doesn't make sense to have more than 20 or so,
+  just to prevent some unwanted loops */
+#define MAX_CODECS 20
+
+/* amount of chips attached via this driver */
+static int zr36060_codecs;
+
+static bool low_bitrate;
+module_param(low_bitrate, bool, 0);
+MODULE_PARM_DESC(low_bitrate, "Buz compatibility option, halves bitrate");
+
+/* debugging is available via module parameter */
+static int debug;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0-4)");
+
+#define dprintk(num, format, args...) \
+	do { \
+		if (debug >= num) \
+			printk(format, ##args); \
+	} while (0)
+
+/* =========================================================================
+   Local hardware I/O functions:
+
+   read/write via codec layer (registers are located in the master device)
+   ========================================================================= */
+
+/* read and write functions */
+static u8
+zr36060_read (struct zr36060 *ptr,
+	      u16             reg)
+{
+	u8 value = 0;
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->readreg)
+		value = (ptr->codec->master_data->readreg(ptr->codec,
+							  reg)) & 0xff;
+	else
+		dprintk(1,
+			KERN_ERR "%s: invalid I/O setup, nothing read!\n",
+			ptr->name);
+
+	//dprintk(4, "%s: reading from 0x%04x: %02x\n",ptr->name,reg,value);
+
+	return value;
+}
+
+static void
+zr36060_write(struct zr36060 *ptr,
+	      u16             reg,
+	      u8              value)
+{
+	//dprintk(4, "%s: writing 0x%02x to 0x%04x\n",ptr->name,value,reg);
+	dprintk(4, "0x%02x @0x%04x\n", value, reg);
+
+	// just in case something is wrong...
+	if (ptr->codec->master_data->writereg)
+		ptr->codec->master_data->writereg(ptr->codec, reg, value);
+	else
+		dprintk(1,
+			KERN_ERR
+			"%s: invalid I/O setup, nothing written!\n",
+			ptr->name);
+}
+
+/* =========================================================================
+   Local helper function:
+
+   status read
+   ========================================================================= */
+
+/* status is kept in datastructure */
+static u8
+zr36060_read_status (struct zr36060 *ptr)
+{
+	ptr->status = zr36060_read(ptr, ZR060_CFSR);
+
+	zr36060_read(ptr, 0);
+	return ptr->status;
+}
+
+/* =========================================================================
+   Local helper function:
+
+   scale factor read
+   ========================================================================= */
+
+/* scale factor is kept in datastructure */
+static u16
+zr36060_read_scalefactor (struct zr36060 *ptr)
+{
+	ptr->scalefact = (zr36060_read(ptr, ZR060_SF_HI) << 8) |
+			 (zr36060_read(ptr, ZR060_SF_LO) & 0xFF);
+
+	/* leave 0 selected for an eventually GO from master */
+	zr36060_read(ptr, 0);
+	return ptr->scalefact;
+}
+
+/* =========================================================================
+   Local helper function:
+
+   wait if codec is ready to proceed (end of processing) or time is over
+   ========================================================================= */
+
+static void
+zr36060_wait_end (struct zr36060 *ptr)
+{
+	int i = 0;
+
+	while (zr36060_read_status(ptr) & ZR060_CFSR_Busy) {
+		udelay(1);
+		if (i++ > 200000) {	// 200ms, there is for sure something wrong!!!
+			dprintk(1,
+				"%s: timeout at wait_end (last status: 0x%02x)\n",
+				ptr->name, ptr->status);
+			break;
+		}
+	}
+}
+
+/* =========================================================================
+   Local helper function:
+
+   basic test of "connectivity", writes/reads to/from memory the SOF marker
+   ========================================================================= */
+
+static int
+zr36060_basic_test (struct zr36060 *ptr)
+{
+	if ((zr36060_read(ptr, ZR060_IDR_DEV) != 0x33) &&
+	    (zr36060_read(ptr, ZR060_IDR_REV) != 0x01)) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, can't connect to jpeg processor!\n",
+			ptr->name);
+		return -ENXIO;
+	}
+
+	zr36060_wait_end(ptr);
+	if (ptr->status & ZR060_CFSR_Busy) {
+		dprintk(1,
+			KERN_ERR
+			"%s: attach failed, jpeg processor failed (end flag)!\n",
+			ptr->name);
+		return -EBUSY;
+	}
+
+	return 0;		/* looks good! */
+}
+
+/* =========================================================================
+   Local helper function:
+
+   simple loop for pushing the init datasets
+   ========================================================================= */
+
+static int
+zr36060_pushit (struct zr36060 *ptr,
+		u16             startreg,
+		u16             len,
+		const char     *data)
+{
+	int i = 0;
+
+	dprintk(4, "%s: write data block to 0x%04x (len=%d)\n", ptr->name,
+		startreg, len);
+	while (i < len) {
+		zr36060_write(ptr, startreg++, data[i++]);
+	}
+
+	return i;
+}
+
+/* =========================================================================
+   Basic datasets:
+
+   jpeg baseline setup data (you find it on lots places in internet, or just
+   extract it from any regular .jpg image...)
+
+   Could be variable, but until it's not needed it they are just fixed to save
+   memory. Otherwise expand zr36060 structure with arrays, push the values to
+   it and initialize from there, as e.g. the linux zr36057/60 driver does it.
+   ========================================================================= */
+
+static const char zr36060_dqt[0x86] = {
+	0xff, 0xdb,		//Marker: DQT
+	0x00, 0x84,		//Length: 2*65+2
+	0x00,			//Pq,Tq first table
+	0x10, 0x0b, 0x0c, 0x0e, 0x0c, 0x0a, 0x10, 0x0e,
+	0x0d, 0x0e, 0x12, 0x11, 0x10, 0x13, 0x18, 0x28,
+	0x1a, 0x18, 0x16, 0x16, 0x18, 0x31, 0x23, 0x25,
+	0x1d, 0x28, 0x3a, 0x33, 0x3d, 0x3c, 0x39, 0x33,
+	0x38, 0x37, 0x40, 0x48, 0x5c, 0x4e, 0x40, 0x44,
+	0x57, 0x45, 0x37, 0x38, 0x50, 0x6d, 0x51, 0x57,
+	0x5f, 0x62, 0x67, 0x68, 0x67, 0x3e, 0x4d, 0x71,
+	0x79, 0x70, 0x64, 0x78, 0x5c, 0x65, 0x67, 0x63,
+	0x01,			//Pq,Tq second table
+	0x11, 0x12, 0x12, 0x18, 0x15, 0x18, 0x2f, 0x1a,
+	0x1a, 0x2f, 0x63, 0x42, 0x38, 0x42, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63,
+	0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63, 0x63
+};
+
+static const char zr36060_dht[0x1a4] = {
+	0xff, 0xc4,		//Marker: DHT
+	0x01, 0xa2,		//Length: 2*AC, 2*DC
+	0x00,			//DC first table
+	0x00, 0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,
+	0x01,			//DC second table
+	0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+	0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,
+	0x10,			//AC first table
+	0x00, 0x02, 0x01, 0x03, 0x03, 0x02, 0x04, 0x03,
+	0x05, 0x05, 0x04, 0x04, 0x00, 0x00,
+	0x01, 0x7D, 0x01, 0x02, 0x03, 0x00, 0x04, 0x11,
+	0x05, 0x12, 0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61,
+	0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1,
+	0x08, 0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52, 0xD1, 0xF0, 0x24,
+	0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16, 0x17,
+	0x18, 0x19, 0x1A, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x34,
+	0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44,
+	0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56,
+	0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66,
+	0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
+	0x79, 0x7A, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88,
+	0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99,
+	0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8,
+	0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9,
+	0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8,
+	0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9,
+	0xDA, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7,
+	0xE8, 0xE9, 0xEA, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7,
+	0xF8, 0xF9, 0xFA,
+	0x11,			//AC second table
+	0x00, 0x02, 0x01, 0x02, 0x04, 0x04, 0x03, 0x04,
+	0x07, 0x05, 0x04, 0x04, 0x00, 0x01,
+	0x02, 0x77, 0x00, 0x01, 0x02, 0x03, 0x11, 0x04,
+	0x05, 0x21, 0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61, 0x71,
+	0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91,
+	0xA1, 0xB1, 0xC1, 0x09, 0x23, 0x33, 0x52, 0xF0, 0x15, 0x62,
+	0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34, 0xE1, 0x25,
+	0xF1, 0x17, 0x18, 0x19, 0x1A, 0x26, 0x27, 0x28, 0x29, 0x2A,
+	0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44,
+	0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56,
+	0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66,
+	0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78,
+	0x79, 0x7A, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98,
+	0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7,
+	0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8,
+	0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7,
+	0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8,
+	0xD9, 0xDA, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7,
+	0xE8, 0xE9, 0xEA, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8,
+	0xF9, 0xFA
+};
+
+/* jpeg baseline setup, this is just fixed in this driver (YUV pictures) */
+#define NO_OF_COMPONENTS          0x3	//Y,U,V
+#define BASELINE_PRECISION        0x8	//MCU size (?)
+static const char zr36060_tq[8] = { 0, 1, 1, 0, 0, 0, 0, 0 };	//table idx's QT
+static const char zr36060_td[8] = { 0, 1, 1, 0, 0, 0, 0, 0 };	//table idx's DC
+static const char zr36060_ta[8] = { 0, 1, 1, 0, 0, 0, 0, 0 };	//table idx's AC
+
+/* horizontal 422 decimation setup (maybe we support 411 or so later, too) */
+static const char zr36060_decimation_h[8] = { 2, 1, 1, 0, 0, 0, 0, 0 };
+static const char zr36060_decimation_v[8] = { 1, 1, 1, 0, 0, 0, 0, 0 };
+
+/* =========================================================================
+   Local helper functions:
+
+   calculation and setup of parameter-dependent JPEG baseline segments
+   (needed for compression only)
+   ========================================================================= */
+
+/* ------------------------------------------------------------------------- */
+
+/* SOF (start of frame) segment depends on width, height and sampling ratio
+			 of each color component */
+
+static int
+zr36060_set_sof (struct zr36060 *ptr)
+{
+	char sof_data[34];	// max. size of register set
+	int i;
+
+	dprintk(3, "%s: write SOF (%dx%d, %d components)\n", ptr->name,
+		ptr->width, ptr->height, NO_OF_COMPONENTS);
+	sof_data[0] = 0xff;
+	sof_data[1] = 0xc0;
+	sof_data[2] = 0x00;
+	sof_data[3] = (3 * NO_OF_COMPONENTS) + 8;
+	sof_data[4] = BASELINE_PRECISION;	// only '8' possible with zr36060
+	sof_data[5] = (ptr->height) >> 8;
+	sof_data[6] = (ptr->height) & 0xff;
+	sof_data[7] = (ptr->width) >> 8;
+	sof_data[8] = (ptr->width) & 0xff;
+	sof_data[9] = NO_OF_COMPONENTS;
+	for (i = 0; i < NO_OF_COMPONENTS; i++) {
+		sof_data[10 + (i * 3)] = i;	// index identifier
+		sof_data[11 + (i * 3)] = (ptr->h_samp_ratio[i] << 4) |
+					 (ptr->v_samp_ratio[i]); // sampling ratios
+		sof_data[12 + (i * 3)] = zr36060_tq[i];	// Q table selection
+	}
+	return zr36060_pushit(ptr, ZR060_SOF_IDX,
+			      (3 * NO_OF_COMPONENTS) + 10, sof_data);
+}
+
+/* ------------------------------------------------------------------------- */
+
+/* SOS (start of scan) segment depends on the used scan components
+			of each color component */
+
+static int
+zr36060_set_sos (struct zr36060 *ptr)
+{
+	char sos_data[16];	// max. size of register set
+	int i;
+
+	dprintk(3, "%s: write SOS\n", ptr->name);
+	sos_data[0] = 0xff;
+	sos_data[1] = 0xda;
+	sos_data[2] = 0x00;
+	sos_data[3] = 2 + 1 + (2 * NO_OF_COMPONENTS) + 3;
+	sos_data[4] = NO_OF_COMPONENTS;
+	for (i = 0; i < NO_OF_COMPONENTS; i++) {
+		sos_data[5 + (i * 2)] = i;	// index
+		sos_data[6 + (i * 2)] = (zr36060_td[i] << 4) |
+					zr36060_ta[i]; // AC/DC tbl.sel.
+	}
+	sos_data[2 + 1 + (2 * NO_OF_COMPONENTS) + 2] = 00;	// scan start
+	sos_data[2 + 1 + (2 * NO_OF_COMPONENTS) + 3] = 0x3f;
+	sos_data[2 + 1 + (2 * NO_OF_COMPONENTS) + 4] = 00;
+	return zr36060_pushit(ptr, ZR060_SOS_IDX,
+			      4 + 1 + (2 * NO_OF_COMPONENTS) + 3,
+			      sos_data);
+}
+
+/* ------------------------------------------------------------------------- */
+
+/* DRI (define restart interval) */
+
+static int
+zr36060_set_dri (struct zr36060 *ptr)
+{
+	char dri_data[6];	// max. size of register set
+
+	dprintk(3, "%s: write DRI\n", ptr->name);
+	dri_data[0] = 0xff;
+	dri_data[1] = 0xdd;
+	dri_data[2] = 0x00;
+	dri_data[3] = 0x04;
+	dri_data[4] = (ptr->dri) >> 8;
+	dri_data[5] = (ptr->dri) & 0xff;
+	return zr36060_pushit(ptr, ZR060_DRI_IDX, 6, dri_data);
+}
+
+/* =========================================================================
+   Setup function:
+
+   Setup compression/decompression of Zoran's JPEG processor
+   ( see also zoran 36060 manual )
+
+   ... sorry for the spaghetti code ...
+   ========================================================================= */
+static void
+zr36060_init (struct zr36060 *ptr)
+{
+	int sum = 0;
+	long bitcnt, tmp;
+
+	if (ptr->mode == CODEC_DO_COMPRESSION) {
+		dprintk(2, "%s: COMPRESSION SETUP\n", ptr->name);
+
+		zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SyncRst);
+
+		/* 060 communicates with 067 in master mode */
+		zr36060_write(ptr, ZR060_CIR, ZR060_CIR_CodeMstr);
+
+		/* Compression with or without variable scale factor */
+		/*FIXME: What about ptr->bitrate_ctrl? */
+		zr36060_write(ptr, ZR060_CMR,
+			      ZR060_CMR_Comp | ZR060_CMR_Pass2 |
+			      ZR060_CMR_BRB);
+
+		/* Must be zero */
+		zr36060_write(ptr, ZR060_MBZ, 0x00);
+		zr36060_write(ptr, ZR060_TCR_HI, 0x00);
+		zr36060_write(ptr, ZR060_TCR_LO, 0x00);
+
+		/* Disable all IRQs - no DataErr means autoreset */
+		zr36060_write(ptr, ZR060_IMR, 0);
+
+		/* volume control settings */
+		zr36060_write(ptr, ZR060_SF_HI, ptr->scalefact >> 8);
+		zr36060_write(ptr, ZR060_SF_LO, ptr->scalefact & 0xff);
+
+		zr36060_write(ptr, ZR060_AF_HI, 0xff);
+		zr36060_write(ptr, ZR060_AF_M, 0xff);
+		zr36060_write(ptr, ZR060_AF_LO, 0xff);
+
+		/* setup the variable jpeg tables */
+		sum += zr36060_set_sof(ptr);
+		sum += zr36060_set_sos(ptr);
+		sum += zr36060_set_dri(ptr);
+
+		/* setup the fixed jpeg tables - maybe variable, though -
+		 * (see table init section above) */
+		sum +=
+		    zr36060_pushit(ptr, ZR060_DQT_IDX, sizeof(zr36060_dqt),
+				   zr36060_dqt);
+		sum +=
+		    zr36060_pushit(ptr, ZR060_DHT_IDX, sizeof(zr36060_dht),
+				   zr36060_dht);
+		zr36060_write(ptr, ZR060_APP_IDX, 0xff);
+		zr36060_write(ptr, ZR060_APP_IDX + 1, 0xe0 + ptr->app.appn);
+		zr36060_write(ptr, ZR060_APP_IDX + 2, 0x00);
+		zr36060_write(ptr, ZR060_APP_IDX + 3, ptr->app.len + 2);
+		sum += zr36060_pushit(ptr, ZR060_APP_IDX + 4, 60,
+				      ptr->app.data) + 4;
+		zr36060_write(ptr, ZR060_COM_IDX, 0xff);
+		zr36060_write(ptr, ZR060_COM_IDX + 1, 0xfe);
+		zr36060_write(ptr, ZR060_COM_IDX + 2, 0x00);
+		zr36060_write(ptr, ZR060_COM_IDX + 3, ptr->com.len + 2);
+		sum += zr36060_pushit(ptr, ZR060_COM_IDX + 4, 60,
+				      ptr->com.data) + 4;
+
+		/* setup misc. data for compression (target code sizes) */
+
+		/* size of compressed code to reach without header data */
+		sum = ptr->real_code_vol - sum;
+		bitcnt = sum << 3;	/* need the size in bits */
+
+		tmp = bitcnt >> 16;
+		dprintk(3,
+			"%s: code: csize=%d, tot=%d, bit=%ld, highbits=%ld\n",
+			ptr->name, sum, ptr->real_code_vol, bitcnt, tmp);
+		zr36060_write(ptr, ZR060_TCV_NET_HI, tmp >> 8);
+		zr36060_write(ptr, ZR060_TCV_NET_MH, tmp & 0xff);
+		tmp = bitcnt & 0xffff;
+		zr36060_write(ptr, ZR060_TCV_NET_ML, tmp >> 8);
+		zr36060_write(ptr, ZR060_TCV_NET_LO, tmp & 0xff);
+
+		bitcnt -= bitcnt >> 7;	// bits without stuffing
+		bitcnt -= ((bitcnt * 5) >> 6);	// bits without eob
+
+		tmp = bitcnt >> 16;
+		dprintk(3, "%s: code: nettobit=%ld, highnettobits=%ld\n",
+			ptr->name, bitcnt, tmp);
+		zr36060_write(ptr, ZR060_TCV_DATA_HI, tmp >> 8);
+		zr36060_write(ptr, ZR060_TCV_DATA_MH, tmp & 0xff);
+		tmp = bitcnt & 0xffff;
+		zr36060_write(ptr, ZR060_TCV_DATA_ML, tmp >> 8);
+		zr36060_write(ptr, ZR060_TCV_DATA_LO, tmp & 0xff);
+
+		/* JPEG markers to be included in the compressed stream */
+		zr36060_write(ptr, ZR060_MER,
+			      ZR060_MER_DQT | ZR060_MER_DHT |
+			      ((ptr->com.len > 0) ? ZR060_MER_Com : 0) |
+			      ((ptr->app.len > 0) ? ZR060_MER_App : 0));
+
+		/* Setup the Video Frontend */
+		/* Limit pixel range to 16..235 as per CCIR-601 */
+		zr36060_write(ptr, ZR060_VCR, ZR060_VCR_Range);
+
+	} else {
+		dprintk(2, "%s: EXPANSION SETUP\n", ptr->name);
+
+		zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SyncRst);
+
+		/* 060 communicates with 067 in master mode */
+		zr36060_write(ptr, ZR060_CIR, ZR060_CIR_CodeMstr);
+
+		/* Decompression */
+		zr36060_write(ptr, ZR060_CMR, 0);
+
+		/* Must be zero */
+		zr36060_write(ptr, ZR060_MBZ, 0x00);
+		zr36060_write(ptr, ZR060_TCR_HI, 0x00);
+		zr36060_write(ptr, ZR060_TCR_LO, 0x00);
+
+		/* Disable all IRQs - no DataErr means autoreset */
+		zr36060_write(ptr, ZR060_IMR, 0);
+
+		/* setup misc. data for expansion */
+		zr36060_write(ptr, ZR060_MER, 0);
+
+		/* setup the fixed jpeg tables - maybe variable, though -
+		 * (see table init section above) */
+		zr36060_pushit(ptr, ZR060_DHT_IDX, sizeof(zr36060_dht),
+			       zr36060_dht);
+
+		/* Setup the Video Frontend */
+		//zr36060_write(ptr, ZR060_VCR, ZR060_VCR_FIExt);
+		//this doesn't seem right and doesn't work...
+		zr36060_write(ptr, ZR060_VCR, ZR060_VCR_Range);
+	}
+
+	/* Load the tables */
+	zr36060_write(ptr, ZR060_LOAD,
+		      ZR060_LOAD_SyncRst | ZR060_LOAD_Load);
+	zr36060_wait_end(ptr);
+	dprintk(2, "%s: Status after table preload: 0x%02x\n", ptr->name,
+		ptr->status);
+
+	if (ptr->status & ZR060_CFSR_Busy) {
+		dprintk(1, KERN_ERR "%s: init aborted!\n", ptr->name);
+		return;		// something is wrong, its timed out!!!!
+	}
+}
+
+/* =========================================================================
+   CODEC API FUNCTIONS
+
+   this functions are accessed by the master via the API structure
+   ========================================================================= */
+
+/* set compression/expansion mode and launches codec -
+   this should be the last call from the master before starting processing */
+static int
+zr36060_set_mode (struct videocodec *codec,
+		  int                mode)
+{
+	struct zr36060 *ptr = (struct zr36060 *) codec->data;
+
+	dprintk(2, "%s: set_mode %d call\n", ptr->name, mode);
+
+	if ((mode != CODEC_DO_EXPANSION) && (mode != CODEC_DO_COMPRESSION))
+		return -EINVAL;
+
+	ptr->mode = mode;
+	zr36060_init(ptr);
+
+	return 0;
+}
+
+/* set picture size (norm is ignored as the codec doesn't know about it) */
+static int
+zr36060_set_video (struct videocodec   *codec,
+		   struct tvnorm       *norm,
+		   struct vfe_settings *cap,
+		   struct vfe_polarity *pol)
+{
+	struct zr36060 *ptr = (struct zr36060 *) codec->data;
+	u32 reg;
+	int size;
+
+	dprintk(2, "%s: set_video %d/%d-%dx%d (%%%d) call\n", ptr->name,
+		cap->x, cap->y, cap->width, cap->height, cap->decimation);
+
+	/* if () return -EINVAL;
+	 * trust the master driver that it knows what it does - so
+	 * we allow invalid startx/y and norm for now ... */
+	ptr->width = cap->width / (cap->decimation & 0xff);
+	ptr->height = cap->height / (cap->decimation >> 8);
+
+	zr36060_write(ptr, ZR060_LOAD, ZR060_LOAD_SyncRst);
+
+	/* Note that VSPol/HSPol bits in zr36060 have the opposite
+	 * meaning of their zr360x7 counterparts with the same names
+	 * N.b. for VSPol this is only true if FIVEdge = 0 (default,
+	 * left unchanged here - in accordance with datasheet).
+	*/
+	reg = (!pol->vsync_pol ? ZR060_VPR_VSPol : 0)
+	    | (!pol->hsync_pol ? ZR060_VPR_HSPol : 0)
+	    | (pol->field_pol ? ZR060_VPR_FIPol : 0)
+	    | (pol->blank_pol ? ZR060_VPR_BLPol : 0)
+	    | (pol->subimg_pol ? ZR060_VPR_SImgPol : 0)
+	    | (pol->poe_pol ? ZR060_VPR_PoePol : 0)
+	    | (pol->pvalid_pol ? ZR060_VPR_PValPol : 0)
+	    | (pol->vclk_pol ? ZR060_VPR_VCLKPol : 0);
+	zr36060_write(ptr, ZR060_VPR, reg);
+
+	reg = 0;
+	switch (cap->decimation & 0xff) {
+	default:
+	case 1:
+		break;
+
+	case 2:
+		reg |= ZR060_SR_HScale2;
+		break;
+
+	case 4:
+		reg |= ZR060_SR_HScale4;
+		break;
+	}
+
+	switch (cap->decimation >> 8) {
+	default:
+	case 1:
+		break;
+
+	case 2:
+		reg |= ZR060_SR_VScale;
+		break;
+	}
+	zr36060_write(ptr, ZR060_SR, reg);
+
+	zr36060_write(ptr, ZR060_BCR_Y, 0x00);
+	zr36060_write(ptr, ZR060_BCR_U, 0x80);
+	zr36060_write(ptr, ZR060_BCR_V, 0x80);
+
+	/* sync generator */
+
+	reg = norm->Ht - 1;	/* Vtotal */
+	zr36060_write(ptr, ZR060_SGR_VTOTAL_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SGR_VTOTAL_LO, (reg >> 0) & 0xff);
+
+	reg = norm->Wt - 1;	/* Htotal */
+	zr36060_write(ptr, ZR060_SGR_HTOTAL_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SGR_HTOTAL_LO, (reg >> 0) & 0xff);
+
+	reg = 6 - 1;		/* VsyncSize */
+	zr36060_write(ptr, ZR060_SGR_VSYNC, reg);
+
+	//reg   = 30 - 1;               /* HsyncSize */
+///*CP*/        reg = (zr->params.norm == 1 ? 57 : 68);
+	reg = 68;
+	zr36060_write(ptr, ZR060_SGR_HSYNC, reg);
+
+	reg = norm->VStart - 1;	/* BVstart */
+	zr36060_write(ptr, ZR060_SGR_BVSTART, reg);
+
+	reg += norm->Ha / 2;	/* BVend */
+	zr36060_write(ptr, ZR060_SGR_BVEND_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SGR_BVEND_LO, (reg >> 0) & 0xff);
+
+	reg = norm->HStart - 1;	/* BHstart */
+	zr36060_write(ptr, ZR060_SGR_BHSTART, reg);
+
+	reg += norm->Wa;	/* BHend */
+	zr36060_write(ptr, ZR060_SGR_BHEND_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SGR_BHEND_LO, (reg >> 0) & 0xff);
+
+	/* active area */
+	reg = cap->y + norm->VStart;	/* Vstart */
+	zr36060_write(ptr, ZR060_AAR_VSTART_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_AAR_VSTART_LO, (reg >> 0) & 0xff);
+
+	reg += cap->height;	/* Vend */
+	zr36060_write(ptr, ZR060_AAR_VEND_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_AAR_VEND_LO, (reg >> 0) & 0xff);
+
+	reg = cap->x + norm->HStart;	/* Hstart */
+	zr36060_write(ptr, ZR060_AAR_HSTART_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_AAR_HSTART_LO, (reg >> 0) & 0xff);
+
+	reg += cap->width;	/* Hend */
+	zr36060_write(ptr, ZR060_AAR_HEND_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_AAR_HEND_LO, (reg >> 0) & 0xff);
+
+	/* subimage area */
+	reg = norm->VStart - 4;	/* SVstart */
+	zr36060_write(ptr, ZR060_SWR_VSTART_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SWR_VSTART_LO, (reg >> 0) & 0xff);
+
+	reg += norm->Ha / 2 + 8;	/* SVend */
+	zr36060_write(ptr, ZR060_SWR_VEND_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SWR_VEND_LO, (reg >> 0) & 0xff);
+
+	reg = norm->HStart /*+ 64 */  - 4;	/* SHstart */
+	zr36060_write(ptr, ZR060_SWR_HSTART_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SWR_HSTART_LO, (reg >> 0) & 0xff);
+
+	reg += norm->Wa + 8;	/* SHend */
+	zr36060_write(ptr, ZR060_SWR_HEND_HI, (reg >> 8) & 0xff);
+	zr36060_write(ptr, ZR060_SWR_HEND_LO, (reg >> 0) & 0xff);
+
+	size = ptr->width * ptr->height;
+	/* Target compressed field size in bits: */
+	size = size * 16;	/* uncompressed size in bits */
+	/* (Ronald) by default, quality = 100 is a compression
+	 * ratio 1:2. Setting low_bitrate (insmod option) sets
+	 * it to 1:4 (instead of 1:2, zr36060 max) as limit because the
+	 * buz can't handle more at decimation=1... Use low_bitrate if
+	 * you have a Buz, unless you know what you're doing */
+	size = size * cap->quality / (low_bitrate ? 400 : 200);
+	/* Lower limit (arbitrary, 1 KB) */
+	if (size < 8192)
+		size = 8192;
+	/* Upper limit: 7/8 of the code buffers */
+	if (size > ptr->total_code_vol * 7)
+		size = ptr->total_code_vol * 7;
+
+	ptr->real_code_vol = size >> 3;	/* in bytes */
+
+	/* the MBCVR is the *maximum* block volume, according to the
+	 * JPEG ISO specs, this shouldn't be used, since that allows
+	 * for the best encoding quality. So set it to it's max value */
+	reg = ptr->max_block_vol;
+	zr36060_write(ptr, ZR060_MBCVR, reg);
+
+	return 0;
+}
+
+/* additional control functions */
+static int
+zr36060_control (struct videocodec *codec,
+		 int                type,
+		 int                size,
+		 void              *data)
+{
+	struct zr36060 *ptr = (struct zr36060 *) codec->data;
+	int *ival = (int *) data;
+
+	dprintk(2, "%s: control %d call with %d byte\n", ptr->name, type,
+		size);
+
+	switch (type) {
+	case CODEC_G_STATUS:	/* get last status */
+		if (size != sizeof(int))
+			return -EFAULT;
+		zr36060_read_status(ptr);
+		*ival = ptr->status;
+		break;
+
+	case CODEC_G_CODEC_MODE:
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = CODEC_MODE_BJPG;
+		break;
+
+	case CODEC_S_CODEC_MODE:
+		if (size != sizeof(int))
+			return -EFAULT;
+		if (*ival != CODEC_MODE_BJPG)
+			return -EINVAL;
+		/* not needed, do nothing */
+		return 0;
+
+	case CODEC_G_VFE:
+	case CODEC_S_VFE:
+		/* not needed, do nothing */
+		return 0;
+
+	case CODEC_S_MMAP:
+		/* not available, give an error */
+		return -ENXIO;
+
+	case CODEC_G_JPEG_TDS_BYTE:	/* get target volume in byte */
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = ptr->total_code_vol;
+		break;
+
+	case CODEC_S_JPEG_TDS_BYTE:	/* get target volume in byte */
+		if (size != sizeof(int))
+			return -EFAULT;
+		ptr->total_code_vol = *ival;
+		ptr->real_code_vol = (ptr->total_code_vol * 6) >> 3;
+		break;
+
+	case CODEC_G_JPEG_SCALE:	/* get scaling factor */
+		if (size != sizeof(int))
+			return -EFAULT;
+		*ival = zr36060_read_scalefactor(ptr);
+		break;
+
+	case CODEC_S_JPEG_SCALE:	/* set scaling factor */
+		if (size != sizeof(int))
+			return -EFAULT;
+		ptr->scalefact = *ival;
+		break;
+
+	case CODEC_G_JPEG_APP_DATA: {	/* get appn marker data */
+		struct jpeg_app_marker *app = data;
+
+		if (size != sizeof(struct jpeg_app_marker))
+			return -EFAULT;
+
+		*app = ptr->app;
+		break;
+	}
+
+	case CODEC_S_JPEG_APP_DATA: {	/* set appn marker data */
+		struct jpeg_app_marker *app = data;
+
+		if (size != sizeof(struct jpeg_app_marker))
+			return -EFAULT;
+
+		ptr->app = *app;
+		break;
+	}
+
+	case CODEC_G_JPEG_COM_DATA: {	/* get comment marker data */
+		struct jpeg_com_marker *com = data;
+
+		if (size != sizeof(struct jpeg_com_marker))
+			return -EFAULT;
+
+		*com = ptr->com;
+		break;
+	}
+
+	case CODEC_S_JPEG_COM_DATA: {	/* set comment marker data */
+		struct jpeg_com_marker *com = data;
+
+		if (size != sizeof(struct jpeg_com_marker))
+			return -EFAULT;
+
+		ptr->com = *com;
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+
+	return size;
+}
+
+/* =========================================================================
+   Exit and unregister function:
+
+   Deinitializes Zoran's JPEG processor
+   ========================================================================= */
+
+static int
+zr36060_unset (struct videocodec *codec)
+{
+	struct zr36060 *ptr = codec->data;
+
+	if (ptr) {
+		/* do wee need some codec deinit here, too ???? */
+
+		dprintk(1, "%s: finished codec #%d\n", ptr->name,
+			ptr->num);
+		kfree(ptr);
+		codec->data = NULL;
+
+		zr36060_codecs--;
+		return 0;
+	}
+
+	return -EFAULT;
+}
+
+/* =========================================================================
+   Setup and registry function:
+
+   Initializes Zoran's JPEG processor
+
+   Also sets pixel size, average code size, mode (compr./decompr.)
+   (the given size is determined by the processor with the video interface)
+   ========================================================================= */
+
+static int
+zr36060_setup (struct videocodec *codec)
+{
+	struct zr36060 *ptr;
+	int res;
+
+	dprintk(2, "zr36060: initializing MJPEG subsystem #%d.\n",
+		zr36060_codecs);
+
+	if (zr36060_codecs == MAX_CODECS) {
+		dprintk(1,
+			KERN_ERR "zr36060: Can't attach more codecs!\n");
+		return -ENOSPC;
+	}
+	//mem structure init
+	codec->data = ptr = kzalloc(sizeof(struct zr36060), GFP_KERNEL);
+	if (NULL == ptr) {
+		dprintk(1, KERN_ERR "zr36060: Can't get enough memory!\n");
+		return -ENOMEM;
+	}
+
+	snprintf(ptr->name, sizeof(ptr->name), "zr36060[%d]",
+		 zr36060_codecs);
+	ptr->num = zr36060_codecs++;
+	ptr->codec = codec;
+
+	//testing
+	res = zr36060_basic_test(ptr);
+	if (res < 0) {
+		zr36060_unset(codec);
+		return res;
+	}
+	//final setup
+	memcpy(ptr->h_samp_ratio, zr36060_decimation_h, 8);
+	memcpy(ptr->v_samp_ratio, zr36060_decimation_v, 8);
+
+	ptr->bitrate_ctrl = 0;	/* 0 or 1 - fixed file size flag
+				 * (what is the difference?) */
+	ptr->mode = CODEC_DO_COMPRESSION;
+	ptr->width = 384;
+	ptr->height = 288;
+	ptr->total_code_vol = 16000;	/* CHECKME */
+	ptr->real_code_vol = (ptr->total_code_vol * 6) >> 3;
+	ptr->max_block_vol = 240;	/* CHECKME, was 120 is 240 */
+	ptr->scalefact = 0x100;
+	ptr->dri = 1;		/* CHECKME, was 8 is 1 */
+
+	/* by default, no COM or APP markers - app should set those */
+	ptr->com.len = 0;
+	ptr->app.appn = 0;
+	ptr->app.len = 0;
+
+	zr36060_init(ptr);
+
+	dprintk(1, KERN_INFO "%s: codec attached and running\n",
+		ptr->name);
+
+	return 0;
+}
+
+static const struct videocodec zr36060_codec = {
+	.owner = THIS_MODULE,
+	.name = "zr36060",
+	.magic = 0L,		// magic not used
+	.flags =
+	    CODEC_FLAG_JPEG | CODEC_FLAG_HARDWARE | CODEC_FLAG_ENCODER |
+	    CODEC_FLAG_DECODER | CODEC_FLAG_VFE,
+	.type = CODEC_TYPE_ZR36060,
+	.setup = zr36060_setup,	// functionality
+	.unset = zr36060_unset,
+	.set_mode = zr36060_set_mode,
+	.set_video = zr36060_set_video,
+	.control = zr36060_control,
+	// others are not used
+};
+
+/* =========================================================================
+   HOOK IN DRIVER AS KERNEL MODULE
+   ========================================================================= */
+
+static int __init
+zr36060_init_module (void)
+{
+	//dprintk(1, "zr36060 driver %s\n",ZR060_VERSION);
+	zr36060_codecs = 0;
+	return videocodec_register(&zr36060_codec);
+}
+
+static void __exit
+zr36060_cleanup_module (void)
+{
+	if (zr36060_codecs) {
+		dprintk(1,
+			"zr36060: something's wrong - %d codecs left somehow.\n",
+			zr36060_codecs);
+	}
+
+	/* however, we can't just stay alive */
+	videocodec_unregister(&zr36060_codec);
+}
+
+module_init(zr36060_init_module);
+module_exit(zr36060_cleanup_module);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@skynet.be>");
+MODULE_DESCRIPTION("Driver module for ZR36060 jpeg processors "
+		   ZR060_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/media/zoran/zr36060.h b/drivers/staging/media/zoran/zr36060.h
new file mode 100644
index 000000000000..82911757ba78
--- /dev/null
+++ b/drivers/staging/media/zoran/zr36060.h
@@ -0,0 +1,216 @@
+/*
+ * Zoran ZR36060 basic configuration functions - header file
+ *
+ * Copyright (C) 2002 Laurent Pinchart <laurent.pinchart@skynet.be>
+ *
+ * $Id: zr36060.h,v 1.1.1.1.2.3 2003/01/14 21:18:47 rbultje Exp $
+ *
+ * ------------------------------------------------------------------------
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * ------------------------------------------------------------------------
+ */
+
+#ifndef ZR36060_H
+#define ZR36060_H
+
+#include "videocodec.h"
+
+/* data stored for each zoran jpeg codec chip */
+struct zr36060 {
+	char name[32];
+	int num;
+	/* io datastructure */
+	struct videocodec *codec;
+	// last coder status
+	__u8 status;
+	// actual coder setup
+	int mode;
+
+	__u16 width;
+	__u16 height;
+
+	__u16 bitrate_ctrl;
+
+	__u32 total_code_vol;
+	__u32 real_code_vol;
+	__u16 max_block_vol;
+
+	__u8 h_samp_ratio[8];
+	__u8 v_samp_ratio[8];
+	__u16 scalefact;
+	__u16 dri;
+
+	/* app/com marker data */
+	struct jpeg_app_marker app;
+	struct jpeg_com_marker com;
+};
+
+/* ZR36060 register addresses */
+#define ZR060_LOAD			0x000
+#define ZR060_CFSR			0x001
+#define ZR060_CIR			0x002
+#define ZR060_CMR			0x003
+#define ZR060_MBZ			0x004
+#define ZR060_MBCVR			0x005
+#define ZR060_MER			0x006
+#define ZR060_IMR			0x007
+#define ZR060_ISR			0x008
+#define ZR060_TCV_NET_HI		0x009
+#define ZR060_TCV_NET_MH		0x00a
+#define ZR060_TCV_NET_ML		0x00b
+#define ZR060_TCV_NET_LO		0x00c
+#define ZR060_TCV_DATA_HI		0x00d
+#define ZR060_TCV_DATA_MH		0x00e
+#define ZR060_TCV_DATA_ML		0x00f
+#define ZR060_TCV_DATA_LO		0x010
+#define ZR060_SF_HI			0x011
+#define ZR060_SF_LO			0x012
+#define ZR060_AF_HI			0x013
+#define ZR060_AF_M			0x014
+#define ZR060_AF_LO			0x015
+#define ZR060_ACV_HI			0x016
+#define ZR060_ACV_MH			0x017
+#define ZR060_ACV_ML			0x018
+#define ZR060_ACV_LO			0x019
+#define ZR060_ACT_HI			0x01a
+#define ZR060_ACT_MH			0x01b
+#define ZR060_ACT_ML			0x01c
+#define ZR060_ACT_LO			0x01d
+#define ZR060_ACV_TRUN_HI		0x01e
+#define ZR060_ACV_TRUN_MH		0x01f
+#define ZR060_ACV_TRUN_ML		0x020
+#define ZR060_ACV_TRUN_LO		0x021
+#define ZR060_IDR_DEV			0x022
+#define ZR060_IDR_REV			0x023
+#define ZR060_TCR_HI			0x024
+#define ZR060_TCR_LO			0x025
+#define ZR060_VCR			0x030
+#define ZR060_VPR			0x031
+#define ZR060_SR			0x032
+#define ZR060_BCR_Y			0x033
+#define ZR060_BCR_U			0x034
+#define ZR060_BCR_V			0x035
+#define ZR060_SGR_VTOTAL_HI		0x036
+#define ZR060_SGR_VTOTAL_LO		0x037
+#define ZR060_SGR_HTOTAL_HI		0x038
+#define ZR060_SGR_HTOTAL_LO		0x039
+#define ZR060_SGR_VSYNC			0x03a
+#define ZR060_SGR_HSYNC			0x03b
+#define ZR060_SGR_BVSTART		0x03c
+#define ZR060_SGR_BHSTART		0x03d
+#define ZR060_SGR_BVEND_HI		0x03e
+#define ZR060_SGR_BVEND_LO		0x03f
+#define ZR060_SGR_BHEND_HI		0x040
+#define ZR060_SGR_BHEND_LO		0x041
+#define ZR060_AAR_VSTART_HI		0x042
+#define ZR060_AAR_VSTART_LO		0x043
+#define ZR060_AAR_VEND_HI		0x044
+#define ZR060_AAR_VEND_LO		0x045
+#define ZR060_AAR_HSTART_HI		0x046
+#define ZR060_AAR_HSTART_LO		0x047
+#define ZR060_AAR_HEND_HI		0x048
+#define ZR060_AAR_HEND_LO		0x049
+#define ZR060_SWR_VSTART_HI		0x04a
+#define ZR060_SWR_VSTART_LO		0x04b
+#define ZR060_SWR_VEND_HI		0x04c
+#define ZR060_SWR_VEND_LO		0x04d
+#define ZR060_SWR_HSTART_HI		0x04e
+#define ZR060_SWR_HSTART_LO		0x04f
+#define ZR060_SWR_HEND_HI		0x050
+#define ZR060_SWR_HEND_LO		0x051
+
+#define ZR060_SOF_IDX			0x060
+#define ZR060_SOS_IDX			0x07a
+#define ZR060_DRI_IDX			0x0c0
+#define ZR060_DQT_IDX			0x0cc
+#define ZR060_DHT_IDX			0x1d4
+#define ZR060_APP_IDX			0x380
+#define ZR060_COM_IDX			0x3c0
+
+/* ZR36060 LOAD register bits */
+
+#define ZR060_LOAD_Load			(1 << 7)
+#define ZR060_LOAD_SyncRst		(1 << 0)
+
+/* ZR36060 Code FIFO Status register bits */
+
+#define ZR060_CFSR_Busy			(1 << 7)
+#define ZR060_CFSR_CBusy		(1 << 2)
+#define ZR060_CFSR_CFIFO		(3 << 0)
+
+/* ZR36060 Code Interface register */
+
+#define ZR060_CIR_Code16		(1 << 7)
+#define ZR060_CIR_Endian		(1 << 6)
+#define ZR060_CIR_CFIS			(1 << 2)
+#define ZR060_CIR_CodeMstr		(1 << 0)
+
+/* ZR36060 Codec Mode register */
+
+#define ZR060_CMR_Comp			(1 << 7)
+#define ZR060_CMR_ATP			(1 << 6)
+#define ZR060_CMR_Pass2			(1 << 5)
+#define ZR060_CMR_TLM			(1 << 4)
+#define ZR060_CMR_BRB			(1 << 2)
+#define ZR060_CMR_FSF			(1 << 1)
+
+/* ZR36060 Markers Enable register */
+
+#define ZR060_MER_App			(1 << 7)
+#define ZR060_MER_Com			(1 << 6)
+#define ZR060_MER_DRI			(1 << 5)
+#define ZR060_MER_DQT			(1 << 4)
+#define ZR060_MER_DHT			(1 << 3)
+
+/* ZR36060 Interrupt Mask register */
+
+#define ZR060_IMR_EOAV			(1 << 3)
+#define ZR060_IMR_EOI			(1 << 2)
+#define ZR060_IMR_End			(1 << 1)
+#define ZR060_IMR_DataErr		(1 << 0)
+
+/* ZR36060 Interrupt Status register */
+
+#define ZR060_ISR_ProCnt		(3 << 6)
+#define ZR060_ISR_EOAV			(1 << 3)
+#define ZR060_ISR_EOI			(1 << 2)
+#define ZR060_ISR_End			(1 << 1)
+#define ZR060_ISR_DataErr		(1 << 0)
+
+/* ZR36060 Video Control register */
+
+#define ZR060_VCR_Video8		(1 << 7)
+#define ZR060_VCR_Range			(1 << 6)
+#define ZR060_VCR_FIDet			(1 << 3)
+#define ZR060_VCR_FIVedge		(1 << 2)
+#define ZR060_VCR_FIExt			(1 << 1)
+#define ZR060_VCR_SyncMstr		(1 << 0)
+
+/* ZR36060 Video Polarity register */
+
+#define ZR060_VPR_VCLKPol		(1 << 7)
+#define ZR060_VPR_PValPol		(1 << 6)
+#define ZR060_VPR_PoePol		(1 << 5)
+#define ZR060_VPR_SImgPol		(1 << 4)
+#define ZR060_VPR_BLPol			(1 << 3)
+#define ZR060_VPR_FIPol			(1 << 2)
+#define ZR060_VPR_HSPol			(1 << 1)
+#define ZR060_VPR_VSPol			(1 << 0)
+
+/* ZR36060 Scaling register */
+
+#define ZR060_SR_VScale			(1 << 2)
+#define ZR060_SR_HScale2		(1 << 0)
+#define ZR060_SR_HScale4		(2 << 0)
+
+#endif				/*fndef ZR36060_H */
-- 
2.26.2

