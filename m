Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35354287C48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgJHTQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:26 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38042 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJHTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:26 -0400
Received: by mail-qv1-f68.google.com with SMTP id de3so3628100qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+X1XpiwkQSDSrUT3wL//k43K4Ktzdm0hf8yCBk0u2Y=;
        b=RgsrAJrIlEkBCEZOtrcLf26SO/bkVgC64GXnvXWUW2djIXgRtiQ0vrdFU3dRwoD0Uj
         gnWc0IYYbOBkCbuolpuYiPE/tveKAbkQILpBc+4PluvplSGr5UpPupoV+QFM0gy0UCMt
         E/q+7hsF0ZFEqllfoG7elOlQwz70rJ3Mj09YMYJJQADxsFLupOxMLx2sERGJTS2OsD6y
         UaVDh4ZHy/SYrOMshqXsaujTT1QlrrLDYs9+SOrZbXoTzB4bv4QjIbOspdKKuW0kFAHy
         xmiW9WsHYLxGRuuKsZN9WgSqLTxQ8NJ4u1pgx8pxSWFQpeo5EfdGRLOhxpE707oiEDdz
         Y+3g==
X-Gm-Message-State: AOAM53011AoYKbWntmREyNSYbd+lBjxeCUEwOQhi8NREplcKUoHP1Ufb
        O68ZxilSzdvW9ZGNeMur50HBo1Uqyvpaag==
X-Google-Smtp-Source: ABdhPJz5nvIL8EazFG54RDWuaSIjHnVvNI+St4ZBN0aUlWWm6lslJH7hedeF8FnnFqYsfH2tGlU/YA==
X-Received: by 2002:a0c:85e3:: with SMTP id o90mr8950553qva.46.1602184584908;
        Thu, 08 Oct 2020 12:16:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z37sm4726759qtz.67.2020.10.08.12.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:16:24 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Couple of bugfixes to sev-es series
Date:   Thu,  8 Oct 2020 15:16:18 -0400
Message-Id: <20201008191623.2881677-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the SEV-ES series, the kernel command line is no longer guaranteed
to be mapped on entry into the main kernel. This fixes that, and a
stackprotector issue that cropped up on head64.c.

The first three patches are preparatory cleanups. Patch 4 fixes the
mapping issue and patch 5 disables stack protector for head code.

Changes from v1:
- Add comments suggested by Joerg
- Split out cmdline into cmdline.h and use it
- Leave add_identity_map() as [start,end)

v1: https://lore.kernel.org/lkml/20201007195351.776555-1-nivedita@alum.mit.edu/

Arvind Sankar (5):
  x86/boot: Initialize boot_params in startup code
  x86/boot: Split out command-line related declarations
  x86/boot/64: Show original faulting address in case of error
  x86/boot/64: Explicitly map boot_params and command line
  x86/head/64: Disable stack protection for head$(BITS).o

 arch/x86/boot/compressed/acpi.c               |  1 +
 arch/x86/boot/compressed/cmdline.c            |  1 +
 arch/x86/boot/compressed/cmdline.h            | 13 +++++++
 .../boot/compressed/early_serial_console.c    |  1 +
 arch/x86/boot/compressed/head_32.S            | 12 ++++---
 arch/x86/boot/compressed/head_64.S            | 35 +++++++------------
 arch/x86/boot/compressed/ident_map_64.c       | 22 +++++++++---
 arch/x86/boot/compressed/kaslr.c              |  7 +---
 arch/x86/boot/compressed/misc.c               | 10 +-----
 arch/x86/boot/compressed/misc.h               |  4 ---
 arch/x86/boot/compressed/pgtable_64.c         |  7 ++--
 arch/x86/kernel/Makefile                      |  2 ++
 12 files changed, 58 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/boot/compressed/cmdline.h

-- 
2.26.2

