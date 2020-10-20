Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4B2941B5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbgJTRry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403854AbgJTRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:47:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E9C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:47:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1066001385d15f8339d059.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:6600:1385:d15f:8339:d059])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 69AA51EC0286;
        Tue, 20 Oct 2020 19:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603216071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jZY0cP9e2uOaVRaW2NKgi/EPOgHDQnS8s+rRzP+9cgU=;
        b=dO0GaT60tCuh0cqDjMBSpR++P64Cz8btck6Bv47g8wDgewa5NY7D+/4JYduqSxV3T8Jv/3
        Gd9ljUNL5tgYyVr9O5Cwpqi77bR67FguipY3SfCqerI5YbhoncvgDNKBYtEiDGGEHMXcST
        KBoJagVdWpjhR5S+dqvpH+zVU0aSpZ4=
Date:   Tue, 20 Oct 2020 19:47:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20201020174741.GJ11583@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae3367ab7d4eb4778b51f798436ab975d7f8a303.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:21:48AM -0700, Srinivas Pandruvada wrote:
> These command id are model specific. There is no guarantee that even
> meaning changes. So I don't think we should write any code in kernel
> which can't stick.

Ok, is there a common *set* of values present on all models?

A common set which we can abstract out from the MSR and have userspace
write them into sysfs and the kernel does the model-specific write?

The sysfs interface should simply provide the functionality, like, for
example say: "we have X valid undervolt indices, choose one".

Userspace doesn't have to deal with *how* that write happens and which
bits need to be set in the MSR and depend on the model - that's all
abstracted away by the kernel. All userspace needs to care about is
*what* it wants done to the hw. The *how exactly* is done by the kernel.

And then the differences are done with x86 model tests.

Does that make more sense?

> May be something like this:
> - Separate mailbox stuff from intel_turbo_max_3.c

Yah, that makes sense.

> - Create a standalone module which creates a debugfs interface
> - This debugs interface takes one 64 bit value from user space and use
> protocol to avoid contention

We can't make debugfs an API - debugfs can change at any point in time.
If you want an API, you put it in sysfs or in a separate fs.

> - Warns users on writes via new interfaces you suggested above

> > #define MSR_ADDR_TEMPERATURE 0x1a2
> Need to check use case for undervolt.

throttled uses it too. I asked them today to talk to us to design a
proper interface which satisfies their needs:

https://github.com/erpalma/throttled/issues/215

> > #define MSR_ADDR_UNITS 0x606
> Why not reuse powercap rapl interface. That interface will take care of
> units.

Sure.

Btw, you should have a look at those tools - they all poke at all kinds
of MSRs and correcting that is like a whack-a-mole game... ;-\

Oh, and the kernel pokes at them too so imagine the surprise one would have when
some kernel driver like

drivers/thermal/intel/int340x_thermal/processor_thermal_device.c

went and read some MSRs and then all of a sudden they changed because
some userspace daemon wrote them underneath it. Not good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
