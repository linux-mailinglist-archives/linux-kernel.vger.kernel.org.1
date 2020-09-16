Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896B26BDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIPHD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIPHDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:03:32 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4A0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:03:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so5824850lff.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M12YDuTVvt+O6a6j14Ji1m8Yc8t57W8FWhVTEPcXPko=;
        b=X+UdvNV0gLviBsZVNU1eTnJvgyzJ3C/83NeiTvlFv7udajGxKr0hO38zMqHa83b64m
         +oqgNGtTVLDFVtMqM05F6psBG2lNed5ulXOAFTkKbXmc+0Vb0UN4/kJLUkPw1iZJyN+I
         4r4ckgPVogthrYw3zFLSdRpthF2O7GthuKTet7GVJzNAN6ZEw9srTNt1axssCUmpPh1J
         KJ3X2dNHUBnb1Xdv1OPPkYNYJD2256LYz3imAauX7ZeUM099TolyNv7yjHIQXIEdEbCI
         i3wldrXjsxExWSoH2Utwyok6GKvlg+l+LFav+40Zs4nQ8jQ6Zfcqm2j6ZStK4Hs9lVq7
         vpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M12YDuTVvt+O6a6j14Ji1m8Yc8t57W8FWhVTEPcXPko=;
        b=AqeFEey/UgS/EAcmQBxi7/x/wfFfLBkphMR2wYXt+Mbaq/ptTP7sEaJS5vHqFMSHRu
         2XMFkPFPf88Xp4YEqk6etRTxuegxT62AFvgU0ahznOpQykDRYb89Xhb9yVf0mz7VmNAY
         Y8XaucNXCQPDhOT05oivLIdk1V7YPzQZ+TtLOoRuvJFEi5kNHY4awF3acm3AnJAs+iuV
         C0BqSA3UPyOQT4r1OlOZnFfcISDFizuyadysX0Ktl4BbrRy3r4AHf6rdavhpLuZ5eGF1
         rWSRe/ivUxDwxpOJ6kW7SRMaOk6t1P9bllsRR3Rtsj0EjrxxvSf5Y6mQw3SO/+c9WUkI
         BetA==
X-Gm-Message-State: AOAM532FZmbhTHhGfC92+QaxkXZMEY9IRMG6y0R80G1ATBHw+TSZe6mi
        QwyzwaXdGYq8RfpiO62Hmf9AHejUXD8tzfM1a8A=
X-Google-Smtp-Source: ABdhPJzUy8QTD5LyU08DmUIRFAn8urrEgdi9G0nwiMU+5bZNnYnwgAe4yY9rBxaXbB9r+FlHjBf9UqTfoq1dlQutaqU=
X-Received: by 2002:a19:189:: with SMTP id 131mr6663801lfb.331.1600239808160;
 Wed, 16 Sep 2020 00:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic> <20200915210231.ysaibtkeibdm4zps@treble> <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
In-Reply-To: <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
From:   Ilie Halip <ilie.halip@gmail.com>
Date:   Wed, 16 Sep 2020 10:03:16 +0300
Message-ID: <CAHFW8PS0WYdfO01XwmLa+3w2W-z_FF_a5eeF8Z-YfuCMQ15ccw@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Should objtool be made aware of the config option and then not check
> traps after no-returns?
>
> I suspect the latter, but I'm not sure how feasible it is to
> implement.  Josh, Marco, do you have thoughts on the above?

This seems to do the trick.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f24f46..9224e6565ba2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2612,9 +2612,10 @@ static bool is_ubsan_insn(struct instruction *insn)
                        "__ubsan_handle_builtin_unreachable"));
 }

-static bool ignore_unreachable_insn(struct instruction *insn)
+static bool ignore_unreachable_insn(struct objtool_file *file, struct
instruction *insn)
 {
        int i;
+       struct instruction *prev_insn;

        if (insn->ignore || insn->type == INSN_NOP)
                return true;
@@ -2640,7 +2641,8 @@ static bool ignore_unreachable_insn(struct
instruction *insn)
         * the UD2, which causes GCC's undefined trap logic to emit another UD2
         * (or occasionally a JMP to UD2).
         */
-       if (list_prev_entry(insn, list)->dead_end &&
+       prev_insn = list_prev_entry(insn, list);
+       if ((prev_insn->dead_end || dead_end_function(file,
prev_insn->call_dest)) &&
            (insn->type == INSN_BUG ||
             (insn->type == INSN_JUMP_UNCONDITIONAL &&
              insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
@@ -2767,7 +2769,7 @@ static int
validate_reachable_instructions(struct objtool_file *file)
                return 0;

        for_each_insn(file, insn) {
-               if (insn->visited || ignore_unreachable_insn(insn))
+               if (insn->visited || ignore_unreachable_insn(file, insn))
                        continue;

                WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
