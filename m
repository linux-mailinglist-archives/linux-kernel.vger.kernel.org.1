Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB7D1E5E17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgE1LTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 07:19:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:36251 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388038AbgE1LTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:19:24 -0400
IronPort-SDR: a2Gr9VjhyEnuXE0OSeAVrS8MXO9GzgdNkGE5eGw5P7uOZTuHc2sazFiQjeTHxPMCx2hDs0q8Xr
 YT2E59GGp91w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 04:19:23 -0700
IronPort-SDR: NWs0ZnOclAos6PZfcotoMSyvxsfh1+yP9kzS1I2Ca34B0tzLlZUNTIW+urXAEwJCq8+po82Qg7
 xRwHP1+gpwMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="442913106"
Received: from dmescala-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.59.102])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 04:19:13 -0700
Date:   Thu, 28 May 2020 14:19:10 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
Message-ID: <20200528111910.GB1666298@linux.intel.com>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
 <CAOASepPFe_ucuwe7JW_-+VBQ4=+sHqyGXOdA9kUbcYA_9=v0sA@mail.gmail.com>
 <20200506221422.GK3329@linux.intel.com>
 <op.0j8dm0zzwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
 <CAOASepNVckens=wiWpHj291EAo0ndi7GCVHd9j7BPn8rjy7Ykg@mail.gmail.com>
 <20200507193459.GA24519@linux.intel.com>
 <op.0j9qdhziwjvjmi@hhuan26-mobl1.amr.corp.intel.com>
 <20200508002555.GA24964@linux.intel.com>
 <20200528111507.GA1666298@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528111507.GA1666298@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 02:15:18PM +0300, Jarkko Sakkinen wrote:
> On Thu, May 07, 2020 at 05:25:55PM -0700, Sean Christopherson wrote:
> > Ah, fudge.  shmem_zero_setup() triggers shmem_acct_size() and thus
> > __vm_enough_memory().  Which I should have rememered because I've stared
> > at that code several times when dealing with the enclave's backing store.
> > I wasn't seeing the issue because I happened to use MAP_PRIVATE.
> > 
> > So, bad analysis, good conclusion, i.e. the kernel is still doing the
> > right thing, it's just not ideal for userspace.
> > 
> > 
> > Jarkko, we should update the docs and selftest to recommend and use
> > 
> >   PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS
> > 
> > or
> > 
> >   PROT_NONE, MAP_SHARED | MAP_NORESERVE | MAP_ANONYMOUS"
> > 
> > when carving out ELRANGE, with an explicit comment that all the normal
> > rules for mapping memory still apply.
> 
> Ugh, had forgotten this.
> 
> OK, I guess this comment explains it all:
> 
> "
> /*
>  * shmem_file_setup pre-accounts the whole fixed size of a VM object,
>  * for shared memory and for shared anonymous (/dev/zero) mappings
>  * (unless MAP_NORESERVE and sysctl_overcommit_memory <= 1),
>  * consistent with the pre-accounting of private mappings ...
>  */
> static inline int shmem_acct_size(unsigned long flags, loff_t size)
> "

Do not agree though that any documentation should be produced but the
selftest should have correct parameters, yes. Instructions on how to
reserve a range of addresses simply does not belong to SGX documentation
because it is not SGX related in the first place. The patterns you
showed are universal.

I'll fix just the selftest for v31.

/Jarkko
