Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4052E28FABA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgJOVfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:35:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32983 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbgJOVfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:35:50 -0400
Received: from wld157.hos.anvin.org (c-24-6-168-49.hsd1.ca.comcast.net [24.6.168.49])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 09FLZ0WN196358
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 15 Oct 2020 14:35:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 09FLZ0WN196358
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020092401; t=1602797701;
        bh=c86/D9gVtdvVpt57v/o95q7X9sRnRZYl1GfvTq4aHyg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=BdXlUsqnHPsbsKNTloyFkkIlSTIewttnxooRTNMUaG1GZRJF1+Gup8dZVUR502IYk
         YmJe6zXymmhHG0bUgAOLLoSh6WNWAS/eLUc1OpNz4BKYqsd9w47FKKvKh9gR6XRpN6
         ph3Usln89aT7cM95dOX1PRDfBV5zEkEA796ipOxQw0fT5Asjp/EO/HXE6D7XaiRobX
         gLQcf5BajKBG8d35Q0MrEtTZy5y+f4oSV2VegZEfiTUfLmBglTRT6qZTcEdI9BXpiZ
         FggXYiTCFmecc0yWgeYkl/hVW8PEfgZ/7e0Y5TksIlLsjIwwlwtT+3u/u33CALRIAt
         mNe3Blrvfkh+Q==
Date:   Thu, 15 Oct 2020 14:34:57 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20201015161216.1563600-1-irogers@google.com>
References: <20201015161216.1563600-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] x86/insn, tools/x86: Fix some potential undefined behavior.
To:     Ian Rogers <irogers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Numfor Mbiziwo-Tiapo <nums@google.com>
From:   hpa@zytor.com
Message-ID: <5E711F64-A9BF-48EC-83A3-3C644D80F848@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2020 9:12:16 AM PDT, Ian Rogers <irogers@google=2Ecom> wrote=
:
>From: Numfor Mbiziwo-Tiapo <nums@google=2Ecom>
>
>Don't perform unaligned loads in __get_next and __peek_nbyte_next as
>these are forms of undefined behavior=2E
>
>These problems were identified using the undefined behavior sanitizer
>(ubsan) with the tools version of the code and perf test=2E Part of this
>patch was previously posted here:
>https://lore=2Ekernel=2Eorg/lkml/20190724184512=2E162887-4-nums@google=2E=
com/
>
>v2=2E removes the validate_next check and merges the 2 changes into one
>as
>requested by Masami Hiramatsu <mhiramat@kernel=2Eorg>
>
>Signed-off-by: Ian Rogers <irogers@google=2Ecom>
>Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google=2Ecom>
>---
> arch/x86/lib/insn=2Ec       | 4 ++--
> tools/arch/x86/lib/insn=2Ec | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/lib/insn=2Ec b/arch/x86/lib/insn=2Ec
>index 404279563891=2E=2Ebe88ab250146 100644
>--- a/arch/x86/lib/insn=2Ec
>+++ b/arch/x86/lib/insn=2Ec
>@@ -20,10 +20,10 @@
> 	((insn)->next_byte + sizeof(t) + n <=3D (insn)->end_kaddr)
>=20
> #define __get_next(t, insn)	\
>-	({ t r =3D *(t*)insn->next_byte; insn->next_byte +=3D sizeof(t); r; })
>+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=3D
>sizeof(t); r; })
>=20
> #define __peek_nbyte_next(t, insn, n)	\
>-	({ t r =3D *(t*)((insn)->next_byte + n); r; })
>+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
>=20
> #define get_next(t, insn)	\
>	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out;
>__get_next(t, insn); })
>diff --git a/tools/arch/x86/lib/insn=2Ec b/tools/arch/x86/lib/insn=2Ec
>index 0151dfc6da61=2E=2E92358c71a59e 100644
>--- a/tools/arch/x86/lib/insn=2Ec
>+++ b/tools/arch/x86/lib/insn=2Ec
>@@ -20,10 +20,10 @@
> 	((insn)->next_byte + sizeof(t) + n <=3D (insn)->end_kaddr)
>=20
> #define __get_next(t, insn)	\
>-	({ t r =3D *(t*)insn->next_byte; insn->next_byte +=3D sizeof(t); r; })
>+	({ t r; memcpy(&r, insn->next_byte, sizeof(t)); insn->next_byte +=3D
>sizeof(t); r; })
>=20
> #define __peek_nbyte_next(t, insn, n)	\
>-	({ t r =3D *(t*)((insn)->next_byte + n); r; })
>+	({ t r; memcpy(&r, (insn)->next_byte + n, sizeof(t)); r; })
>=20
> #define get_next(t, insn)	\
>	({ if (unlikely(!validate_next(t, insn, 0))) goto err_out;
>__get_next(t, insn); })

Wait, what?

You are taking about x86-specific code, and on x86 unaligned memory access=
es are supported, well-defined, and ubiquitous=2E=20

This is B=2ES=2E at best, and unless the compiler turns the memcpy() right=
 back into what you started with, deleterious for performance=2E

If you have a *very* good reason for this kind of churn, wrap it in the un=
aligned access macros, but using memcpy() is insane=2E All you are doing is=
 making the code worse=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
