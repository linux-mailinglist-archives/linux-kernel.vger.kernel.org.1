Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22B11E59E5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgE1HyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 03:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1HyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:54:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B16F20899;
        Thu, 28 May 2020 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590652464;
        bh=PrWtcly4mSIxq6xvX0BT2n5SIuYjluRSR6BsVqU0pRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBTUoTw4WBBjrctA2lgQMN+f9rzpSob4VFN0mXonOjpXqWs3hd1r1Tkq9kxdcjKZ3
         qNQF95aIn9eBj8IHBcqlBHV3GvXcXsjlVHOLIFyxeCTABQhFaN2dD0IO1gokLxAsRc
         FHOJ5cY8U+hBGL0n4m+2ePFTBnMiKe5/7D4KXRYk=
Date:   Thu, 28 May 2020 08:54:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Jiping Ma <Jiping.Ma2@windriver.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200528075418.GB22156@willie-the-truck>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
 <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:06:07AM +0800, Jiping Ma wrote:
> On 05/27/2020 11:19 PM, Mark Rutland wrote:
> > On Wed, May 27, 2020 at 09:33:00AM +0800, Jiping Ma wrote:
> > > On 05/26/2020 06:26 PM, Mark Rutland wrote:
> > > > On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
> > > This modification can not fix our issue,� we need
> > > perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 32-bit
> > > task or not,
> > > then return the correct PC value.
> > I must be missing something here.
> > 
> > The core code perf_reg_abi(task) is called with the task being sampled,
> > and the regs are from the task being sampled. For a userspace sample for
> > a compat task, compat_user_mode(regs) should be equivalent to the
> > is_compat_thread(task_thread_info(task)) check.
> > 
> > What am I missing?
> This issue caused by PC value is not correct. regs are sampled in function
> perf_output_sample_regs, that call perf_reg_value(regs, bit) to get PC
> value.
> PC value is regs[15] in perf_reg_value() function. it should be regs[32].
> 
> perf_output_sample_regs(struct perf_output_handle *handle,
> ����������������������� struct pt_regs *regs, u64 mask)
> {
> ������� int bit;
> ������� DECLARE_BITMAP(_mask, 64);
> 
> ������� bitmap_from_u64(_mask, mask);
> ������� for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
> ��������������� u64 val;
> 
> ��������������� val = perf_reg_value(regs, bit);
> ��������������� perf_output_put(handle, val);
> ������� }
> }

Yes, but Mark's point is that checking 'compat_user_mode(regs)' should be
exactly the same as checking 'perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32'.
Are you saying that's not the case? If so, please can you provide an example
of when they are different?

Leaving that aside for a second, I also think it's reasonable to question
whether this whole interface is busted or not. I looked at it last night but
struggled to work out what it's supposed to do. Consider these three
scenarios, all under an arm64 kernel:

  1. 64-bit perf + 64-bit application being profiled
  2. 64-bit perf + 32-bit application being profiled
  3. 32-bit perf + 32-bit application being profiled

It looks like the current code is a bodge to try to handle both (2) and
(3) at the same time:

  - In case (3), userspace only asks about registers 0-15
  - In case (2), we fudge the higher registers so that 64-bit SP and LR
    hold the 32-bit values as a bodge to allow a 64-bit dwarf unwinder
    to unwind the stack

So the idea behind the patch looks fine because case (3) is expecting the PC
in register 15 and instead gets 0, but the temptation is to clean this up so
that cases (2) and (3) report the same data to userspace (along the lines of
Mark's patch), namely only the first 16 registers with the PC moved down. We
can only do that if the unwinder is happy, which it might be if it only ever
looks up dwarf register numbers based on the unwind tables in the binary.
Somebody would need to dig into that. Otherwise, if it generates unconditional
references to things like register 30 to grab the link register, then we're
stuck with the bodge and need to special-case the PC.

Thoughts?

Will
