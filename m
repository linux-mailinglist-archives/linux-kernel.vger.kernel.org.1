Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E42A92BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKFJac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgKFJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:30:31 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF083C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 01:30:30 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so499232pgh.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9IjLA/xj+DCaqgqGoF9Azl/MuEmkxVdtKRQX7C0Fd1c=;
        b=oEMybdqmr95hrZY/hQwyBKi9MAagPUHqbE2DaSTPVO6nJ3xAap7nnQaSAl13MglVkW
         8dD7Sa0IgcuaELVi3kjGgDYV1GW64m2zF1c5rKbsyHPy9mh8iyUBHWYwxbOK3TI5b1Iq
         JwAfMNWachoFTgNndJsVtagFpY87gK0TypeP/jVbHmu5IOLxO1Sx0XFsPpCkfG89YCpv
         D0M2iikm9dks0ltM5Lc2oL4EkAO53DyGZB0lSwKJQs74UlZMg+47hltxFmaEf1IcqIzq
         1m7WaOdG9avHDRZBeD3DF17VVBg3X+08g7MH7BOFotBoXh7a/lkBOUnBFEYjsI4/IwSs
         nLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9IjLA/xj+DCaqgqGoF9Azl/MuEmkxVdtKRQX7C0Fd1c=;
        b=FOSmwdQ3qN7n/um9jbF+DaM5NrD5Zshbei48iiJf2ZDi33uMeQUL7Sf4b8F0eEE0nv
         Ih7+PJNhot7ajWEj7RuVXRfYq6pRbeNH4Z/zb9t3YLhYPM1QTa84HL4Ns06fXPU8RkG9
         9cmrWf9iUR9yKvQz5kc617XzRxgXkaFLIWBkfQv9lWssfCmb/0d8agiHtIFsGZUmx9VH
         K76Yn/FFWYq9+cPKwz4GX21YACfCCyoXNT3ZFMKj2hXN+MnaP4FP/bKegP1HVDVTDOsk
         OS//jQmaz/WQeq6zLQx6aYHRGiv4ooBX6NaO7UICUQgz5F3eJKbPzLrfcAPhJZsCtqKk
         4JEw==
X-Gm-Message-State: AOAM532/C+PV5PAJZoP/DaWib29Yyh8IBmK93lJJn7bn2mPBXxW1VH0U
        7WszAylf9aPsW4xU/l9QSg==
X-Google-Smtp-Source: ABdhPJyyHHQHPk/miYMvK3I7A3pJyIqVqCI4XP4bzwu4ZDR+kR8EHkhl1nQyYgOMuhMtvMvAXaeq2w==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr1495282pjb.23.1604655030124;
        Fri, 06 Nov 2020 01:30:30 -0800 (PST)
Received: from Sleakybeast ([103.250.163.155])
        by smtp.gmail.com with ESMTPSA id t19sm1030428pgv.37.2020.11.06.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:30:29 -0800 (PST)
Date:   Fri, 6 Nov 2020 15:00:21 +0530
From:   Siddhant Gupta <siddhantgupta416@gmail.com>
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        mamtashukla555@gmail.com, himadrispandya@gmail.com
Subject: [PATCH] Staging: mt7621-pci: Fix alignment warnings
Message-ID: <20201106093021.GA25237@Sleakybeast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the alignment issue pointed out by checkpatch

Signed-off-by: Siddhant Gupta <siddhantgupta416@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index f961b353c22e..0e95fb33b4e9 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -278,8 +278,8 @@ static void setup_cm_memory_region(struct mt7621_pcie *pcie)
 		write_gcr_reg1_base(mem_resource->start);
 		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
 		dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
-			(unsigned long long)read_gcr_reg1_base(),
-			(unsigned long long)read_gcr_reg1_mask());
+			 (unsigned long long)read_gcr_reg1_base(),
+			 (unsigned long long)read_gcr_reg1_mask());
 	}
 }
 
-- 
2.25.1

