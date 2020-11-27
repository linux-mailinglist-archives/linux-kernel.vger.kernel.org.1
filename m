Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6E02C6AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbgK0Rw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgK0Rw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:52:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D57CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:52:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v21so3002818plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbnqR/dwNXO8ukUwnuRC4kie3nqwg50nA32KImSkc7k=;
        b=ubQa7ckKR0eyvh8TJDsqdKKxfWSD+QLVWWOCeBnZu/2tQdAPwArorP24IzFNDQu1cV
         FxnJ75gGZDNXdGsGn5oXF+vwLw/UdLt0q/SXbr8NyefI45R6qcF/HwV9sNgzfM0W2jzS
         YMrWs1RsCYE5UFWKB2xvD8jPIP7Xw3FTGqUssBvBgDNRSa2Ag5ZFi5QwwP5w8QKfpn7L
         F7kx9X5H98gALeKSLhisiAtbe300WQvyz0XWJWxaQh0r9fUxXvfj6IRzM2ZZqdbgjU86
         zmlVaOL8P1Rw/1iN5imilJgwKIXfaRHVVuAz8xkJekgPFHPHmMLbnJ9e8feTCRUVcXYc
         mjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbnqR/dwNXO8ukUwnuRC4kie3nqwg50nA32KImSkc7k=;
        b=kTXvOFv68hXqjEmcERRHctLlKH5Saqq04pteQ36q47KeN7CUyxDb3yGDZMqGWjhBt9
         dAqf9/71m1SUJ0pububkOCBohpO5uh+qYfA4+ZIJo+4tNk1AUVS8SICvXCRGJUSpaViS
         cDvEAXYz5OV3VU6MR8qM8Og8CurNiCEBGnvmDFvAwdPQrx+PbFptnQOJ/Z9ohjcIRuEc
         VWIo5dUIXFXyKktKJ0f2vIBjVvqabeggT7yl5abXaD3egqGu/yzCNPqDQfMORTlHvf5u
         vuc/L43DvIiTx10pxHeqI1SZyxIAaacQNgL0jfs/V+5H+sUePquj3taJi2HXp2T85xq4
         Wglg==
X-Gm-Message-State: AOAM531dD7gg5KpREm34oCpOGg9ZXJzKIX3+Efj6QBCUkhW3vPdFdomf
        Lf/e08xnIH4QBTij1BFI50XSUA==
X-Google-Smtp-Source: ABdhPJzIINDzGoS1N3BkOc7gA0lHFBDLM7NmCI0YjH6LsJmwSSfkWbqiO4CeMbYk5Mwx6RIAWEtr7w==
X-Received: by 2002:a17:902:6905:b029:d9:9114:280d with SMTP id j5-20020a1709026905b02900d99114280dmr8079895plk.74.1606499578061;
        Fri, 27 Nov 2020 09:52:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:52:57 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] coresight: Patches for v5.11
Date:   Fri, 27 Nov 2020 10:52:41 -0700
Message-Id: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here is the tally for coresight to be included in the v5.11 merge
window.  There might be a part 2 in the next couple of weeks,
depending on how things go. 

Please consider when you have time.

Thanks,
Mathieu  

Kaixu Xia (1):
  coresight: tmc-etr: Assign boolean values to a bool variable

Mao Jinlong (1):
  coresight: tmc-etr: Check if page is valid before dma_map_page()

Mathieu Poirier (3):
  coresight: Fix W=1 warnings in core framework
  coresight-tpiu: Fix W=1 warning in TPIU driver
  coresight-stm: Fix W=1 warning in STM driver

Qi Liu (1):
  coresight: Remove unnecessary THIS_MODULE of funnel and replicator
    driver

Sai Prakash Ranjan (3):
  coresight: etm4x: Skip setting LPOVERRIDE bit for qcom,skip-power-up
  coresight: tmc-etf: Fix NULL ptr dereference in
    tmc_enable_etf_sink_perf()
  coresight: etb10: Fix possible NULL ptr dereference in
    etb_enable_perf()

Suzuki K Poulose (5):
  coresight: etm4x: Fix accesses to TRCVMIDCTLR1
  coresight: etm4x: Fix accesses to TRCCIDCTLR1
  coresight: etm4x: Update TRCIDR3.NUMPROCS handling to match v4.2
  coresight: etm4x: Fix accesses to TRCPROCSELR
  coresight: etm4x: Handle TRCVIPCSSCTLR accesses

Zou Wei (1):
  coresight: core: Remove unneeded semicolon

 drivers/hwtracing/coresight/coresight-core.c  | 10 +++-
 drivers/hwtracing/coresight/coresight-etb10.c |  4 +-
 .../coresight/coresight-etm4x-core.c          | 50 ++++++++++++-------
 .../hwtracing/coresight/coresight-funnel.c    |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +
 .../coresight/coresight-replicator.c          |  2 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  4 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  6 ++-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  2 +-
 10 files changed, 57 insertions(+), 27 deletions(-)

-- 
2.25.1

