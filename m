Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01E27D073
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgI2ODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:03:45 -0400
Received: from foss.arm.com ([217.140.110.172]:45502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730777AbgI2ODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:03:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 099E012FC;
        Tue, 29 Sep 2020 07:03:42 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD5943F6CF;
        Tue, 29 Sep 2020 07:03:39 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:03:37 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?Q?Andr=E9?= Przywara <andre.przywara@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] perf: arm_spe: Decode SVE events
Message-ID: <20200929140334.GL6642@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
 <20200922101225.183554-6-andre.przywara@arm.com>
 <20200928132114.GF6642@arm.com>
 <8efd63eb-5ae7-0f9a-6c37-ef5e68af4e6c@arm.com>
 <20200928144755.GI6642@arm.com>
 <20200929021902.GA16749@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200929021902.GA16749@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:19:02AM +0800, Leo Yan wrote:
> On Mon, Sep 28, 2020 at 03:47:56PM +0100, Dave Martin wrote:
> > On Mon, Sep 28, 2020 at 02:59:34PM +0100, André Przywara wrote:
> > > On 28/09/2020 14:21, Dave Martin wrote:
> > > 
> > > Hi Dave,
> > > 
> > > > On Tue, Sep 22, 2020 at 11:12:25AM +0100, Andre Przywara wrote:
> > > >> The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
> > > >> that introduces very long vector operations (up to 2048 bits).
> > > > 
> > > > (8192, in fact, though don't expect to see that on real hardware any
> > > > time soon...  qemu and the Arm fast model can do it, though.)

[...]

> > Mostly I'm curious because the encoding doesn't match the SVE
> > architecture: SVE requires 4 bits to specify the vector length, not 3.
> > This might have been a deliberate limitation in the SPE spec., but it
> > raises questions about what should happen when 3 bits is not enough.
> > 
> > For SVE, valid vector lengths are 16 bytes * n
> > or equivalently 128 bits * n), where 1 <= n <= 16.
> > 
> > The code here though cannot print EVLEN16 or EVLEN48 etc.  This might
> > not be a bug, but I'd like to understand where it comes from...
> 
> In the SPE's spec, the defined values for EVL are:
> 
>   0b'000 -> EVLEN: 32 bits.
>   0b'001 -> EVLEN: 64 bits.
>   0b'010 -> EVLEN: 128 bits.
>   0b'011 -> EVLEN: 256 bits.
>   0b'100 -> EVLEN: 512 bits.
>   0b'101 -> EVLEN: 1024 bits.
>   0b'110 -> EVLEN: 2048 bits.
> 
> Note that 0b'111 is reserved.  In theory, I think SPE Operation packet
> can support up to 4196 bits (32 << 7) when the EVL field is 0b'111; but

OK, having looked at the spec I can now confirm that this look correct.
I was expecting a more direct correspondence between the SVE ISA and
these events, but it looks like SPE may report on a finer granularity
than whole instructions, hence showing effective vector lengths smaller
than 32; also SPE rounds the reported effective vector length up to a
power of two, which allows the full range of lengths to be reported via
the 3-bit EVL field.

> it's impossible to express vector length for 8192 bits as you mentioned.

Yes, ignore my comment about 8192-bit vectors: I was confusing myself
(the Linux API extensions support up to 8192 _bytes_ per vector in order
to have some expansion room just in case; however the SVE architecture
limits vectors to at most 2048 bits).

So I don't see any obvious issues.

It might be a good idea to explicitly reject the encoding 0b111, since
we can't be certain what it is going to mean -- however, I don't have a
strong opinion on this.

Cheers
---Dave
