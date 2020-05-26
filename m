Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4671A1E64
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDHJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 05:58:21 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56289 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:58:20 -0400
X-Originating-IP: 84.210.220.251
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EEA966000F;
        Wed,  8 Apr 2020 09:58:17 +0000 (UTC)
Subject: Re: [PATCH] arm64: armv8_deprecated: Fix undef_hook mask for thumb
 setend
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com
References: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
 <20200407092744.GA2665@gaia> <a2b345a4-30a0-3218-8c8d-e84ec2317dc9@arm.com>
 <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
 <20200408090111.GA27331@gaia>
From:   Fredrik Strupe <fredrik@strupe.net>
Message-ID: <9979396e-5d01-0cfe-722f-3a4f6e81dc01@strupe.net>
Date:   Wed, 8 Apr 2020 11:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200408090111.GA27331@gaia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.2020 11:01, Catalin Marinas wrote:
> On Tue, Apr 07, 2020 at 01:18:21PM +0200, Fredrik Strupe wrote:
>> (Sorry for duplicate, something went terribly wrong with the formatting of
>> the previous email.)
>
> It's still wrong here with tabs converted to spaces. The patch doesn't
> apply. Could you please send the patch separately as a v2? It looks fine
> otherwise.
>
> Thanks.
>

Alright, let's hope third time's the charm.

Fredrik

---
For thumb instructions, call_undef_hook() in traps.c first reads a u16,
and if the u16 indicates a T32 instruction (u16 >= 0xe800), a second
u16 is read, which then makes up the the lower half-word of a T32
instruction. For T16 instructions, the second u16 is not read,
which makes the resulting u32 opcode always have the upper half set to
0.

However, having the upper half of instr_mask in the undef_hook set to 0
masks out the upper half of all thumb instructions - both T16 and T32.
This results in trapped T32 instructions with the lower half-word equal
to the T16 encoding of setend (b650) being matched, even though the upper
half-word is not 0000 and thus indicates a T32 opcode.

An example of such a T32 instruction is eaa0b650, which should raise a
SIGILL since T32 instructions with an eaa prefix are unallocated as per
Arm ARM, but instead works as a SETEND because the second half-word is set
to b650.

This patch fixes the issue by extending instr_mask to include the
upper u32 half, which will still match T16 instructions where the upper
half is 0, but not T32 instructions.

Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: 2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks")
---
 arch/arm64/kernel/armv8_deprecated.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 9d3442d62..8c06dfee0 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -609,7 +609,7 @@ static struct undef_hook setend_hooks[] = {
 	},
 	{
 		/* Thumb mode */
-		.instr_mask	= 0x0000fff7,
+		.instr_mask	= 0xfffffff7,
 		.instr_val	= 0x0000b650,
 		.pstate_mask	= (PSR_AA32_T_BIT | PSR_AA32_MODE_MASK),
 		.pstate_val	= (PSR_AA32_T_BIT | PSR_AA32_MODE_USR),
-- 
2.20.1

