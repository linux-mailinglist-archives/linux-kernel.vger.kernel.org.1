Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07F1E73AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 05:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436780AbgE2DhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 23:37:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:11551 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436471AbgE2DhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:37:18 -0400
IronPort-SDR: k6ETZKGsMesBYb2JuwUcCjmbWDGfiKybC11WORogSQ2VEEgizY9e6WsmWVIaw+2h8VRtyPRur4
 7oYD/10DspOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 20:37:17 -0700
IronPort-SDR: B6gSQMsUEDL92rpeTbGFvy5JSID46pgaOhjpoJojBIg/8j3x6roy/tcpYSD8R4stat+7e5twAf
 T6W87DdJzY8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="311120170"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 20:37:16 -0700
Date:   Thu, 28 May 2020 20:37:16 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
Message-ID: <20200529033716.GH30353@linux.intel.com>
References: <20200526125207.GE28228@zn.tnic>
 <20200527042111.GI31696@linux.intel.com>
 <20200527204638.GG1721@zn.tnic>
 <20200528012319.GA7577@linux.intel.com>
 <20200528013617.GD25962@linux.intel.com>
 <20200528065223.GB188849@linux.intel.com>
 <20200528171635.GB382@zn.tnic>
 <20200528190718.GA2147934@linux.intel.com>
 <20200528195917.GF30353@linux.intel.com>
 <20200529032816.GC6182@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529032816.GC6182@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:28:16AM +0300, Jarkko Sakkinen wrote:
> On Thu, May 28, 2020 at 12:59:17PM -0700, Sean Christopherson wrote:
> > On Thu, May 28, 2020 at 10:07:18PM +0300, Jarkko Sakkinen wrote:
> > >  * sgx_grab_page() - Grab a free EPC page
> > >  * @owner:	the owner of the EPC page
> > >  * @reclaim:	reclaim pages if necessary
> > >  *
> > >  * Iterate through EPC sections and borrow a free EPC page to the caller. When a
> > >  * page is no longer needed it must be released with sgx_free_page(). If
> > >  * @reclaim is set to true, directly reclaim pages when we are out of pages. No
> > >  * mm's can be locked when @reclaim is set to true.
> > >  *
> > >  * Finally, wake up ksgxswapd when the number of pages goes below the watermark
> > >  * before returning back to the caller.
> > >  *
> > >  * Return:
> > >  *   an EPC page,
> > >  *   -errno on error
> > >  */
> > > 
> > > I also rewrote the kdoc.
> > > 
> > > I do agree that sgx_try_grab_page() should be renamed as __sgx_grab_page().
> > 
> > FWIW, I really, really dislike "grab".  The nomenclature for normal memory
> > and pages uses "alloc" when taking a page off a free list, and "grab" when
> > elevating the refcount.  I don't understand the motivation for diverging
> > from that.  SGX is weird enough as is, using names that don't align with
> > exist norms will only serve to further obfuscate the code.
> 
> OK, what would be a better name then? The semantics are not standard
> memory allocation semantics in the first place. And kdoc in v30 speaks
> about grabbing.

In what way are they not standard allocation semantics?  sgx_alloc_page()
is an API to allocate (EPC) memory on-demand, sgx_free_page() is its partner
to free that memory when it is no longer needed.  There are many different
ways to manage and allocate memory, but the basic premise is the same for
all and no different than what we're doing.
