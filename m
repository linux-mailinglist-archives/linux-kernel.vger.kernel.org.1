Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037EF1D8B55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgERXDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgERXDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:03:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC124C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 16:03:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaon8-0005Gg-6r; Tue, 19 May 2020 01:03:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id AF7351006A1; Tue, 19 May 2020 01:03:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com> <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
Date:   Tue, 19 May 2020 01:03:25 +0200
Message-ID: <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
> On Mon, 2020-05-18 at 08:34 -0700, Andi Kleen wrote:
>> > Yes, for SGX this is functional feature because enclave entry points,
>> > thread control structures (aka TCS's), reset FSBASE and GSBASE registers
>> > to fixed (albeit user defined) values. And syscall's can be done only
>> > outside of enclave.
>> > 
>> > This is a required feature for fancier runtimes (such as Graphene).
>> 
>> Can you please explain a bit more? What do they need GS for?
>
> Apparently, uses only wrfsbase:
>
> https://raw.githubusercontent.com/oscarlab/graphene/master/Pal/src/host/Linux-SGX/db_misc.c
>
> I'm not too familiar with the codebase yet but by reading some research
> papers in the past the idea is to multiplex one TCS for multiple virtual
> threads inside the enclave.
>
> E.g. TCS could represent a vcpu for a libos type of container and on
> entry would pick on a thread and set fsbase accordingly for a thread
> control block.

That justifies to write books which recommend to load a kernel module
which creates a full unpriviledged root hole. I bet none of these papers
ever mentioned that.

Thanks,

        tglx
