Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10942D5EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbgLJOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389817AbgLJOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:55:22 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8792C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:54:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so8567021lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6ptu9+yUqmrrvRHBz+Ms5c7MJTZlfGGguaJ8+pJhRs=;
        b=qxBha0sjMFxg78EJkra1StvHmiJuvX4oZdELZZHCiMYynG9+F2BGZs8Yaiw9qAKdi8
         fxY7UzrkO85flZO+CSrbBvebiSEju746gwY/NF4sBcdMiwzhEFWDk16DGFly+nVSgIc1
         LnJK7PLqlSTzXFJDHN7xtRWPo+m+1IsIwr43WWde3G8pDSP7KFg1I3Ie6gTsWrW0ncPr
         XY9y4A2Hu8YsqjB4iZVfOgDMk62zejdDD+8h1zWB06jIcljpu0N3Pque8hVyd5QqcD6q
         /5AbBTX81YZ/S2rW7rphnJ5dOCB0Y0uLvMMwbaYS/bGF7RUXBTOtwYp00VZfEvwEb/mc
         Bh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6ptu9+yUqmrrvRHBz+Ms5c7MJTZlfGGguaJ8+pJhRs=;
        b=XyxWl8OTY4gY2ohTA/N2lYW387Qsn3KG7GuCNaW4YjHSLd/gxaOx7xnYMQLx3Qk4Kc
         f4FWxT4Krcy0Dh6FwN8eDrA8qbHn0ZuNjJoF9ixJwF4ckqCYiBvUC427zH6C6xQU96l8
         Af3Kovomnyon8sRUpfOgOw5MuNr8bGsObZmoZlY7JPcMwfl61Ax1SjfUEQY2Cz8Eqj4V
         Gu2I8ig7FTdBS3LJCRq1OJnqDysFS+Tnjn5/zZX+LHUJtYwaz5ogF3Ca9/wRPsYoL3b1
         HoT6keQ9JbStZlJ1My7MxSmNTE56AZOx+ONDiDhj3ugRP1f73YvwXUGrx5nGkWCh5BQm
         kTAQ==
X-Gm-Message-State: AOAM53317S8h8BOBGuXRjEXSL4rRcoF1GEwcFtyhLucjPsxjfCSF4CGi
        SVuIvlmb01GsFbJ2BWx3HWT+ndu5lYygrV3q3jATcPs5/HwEhnxd
X-Google-Smtp-Source: ABdhPJx9BBe95t8VEi0zGcvOT3yVFSJe0tilLfooilcZm/UnWooZuHQA/ZBkhpu8dfmwgsQSCzqTTtmtUxFTJgle8F0=
X-Received: by 2002:a19:5f06:: with SMTP id t6mr2921786lfb.117.1607612080214;
 Thu, 10 Dec 2020 06:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20201210141903.72327-1-dwaipayanray1@gmail.com> <97a20537627bb281745fee157713200830c3a7bb.camel@perches.com>
