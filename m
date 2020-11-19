Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0CB2B9132
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgKSLhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKSLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:37:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:37:49 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f11so7783236lfs.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OR5DlQ82Z0giWyrUKoqiG/pahiCDRhRB22HiV/XCm3A=;
        b=QeqvO+IV+oEFVnggQNPfdOQaZMm/RAsTtKSrrEVaVkl1eeK7qoEjq34P+PGVF7xNYx
         n2hddAzgDM8f1sbUAJejdIWM14Qu2GOcu74ITuJYIu14oHTcpxaljeFA1/cGTYSIo+7K
         WXotrmmoFm2lpkWcX/X2lmXrTK6t3sy0Xv0kSVX2DMrumWyL14VZt8RBtV3NbbUDhjVH
         nFz4Lif84tDxgFd6AP7RTiib4yB+4t95InRG78UtH/Ztqrj41EPLfi+hSjOcBB48OZyU
         EXuvpAVmqvq0N7842ttWRLUJpvc9a1STfkl41u9h29sntyWIx0Em3Z21rC6j3eAsOy9T
         5AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OR5DlQ82Z0giWyrUKoqiG/pahiCDRhRB22HiV/XCm3A=;
        b=PnuxuyqO4AlpFhwFGCye77fAZqo7hoiAPUQhd3+Jc79o3Q1RSKdHvVBlRABoZfcr5Y
         hsULmPiDyYzNlGVYH1PkuXtJXaVM/RrL+tMkt75AaEf51I6la0iYTh+MsqHZWgRBPe5K
         P+ZDTH3CQtGdVYmp7uI6zeqHSzCajSgo6/PKFxMF4vZ1U3/1IAqJcQgcZkbJQwA1VT3x
         jlppKxjhV7purxBmrRfxPcL0vQgOKRXa8eN5jW8MGRB22fxa3z6N0yrfM6AGr+zOeIV9
         o9PXpykGX2BmWvQpq0cULTAwW8rez1JpWpBTVfi7Gvag8RVj5RPkWBsn/calZJx0JgPd
         aXVg==
X-Gm-Message-State: AOAM533WookGl2XUEOm8tIp0P45TLKVtdzhgQDNNgPOMTxuiAshsFFyl
        HRpUzk85fZyGlE15Gk3qaQw=
X-Google-Smtp-Source: ABdhPJyY2cwSvDfGgfMiKJsiUkaO24dX2pW/4J4CifTSN+qB7d7nY6FdD0GqHXSKOMuR5R12ULhF6Q==
X-Received: by 2002:a05:6512:2141:: with SMTP id s1mr5298952lfr.307.1605785868515;
        Thu, 19 Nov 2020 03:37:48 -0800 (PST)
Received: from octofox.metropolis ([5.19.183.212])
        by smtp.gmail.com with ESMTPSA id 12sm4059857lfz.10.2020.11.19.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 03:37:47 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa fixes for v5.10
Date:   Thu, 19 Nov 2020 03:37:34 -0800
Message-Id: <20201119113734.25047-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture for v5.10.

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20201119

for you to fetch changes up to dc293f2106903ab9c24e9cea18c276e32c394c33:

  xtensa: uaccess: Add missing __user to strncpy_from_user() prototype (2020-11-17 05:09:28 -0800)

----------------------------------------------------------------
Xtensa fixes for v5.10:

- fix placement of cache alias remapping area
- disable preemption around cache alias management calls
- add missing __user annotation to strncpy_from_user argument

----------------------------------------------------------------
Laurent Pinchart (1):
      xtensa: uaccess: Add missing __user to strncpy_from_user() prototype

Max Filippov (2):
      xtensa: fix TLBTEMP area placement
      xtensa: disable preemption around cache alias management calls

 Documentation/xtensa/mmu.rst      |  9 ++++++---
 arch/xtensa/include/asm/pgtable.h |  2 +-
 arch/xtensa/include/asm/uaccess.h |  2 +-
 arch/xtensa/mm/cache.c            | 14 ++++++++++++++
 4 files changed, 22 insertions(+), 5 deletions(-)

-- 
Thanks.
-- Max
