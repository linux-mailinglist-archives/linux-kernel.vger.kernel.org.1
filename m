Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFD2B1E55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKMPL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:11:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4087C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:11:27 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p19so8232466wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c7MgAWiy74K8vib51943ipBd0WSQob8Na1TvgSxr4c=;
        b=jRxBh00r4ZPgm+5y81fpNmc2uLxlIkC1HJ5Mxx6oBSuVzHXNnqXBbgo/FlP9mVmL8o
         92j1Ecy1ZjQ0y1q9Qcz/A67zTdEbVSPIG/3kt9qPHzIF183uhI730A+EiEtRxtJ9wAjq
         B8KunaNuNysZeA7r/skZeNL+5s4EEb/1rPTjSwUt6ZKF1Ocsc5XsvbZQca9C3UTaQYnR
         WH/Z1pylUdxj/IC55v9oc5F0TK9iucRs/vnSRk+H+iTHJ3NoWTwCWp2Kd+6B9iR9mJ4U
         Be9eHzBduZzJ6xxW1VPfxX6/SMZyUC/eo7+Bsfqc4KhQHB7we1ebKDxe/SdBw6g9gBQB
         3/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8c7MgAWiy74K8vib51943ipBd0WSQob8Na1TvgSxr4c=;
        b=lh62tW4CGtTQq8wWYnIif9NxOqAXRdk8LDWlh2lAiwxoNvJXUPCWJaq6KzyqgeqHL9
         IkRdM/WgVDeXElHbn8dMxgqNgz1pYxD1RZKHlHutCZD9aVHjN6FhSQNS7aCycRosS30c
         UwQU2LhJU3OEzOntAkyCMbLLFV1P7ao9kg3sXpfZ9M/MDJy7ENt03KlHGO2RK6fIGZis
         9EZRW9YUz2/CbX1t3locEv1zz91pYY0h9G5gR/v5f/pHDOYMA7CiK9MrmWGdDYWUHrC1
         jtBSsBSfI+Z4S62hZFuPUCLf+bUL6b6/cAcE0WAdR9MYIBOEwBAh4FuNK9MJ1e61uKAn
         HFJQ==
X-Gm-Message-State: AOAM5333XzjidO7QHJ4Dx2lQBMmyOB7PWos3MV0LCto7X9Z7irPOS0+M
        abhDjSJ/+WorneXm1n9cyKG50g==
X-Google-Smtp-Source: ABdhPJzUjjiv4HSAm1m6OXfhg7ZI0huYsHIgN5N/AnHyo32gOQyprZpjYFlrpyXCBMRgcJZJWOoxaA==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr3032912wmj.89.1605280286364;
        Fri, 13 Nov 2020 07:11:26 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n9sm10527195wmd.4.2020.11.13.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:11:25 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/2] phy: qualcomm: usb: Fix two COMPILE_TEST errors
Date:   Fri, 13 Nov 2020 15:12:23 +0000
Message-Id: <20201113151225.1657600-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel build robot fired this email at me about an hour ago
https://lkml.org/lkml/2020/11/13/414

The build robot has flagged the super-speed PHY driver but both Kconfig
entries have the same error. Fix those now.

verified with "make menuconfig ARCH=s390"

Bryan O'Donoghue (2):
  phy: qualcomm: usb: Fix SuperSpeed PHY OF dependency
  phy: qualcomm: Fix 28 nm Hi-Speed USB PHY OF dependency

 drivers/phy/qualcomm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0

