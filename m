Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ACF2C7343
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbgK1VuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732497AbgK1SH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:07:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C5EC0258D4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 07:42:12 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so7060310pfp.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lT4ugpRxM+U436g85kVh5NxCK7gn8GFnxue2bFMn0YY=;
        b=oaAV9LTLo9/bBnEqOE9KCPCx74MbmLOXY63h5dRXGj2FMxXRfGqplHwLAgWkkK1c7/
         V8zmFNeI+Z3A6fjeVLvkwCA5mqgyw+8Zv26H0F2TfCQvTbtVoMD2tG4yG/oSP029zUHg
         PJsE+LY4UQ3VqVBvlm3lMw605RbVHNf/lTiCFXPAl4MNJYFea5/3ueZOm1fwk8fMQzbY
         jxcULAlfZdPA/Y0JyjbcFvBbeLKjDYw2DqkQ0EoWR+eEncsPz8R87sPm4VIN+EoUxIdw
         ruhHPGloZ1DcIgac0IVvXT+FZ7YWOeZ/Ju9vgFC4q23GCJEprFmNbfZSRDBzjnjpJrCY
         PMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lT4ugpRxM+U436g85kVh5NxCK7gn8GFnxue2bFMn0YY=;
        b=WFU9TTT8SVBpTWXFZaFdsPsAB7YA3YU+8COg6DqCqpQE6iSy0cZvXUfiYLhJzsmQ/2
         pcNuzBK+fYIOEkxlk11zI9boaAeHiu9E+q0LnHEuYg3gMURj0y3+pygMbdqdQmTONPQe
         wUKKUSS26ICa11fXuhds3yiBzft4tvKAU8/7Wzet5PyUo+BeOfogZ0MKH4HC3CM8BJTv
         AQoL8tg+hrXk+EpVl+sM/P5ChYZdfrt1W8iGQ7pGGOPJLMvUxjeMixAUtfv3EBjdkiuf
         pVmOL364PkUKoK7QEhnCFhwixKL/LXnrarhIPFlwqTZMjcKtzEFXaaosVdw1OHfhBaKn
         4NtA==
X-Gm-Message-State: AOAM5318UqRY1wg7zCFu/7m51a5ckFjNXRwJJRKS9/NSQfII1X5W74Wa
        9ThFiNyoyDUnMKTdb8nHrHk=
X-Google-Smtp-Source: ABdhPJySK65OGh7npov+iw1s10F/3346tI830s3uK/mQiJVRQk/k0JDgwG6v2MkTZt2idcKratUxNA==
X-Received: by 2002:a63:ec50:: with SMTP id r16mr10640493pgj.281.1606578132138;
        Sat, 28 Nov 2020 07:42:12 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.220.174])
        by smtp.gmail.com with ESMTPSA id q29sm11401667pfg.146.2020.11.28.07.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Nov 2020 07:42:11 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     hca@linux.ibm.com, kbuild-all@lists.01.org, svens@linux.ibm.com
Cc:     clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH linux-next] include/getcpu.h: Fixed kernel test robot warning
Date:   Sat, 28 Nov 2020 21:11:57 +0530
Message-Id: <1606578117-2895-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot generates below warning ->

>> arch/s390/kernel/vdso64/getcpu.c:8:5: warning: no previous prototype
>> for function '__s390_vdso_getcpu' [-Wmissing-prototypes]
   int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct
getcpu_cache *unused)
       ^
   arch/s390/kernel/vdso64/getcpu.c:8:1: note: declare 'static' if the
function is not intended to be used outside of this translation unit
   int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct
getcpu_cache *unused)
   ^
   static
   1 warning generated.

vim +/__s390_vdso_getcpu +8 arch/s390/kernel/vdso64/getcpu.c

     7
   > 8  int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct
   > getcpu_cache *unused)

It is fixed by adding a prototype.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/getcpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/getcpu.h b/include/linux/getcpu.h
index c304dcd..43c9208 100644
--- a/include/linux/getcpu.h
+++ b/include/linux/getcpu.h
@@ -16,4 +16,5 @@ struct getcpu_cache {
 	unsigned long blob[128 / sizeof(long)];
 };
 
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
 #endif
-- 
1.9.1

