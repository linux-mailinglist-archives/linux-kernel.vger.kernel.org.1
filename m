Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71C51DA6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgETBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 21:04:21 -0400
Received: from mx.h4ck.space ([159.69.146.50]:58672 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:04:20 -0400
Date:   Wed, 20 May 2020 03:04:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1589936658;
        bh=SXL42srFoPlaa2GUG3aQEU4fKva96clfFImQwvvj0kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NJpU64f086GykurTVLJgzZg2h6QJW6hyh4o4awavfBwOCyTWlGRUa9QnS4i1WonMw
         LKgv1wirpX6uWaTATrjPhiaMog7MfV88X7cAFHU6iqgAoY/GOS2RzDZXNU2RCBr3A9
         cS4VU71DxdVi8Ap5My4DjUSGvn/An5DwMOEEqlf4=
From:   andi@notmuch.email
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200520010418.ippljxawcwrbp6o2@wrt>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
 <20200519194320.GA25138@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519194320.GA25138@ranerica-svr.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:43 19.05.20, Ricardo Neri wrote:
> > > Running the same executable on the exact same kernel (and userland) but
> > > on a Intel i7-8565U doesn't crash at this point. I am guessing the
> > > emulation is supposed to do something different on AMD CPUs?
> 
> I am surprised you don't see it on the Intel processor. Maybe it does
> not have UMIP. Do you see umip when you do
> 
> $ grep umip /proc/cpuinfo 

Indeed it doesn't ahve the feature. I would have assumed that it is
recent enough. Apparently not.

> > > On the Ryzen the code executes successfully after setting CONFIG_X86_UMIP=n.
> > 
> > Hi Andreas,
> > 
> > The problem is that the kernel does not emulate/spoof the SLDT instruction, only SGDT, SIDT, and SMSW.
> > SLDT and STR weren't thought to be commonly used, so emulation/spoofing wasn’t added.
> > In the last few months I have seen reports of one or two (32-bit) Windows games that use SLDT though.
> > Can you share more information about the application you’re running?
> > 
> > Maybe the best path is to add kernel emulation/spoofing for SLDT and STR on 32 and 64-bit, just to cover all the cases. It should be a pretty simple patch, I’ll start working on it.
> 
> I have a patch for this already that I wrote for testing purposes:
> 
> https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b93be50
> 
> Perhaps it can be used as a starting point? Not sure what the spoofing
> value should be, though. Perhaps 0?

I am not entirely sure what it should return in the general case. My
assumption is that 0 might work. Maybe making it configurable like with
the other UMIP constants that I saw?

I'll give the patch a shot and try to figure out what the authors of the
code have to say about it.
