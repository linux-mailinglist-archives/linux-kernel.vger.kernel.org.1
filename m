Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04A275CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWQJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIWQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:09:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:09:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so662017wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3P/ZxpNJo4PSk7Ep/fF4Gu3Oz1IinM7von/Sj/dKjYs=;
        b=Q+a+88KMJKfYyJmtJGcC9p67yACHUBTsddpjNbsAYg17ZlcFjmZBgsM1kpms9i98B4
         gX6157evJeTYbkQkd+iptaTFKMlByOsDAQlbXJDzGYIP2Y27QcHK6Calx+erxYT3IK0i
         +y/lRvHxs7Krm6szOxn+4/eMtbKpIHNcH8ba+TJs7xAnzqjtnUgKoRm7r0mQStyUX+vc
         DI0tVnSCzUtlu6Dd24+QThRIX5OtVImQ/FlUfkwcuVbWkdFhCLPlj1i7WsdhKA8umn/X
         AZnjE2qh6yjrAGrGdOlESpYn8E857i/1oudG8pz/KUPcKPsakRlyAmOzaU8HfDizuoNJ
         FxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3P/ZxpNJo4PSk7Ep/fF4Gu3Oz1IinM7von/Sj/dKjYs=;
        b=DGptIEWJbFXf+TmZCTk2A31T7gLdRJ08I59wB9DF4LPLfuwXwHJukACaL7KX57gG5j
         iCicsXL5Vw2L21lMJkqdNVfXX54RiKf7HiqFdsTbpIfLyhvC14ErLWknQ9VrmZstMQiy
         O8jfuAWNLKyYwtMfAW1rByybOCIIX5dk0gPQrggyjfirpyCbbuBg8RM9x+rlhK/x3gdF
         R9/PwAq6Yz3SXCnqkdnJLx5679EVByTOCSEgdB5wmM2XYA4bc3MKygkMNafKwj2lrWM+
         o3PZit+H9QEFUsbRTX/FAP3IkVdt2nY14pb5KB0JJmMnXaVFFLRvRqQD4VR7dQRID96G
         lhEA==
X-Gm-Message-State: AOAM532sAjPiKL+h+X6v6oiYkuGbSebl2ql69p41ex/36/30WzqEGB/E
        Z7KMv4dsHo/Oo2HK2iDx7WXrLA==
X-Google-Smtp-Source: ABdhPJxJa9JbXjuoS6k/d1Yja3vveIuq2rji2Ep/SXUrtBlo3aF/ie479LMXzqBqWUPuJ/CEn96+RQ==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr378893wro.69.1600877356110;
        Wed, 23 Sep 2020 09:09:16 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:28ac:1772:9398:891a])
        by smtp.gmail.com with ESMTPSA id c79sm249769wmd.41.2020.09.23.09.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 09:09:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linux-media@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: remove Maxime Jourdan as maintainer of Amlogic VDEC
Date:   Wed, 23 Sep 2020 18:09:10 +0200
Message-Id: <20200923160910.31968-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime is no more a BayLibre employee, and his e-mail address is now invalid.

I'll be happy to add him back using another e-mail address if he wants to continue
maintaining this driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d3126fc2cca2..7364ac24ad6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11320,7 +11320,6 @@ F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 F:	drivers/mtd/nand/raw/meson_*
 
 MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
-M:	Maxime Jourdan <mjourdan@baylibre.com>
 M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-media@vger.kernel.org
 L:	linux-amlogic@lists.infradead.org
-- 
2.22.0

