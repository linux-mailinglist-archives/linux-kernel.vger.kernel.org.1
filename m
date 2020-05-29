Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8971E8675
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgE2SSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 14:18:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:14877 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgE2SSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:18:14 -0400
IronPort-SDR: 8xNUVoEBsKC4ZkUC5SNTwKOkPGwVFLU8L44XJBzO2XiXYdlroZb2ZQ2N3Bg9kltiwYhr5xibGO
 l4AhyFahfZPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 11:18:14 -0700
IronPort-SDR: 8RsTl9qsuI5P+30Zhq0yHWiULLqrhQrAg436HmmZSkpbvH7ycsLa5ipWODEoyTCkdpjMpPm2Li
 Q4zXcSlHavVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="292462276"
Received: from ssudnits-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.116])
  by fmsmga004.fm.intel.com with ESMTP; 29 May 2020 11:18:05 -0700
Date:   Fri, 29 May 2020 21:18:03 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        puiterwijk@redhat.com, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 09/20] mm: Introduce vm_ops->may_mprotect()
Message-ID: <20200529181803.GA4990@linux.intel.com>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-10-jarkko.sakkinen@linux.intel.com>
 <20200529121038.GG9011@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529121038.GG9011@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 02:10:38PM +0200, Borislav Petkov wrote:
> On Fri, May 15, 2020 at 03:43:59AM +0300, Jarkko Sakkinen wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Add vm_ops()->may_mprotect() to check additional constrains set by a
> 
> "constraints"
> 
> > subsystem for a mprotect() call.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Acked-by: Jethro Beekman <jethro@fortanix.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  include/linux/mm.h |  2 ++
> >  mm/mprotect.c      | 14 +++++++++++---
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> This needs an ACK from an mm person.

Good point. I'll add the needed cc's.

/Jarkko
