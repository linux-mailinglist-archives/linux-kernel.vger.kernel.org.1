Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE33E1E5769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgE1GRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 02:17:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:56969 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgE1GRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:17:02 -0400
IronPort-SDR: 5UIoC2uDze2EHA21ah7/mM7rGAWUFqk+tnCpFnQOfP+xa0JgdcTIf08svlW2uhT4gIZB8rUoeP
 Q9S2mQ0tbZIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 23:17:02 -0700
IronPort-SDR: +tLF3uRyihbI6HBCrkZKOMKLnCoThQQu7dB46/KLPCMHYAuGRhzGKf6zEJAE5gHAdzsCumAbuR
 WedkJ0i1uLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="442833403"
Received: from dmescala-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.59.102])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2020 23:16:52 -0700
Date:   Thu, 28 May 2020 09:16:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        puiterwijk@redhat.com, Serge Ayoun <serge.ayoun@intel.com>,
        Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 07/20] x86/sgx: Enumerate and track EPC sections
Message-ID: <20200528061651.GA103000@linux.intel.com>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-8-jarkko.sakkinen@linux.intel.com>
 <20200525092304.GD25636@zn.tnic>
 <20200527035613.GH31696@linux.intel.com>
 <20200528052532.GA63435@linux.intel.com>
 <20200528053515.GA64796@linux.intel.com>
 <20200528061432.GA102386@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528061432.GA102386@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:14:43AM +0300, Jarkko Sakkinen wrote:
> On Thu, May 28, 2020 at 08:35:15AM +0300, Jarkko Sakkinen wrote:
> > On Thu, May 28, 2020 at 08:25:43AM +0300, Jarkko Sakkinen wrote:
> > > On Tue, May 26, 2020 at 08:56:14PM -0700, Sean Christopherson wrote:
> > > > On Mon, May 25, 2020 at 11:23:04AM +0200, Borislav Petkov wrote:
> > > > > On Fri, May 15, 2020 at 03:43:57AM +0300, Jarkko Sakkinen wrote:
> > > > > > +struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
> > > > > > +int sgx_nr_epc_sections;
> > > > > 
> > > > > We have become very averse against global stuff. What is going to use
> > > > > those, only sgx code I assume...?
> > > > 
> > > > Yes, only SGX code.  The reclaim/swap code needs access to the sections,
> > > > and that code is in a different file, reclaim.c.  I don't have a super
> > > > strong objection to sucking reclaim.c into main.c, but I'm somewhat
> > > > indifferent on code organization as a whole.  Jarkko likely has a stronger
> > > > opinion.
> > > 
> > > I'll change it.
> > > 
> > > It's not quite as easy as just "sucking the file in". All the commits
> > > that touch the file need to be reworked:
> > > 
> > > $ git --no-pager log --format="%H %s" arch/x86/kernel/cpu/sgx/reclaim.c
> > > 5aeca6dabf767e9350ee3188ba25ceb21f3162b4 x86/sgx: Add a page reclaimer
> > > de9b1088959f36ffdaf43a49bfea1c7f9f81cac7 x86/sgx: Linux Enclave Driver
> > > 08d8fcb74fe268059ee58fcc2a0833b244e1f22a x86/sgx: Enumerate and track EPC sections
> > 
> > Not that I haven't done this a lot last few years. A proven approach
> > is to do it in two "git rebase -i mainline/master" sweeps:
> > 
> > 1. For each commit, remove reclaim.c entry from the Makefile and import
> >    reclaim.c contents to main.c.
> > 2. For each commit, delete reclaim.c.
> > 
> > I've tried quite a few different angles and this what I've converged
> > into. Very hard to hit messy into messy merge conflicts.
> 
> Remembered why the things are the way they are. Also ioctl.c needs these
> symbols and I'd keep that separate from the contents of main.c and
> reclaim.c. There the separation obviously makes sense.
> 
> I'll anyway merge main.c and reclaim.c as one for v31 because they are
> strongly connected.

And more importantly for the reason that it allows to make ksgxswapd_tsk
making the whole thing way more cleaner.

/Jarkko
