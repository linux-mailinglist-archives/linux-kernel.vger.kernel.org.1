Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070521F840A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFMPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 11:54:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgFMPyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:54:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A9DDAB76;
        Sat, 13 Jun 2020 15:54:54 +0000 (UTC)
Date:   Sat, 13 Jun 2020 17:54:49 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
        glider@google.com, peterz@infradead.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: AMD SME + KASAN = doom
Message-ID: <20200613155449.GB3090@zn.tnic>
References: <20200613152408.GB992@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200613152408.GB992@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 11:24:08AM -0400, Qian Cai wrote:
> CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y + KASAN (inline) will reset
> the host right away after those lines on linux-next (the mainline has
> the same problem when I tested a while back, so it seems never work),

$ head arch/x86/mm/Makefile
# SPDX-License-Identifier: GPL-2.0
# Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
KCOV_INSTRUMENT_tlb.o                   := n
KCOV_INSTRUMENT_mem_encrypt.o           := n
KCOV_INSTRUMENT_mem_encrypt_identity.o  := n

KASAN_SANITIZE_mem_encrypt.o            := n
KASAN_SANITIZE_mem_encrypt_identity.o   := n

so something else needs to be de-KASAN-ed too.

For now flip your Subject: AMD SME - KASAN = boot.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
