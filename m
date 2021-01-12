Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955942F2D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbhALLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbhALLCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:02:51 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF61C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:02:10 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id u17so3078219iow.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EW3A5b9Qfm71A7R5e2DVuGK+dJkYonq6m8LtxtzCIo=;
        b=pWOW4aBDdcbZOaitsfnsoIAlbh/HjVoZbPbqOl67YErSFXP92YAgjjPbjXwL2Dq7Kv
         PIPEgNBttfXyruCTnBPvz8HO77BefJJZ8lyqk+Ven89bpC11tt6EXxeoTSdFt2VDjFIN
         0glyf5oXc6OLOOfyGgHaob2JkK/r3ZVw6iCkyB6C1wxbvQpUEvxrBcwbT44hN5R23tXe
         bYxwuMZcHGdz+ohWoOIvmm1RY5PahW9ODfsBqesVhemB1fLzf2CfqJwG1+VfqYQQ4MDg
         kLxthR8kddgFeS04G/C9K4zoF87IGxeXaBGZBk8NoexsO0+KfjMqCkmc595hPo2xu/6L
         Np3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+EW3A5b9Qfm71A7R5e2DVuGK+dJkYonq6m8LtxtzCIo=;
        b=eQW3TLiLJT3uGB0DIHC1H8tNNd5QP2gBPoFh+t4yYz5fjYTJF3PqAxV9LhtrZzuV94
         l2DM4qkz9KQm4hJccq9ttsTZujlgiPEXbT5QkC3EMoudK9t/+tV3ClPdjjnhsRVY0Czi
         3SK5YddX8OYzSqIvH9frYLotz5LRMDk+NrIqhqx54BYWq++aH33/ATLTd/R4vPvZ9FCl
         dQHVZOcpJGxqCIThKCZu7FielQUinYafdlNHHfIuUhFnQeO47o2tQYvsyRj0glR1alqz
         pNjg+yo/4ry7f2HLquUAY9a9ksxec9RU1VhN9i04hegQ4k3UCKUYYR90asMPrKJS1n+m
         +dvA==
X-Gm-Message-State: AOAM532mSmWgzmlsYaKgDHrTrTYVlQv/bCp8auy7jSC2E0CMN53Xo4Qp
        s80yw4s6EkmafZyLT3L6lpo=
X-Google-Smtp-Source: ABdhPJzhQiiSGxoLf1TesAerbFcgwtqDSf2wpPeFPVSm258as10LauPCqwzbgul7YYUOBahCucwJRg==
X-Received: by 2002:a6b:fd03:: with SMTP id c3mr2893370ioi.64.1610449330332;
        Tue, 12 Jan 2021 03:02:10 -0800 (PST)
Received: from localhost.localdomain ([143.244.44.199])
        by smtp.gmail.com with ESMTPSA id o195sm2254549ila.38.2021.01.12.03.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 03:02:09 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V3] arch: x86: kernel: cpu: Takes a letter away and append a colon to match below stuc member
Date:   Tue, 12 Jan 2021 16:31:31 +0530
Message-Id: <20210112110131.23378-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/kernlfs/kernfs/
s/@mon_data_kn/@mon_data_kn:/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
Changes from V2: Modified the subject line to match exact change description

 arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ee71c47844cb..ef9e2c0809b8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -142,7 +142,7 @@ enum rdtgrp_mode {

 /**
  * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn		kernlfs node for the mon_data directory
+ * @mon_data_kn:		kernfs node for the mon_data directory
  * @parent:			parent rdtgrp
  * @crdtgrp_list:		child rdtgroup node list
  * @rmid:			rmid for this rdtgroup
--
2.26.2

