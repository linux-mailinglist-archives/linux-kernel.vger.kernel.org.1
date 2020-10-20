Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5328C294243
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437555AbgJTSkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 14:40:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:63918 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389798AbgJTSkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 14:40:33 -0400
IronPort-SDR: NZBZfjVIwpsC/2OeVxRQeD7Pd177279Ze9mGQiK+x4e3MiX2vi2hr/56XbqttMqQlfYzJuR16L
 rHUDUTYVVssw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="147115622"
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400"; 
   d="scan'208";a="147115622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 11:40:31 -0700
IronPort-SDR: bshzyYqLcE1ANS+oDuToT1QTJqZXlJgLQ/AoSQuk7mSjDdIjpUkyyAaAqamr58E417S/9J89+s
 0xuHbIOEb+oA==
X-IronPort-AV: E=Sophos;i="5.77,398,1596524400"; 
   d="scan'208";a="533182999"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.136.168])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 11:40:29 -0700
Message-ID: <2147d5853a5a3e0d753fcc0a4ed330f61b29aa83.camel@linux.intel.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Oct 2020 11:40:28 -0700
In-Reply-To: <20201020174741.GJ11583@zn.tnic>
References: <20200908172558.GG25236@zn.tnic>
         <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
         <20200908173656.GI25236@zn.tnic>
         <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
         <20200908180112.GK25236@zn.tnic>
         <20200908191838.GA2014@sultan-box.localdomain>
         <20200908193029.GM25236@zn.tnic>
         <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
         <20201019171539.GF24325@zn.tnic>
         <ae3367ab7d4eb4778b51f798436ab975d7f8a303.camel@linux.intel.com>
         <20201020174741.GJ11583@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-20 at 19:47 +0200, Borislav Petkov wrote:
> On Tue, Oct 20, 2020 at 10:21:48AM -0700, Srinivas Pandruvada wrote:
> > These command id are model specific. There is no guarantee that
> > even
> > meaning changes. So I don't think we should write any code in
> > kernel
> > which can't stick.
> 
> Ok, is there a common *set* of values present on all models
Sorry, don't know.

> 
> A common set which we can abstract out from the MSR and have
> userspace
> write them into sysfs and the kernel does the model-specific write?
> 
> The sysfs interface should simply provide the functionality, like,
> for
> example say: "we have X valid undervolt indices, choose one".
> 
> Userspace doesn't have to deal with *how* that write happens and
> which
> bits need to be set in the MSR and depend on the model - that's all
> abstracted away by the kernel. All userspace needs to care about is
> *what* it wants done to the hw. The *how exactly* is done by the
> kernel.
> 
> And then the differences are done with x86 model tests.
> 
> Does that make more sense?
> 
> > May be something like this:
> > - Separate mailbox stuff from intel_turbo_max_3.c
> 
> Yah, that makes sense.
> 
> > - Create a standalone module which creates a debugfs interface
> > - This debugs interface takes one 64 bit value from user space and
> > use
> > protocol to avoid contention
> 
> We can't make debugfs an API - debugfs can change at any point in
> time.
> If you want an API, you put it in sysfs or in a separate fs.
Ok we can create a sysfs entry.

> 
> > - Warns users on writes via new interfaces you suggested above
> > > #define MSR_ADDR_TEMPERATURE 0x1a2
> > Need to check use case for undervolt.
> 
> throttled uses it too. I asked them today to talk to us to design a
> proper interface which satisfies their needs:
> 
> https://github.com/erpalma/throttled/issues/215
> 
> > > #define MSR_ADDR_UNITS 0x606
> > Why not reuse powercap rapl interface. That interface will take
> > care of
> > units.
> 
> Sure.
> 
> Btw, you should have a look at those tools - they all poke at all
> kinds
> of MSRs and correcting that is like a whack-a-mole game... ;-\
> 
> Oh, and the kernel pokes at them too so imagine the surprise one
> would have when
> some kernel driver like
> 
> drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> 
> went and read some MSRs and then all of a sudden they changed because
> some userspace daemon wrote them underneath it. Not good.
Agree, that poking MSR from user space is not a right thing to do.

Thanks,
Srinivas

> 
> Thx.
> 

