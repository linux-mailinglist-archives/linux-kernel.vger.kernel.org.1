Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9F12938BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405852AbgJTKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:02:14 -0400
Received: from wind.enjellic.com ([76.10.64.91]:57434 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbgJTKCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:02:14 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 09KA1J3d007162;
        Tue, 20 Oct 2020 05:01:19 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 09KA1IIc007161;
        Tue, 20 Oct 2020 05:01:18 -0500
Date:   Tue, 20 Oct 2020 05:01:18 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
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
Message-ID: <20201020100118.GA6957@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200924230501.GA20095@linux.intel.com> <b737fcab-bfde-90e1-1101-82d646a6f5b7@intel.com> <20200925000052.GA20333@linux.intel.com> <32fc9df4-d4aa-6768-aa06-0035427b7535@intel.com> <20200925194304.GE31528@linux.intel.com> <230ce6da-7820-976f-f036-a261841d626f@intel.com> <20200928005347.GB6704@linux.intel.com> <6eca8490-d27d-25b8-da7c-df4f9a802e87@intel.com> <20201018084920.GA19255@wind.enjellic.com> <20201019213105.GE23072@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019213105.GE23072@linux.intel.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 20 Oct 2020 05:01:19 -0500 (CDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 02:31:05PM -0700, Sean Christopherson wrote:

Good morning, I hope the day is starting well for everyone.

> On Sun, Oct 18, 2020 at 03:49:20AM -0500, Dr. Greg wrote:
> > Is this even a relevant control if we cede the notion of dynamically
> > loadable enclave code, which is the objective of SGX2 hardware, which
> > will in all likelihood be the only relevant hardware implementation in
> > the future?

> Yes, it's still relevant.  Giving the thumbs up to dynamically
> loadable code is not a purely binary decision, e.g. a user/admin can
> allow RW->RX transitions but still disallow full RWX permissions.

With respect to the security issue at hand, the only relevant issue
would seem to be if a page had write permissions at one time in its
trajectory to having execute permisions, isn't this correct?

The next paragraph of my reply wasn't included in your reply, but I
did state that the mprotect hook would be relevant if its purpose was
to disallow this permission trajectory and in the process disable
enclave dynamic code loading and execution.

So to assist everyone in understanding this issue and the security
implications involved, is the ultimate purpose of the mprotect hook to
disable dynamic code loading?

Have a good day.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: dg@enjellic.com
------------------------------------------------------------------------------
"Those who will not study history are doomed to debug it."
                                -- Barry Shein
