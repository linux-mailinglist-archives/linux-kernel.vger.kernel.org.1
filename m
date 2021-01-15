Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38172F8717
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbhAOVCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhAOVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:02:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3429C06179A;
        Fri, 15 Jan 2021 13:01:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o10so2588494wmc.1;
        Fri, 15 Jan 2021 13:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpsAkxAkTGW0ezsZh7If/0oVx9Z3+WsvGsLBvRRdrWc=;
        b=jjvPi0uZEcgWYHHH1Iwg9GuQT/6GMtzBLf5LsqxEK3wL58k3rVUziJY1BNOvZlBYhO
         QeyCa5xrEjAGmxJ0c77EUEPx7QVVCTddR4vXjyK4loOKnh6QXpJDR2kaiMIY8Yy01GsG
         zH7LInyKLJ41L2i4NmL59fZFNl7wjmHYucm+b+A1QHdVHyjbaxK9yx49Ox9vu3qP4grX
         VH7RAlfuf60Qc1ViJEDrBZ4tcUqForCMop8XyBKQ77G3LZmfDi1ohLcqNZFAjfmWpCwq
         cy7WAOP3pKhllY353PKmBlzMOReMOSt1g/W2v/p8LEZUxEHWoyYYX6N6+Qk4QSfNV0ja
         JSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bpsAkxAkTGW0ezsZh7If/0oVx9Z3+WsvGsLBvRRdrWc=;
        b=NjHwNAtEU45VGahn5OOXI1vshlq9ceGdo3pNt7aGNUlxxv+3SdHT6tAvpoVtuJ8ThF
         BvSJCjdDv8SJKLdCY7qZnUuhzr2u+kQ7S1JXqS2Hx6Ab3iQdJEyVNSSkBAs0ehGnfWQk
         GWuPz1EauQ6UzlAeQ+A8y/1tGcmKHXd6O2S8QtiCOlL1wv89ah2XVzSeQj6IC7gV0bCC
         SqsewboZhyI2TVMs40AO1ftvyO04ZvpHfWfkdMKqOZKyR355JGwpYWlBDGIs627WbPxw
         1MjVcrgeG8mJA28j0SpqwrbmaRzBMTw4WiDL2lk8rkG0gFHUoESPN+N3eWj0EXh9QTut
         dcrA==
X-Gm-Message-State: AOAM530d4sGC72PeL42ZvOdyfVTA5GYOO+WlqFtrsQ9AHAwBWcXhMXU5
        Obi2xkkTDhw7f/WrqJbczow=
X-Google-Smtp-Source: ABdhPJzVXwlOfp+uJOID97HxREesaAtzxn9LsqMJNcoMBcPsIo3heQ/5vq8/rnAbRSFg1K6PuC0+7Q==
X-Received: by 2002:a05:600c:4ecc:: with SMTP id g12mr9119530wmq.84.1610744487428;
        Fri, 15 Jan 2021 13:01:27 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270090311bc0a820c7e4.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9031:1bc0:a820:c7e4])
        by smtp.gmail.com with ESMTPSA id l7sm13414853wme.4.2021.01.15.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:01:26 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 0/3] Add support for Boundary Nitrogen8M Mini SBC
Date:   Fri, 15 Jan 2021 22:01:21 +0100
Message-Id: <20210115210124.507282-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch set aims is to add the support of the Nitrogen8M Mini SBC
from Boundary Devices.

Thanks,

Update in v2:
  - Rewrite the dts (Remove the unused wlan and audio);
  - Remove useless definition;
  - Take in account review.

Update in v3:
  - Take in account review.

Update in v4:
  - Reorder definition in pmic

Adrien Grassein (3):
  dt-bindings: arm: imx: add imx8mm nitrogen support
  arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
  arm64: defconfig: Enable PF8x00 as builtin

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 415 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 4 files changed, 418 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

-- 
2.25.1

