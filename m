Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFE2DB34A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgLOSJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbgLOSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:08:18 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10247C0617B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:07:38 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id q25so24296882oij.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWT20cxGDnE+dNIxUaJWQEqPNcNAaFYi+yHn0ak9yqY=;
        b=Ar1Etn1abBefJjCVtgl/nkMWVHndI9Y5bRpOMmsPzFda+OV4u8idKMnl3Pe96J0oEH
         NkcTwp4VZsR+CS3U3fP4isewKiQb6ybba7QUc7WG41QpkaAV19YS9+/1+KDvwaXu+uPp
         /PVWZ0dDWJ7ZY4vTmVFsyMVuCdKfnX3mi3GEvGH/PZs1HUv6gYwIMnOmYtYZIc9/yJOG
         G0Y8SUs71CEw7Db+OFiAjrvS+kptYuRLVAtGjb1iJou4SJYSlnXQtzj2111O3gcaJ1Fe
         FXY1WROoZBw66i48Q9JT11gN20E7qafrBDBa/D6mxHl6V+HFHSCh/FzUFeiZAqbZCTJO
         AjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aWT20cxGDnE+dNIxUaJWQEqPNcNAaFYi+yHn0ak9yqY=;
        b=rv6hwloztTWAXXG8gLjfQs1LmTs1ytEfSSTqoBuoxBOjKtLf0vhxrbfnW5PdRHRNOl
         wpVqo33Mc+hYAqxCzl7cbK4WOmn5wm6lP49SdVRSdYQuvaLQ1u4hUnhh736WTC79SToJ
         vm5BXHKhm5dOXaJTsoD1kQNdy8YEFCIR9hmrdq71k2A5elr+xKRAcwDB/7tcpXnr7eP9
         4WIboBf0lWivB3j6EIa2ZmiLwlR2bJzeTk5FysbRRut9C3yLuWCTi8aJyiLtFKP5a+Yc
         NJaj6jpmHxcb2tiUX709/YwHEw1pQ8Iagul6x/icTz83Qrav0maO9WinGxiTU++w9dzZ
         f5Bg==
X-Gm-Message-State: AOAM5301+OimscRuOjizaUFoY3XShebyfPopvrIJJE1kTgr+/gjSsjOO
        ANyo+SMxR6/uaS9jxJzBOq3/cw==
X-Google-Smtp-Source: ABdhPJwK+5A9TPLHf3urLGkpH6nkUE2PbxcaEVEGg6uBnCbM+6OjzkKh518fON34xzTwLrjfQMvRQw==
X-Received: by 2002:aca:ed51:: with SMTP id l78mr65136oih.144.1608055657471;
        Tue, 15 Dec 2020 10:07:37 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s26sm585458otd.8.2020.12.15.10.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:07:36 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [GIT PULL] hwspinlock updates for v5.11
Date:   Tue, 15 Dec 2020 12:07:35 -0600
Message-Id: <20201215180735.1528535-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.11

for you to fetch changes up to c3e9b463b41b45c4556a13043265097e2184226e:

  hwspinlock: sirf: Remove the redundant 'of_match_ptr' (2020-12-10 13:34:40 -0600)

----------------------------------------------------------------
hwspinlock updates for v5.11

This contains a few minor cleanups and build warning fixes for the sprd
and sirf hwspinlock drivers.

----------------------------------------------------------------
Baolin Wang (2):
      hwspinlock: sprd: Remove redundant header files
      hwspinlock: sirf: Remove the redundant 'of_match_ptr'

Chunyan Zhang (2):
      hwspinlock: sprd: use module_platform_driver() instead postcore initcall
      hwspinlock: sprd: fixed warning of unused variable 'sprd_hwspinlock_of_match'

 drivers/hwspinlock/sirf_hwspinlock.c |  2 +-
 drivers/hwspinlock/sprd_hwspinlock.c | 17 ++---------------
 2 files changed, 3 insertions(+), 16 deletions(-)
