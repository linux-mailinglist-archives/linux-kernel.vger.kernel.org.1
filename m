Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A26200291
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFSHOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:14:38 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:56829 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbgFSHOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:14:37 -0400
X-Greylist: delayed 1026 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 03:14:36 EDT
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 49p8kf2y85zDSs
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 02:57:30 -0400 (EDT)
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 49p8kc55jszTg9;
        Fri, 19 Jun 2020 02:57:28 -0400 (EDT)
Date:   Thu, 18 Jun 2020 23:57:27 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
In-Reply-To: <20200619065007.GA3041@lst.de>
Message-ID: <alpine.DEB.2.22.394.2006182351090.9276@xps-7390>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390> <20200619065007.GA3041@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jun 2020, Christoph Hellwig wrote:

> That is indeed really strange, as that commit is just a rename.
> Well, Linus also added swapping of the argument order, but again it
> shouldn't change much.

Thing is, there's other examples of the previous version in the kernel tree- any
chance there's a usage conflict (Thunderbolt has a ROM in it, maybe something in
"probe_roms.c"? (Just guessing, no idea):

----
afind probe_kernel_address
./lib/test_lockup.c:        probe_kernel_address(ptr, buf) ||
./lib/test_lockup.c:        probe_kernel_address(ptr + size - 1, buf)) {
./lib/test_lockup.c:    if (probe_kernel_address(ptr, magic) || magic != expected) {
./arch/arm64/kernel/traps.c:            if (probe_kernel_address((__force __le32 *)pc, instr_le))
./arch/sh/kernel/traps.c:       if (probe_kernel_address((insn_size_t *)addr, opcode))
./arch/x86/kernel/traps.c:      if (probe_kernel_address((unsigned short *)addr, ud))
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom_list, device) != 0)
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom + 0x18, offset) != 0)
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom + offset + 0x4, vendor) != 0)
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom + offset + 0x6, device) != 0)
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom + offset + 0x8, list) == 0 &&
./arch/x86/kernel/probe_roms.c:             probe_kernel_address(rom + offset + 0xc, rev) == 0 &&
./arch/x86/kernel/probe_roms.c: return probe_kernel_address(ptr, sig) == 0 && sig == ROMSIGNATURE;
./arch/x86/kernel/probe_roms.c: for (sum = 0; length && probe_kernel_address(rom++, c) == 0; length--)
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom + 2, c) != 0)
./arch/x86/kernel/probe_roms.c:         if (probe_kernel_address(rom + 2, c) != 0)
./arch/x86/mm/fault.c:          if (probe_kernel_address(instr, opcode))
./arch/x86/mm/fault.c:          if (probe_kernel_address(instr, opcode))
./arch/x86/mm/fault.c:  return probe_kernel_address((unsigned long *)p, dummy);
./arch/x86/pci/pcbios.c:                if (probe_kernel_address(&check->fields.signature, sig))
./arch/arm/mm/alignment.c:              fault = probe_kernel_address(ip, instr);
./arch/arm/mm/alignment.c:              fault = probe_kernel_address(ip, instr);
./arch/s390/mm/fault.c: return probe_kernel_address((unsigned long *)p, dummy);
./arch/powerpc/kernel/process.c:                    probe_kernel_address((const void *)pc, instr)) {
./arch/powerpc/kernel/kprobes.c:                if (probe_kernel_address(addr, instr))
./arch/powerpc/sysdev/fsl_pci.c:                        ret = probe_kernel_address((void *)regs->nip, inst);
./arch/riscv/kernel/kgdb.c:     if (probe_kernel_address((void *)pc, op_code))
./arch/riscv/kernel/kgdb.c:     error = probe_kernel_address((void *)addr, stepped_opcode);
./arch/riscv/kernel/traps.c:    if (probe_kernel_address((bug_insn_t *)pc, insn))
./arch/riscv/kernel/traps.c:    if (probe_kernel_address((bug_insn_t *)pc, insn))
----

> Do you see any compiler warnings or something
> odd in the kernel log before the actual crash?

Not that I could see, but I'll try building again later on.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
