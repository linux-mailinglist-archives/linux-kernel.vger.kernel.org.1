Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB32758BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIWNbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:31:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:52193 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWNbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:31:08 -0400
IronPort-SDR: A6LwXju4an2RQAfeDyFDjgfLUKEf9qn64qDLP3CjS+hZDhHHEmPBqcnqRQUKp4X4Uc0ClJTD6A
 kXWYf2seMR2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="148538140"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="148538140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 06:31:08 -0700
IronPort-SDR: Uj5lNb/86HNoXNl0NOZ1QzuO25rPsPO40SiyFdWUt2yP40x3KowyctRG3E7q7xNzTNmpxGmzhA
 mYsBi72ufEKw==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="486442114"
Received: from ichiojdo-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 06:31:01 -0700
Date:   Wed, 23 Sep 2020 16:30:59 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        "Xing, Cedric" <cedric.xing@intel.com>, chenalexchen@google.com,
        Conrad Parker <conradparker@google.com>, cyhanish@google.com,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Neil Horman <nhorman@redhat.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
Subject: Re: [PATCH v38 10/24] mm: Add vm_ops->mprotect()
Message-ID: <20200923133059.GB5160@linux.intel.com>
References: <20200918235337.GA21189@sjchrist-ice>
 <1B23E216-0229-4BDD-8B09-807256A54AF5@amacapital.net>
 <20200922125801.GA133710@linux.intel.com>
 <25d46fdc-1c19-2de8-2ce8-1033a0027ecf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d46fdc-1c19-2de8-2ce8-1033a0027ecf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:11:14AM -0700, Dave Hansen wrote:
> > Enclave permissions can be dynamically modified by using ENCLS[EMODPE]
> 
> I'm not sure this sentence matters.  I'm not sure why I care what the
> instruction is named that does this.  But, it _sounds_ here like an
> enclave can adjust its own permissions directly with ENCLS[EMODPE].

If there was no EMODPE, I would drop this patch from the patch set. It
is the only reason I keep it. There are no other hard reasons to have
this.

> Now I'm confused.  I actually don't think I have a strong understanding
> of how an enclave actually gets loaded, how mmap() and mprotect() are
> normally used and what this hook is intended to thwart.

Enclave gets loaded with the ioctl API so ATM we rely only on
DAC permissions.

In future you might want to have LSM hooks to improve granularity
in two points:

1. When pages are added using SGX_IOC_ENCLAVE ADD_PAGES.
2. When enclave is initialized using SGX_IOC_ENCLAVE_INIT

In both you might want to make a policy decision based on origin
and page permissions.

If we do not limit mmap(), enclave could later on upgrade its
permissions with EMODPE and do mmap().

No matter what kind of LSM hooks or whatever possible improvements
are done later on to access control, they won't work unless we have
this because the permissions could be different than the original.

With this change you can still do EMODPE inside an enclave, but you
don't gain anything with it because your max permissions are capped
during the build time.

I'm not sure what exactly from this is missing from the commit message
but if you get this explanation maybe you can help me out with that.

Thank you for the feedback.

/Jarkko
