Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A612488AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHRPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:06:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:31048 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgHRPGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:06:46 -0400
IronPort-SDR: qc3U4rRDt8enX9dppp2eMUw62Q424IMEqdHo2xLO3Cedu+7A1iwNRHpluDHrXKHFChAHVlGylm
 koRmbLRuONRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152551339"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="152551339"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 08:06:35 -0700
IronPort-SDR: Ww7ojPoHjm4INVvKIPKcxsngbNw6jdurmN5xOs5RdoxzroApsVouVCcQt4ENYKkk41wQ8a/Bb0
 40jq8DjVwwbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="370918038"
Received: from ribnhajh-mobl.ger.corp.intel.com (HELO localhost) ([10.249.47.113])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2020 08:06:28 -0700
Date:   Tue, 18 Aug 2020 18:06:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Nathaniel McCallum <npmccallum@redhat.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>, kai.huang@intel.com,
        "Svahn, Kai" <kai.svahn@intel.com>, kmoy@google.com,
        ludloff@google.com, luto@kernel.org,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Subject: Re: [PATCH v36 21/24] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
Message-ID: <20200818150627.GD132200@linux.intel.com>
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
 <20200716135303.276442-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepOqRfUafSv_qjUv-jW_6n8G7kZ9yh-2z_Z9sjL_2zqNCg@mail.gmail.com>
 <20200810222317.GG14724@linux.intel.com>
 <20200818145234.GC132200@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818145234.GC132200@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 05:52:41PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 10, 2020 at 03:23:17PM -0700, Sean Christopherson wrote:
> > > This can be done implicitly by wrapping the struct
> > > sgx_enclave_exception in another structure and then using techniques
> > > like container_of() to find another field. However, this is made more
> > > difficult by the fact that the sgx_enclave_exit_handler_t is not
> > > really using the x86_64 sysv calling convention. Therefore, the
> > > sgx_enclave_exit_handler_t MUST be written in assembly.
> > 
> > What bits of the x86-64 ABI require writing the handler in assembly?  There
> > are certainly restrictions on what the handler can do without needing an
> > assembly trampoline, but I was under the impression that vanilla C code is
> > compatible with the exit handler patch.  Is Rust more picky about calling
> > convention?
> > 
> > Side topic, the documentation for vdso_sgx_enter_enclave_t is wrong, it
> > states the EFLAGS.DF is not cleared before invoking the handler, but that's
> > a lie.
> 
> If handler requires the use of setjmp/longjmp API for sudden exits, that
> is considered bad even with C++, as it is not compatible with stack
> unwinding. The handler has a lot of constraints for its environment, and
> is somewhat unappealing to use.
> 
> That's why I started today thinking a possibility of using a bpf program
> as a middle-man. BPF programs can be used to execute code by the kernel
> in behalf of user in a domain defined sandbox. The execution context is
> just a buffer passed in R1 to the BPF interpreter. It can be defined by
> application.

Something like

1. An exception is triggered.
2. Kernel executes an eBPF program behalf of the caller, if one was
   given.
3. vDSO calls a fixed exit handler that based on the outcome calls
   ERESUME/EENTER.

Possibly an ioctl could be used to attach an eBPF program to an
enclave and vDSO would only get a context struct.

/Jarkko
