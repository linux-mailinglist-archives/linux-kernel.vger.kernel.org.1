Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B754E2DA025
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502070AbgLNTQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395235AbgLNTQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:16:26 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC42C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:15:45 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id r8so6987082wro.22
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OXWZqhdKXz2gQWFbmjoSr/aaAS/tBQHv4yy/WSCCm6Y=;
        b=i11amYTd+5wzzQ0Wq8vH2D7LdZ//1GkMyl35MDoYEbyz4SNzUAPwuPWCY+AJ2ypE+w
         ourJPpgkvcbjcsjD0mRg2LLL44NIRVpN2sGhXjbMjGsKKcvsT6LV7D+g3oHpEFnfWf12
         R3wJuuIAkcFVeLmGoUY3RAnmL5YzkAI2F+bQ+1WA50gvFSsYppahYR+ObV0n4mSvcbhd
         fN1aP2+oeOX2lF6Zkhys6hX/Q3qqLzrAdTZ5Zy24mOZICvUNujhmwVg9qNDWFjIMw2HO
         JIYxoPpkfJZygeNwDWmDoSd+VojNSU08Jxz1bJAOiXsfQUThx3hlXh/93fsckZIX+20d
         5vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OXWZqhdKXz2gQWFbmjoSr/aaAS/tBQHv4yy/WSCCm6Y=;
        b=W7QGeHgAu5S8IQohtn/GR/w+0EHqmhkIX4b8DPzHJS4qhp+QKDFY/CP1HdoKY497yZ
         3w3ka1v6L67c5aITSA81jKfiIXBydbkhQ+pDtGswR8B6k/fooUgoNM4LvUttVzffQ+7d
         7F0F8mbpc4MGWVwl44If2JCQ/MU6v3fOcmKaAuJwMLAcoR9+OAvvDAvy2g8zMx21aQ5/
         YliaUuhjEPLPELn5HhkscbMqMzWM6ZM6rARvDFz0CLmY5gGKhdh3brh5zWLZqS/q2yi4
         zKgOJau4ojMn/xjyvA7ZD9/+OmKPD79MPegroSOqJHuM5bHpzrVFGRl24zJTzRR0KCck
         k85Q==
X-Gm-Message-State: AOAM533fS56BcPe4kzbB8TTdwI4Dz21IIeEY0kB6m2PgPD0wKhTxQ5hy
        jheUDGr9tiax44fKt3SqeGyDXEFz/Q==
X-Google-Smtp-Source: ABdhPJz/+8/uvhTIGkfPzKo125/5Uo8fHCOHu6zly5UvIEMmeuZ8Dwu5dT1x1zgSNkyQe3bd26JfabxC8w==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a1c:2783:: with SMTP id n125mr25239565wmn.74.1607973343268;
 Mon, 14 Dec 2020 11:15:43 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:14:15 +0100
Message-Id: <20201214191413.3164796-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH] lkdtm: disable KASAN for rodata.o
From:   Marco Elver <elver@google.com>
To:     elver@google.com, keescook@chromium.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, andreyknvl@google.com,
        dvyukov@google.com, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building lkdtm with KASAN and Clang 11 or later results in the following
error when attempting to load the module:

  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffffffffc019cd70
  #PF: supervisor instruction fetch in kernel mode
  #PF: error_code(0x0011) - permissions violation
  ...
  RIP: 0010:asan.module_ctor+0x0/0xffffffffffffa290 [lkdtm]
  ...
  Call Trace:
   do_init_module+0x17c/0x570
   load_module+0xadee/0xd0b0
   __x64_sys_finit_module+0x16c/0x1a0
   do_syscall_64+0x34/0x50
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason is that rodata.o generates a dummy function that lives in
.rodata to validate that .rodata can't be executed; however, Clang 11
adds KASAN globals support by generating module constructors to
initialize globals redzones. When Clang 11 adds a module constructor to
rodata.o, it is also added to .rodata: any attempt to call it on
initialization results in the above error.

Therefore, disable KASAN instrumentation for rodata.o.

Signed-off-by: Marco Elver <elver@google.com>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..1c4c7aca0026 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -11,6 +11,7 @@ lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= stackleak.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
+KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
 

base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.29.2.684.gfbc64c5ab5-goog

