Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C1D1E77FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgE2INz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 04:13:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:42043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgE2INy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:13:54 -0400
IronPort-SDR: ImBvsmHhKQ9CDjO/kcfjVM8BJ9hgKGqRJ/ZE1dGyGM2vK61xBjQJBE2pXe8Nd+QriCQXTASg9n
 MSVAgcW5orAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 01:13:53 -0700
IronPort-SDR: wnPpwAR1hFvkQSCzx0+PXJj3jFnWPTfZWjzMLudp+VFzzdspZ3HeeIfr15h7Im0tEMylNJuZ9L
 l3n5PF3nu5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="303060969"
Received: from pratuszn-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.65])
  by orsmga008.jf.intel.com with ESMTP; 29 May 2020 01:13:44 -0700
Date:   Fri, 29 May 2020 11:13:42 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        puiterwijk@redhat.com, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 08/20] x86/sgx: Add functions to allocate and free
 EPC pages
Message-ID: <20200529081342.GB1376838@linux.intel.com>
References: <20200527204638.GG1721@zn.tnic>
 <20200528012319.GA7577@linux.intel.com>
 <20200528013617.GD25962@linux.intel.com>
 <20200528065223.GB188849@linux.intel.com>
 <20200528171635.GB382@zn.tnic>
 <20200528190718.GA2147934@linux.intel.com>
 <20200528195917.GF30353@linux.intel.com>
 <20200529032816.GC6182@linux.intel.com>
 <20200529033716.GH30353@linux.intel.com>
 <20200529081258.GA1376838@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529081258.GA1376838@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:13:09AM +0300, Jarkko Sakkinen wrote:
> On Thu, May 28, 2020 at 08:37:16PM -0700, Sean Christopherson wrote:
> > On Fri, May 29, 2020 at 06:28:16AM +0300, Jarkko Sakkinen wrote:
> > > On Thu, May 28, 2020 at 12:59:17PM -0700, Sean Christopherson wrote:
> > > > On Thu, May 28, 2020 at 10:07:18PM +0300, Jarkko Sakkinen wrote:
> > > > >  * sgx_grab_page() - Grab a free EPC page
> > > > >  * @owner:	the owner of the EPC page
> > > > >  * @reclaim:	reclaim pages if necessary
> > > > >  *
> > > > >  * Iterate through EPC sections and borrow a free EPC page to the caller. When a
> > > > >  * page is no longer needed it must be released with sgx_free_page(). If
> > > > >  * @reclaim is set to true, directly reclaim pages when we are out of pages. No
> > > > >  * mm's can be locked when @reclaim is set to true.
> > > > >  *
> > > > >  * Finally, wake up ksgxswapd when the number of pages goes below the watermark
> > > > >  * before returning back to the caller.
> > > > >  *
> > > > >  * Return:
> > > > >  *   an EPC page,
> > > > >  *   -errno on error
> > > > >  */
> > > > > 
> > > > > I also rewrote the kdoc.
> > > > > 
> > > > > I do agree that sgx_try_grab_page() should be renamed as __sgx_grab_page().
> > > > 
> > > > FWIW, I really, really dislike "grab".  The nomenclature for normal memory
> > > > and pages uses "alloc" when taking a page off a free list, and "grab" when
> > > > elevating the refcount.  I don't understand the motivation for diverging
> > > > from that.  SGX is weird enough as is, using names that don't align with
> > > > exist norms will only serve to further obfuscate the code.
> > > 
> > > OK, what would be a better name then? The semantics are not standard
> > > memory allocation semantics in the first place. And kdoc in v30 speaks
> > > about grabbing.
> > 
> > In what way are they not standard allocation semantics?  sgx_alloc_page()
> > is an API to allocate (EPC) memory on-demand, sgx_free_page() is its partner
> > to free that memory when it is no longer needed.  There are many different
> > ways to manage and allocate memory, but the basic premise is the same for
> > all and no different than what we're doing.
> 
> I end up to (ignoring unchanged names):
> 
> - __sgx_alloc_epc_page_from_section() (static)
> - __sgx_alloc_epc_page()
> - sgx_alloc_epc_page()
> - sgx_setup_epc_section()

OK, also sgx_free_epc_page (not sgx_free_page() as before).

/Jarkko
