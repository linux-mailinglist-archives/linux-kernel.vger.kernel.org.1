Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815842856E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgJGDOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:14:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:28714 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgJGDOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:14:18 -0400
IronPort-SDR: 6aeZgFcSRSrb20Zp7W5z+r9Yp5EXulGRIevzmzvkUOt2cpR9YYVyaIjhaqtOiKGdO2arH+bFLw
 PGrRgnVXqz5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226390184"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="226390184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:14:17 -0700
IronPort-SDR: NgVF+tTLndj2QAjGanEhiOhL4IjZVyNy1JrwQVgLoc21jF3aF2wBPMthKk5jeSsU1LNUugQjAP
 Ru3UFEEtEvwQ==
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="527744627"
Received: from thijsmet-mobl.ger.corp.intel.com (HELO localhost) ([10.249.34.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:14:10 -0700
Date:   Wed, 7 Oct 2020 06:14:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Cedric Xing <cedric.xing@intel.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        ludloff@google.com, luto@kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v39 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20201007031402.GA143690@linux.intel.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <20201003045059.665934-22-jarkko.sakkinen@linux.intel.com>
 <20201006025703.GG15803@linux.intel.com>
 <453c2d9b-0fd0-0d63-2bb9-096f255a6ff4@fortanix.com>
 <20201006151532.GA17610@linux.intel.com>
 <20201006172819.GA114208@linux.intel.com>
 <20201006232129.GB28981@linux.intel.com>
 <20201007002236.GA139112@linux.intel.com>
 <20201007011738.GE28981@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007011738.GE28981@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 06:17:38PM -0700, Sean Christopherson wrote:
> On Wed, Oct 07, 2020 at 03:22:36AM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 06, 2020 at 04:21:29PM -0700, Sean Christopherson wrote:
> > > On Tue, Oct 06, 2020 at 08:28:19PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Oct 06, 2020 at 08:15:32AM -0700, Sean Christopherson wrote:
> > > > > On Tue, Oct 06, 2020 at 10:30:16AM +0200, Jethro Beekman wrote:
> > > > > > On 2020-10-06 04:57, Sean Christopherson wrote:
> > > > > > > On Sat, Oct 03, 2020 at 07:50:56AM +0300, Jarkko Sakkinen wrote:
> > > > > > >> +struct sgx_enclave_run {
> > > > > > >> +  __u64 tcs;
> > > > > > >> +  __u64 user_handler;
> > > > > > >> +  __u64 user_data;
> > > > > > >> +  __u32 leaf;
> > > > > > >
> > > > > > > I am still very strongly opposed to omitting exit_reason.  It is not at all
> > > > > > > difficult to imagine scenarios where 'leaf' alone is insufficient for the
> > > > > > > caller or its handler to deduce why the CPU exited the enclave.  E.g. see
> > > > > > > Jethro's request for intercepting interrupts.
> > > > > >
> > > > > > Not entirely sure what this has to do with my request, I just expect to see
> > > > > > leaf=ERESUME in this case, I think? E.g. as you would see in EAX when calling
> > > > > > ENCLU.
> > > > > 
> > > > > But how would you differentiate from the case that an exception occured in
> > > > > the enclave?  That will also transfer control with leaf=ERESUME.  If there
> > > > > was a prior exception and userspace didn't zero out the struct, there would
> > > > > be "valid" data in the exception fields.
> > > > > 
> > > > > An exit_reason also would allow retrofitting the exception fields into a
> > > > > union, i.e. the fields are valid if and only if exit_reason is exception.
> > > > 
> > > > Let's purge this a bit. Please remark where my logic goes wrong. I'm
> > > > just explaining how I've deduced the whole thing.
> > > > 
> > > > The information was encoded in v38 version of the vDSO was exactly this:
> > > > 
> > > > - On normal EEXIT, it got the value 0.
> > > > - Otherwise, it got the value 1.
> > > > 
> > > > The leaf, then embdded to struct sgx_exception but essentially the same
> > > > field got the value from EAX, and the value that EAX had was only
> > > > written on exception path.
> > > > 
> > > > Thus, I deduced that if you write $EEXIT to leaf on synchrous exit you
> > > > get the same information content, nothing gets overwritten. I.e. you
> > > > can make same conclusions as you would with those two struct fields.
> > > 
> > > And then a third flavor comes along, e.g. Jethro's request interrupt case,
> > > and exit_reason can also return '2'.  How do you handle that with only the
> > > leaf?
> > 
> > I'm listening. How was that handled before? I saw only '0' and '1'.  Can
> > you bring some context on that? I did read the emails that were swapped
> > when the run structure was added but I'm not sure what is the exact
> > differentiator. Maybe I'm missing something.
> 
> https://patchwork.kernel.org/patch/11719889/

Thank you.

There's aboslutely nothing that is blocking adding such support for such
AEP handling in the current implementation. SGX_SYNCHRONOUS_EXIT is just
another name for EEXIT. Even if that was in place, you'd need to
separate normal and interrupt. Tristate is useless here. As far as I'm
concerned, no bottlenecks have been created.

/Jarkko
