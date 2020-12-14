Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E599B2DA3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441310AbgLNXAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgLNW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:59:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A00C0613D6;
        Mon, 14 Dec 2020 14:59:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c133so3214244wme.4;
        Mon, 14 Dec 2020 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ucI5AYNdCzRR42JyUXlxwEuGOQwsKsN1A0Pzs97M1s=;
        b=Bc7Usamt8/YLx04epsjCcfI2Z0IKsTXKO/bu3daoYbC0Sq7tzMihmayGb6Jc9P0qlH
         hrCJ1JezTZou1AD3lnLtWUStZ7nAVHQkCMsmPtZLWiRjKEanBpHqFTvxNRT4L+4q3AQR
         gEWG3qQ2ia3J1tbQySRQdXAU6is5sRm2JcpdN9zpAJYkHLHMVBcnQbj+RyUPZ4u7hGYA
         boseZfG+JBpIu687QQ78KmF1L+OzvEALRhLH/BU161E50x2/+LVaHa/WTERQtm6oNsD9
         L/36F/YBxXzckgy6IGmCL2aF8166dpcK8qi46UjOpKmZEFYbaLhF2KZqfs1nEDIqD1Su
         EZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ucI5AYNdCzRR42JyUXlxwEuGOQwsKsN1A0Pzs97M1s=;
        b=kP4xXRN0V9LJWjXPuJF/vubOD1AkeimAJPfy34rCEnOFpnZhbZ3ajp408auz89pLgz
         TupcZwjf6J8G2kXR/fGFvmv/UJvRnxCwc7X8cJQ7aSszIIhN95rbhZHaqMpHs0q4GXKS
         gfqnZNk0b2cM+w5KPae5jwuVAn20wydGuI2QVnmVQLYoUO3X0uM0W3WXnia2FMTQfDtJ
         KBtO4YJuFmHwlExJxIcIQONlmNSSH29CUGuO2uJ8wmAjdSnWXbi59HiA3LYS9/2DLOM7
         bEbEowC+dSRfysRcN/ga+rOdA10q6872XQWUQdrQN/ClRzAJjXuC59xlaPDI2sML2ANt
         hxlg==
X-Gm-Message-State: AOAM530hFOOTscVpVAXEy+1a94q9TmUBy/pyHf4M+ptr4vsUkQPfx6Gt
        dGr9gpb3jj4aasgm9JyVHuQ=
X-Google-Smtp-Source: ABdhPJyWz6LSqwWJELdrb0jfEDJQfcQnmR9g4oRwCmR1PW5j1OE7faHoJnRu2oaR9VY5xVZm2Iv/ag==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr30122223wmi.35.1607986748065;
        Mon, 14 Dec 2020 14:59:08 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id k11sm33091857wmj.42.2020.12.14.14.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:59:07 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 0/2] Add support of nxp pf8x00 regulator
Date:   Mon, 14 Dec 2020 23:58:49 +0100
Message-Id: <20201214225851.23342-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this set of patch intends to add the support of the pf8x00 PMIC
regulators. This family of PMIC contains 12 regulators (7 bucks
converters, 4 LDO, 1 RTC supply). All these 12 regulators are
configurable via an OTP memory and by i2c at runtime for some
specific properties.

1: Adds the dt-binding corresponding to the new driver;
2: Adds the driver itself. 

This is th 3rd version of the patch set. In this version I fixed:
  - Bad default values were described in the description;
  - The configuration is now done at parsing time;
  - The code doesn't attempt to parse the regulator properties;
  - Remove the unnecessary new "nxp,illim-microamp" property;
  - Use the "regulator-max-microamp" of the regulator instead;
  - Cut the code in multiple function to obtain a better readability.
  - Rework some code part;

Thanks,

Adrien Grassein (2):
  dt-bindings: regulator: add pf8x00 PMIC
  regulator: pf8x00: add support of nxp pf8x00 regulator

 .../regulator/nxp,pf8x00-regulator.yaml       | 220 +++++
 MAINTAINERS                                   |   7 +
 drivers/regulator/Kconfig                     |  12 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/pf8x00-regulator.c          | 798 ++++++++++++++++++
 5 files changed, 1038 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
 create mode 100644 drivers/regulator/pf8x00-regulator.c

-- 
2.20.1

