Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41F2841A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgJEUpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 16:45:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:23280 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJEUpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:45:47 -0400
IronPort-SDR: XRbupo9fQrjM7kTVjr+7iP7BFHLlwUf600Y5Ruor3O7UQc3wMmGwdGdwiaD2SNOnTku1B7WCTv
 bL/aKFqX8/ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="161418525"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="161418525"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP; 05 Oct 2020 13:17:34 -0700
IronPort-SDR: bWUdjiCtQL4FeLoEONcPOHpiol6g0UkplB0CinvIRbVF/ddxZYwUKNf8J6Yg1e32pqE2gRMdPr
 PzMdHdte1hIA==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="460048735"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 12:54:13 -0700
Date:   Mon, 5 Oct 2020 12:54:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Subject: Re: [PATCH v2 7/9] x86: Use current USER_CS to setup correct context
 on vmx entry
Message-ID: <20201005195411.GB15803@linux.intel.com>
References: <20201001205819.27879-1-krisman@collabora.com>
 <20201001205819.27879-8-krisman@collabora.com>
 <CALCETrW74MjC2-MRkRrp3uGOhapH_1zG5GCBkPsLFXs+jPXNOg@mail.gmail.com>
 <20201002224005.GF24460@linux.intel.com>
 <CALCETrWw3WkjzzqS+j5LDhLdLrr1yCoSq3j-wTD6i_Rdge8pBw@mail.gmail.com>
 <CALCETrUGySDqc1bmwWGZvdADSCNehhJLLNNneGCvaCh_xVkD4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUGySDqc1bmwWGZvdADSCNehhJLLNNneGCvaCh_xVkD4Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 04:04:22PM -0700, Andy Lutomirski wrote:
> On Fri, Oct 2, 2020 at 5:15 PM Andy Lutomirski <luto@kernel.org> wrote:
> > But it's also more subtly wrong -- this corrupts all the segment attributes
> > in the case where a segment points to the GDT and the GDT attributes are
> > non-default.

Part of me wants to ask if it's even possible to get into such a scenario,
but a much larger part of me doesn't want to think about segmentation any
more :-)

> > I would also be okay with making the KVM code match the context switch
> > code, but this may be distinctly nontrivial.

Ya.
 
> If you're okay waiting for a couple days, I'll just do this.  I have
> it 2/3-done already, except I'm running into the utter catastrophe
> that is 32-bit stackprotector, so I'm going to fix that first.  (Or
> delete it if I get toosick of it.)

By all means.  I dragged my feet for several months, I can certainly do
nothing for a few more days.
