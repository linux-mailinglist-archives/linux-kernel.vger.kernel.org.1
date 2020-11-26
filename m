Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895CC2C5530
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbgKZNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbgKZNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:25:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E27CC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q3so2243589edr.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9ZHaFKKBeckNSWoLOmLErLJJKCJkg2AhOu6rYTvYf4=;
        b=aJ0a/EFDWsuwakDG8ZwjFKkKT1COTMwtWrZGPTk1xnJ1PL04J0HeYF1zsOuDZGZyxo
         5zgV6/XZqZ1o9snsENEukUsMLMZyHbUrn/myrgt1IyHigwHt+34seKf7+LfWf9pTNay6
         64ozu6w076ifcoZBrQDAVJpgg1YG3s/RLCcCsPb/MkFJxhGBkH5XsDL6HRvMnlFhLIZ4
         U735GNTTEgHIjTMH3HKpTlGTaadx0esMn6KEFGPL5f6Uh43YwKWYepdaODAJG72ASooa
         b8y7m+z0De2GnUShLd8GqYO1wQ5rCTrssXdZ1G9uiOSc1ipxqFqgt+c4tdR+q0QsPOTK
         Nibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=V9ZHaFKKBeckNSWoLOmLErLJJKCJkg2AhOu6rYTvYf4=;
        b=NWFfjqF0jMmUIdl6qv/qA2IpE20v/a1AMCNCaQjPEhxnRrV0PFg0zEDl2Srtnt2xmO
         zlZULmiI9XWou392go1Qrnm+iTObfkgwdZsZRbu9OXGT24cFweYqMW3l8xQP4PRABlnT
         a8HelyOoq36kHexEDt2oMOTnRxKFfVzxyhIHe7eztUMVwyHYGzVVIMSoU/KHxigFUisH
         XU9bcGzil9s9gHVJF5TdKEa0QCsNpY5Ktpg5xdUcrPpAbJ/wc3E+uKyaHz4sxZVq0jB2
         pJDsP7Emnjf30qrcpn3U7F2hsY3hGu5tfK+Jw58hs0Uw5K0+QwSwhf2Zy7JNoEnMGlVN
         fDdQ==
X-Gm-Message-State: AOAM532zJ9qBH1SibvcOuEmuug4VEeyrMvx0kILR2/4yrdPDejWYP9rG
        vBq2pI6FPL6bX0QMNBiM6OW8iNkVfoamzXyd
X-Google-Smtp-Source: ABdhPJxsTi/MID2ZG+lKAhTCJs9QPJ1yBGV+4AL1pUay95bfu6u0etQ3/E+4qaaKb17rSwdt1XICIA==
X-Received: by 2002:a05:6402:1a22:: with SMTP id be2mr2624155edb.102.1606397109122;
        Thu, 26 Nov 2020 05:25:09 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id d1sm3196262edd.59.2020.11.26.05.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Nov 2020 05:25:08 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] ARM: zynq: Update DTs based on the latest YAML checking
Date:   Thu, 26 Nov 2020 14:24:59 +0100
Message-Id: <cover.1606397101.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

several issues have been reported from binding check. The series is
addressing most of them.
Patches are based on
https://github.com/Xilinx/linux-xlnx/tree/zynq/dt

Thanks,
Michal


Michal Simek (5):
  ARM: zynq: Fix compatible string for adi,adxl345 chip
  ARM: zynq: Rename bus to be align with simple-bus yaml
  ARM: zynq: Fix leds subnode name for zc702/zybo-z7
  ARM: zynq: Fix OCM mapping to be aligned with binding on zc702
  ARM: zynq: Convert at25 binding to new description on zc770-xm013

 arch/arm/boot/dts/zynq-7000.dtsi         | 2 +-
 arch/arm/boot/dts/zynq-zc702.dts         | 8 +++++++-
 arch/arm/boot/dts/zynq-zc770-xm013.dts   | 7 +++----
 arch/arm/boot/dts/zynq-zturn-common.dtsi | 2 +-
 arch/arm/boot/dts/zynq-zybo-z7.dts       | 2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.29.2

