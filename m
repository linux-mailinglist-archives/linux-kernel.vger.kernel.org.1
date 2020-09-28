Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31EC27B815
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgI1X2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgI1X2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:44 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9BBC0613BA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:49:28 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id b17so989956ejb.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=TAg/M8M9moj9aK9JgpCPViDbJ0zI90Vf31L7QZTXfVA=;
        b=WCUoXB1SE0Qc15j9g1xzWJXPQY6xWmD1DZrha/7ZIozuW1dz2KCGlkFXksQQHPiytA
         37piZ/s1sdbzot6pdWymCATwrZYuWFcw4f5YRMl8VrGV7213VPF2JP5L8Y1UTIbiQSBu
         3M6mmbaaaNbSbcuPDRz4HryzjbKVXh+uVXhpkAUQdY0+wtSxMHMpvzVk8B6asUzn95mK
         dDvbAWQcXhp3gH6urgFmT1ke3ITD1KKZTupmsqtc7LY00xgBd/Xw6a4Q214C9xGvsj6A
         v/u9lf8V2NoR/JWzAtDrzx67+0MzaHFTtxL3CwTSITPMHolHL8C78MI4byx3SuUqHLnM
         x60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc:content-transfer-encoding;
        bh=TAg/M8M9moj9aK9JgpCPViDbJ0zI90Vf31L7QZTXfVA=;
        b=CpGBn0MCPTuUV544ZwzojRQXL2+ZWd9gq5soYzZi5SbulDDwqtaf3VjGmEHkpH4+w4
         1wBCMJTT4j57aYpsKXE33dfWhX679lUHybhemmg/yv2Kwd1ZV62LO2Uu09AMw+HkhJ2o
         cuay0ZAUG/e++jw37rieYsb8deHwSiXJap5JtbvnVDyoRWz0OvtdhDNVf3+sIUwp18bA
         rBpCBgHUKGWuZsIiIIbR7ygBAG53IZAmUgahRTWxbPJT1UvAGC/i855MEQ40DcJpGvz4
         I29/qYz+V0Kdynd11ljhhOl3CeWTu52YwQE+4v6IR+V64bH//OVlB5wD/AvkHqCxMEUE
         CDCA==
X-Gm-Message-State: AOAM5306Q91HirxvZR556zIUjEd/WE5OlUP3RNOSq47LjOnhN4TxIZ3b
        eYJPPP28T0qlQCA9fhPUSzqtfr001g==
X-Google-Smtp-Source: ABdhPJx5pciSmGAqNJelDt4If0xrz1Ql9OatJJf8io35LL2bKVVeDGinctQ1ejMwKVM9nQBU4GZqMmWJlA==
Sender: "jannh via sendgmr" <jannh@jannh2.zrh.corp.google.com>
X-Received: from jannh2.zrh.corp.google.com ([2a00:79e0:1b:201:1a60:24ff:fea6:bf44])
 (user=jannh job=sendgmr) by 2002:aa7:d3da:: with SMTP id o26mr221995edr.169.1601333366593;
 Mon, 28 Sep 2020 15:49:26 -0700 (PDT)
Date:   Tue, 29 Sep 2020 00:49:16 +0200
Message-Id: <20200928224916.2101563-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] objtool: Permit __kasan_check_{read,write} under UACCESS
From:   Jann Horn <jannh@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building linux-next with JUMP_LABEL=3Dn and KASAN=3Dy, I got this objtool
warning:

arch/x86/lib/copy_mc.o: warning: objtool: copy_mc_to_user()+0x22: call to
__kasan_check_read() with UACCESS enabled

What happens here is that copy_mc_to_user() branches on a static key in a
UACCESS region:

=C2=A0 =C2=A0 =C2=A0 =C2=A0 __uaccess_begin();
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (static_branch_unlikely(&copy_mc_fragile_key=
))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D copy_mc_fra=
gile(to, from, len);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D copy_mc_generic(to, from, len);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __uaccess_end();

and the !CONFIG_JUMP_LABEL version of static_branch_unlikely() uses
static_key_enabled(), which uses static_key_count(), which uses
atomic_read(), which calls instrument_atomic_read(), which uses
kasan_check_read(), which is __kasan_check_read().

Let's permit these KASAN helpers in UACCESS regions - static keys should
probably work under UACCESS, I think.

Signed-off-by: Jann Horn <jannh@google.com>
---
Calling atomic_read() on a global under UACCESS should probably be fine,
right? The alternative to this patch would be to change
copy_mc_to_user()...

Note that copy_mc_to_user() does not exist in the tip tree yet; it
appeared in commit 0a78de3d4b7b1b80e5c1eead24ce11c4b3cc8791 in the
nvdimm tree.

 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a88fb05242d5..1141a8e26c1e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -583,6 +583,8 @@ static const char *uaccess_safe_builtin[] =3D {
 	"__asan_store4_noabort",
 	"__asan_store8_noabort",
 	"__asan_store16_noabort",
+	"__kasan_check_read",
+	"__kasan_check_write",
 	/* KASAN in-line */
 	"__asan_report_load_n_noabort",
 	"__asan_report_load1_noabort",

base-commit: 0248dedd12d43035bf53c326633f0610a49d7134
--=20
2.28.0.709.gb0816b6eb0-goog

