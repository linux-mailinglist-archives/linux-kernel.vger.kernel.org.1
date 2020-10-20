Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D063C294152
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395369AbgJTRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:22:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:24521 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395296AbgJTRWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:22:05 -0400
IronPort-SDR: TPxQYRhW7ZMv4r0oVEdqrM3rwUlyx/4N1dlS2MM5J/cQO5OvToEd+Xu8a9mVUkLU369xae6xcf
 DbGsTw5tEbDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="154196513"
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400"; 
   d="scan'208";a="154196513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 10:21:51 -0700
IronPort-SDR: HtN3cdlKQDHuLuDwNveApLKcw3czqHdOacTn3X+t0rmM7DGQ38ClHeWe7gXdv26v7sb1E6Ei/D
 k77UkLdPUgUg==
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400"; 
   d="scan'208";a="353402885"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.136.168])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 10:21:50 -0700
Message-ID: <ae3367ab7d4eb4778b51f798436ab975d7f8a303.camel@linux.intel.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Oct 2020 10:21:48 -0700
In-Reply-To: <20201019171539.GF24325@zn.tnic>
References: <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
         <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
         <20200908172558.GG25236@zn.tnic>
         <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
         <20200908173656.GI25236@zn.tnic>
         <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
         <20200908180112.GK25236@zn.tnic>
         <20200908191838.GA2014@sultan-box.localdomain>
         <20200908193029.GM25236@zn.tnic>
         <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
         <20201019171539.GF24325@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-19 at 19:15 +0200, Borislav Petkov wrote:
> On Tue, Sep 08, 2020 at 06:02:05PM -0700, Srinivas Pandruvada wrote:
> > The actual OC mailbox implementation itself is implemented in Linux
> > in
> > intel_turbo_max_3 driver. So that is public.
> > So someone can develop a driver and provide some sysfs to send
> > mailbox
> > commands, but kernel can't validate commands which can cause any
> > security or stability issues. Not sure if this is acceptable
> > standard.
> > I don't think there is any precedent of creating such blind sysfs
> > entries.
> 
> So we don't need to validate those commands - we can issue a
> pr_warn_once() when something pokes at that to say that issuing those
> commands is dangerous.
> 
> For example, from looking at
> 
> drivers/platform/x86/intel_turbo_max_3.c::get_oc_core_priority()
> 
> we should at least provide a well-defined interface to at least
> synchronize access to that MSR with the kernel. And then maybe allow
> a
> well-defined set of commands or better yet, we do them ourselves.
> Here's
> what I mean:
> 
> Looking at the code in intel-undervolt:
> 
> bool undervolt(struct config_t * config, bool * nl, bool write) {
> 	bool success = true;
> 	bool nll = false;
> 	int i;
> 
> 	for (i = 0; config->undervolts && i < config->undervolts-
> >count; i++) {
> 		struct undervolt_t * undervolt = array_get(config-
> >undervolts, i);
> 
> 		static const int mask = 0x800;
> 		uint64_t uvint = ((uint64_t) (mask - absf(undervolt-
> >value) * 1.024f +
> 			0.5f) << 21) & 0xffffffff;
> 		uint64_t rdval = 0x8000001000000000 |
> 			((uint64_t) undervolt->index << 40);
> 		uint64_t wrval = rdval | 0x100000000 | uvint;
> 
> 		bool write_success = !write ||
> 			wr(config, MSR_ADDR_VOLTAGE, wrval);
> 		bool read_success = write_success &&
> 			wr(config, MSR_ADDR_VOLTAGE, rdval) &&
> 			rd(config, MSR_ADDR_VOLTAGE, rdval);
> 
> 
> That MSR_ADDR_VOLTAGE is 0x150, i.e., MSR_OC_MAILBOX.
> 
> Trying to decipher the MSR accesses, it looks like it does the write
> with:
> 
> 0x8000001000000000 | (0xf << 40) | (0x3 << 21) | 0x100000000
> 
> and I've made the uvint 0x3 so that I can see the two 11s in the
> bitfield below.
> 
> The undervolt index I made 0xffff for a similar reason:
> 
> And the result is:
> 
> Hex: 0x80000f1100600000 Dec: 9.223.388.602.549.927.936
> 31   27   23   19   15   11   7    3    31   27   23   19   15   11  
>  7    3   
> 1000_0000_0000_0000_0000_1111_0001_0001_0000_0000_0110_0000_0000_0000
> _0000_0000
> 63   59   55   51   47   43   39   35   31   27   23   19   15   11  
>  7    3
> 
> With 
> 
> - bit 63: MSR_OC_MAILBOX_BUSY_BIT
> 
> - [47?:40]: that's some index, undervolting index, who knows. I'm
> assuming this is
> a byte, thus the 47?.
> 
> 
> - [39?:32]: cmd, in this case, 0x11, gonna assume that the command is
> bits [39:32]
> looking how this is a byte too:
> 
> #define OC_MAILBOX_FC_CONTROL_CMD	0x1C
> 
> and 
> 
> - [31:21]: the undervolt value
> 
> The second write does:
> 
> 0x8000001000000000 | (0xf << 40)
> Hex: 0x80000f1000000000 Dec: 9.223.388.598.248.669.184
> 31   27   23   19   15   11   7    3    31   27   23   19   15   11  
>  7    3   
> 1000_0000_0000_0000_0000_1111_0001_0000_0000_0000_0000_0000_0000_0000
> _0000_0000
> 63   59   55   51   47   43   39   35   31   27   23   19   15   11  
>  7    3
> 
> - bit 63: MSR_OC_MAILBOX_BUSY_BIT
> - [47:40] index
> - [39:32] cmd - 0x10
> 
> All from only staring at this anyway - could very well be wrong.
> 
These command id are model specific. There is no guarantee that even
meaning changes. So I don't think we should write any code in kernel
which can't stick.


> In any case, my point is that we could have a sysfs interface for
> those userspace-suppliable values like the undervolt value at
> [31:21],
> dunno if the index can be inferred by the kernel automatically or
> enumerated and the commands we should issue ourselves depending on
> the
> functionality, etc.
> 
> And put all that in drivers/platform/x86/intel_turbo_max_3.c instead
> of
> leaving userspace to poke at it.
> 
May be something like this:
- Separate mailbox stuff from intel_turbo_max_3.c
- Create a standalone module which creates a debugfs interface
- This debugs interface takes one 64 bit value from user space and use
protocol to avoid contention
- Warns users on writes via new interfaces you suggested above

> Thoughts?
> 
> Btw, intel-undervolt pokes all in all at:
> 
> #define MSR_ADDR_TEMPERATURE 0x1a2
Need to check use case for undervolt.

> #define MSR_ADDR_UNITS 0x606
Why not reuse powercap rapl interface. That interface will take care of
units.

> #define MSR_ADDR_VOLTAGE 0x150
This will not be needed once we expose the above debugfs interface.
This is the OC mailbox MSR.

Thanks,
Srinivas

> 
> and those should probably be exposed too.
> 
> The temperature target one is read at least by this too:
> 
> https://py3status.readthedocs.io/en/latest/modules.html
> 
> but at least that MSR is documented so exposing it is trivial.
> 
> Thx.
> 

