Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127BE26FAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:49:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37AC061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:49:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id bw23so122827pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8srl7JTOHY4H9N4k8WT8uX/+x+VBfYA5c5ucCNG/qc=;
        b=JXLL7mSrrYXNp0hvx4cxXl6T/RMwuV17wRZstxrboAkz6rkZtK/X8mrs8pgpZXUJUJ
         qUdwyx4YlBsqjgY6//zXsxvyJ7THeM2iDLMkBjXnZR3pHeo8bEfxy4NETqJ8tA7vIcAC
         kz5gI16PzSbLcSFcP79kl3pBVy3Olqe7bTBf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S8srl7JTOHY4H9N4k8WT8uX/+x+VBfYA5c5ucCNG/qc=;
        b=h7Zxamc8os+9uq20Z2m9eM+PTw4OGklqFoe5avKLs2GnuZVmLlwmRugvB1Gz0ygvCq
         BU9SAlg4ZH2/bqACYE462+ROi9F46iBZKSea68EKfbNcwp+eW6j61xTXUSQHedi/Rtqb
         9wyNSggqwTVm8lvFxsYEbG0ZmKAadXvcEgz19xAJkpbPSgh+nIxVMEsArKUHHiZ3pZIO
         3beiv0mXcmd0C9HS7tRN+Nn0iSbRnFq7WesEUPc3Y9CHybbucAHhtmSB2WEd7VnuPP+9
         5Glr1UK2WzobndPWLf/mz/g3RreCpopluq2IqO6Ear+m2E4QBit6EZS4Bs4rxRc4hgbY
         f6dg==
X-Gm-Message-State: AOAM532wrh+tsjMpEUuNNXyjG/kb4+zg7v9oDuB3iI/6+qDrPi7fSpFL
        W6MEhYYM863//3ObK+VMon6Jyw==
X-Google-Smtp-Source: ABdhPJyD97UGHfsogcOBzNaFIl0HRacR4ZV4wrQp6+MgiwWtlCWJ8oEp9uqEA+QBSn4ljKsYNHaMmQ==
X-Received: by 2002:a17:90a:648d:: with SMTP id h13mr8805516pjj.151.1600426196261;
        Fri, 18 Sep 2020 03:49:56 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id 131sm2857634pfy.5.2020.09.18.03.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:49:55 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, mark-pk.tsai@mediatek.com,
        arnd@arndb.de, maz@kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/3] ARM: mstar: wire up interrupt controllers
Date:   Fri, 18 Sep 2020 19:49:46 +0900
Message-Id: <20200918104949.3260823-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark-PK Tsai's driver for the MStar interrupt
controller should be going into 5.10[0].

This small series selects the driver when building
support for MStar/SigmaStar Arm v7 SoCs, adds the
instances of it to the base dtsi and wires up the
interrupt for pm_uart.

0 - https://lore.kernel.org/linux-arm-kernel/87lfhdr7l6.wl-maz@kernel.org/

Daniel Palmer (3):
  ARM: mstar: Select MStar intc
  ARM: mstar: Add interrupt controller to base dtsi
  ARM: mstar: Add interrupt to pm_uart

 arch/arm/boot/dts/mstar-v7.dtsi | 20 ++++++++++++++++++++
 arch/arm/mach-mstar/Kconfig     |  1 +
 2 files changed, 21 insertions(+)

-- 
2.27.0

