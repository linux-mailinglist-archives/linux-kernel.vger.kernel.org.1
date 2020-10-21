Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22B294D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442870AbgJUNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:11:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:4159 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441169AbgJUNLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:11:14 -0400
IronPort-SDR: 5ofOq2mSvIHzUNOUr+1ZD6HCswdMO/7dNPxyfKz1cluFftLN0UG/+eel9nfvKtrOhLB9cY8LYC
 OP51EoVAU9PA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="163872312"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="163872312"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 06:11:12 -0700
IronPort-SDR: rO3sjPwwdItL7rqdWgl21CrANDOKOqDpXsySYaBTg1ufeu29h9MGuBBUH4d1Zhfbihc5+Ah9Cy
 jRp2QGqf8kHw==
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="466294027"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.247.253])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 06:11:10 -0700
Message-ID: <7c9e406c3b409bd7d4d786a7835d37bfcd5c8189.camel@linux.intel.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Oct 2020 06:11:09 -0700
In-Reply-To: <1188ee0f-f3cb-988f-474d-618bd5a5b879@intel.com>
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
         <2147d5853a5a3e0d753fcc0a4ed330f61b29aa83.camel@linux.intel.com>
         <1188ee0f-f3cb-988f-474d-618bd5a5b879@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-20 at 12:40 -0700, Dave Hansen wrote:
> On 10/20/20 11:40 AM, Srinivas Pandruvada wrote:
> > On Tue, 2020-10-20 at 19:47 +0200, Borislav Petkov wrote:
> > > On Tue, Oct 20, 2020 at 10:21:48AM -0700, Srinivas Pandruvada
> > > wrote:
> > > > These command id are model specific. There is no guarantee that
> > > > even
> > > > meaning changes. So I don't think we should write any code in
> > > > kernel
> > > > which can't stick.
> > > Ok, is there a common *set* of values present on all models
> > Sorry, don't know.
> 
> So, the question is: Is Intel willing to document this on a
> sufficient
> number of models that folks can make a sane driver out of it?
> 
> Srinivas, that seems like a pretty sane thing for the community to
> ask.
>  We've got random folks poking at MSRs and we don't know whether
> they're
> nuts or not and whether we should spew warnings of disdain.  Seems
> like
> it would be in Intel's best interests to understand what users are
> doing
> with this MSR and to try to make sure they're not doing stuff which
> is
> too nutty, or at least give them the chance of avoiding warnings if
> they're being nice.
We are all for it. We have added several sysfs interfaces and adding
more.

> 
> Sounds like Borislav is willing to help give Intel's customers a
> nicer
> interface.  Mostly we from Intel would have to go dig out the docs
> for
> as many models as we can, and make sure we're allowed to talk about
> it
> publicly.
> 
That is the problem. There is no public document.

> I dunno.  Maybe we should try it for *one* model and see how it goes.
> Maybe start with the one we're already poking from inside the kernel.

