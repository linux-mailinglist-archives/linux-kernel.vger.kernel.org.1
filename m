Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC82B5121
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKPT3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKPT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:29:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352E4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=BBb+0MAVRl4o+gsCUweO3CE8BYgSiGgb0WEbUxUtSNM=; b=t3YX5Pr5Jm0DVCluskREN3Aari
        K4yvnb8dD7Y5wolEiLfgGcDYPnQDQasMEFFlzyz14w3EefsbpqaIrfrtyGa1CHF0Q+p85CrSsmD5b
        qp1JSAmkXE31ScAV/X1XCGW2ZUA+q1FgL09Miv3pzCyjf67XFOwRa3361X/rO5KD67m9mDlm7IQVD
        reNIEWQS16u62+dK2M7CejNK7I+XPVbb5l6jO61dM6WoxX4HqvDK2PwIq4561iPIVbbuzO24K8sJX
        FOW5NhLJMNYWXU3ViXp8UFll/RXJIVI2JWxNKRHKj4BmhyWscmI+LQXVUndo7ADUG40tJK3gPMV+8
        Zh179aaA==;
Received: from [2601:1c0:6280:3f0::990e] (helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kekBP-0006V2-LK; Mon, 16 Nov 2020 19:28:59 +0000
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
 <87sg999ot0.fsf@igel.home>
 <0dbaca2d-9ad0-8c1a-a280-97be01cac2bd@infradead.org>
 <87k0ul9msr.fsf@igel.home>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3fff1eb9-83c0-1c29-6f57-fa50f1ec6ee7@infradead.org>
Date:   Mon, 16 Nov 2020 11:28:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87k0ul9msr.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 10:30 AM, Andreas Schwab wrote:
> On Nov 16 2020, Randy Dunlap wrote:
> 
>> What kernel version are you building?
> 
> 5.10-rc4
> 
> Andreas.

OK, thanks.

My build machine is slow, but I have a patch that I am testing:

---
From: Randy Dunlap <rdunlap@infradead.org>

riscv's <vdso/processor.h> uses barrier() so it should
#include <asm/barrier.h> to prevent build errors.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
---
  arch/riscv/include/asm/vdso/processor.h |    2 ++
  1 file changed, 2 insertions(+)

--- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
+++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
@@ -4,6 +4,8 @@

  #ifndef __ASSEMBLY__

+#include <asm/barrier.h>
+
  static inline void cpu_relax(void)
  {
  #ifdef __riscv_muldiv





