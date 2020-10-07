Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC78B2867F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgJGTCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:02:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92398C061755;
        Wed,  7 Oct 2020 12:02:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so2931279qtp.2;
        Wed, 07 Oct 2020 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MiSY8J6mDu3JaytwdQp1vhGc2vsjxotqzRzsTO3QWRE=;
        b=CqXmTlnawugmG6qE1YpW6lnTfluvSgYJBxSHZ1oNBGSTFyB10P/SMNjvkyFeGLy1Ak
         S2+ggp1gsj8q7wHdUnCBqIcNd4T19F2sHR7OkDLgcq89JsKzy+05M85HXn6koBvImIuv
         kiGTJAlAxJA04rHi9wVVTThXiz+vtFXMbYNdhvyD5+uJExU2uoSdZhnvxx2IWCdC+Zbz
         gWV9t3jmypBz9ICPuVZ6D9sgkk/kKVBPg5hg2HwndwVbLI5gA5dcDYgBget4mdNkiqmd
         jE+8QnR8RnwRW3RNBpQx1elcvBSD518kjJJ3GH0u7FIRslmm145jradvhJvcHLkqiXib
         u8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MiSY8J6mDu3JaytwdQp1vhGc2vsjxotqzRzsTO3QWRE=;
        b=rFmu6CzBHbRiQZ8D6XakyhCaTTJZEci7eKw57fkxJPiNtTYvx9dpg9lE4Dx23DDsn/
         /3+S2Jy4avLjh0cWrDRBKs/FyKjFoc5kFpy8SiJjzR95bmOh/rJ9XjFKO4WzRwPjQ/fD
         VRrtG0kCnUBWXCuw8l1mFvs41qYGmuzWHTcT/49RZoFSzkgVEKYwogk9EBM65k693BuD
         hIC8r51vWrimD4hg+fOwlHo98QjInzQy3DGnbvAa9oMmo1MZrOs4LuLx6ArhrBBhJ+bO
         tiUQoUr5a28dDjZORiDSlC1IyzZJNAxYSHa7nN64v+Cd0BHr8MFa0MuA7pVg/B9Uri7M
         MkbA==
X-Gm-Message-State: AOAM532uVuGz0c3HPQCix6vOcIN10CHxX/BawVi1ojm9dGELmra8wtTC
        Hk5vBNUzJJ93OPLzAD7H8gI=
X-Google-Smtp-Source: ABdhPJxNch6C0aT/JvwWZ3iO8uD9fla6pKSkVWtTwIiWg5yNaIGl2BcCcvq6CLYtMkQTeLfwE78LDQ==
X-Received: by 2002:ac8:3385:: with SMTP id c5mr4704558qtb.46.1602097323831;
        Wed, 07 Oct 2020 12:02:03 -0700 (PDT)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id j16sm2087078qkg.26.2020.10.07.12.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:02:03 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: dts: BCM5301X: Linksys EA9500 device tree changes
Date:   Wed,  7 Oct 2020 15:01:49 -0400
Message-Id: <cover.1601655904.git.npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Drop mmioreg mdio mux infavor of the pinmux
2. Add port5 and port7 which are connected to gmac0 & 1 respectively
3. Define fixed partitions

Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Rafał Miłecki" <zajec5@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vivek Unune <npcomplete13@gmail.com>

Vivek Unune (3):
  ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
  ARM: dts: BCM5301X: Linksys EA9500 add port 5 and port 7
  ARM: dts: BCM5301X: Linksys EA9500 add fixed partitions

 .../boot/dts/bcm47094-linksys-panamera.dts    | 216 +++++++++++-------
 arch/arm/boot/dts/bcm5301x.dtsi               |   4 +-
 2 files changed, 137 insertions(+), 83 deletions(-)

-- 
2.25.1

