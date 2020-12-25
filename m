Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3332E2B90
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 14:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLYNba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 08:31:30 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:34913 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgLYNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 08:31:30 -0500
Received: by mail-pg1-f174.google.com with SMTP id n7so3127213pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 05:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=HPNImk3m6nx95sWUaSjaguGP9iU1LblorKP8BGuR6TI=;
        b=oY0z1j9gk1oyLexak9pbCKmQugor1zMTMl9I4+JRNrkunsg+kgLC8iEIbk0W4h+4Yq
         tq3YrxFf0OWJftBUPMZUzpBWSfsP8+UqKUi+dPJAjflS5HVIhdHZQTYJ9TU202O716uv
         4zfsK+HKwQ5dg0Opz/Ha53lRP7H0UCvTvtquVAcbFRhhWp9KGyd60JYKEiY4f8qKeaTe
         zGDopxCF73sFEOMYynHww2jlyuZZgUZ/3X8YzUadOXuy2c+zb4ErcxFVLX460EGCh6A1
         ONb5fBTp+TdEtl/OviDjzbnD5BELh9aInDizkwuQUuCFwkILhCpeCL1CXblQzuVuXzvm
         UVlQ==
X-Gm-Message-State: AOAM530O5INJK+p2q1ilaqVlyaPG+zcrAMLpSdj4ww3E86UZuCIOfZ2a
        oRbgjYwF59V8IGsy/3elToUMImY5B/e1TQ/4
X-Google-Smtp-Source: ABdhPJzDIiEfv6eLYEN/C0p/6oW1WfYAV/rVS5JZjy/7MTmokD020BrUECceOnNT9pd/+HMnn7Sqkg==
X-Received: by 2002:a63:643:: with SMTP id 64mr32633042pgg.422.1608903049231;
        Fri, 25 Dec 2020 05:30:49 -0800 (PST)
Received: from macbook.local (ae142046.dynamic.ppp.asahi-net.or.jp. [14.3.142.46])
        by smtp.gmail.com with ESMTPSA id x1sm29434770pfj.95.2020.12.25.05.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Dec 2020 05:30:48 -0800 (PST)
From:   John Millikin <john@john-millikin.com>
Subject: [PATCH] x86/tools: Use POSIX-compliant syntax for empty regex groups
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Millikin <john@john-millikin.com>
Message-ID: <ed1d5611-a0e6-7629-c827-a17112944c5f@john-millikin.com>
Date:   Fri, 25 Dec 2020 22:30:43 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax for POSIX regexes technically doesn't allow empty branches in
conditional match groups. GNU libc accepts them as equivalent to `()',
but other libc implementations (e.g. macOS libc) reject them with a
parse error.

Changing to compliant syntax, `(|_sym)' to `(()|_sym)', lets the `relocs'
tool run successfully when using a non-GNU platform as a build host for
cross-compiling the kernel.

Signed-off-by: John Millikin <john@john-millikin.com>
---

Helper binary to verify behavior for the current platform:

    #include <regex.h>
    #include <stdio.h>
    int main(int argc, char **argv) {
        regex_t compiled;
        int err = regcomp(&compiled, argv[1], REG_EXTENDED|REG_NOSUB);
        if (err != 0) {
            char errbuf[128];
            regerror(err, &compiled, errbuf, sizeof(errbuf));
            printf("regcomp(\"%s\"): %s\n", argv[1], errbuf);
           return 1;
        }
        printf("regcomp(\"%s\"): OK\n", argv[1]);
        return 0;
    }

Output from GNU libc 2.28 and a fussier non-GNU libc:

    debian:~$ ./regcomp '^a(|b)$'
    regcomp("^a(|b)$"): OK
    debian:~$ ./regcomp '^a(()|b)$'
    regcomp("^a(()|b)$"): OK

    darwin:~$ ./regcomp '^a(|b)$'
    regcomp("^a(|b)$"): empty (sub)expression
    darwin:~$ ./regcomp '^a(()|b)$'
    regcomp("^a(()|b)$"): OK

 arch/x86/tools/relocs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ce7188cbdae5..e6f28616a625 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -57,12 +57,12 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
     [S_REL] =
     "^(__init_(begin|end)|"
     "__x86_cpu_dev_(start|end)|"
-    "(__parainstructions|__alt_instructions)(|_end)|"
-    "(__iommu_table|__apicdrivers|__smp_locks)(|_end)|"
+    "(__parainstructions|__alt_instructions)(()|_end)|"
+    "(__iommu_table|__apicdrivers|__smp_locks)(()|_end)|"
     "__(start|end)_pci_.*|"
     "__(start|end)_builtin_fw|"
-    "__(start|stop)___ksymtab(|_gpl|_unused|_unused_gpl|_gpl_future)|"
-    "__(start|stop)___kcrctab(|_gpl|_unused|_unused_gpl|_gpl_future)|"
+    "__(start|stop)___ksymtab(()|_gpl|_unused|_unused_gpl|_gpl_future)|"
+    "__(start|stop)___kcrctab(()|_gpl|_unused|_unused_gpl|_gpl_future)|"
     "__(start|stop)___param|"
     "__(start|stop)___modver|"
     "__(start|stop)___bug_table|"
-- 
2.29.2