In-Reply-To: <97a20537627bb281745fee157713200830c3a7bb.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 10 Dec 2020 20:24:15 +0530
Message-ID: <CABJPP5Cjyh1QekK7LnTbxYEgmtLMO81Vdu77tGTRrNhjL_iEcg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add --fix option to IS_ENABLED_CONFIG check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > checkpatch correspondingly has a check for IS_ENABLED() without
> > CONFIG_<FOO>.
> > Add a --fix option to the check to automatically correct the argument.
> >
> > Macros like:
> >  #if IS_ENABLED(THERMAL)
> >
> > is corrected to:
> >  #if IS_ENABLED(CONFIG_THERMAL)
>
> I think adding a --fix option here is not a good option.
>
> Look at the existing uses without CONFIG and tell me
> the majority of them need to have CONFIG added.
>
> $ git grep -P '\bIS_ENABLED\s*\(\s*(?!CONFIG_)'
> arch/arc/include/asm/asserts.h: chk_opt_strict(#opt_name, hw_exists, IS_ENABLED(opt_name));     \
> arch/arc/include/asm/asserts.h: chk_opt_weak(#opt_name, hw_exists, IS_ENABLED(opt_name));       \
> arch/arc/include/asm/setup.h:#define IS_USED_CFG(cfg)   IS_USED_RUN(IS_ENABLED(cfg))
> arch/arm64/include/asm/alternative-macros.h:    __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
> arch/arm64/include/asm/alternative-macros.h:    alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
> arch/arm64/include/asm/cpufeature.h:    (IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
> arch/x86/mm/numa.c:     if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
> drivers/gpu/drm/exynos/exynos_drm_drv.c:#define DRV_PTR(drv, cond) (IS_ENABLED(cond) ? &drv : NULL)
> drivers/gpu/drm/i915/i915_utils.h: * This is a lookalike for IS_ENABLED() that takes a kconfig value,
> drivers/gpu/drm/i915/i915_utils.h: * Sadly IS_ENABLED() itself does not work with kconfig values.
> drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    if (IS_ENABLED(cond) && \
> drivers/net/wireguard/allowedips.c:             WARN_ON(IS_ENABLED(DEBUG) && *len >= 128);
> drivers/net/wireguard/allowedips.c:             WARN_ON(IS_ENABLED(DEBUG) && len >= 128);                      \
> drivers/net/wireguard/noise.c:  WARN_ON(IS_ENABLED(DEBUG) &&
> drivers/net/wireguard/selftest/allowedips.c:    if (IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)) {
> drivers/net/wireguard/selftest/allowedips.c:    if (IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)) {
> drivers/net/wireguard/selftest/allowedips.c:    if (IS_ENABLED(DEBUG_RANDOM_TRIE) && success)
> drivers/phy/broadcom/phy-brcm-usb-init.h:       if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> drivers/phy/broadcom/phy-brcm-usb-init.h:       if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
> include/asm-generic/vmlinux.lds.h:#define OF_TABLE(cfg, name)   __OF_TABLE(IS_ENABLED(cfg), name)
> include/crypto/blake2s.h:       WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
> include/crypto/blake2s.h:       WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
> include/linux/init.h:   int var = IS_ENABLED(config);                                   \
> include/linux/kconfig.h: * This is similar to IS_ENABLED(), but returns false when invoked from
> include/linux/kconfig.h:#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
> include/linux/page-flags-layout.h: * the IS_ENABLED() macro.
> include/linux/raid/pq.h:#define IS_ENABLED(x) (x)
> lib/crypto/blake2s-generic.c:   WARN_ON(IS_ENABLED(DEBUG) &&
> lib/crypto/blake2s.c:   WARN_ON(IS_ENABLED(DEBUG) && !out);
> lib/crypto/chacha20poly1305-selftest.c: for (total_len = POLY1305_DIGEST_SIZE; IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
> lib/test_ubsan.c:                       #config, IS_ENABLED(config) ? "y" : "n");       \
> scripts/checkpatch.pl:# check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
> scripts/checkpatch.pl:                       "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
> scripts/checkpatch.pl:                           "Prefer IS_ENABLED(<FOO>) to ${CONFIG_}<FOO> || ${CONFIG_}<FOO>_MODULE\n" . $herecurr) &&
> scripts/checkpatch.pl:                          $fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
> tools/testing/scatterlist/linux/mm.h:#define IS_ENABLED(x) (0)
>
>

That's true.
The following looks okay to me:

IS_ENABLED(DEBUG)
IS_ENABLED(cfg)
IS_ENABLED(opt_name)
IS_ENABLED(option)
IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
IS_ENABLED(config)
IS_ENABLED(cond)
IS_ENABLED(__BIG_ENDIAN)
IS_ENABLED(x)
IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)

Adding a CONFIG_ in these would be wrong I think.
I will drop this patch.

Thank you,
Dwaipayan.
