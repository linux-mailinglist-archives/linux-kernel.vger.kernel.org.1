Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924F92ECE26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbhAGKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:50:04 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB134C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:49:23 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v19so4548376pgj.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHuzJX3AXMDyR6q3I0Hp62ensb6x58xwS1/Acc8orx4=;
        b=ixT3pGH/0DXIroqi6tiSTr5sWzG5Iei4XLapjaZ+piLGLPbsnkkOIFu4h1K/bDrWw4
         1BD70hpC7J7IMlAQQlgAFucYkfptwu84CbbdQ62bth3y9ceK0oYxOF2s0XCLwp2FbIB5
         sPrsVrz183b0a8zzev0uZO8x/gHlvTbfYT66Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fHuzJX3AXMDyR6q3I0Hp62ensb6x58xwS1/Acc8orx4=;
        b=V+bI7rL5PMhJAc1Pg4NrGbYlg+rsKtd5Cv2RJ4zB9Z6N3B32QPwIoMwYVQzDzOrpZW
         ku6EERURY4EJqquFq+A/lTbVO4FywjRACzkY5O9CIqoGJa0C0xOWjumOvp8IhAoBVFRJ
         yis7Rkg4O9WuezIiOryhO19+FMkW/dtv25kx6hJN8SIt4qdW/JzzLSDyytVFLPM4Pak5
         wlQSAkIpoeRX0pE71HMidG4N6B+CvYmF/i9ikAnSMVfhBZkzkBFGlE9ap4gIlupJ412m
         69iwhp1p2G+NToQ7K6cMLYoM7Ik3lRhZLx3H5i40a8rWjUO9bqoxuvwaSewCu1wCwKAL
         kyBw==
X-Gm-Message-State: AOAM531chI1HcU++r3iXeioNSR370jNb592Car53GSXeXY/cot9IIGD2
        sZBJ3X3ujll21hEQSCpEn6zslQ==
X-Google-Smtp-Source: ABdhPJx7bXQ1sTDWZrRM55QgfTlZnWkr93l8D9TzllVk/mmwNj/Wmaw0FUNbVpOLrfiWKTlbg+EWMw==
X-Received: by 2002:a63:f111:: with SMTP id f17mr1255707pgi.287.1610016563437;
        Thu, 07 Jan 2021 02:49:23 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id n10sm5381974pfu.176.2021.01.07.02.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:49:22 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] Add domain supply for mtk power domains
Date:   Thu,  7 Jan 2021 18:49:12 +0800
Message-Id: <20210107104915.2888408-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some power domains (eg. mfg on mt8183) needs to turn on its domain
power supply before power on.

Otherwise readx_poll_timeout() in scpsys_power_on() would timeout.

Hsin-Yi Wang (3):
  dt-bindings: power: Add domain regulator supply
  soc: mediatek: pm-domains: Add domain regulator supply
  arm64: dts: mediatek: mt8183: Add domain supply for mfg

 .../power/mediatek,power-controller.yaml      |  9 +++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  4 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  2 +-
 drivers/soc/mediatek/mt8183-pm-domains.h      |  1 +
 drivers/soc/mediatek/mtk-pm-domains.c         | 36 ++++++++++++++++++-
 drivers/soc/mediatek/mtk-pm-domains.h         |  1 +
 6 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

