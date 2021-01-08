Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9DE2EF018
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbhAHJwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbhAHJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:52:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECCC0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1PDtrbcaBPK2Go3OlTjgm02lDmV3mwof4pPUUTeO7Z4=; b=0uEJgH+66I5JaBymO9Gh0bMRwC
        UITBv1j2qRhYCStpw8VpTopyJo6yv3ZOprk9DliwkJE3btxsYl0St71q7iEdB+9h4P39swUix3Hp1
        ejf07vs2FQeafuQjw7kq6EOUuR0+wY4Pd4TSsxiIaSQDl6aMr36UsjCGvjedaS/P/7Yq/i/GmkzVr
        Ao+mxPb/i/0U1ZsWWDpBKMxsd4jsqBa7ca3bPnDoBujTNqRwSNlgx93O1BfQO2JfqJP54/3rSdJBy
        Cs4TH8To2KstXWc4HcHzGLTGe7/lFxsAW+ZLmuqmmcEZuadKFlmSqhIGpSDwLUPd4/1AjZBzhqeUh
        Ud5VKs/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxoR4-0000kL-6W; Fri, 08 Jan 2021 09:51:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40E9D3003D8;
        Fri,  8 Jan 2021 10:51:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FC322BC2B3D9; Fri,  8 Jan 2021 10:51:56 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:51:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
Message-ID: <X/grPFTgOMvtqEVZ@hirez.programming.kicks-ass.net>
References: <20210107134723.GA28532@xsang-OptiPlex-9020>
 <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
 <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
 <20210107190445.GK3579531@ZenIV.linux.org.uk>
 <CAHk-=whneXU5Sr=iOOrzcqZt6q85zp-8CUSviOwGPj5ePBW4CQ@mail.gmail.com>
 <824461ae2cb642b1b2f82fac140a98da@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824461ae2cb642b1b2f82fac140a98da@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:37:45AM +0000, David Laight wrote:
> The lack of spinlocks in userspace really kills you.

Glibc has them, but please don't complain about lock holder preemption
issues if you do actually use them ;-)
