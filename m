Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C672D6296
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392038AbgLJQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:54:32 -0500
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:37860 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391053AbgLJOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:36:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8A46E180206F5;
        Thu, 10 Dec 2020 14:36:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:1801:1981:2194:2197:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:7904:10004:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12895:13019:13161:13229:13439:13894:14181:14659:14721:21080:21221:21433:21451:21627:21740:21939:21990:30012:30029:30054:30056:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:15,LUA_SUMMARY:none
X-HE-Tag: elbow97_3e04abc273f9
X-Filterd-Recvd-Size: 5049
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Dec 2020 14:36:07 +0000 (UTC)
Message-ID: <97a20537627bb281745fee157713200830c3a7bb.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add --fix option to IS_ENABLED_CONFIG check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Thu, 10 Dec 2020 06:36:06 -0800
In-Reply-To: <20201210141903.72327-1-dwaipayanray1@gmail.com>
References: <20201210141903.72327-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-10 at 19:49 +0530, Dwaipayan Ray wrote:
> Documentation/process/coding-style.rst specifies the use of
> IS_ENABLED macro:
> 
> Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
> symbol into a C boolean expression, and use it in a normal C conditional:
> 
> 	if (IS_ENABLED(CONFIG_SOMETHING)) {
> 		...
> 	}
> 
> checkpatch correspondingly has a check for IS_ENABLED() without
> CONFIG_<FOO>.
> Add a --fix option to the check to automatically correct the argument.
> 
> Macros like:
>  #if IS_ENABLED(THERMAL)
> 
> is corrected to:
>  #if IS_ENABLED(CONFIG_THERMAL)

I think adding a --fix option here is not a good option.

Look at the existing uses without CONFIG and tell me
the majority of them need to have CONFIG added.

$ git grep -P '\bIS_ENABLED\s*\(\s*(?!CONFIG_)'
arch/arc/include/asm/asserts.h: chk_opt_strict(#opt_name, hw_exists, IS_ENABLED(opt_name));     \
arch/arc/include/asm/asserts.h: chk_opt_weak(#opt_name, hw_exists, IS_ENABLED(opt_name));       \
arch/arc/include/asm/setup.h:#define IS_USED_CFG(cfg)   IS_USED_RUN(IS_ENABLED(cfg))
arch/arm64/include/asm/alternative-macros.h:    __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
arch/arm64/include/asm/alternative-macros.h:    alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
arch/arm64/include/asm/cpufeature.h:    (IS_ENABLED(config) ? FTR_VISIBLE : FTR_HIDDEN)
arch/x86/mm/numa.c:     if (IS_ENABLED(NODE_NOT_IN_PAGE_FLAGS)) {
drivers/gpu/drm/exynos/exynos_drm_drv.c:#define DRV_PTR(drv, cond) (IS_ENABLED(cond) ? &drv : NULL)
drivers/gpu/drm/i915/i915_utils.h: * This is a lookalike for IS_ENABLED() that takes a kconfig value,
drivers/gpu/drm/i915/i915_utils.h: * Sadly IS_ENABLED() itself does not work with kconfig values.
drivers/gpu/drm/rockchip/rockchip_drm_drv.c:    if (IS_ENABLED(cond) && \
drivers/net/wireguard/allowedips.c:             WARN_ON(IS_ENABLED(DEBUG) && *len >= 128);
drivers/net/wireguard/allowedips.c:             WARN_ON(IS_ENABLED(DEBUG) && len >= 128);                      \
drivers/net/wireguard/noise.c:  WARN_ON(IS_ENABLED(DEBUG) &&
drivers/net/wireguard/selftest/allowedips.c:    if (IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)) {
drivers/net/wireguard/selftest/allowedips.c:    if (IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)) {
drivers/net/wireguard/selftest/allowedips.c:    if (IS_ENABLED(DEBUG_RANDOM_TRIE) && success)
drivers/phy/broadcom/phy-brcm-usb-init.h:       if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
drivers/phy/broadcom/phy-brcm-usb-init.h:       if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
include/asm-generic/vmlinux.lds.h:#define OF_TABLE(cfg, name)   __OF_TABLE(IS_ENABLED(cfg), name)
include/crypto/blake2s.h:       WARN_ON(IS_ENABLED(DEBUG) && (!outlen || outlen > BLAKE2S_HASH_SIZE ||
include/crypto/blake2s.h:       WARN_ON(IS_ENABLED(DEBUG) && ((!in && inlen > 0) || !out || !outlen ||
include/linux/init.h:   int var = IS_ENABLED(config);                                   \
include/linux/kconfig.h: * This is similar to IS_ENABLED(), but returns false when invoked from
include/linux/kconfig.h:#define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
include/linux/page-flags-layout.h: * the IS_ENABLED() macro.
include/linux/raid/pq.h:#define IS_ENABLED(x) (x)
lib/crypto/blake2s-generic.c:   WARN_ON(IS_ENABLED(DEBUG) &&
lib/crypto/blake2s.c:   WARN_ON(IS_ENABLED(DEBUG) && !out);
lib/crypto/chacha20poly1305-selftest.c: for (total_len = POLY1305_DIGEST_SIZE; IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
lib/test_ubsan.c:                       #config, IS_ENABLED(config) ? "y" : "n");       \
scripts/checkpatch.pl:# check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
scripts/checkpatch.pl:                       "IS_ENABLED($1) is normally used as IS_ENABLED(${CONFIG_}$1)\n" . $herecurr);
scripts/checkpatch.pl:                           "Prefer IS_ENABLED(<FOO>) to ${CONFIG_}<FOO> || ${CONFIG_}<FOO>_MODULE\n" . $herecurr) &&
scripts/checkpatch.pl:                          $fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
tools/testing/scatterlist/linux/mm.h:#define IS_ENABLED(x) (0)



