Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EEE1E9AC9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 01:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgEaXMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 19:12:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:40271 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgEaXMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:12:39 -0400
IronPort-SDR: gGjzBsu4San1pLzDhPZbIigeaePMMoW8oLqIhiNux+WfelH2jXttStnqqz0WmeSy8eboLe5bHd
 eeWPLfVlGKwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 16:12:38 -0700
IronPort-SDR: U/BX8FEyI0at2h6lSS3YaPcvQOiM4l3ZkffvFnD6V+dbok1zaKVgXVKnFWz6G7DVeNumuzz/VF
 IRx77a6JJD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,458,1583222400"; 
   d="scan'208";a="415608645"
Received: from hbetts-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.178])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2020 16:12:29 -0700
Date:   Mon, 1 Jun 2020 02:12:27 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 09/20] mm: Introduce vm_ops->may_mprotect()
Message-ID: <20200531231227.GA236202@linux.intel.com>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-10-jarkko.sakkinen@linux.intel.com>
 <66a227f2-8056-6318-111e-3b0abd5d94c3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a227f2-8056-6318-111e-3b0abd5d94c3@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:28:56AM -0700, Dave Hansen wrote:
> On 5/14/20 5:43 PM, Jarkko Sakkinen wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Add vm_ops()->may_mprotect() to check additional constrains set by a
> > subsystem for a mprotect() call.
> 
> This changelog needs some more detail about why this is needed.  It
> would also be nice to include thought about what else it could get used
> for and what subsystems can expect by doing this and what the mm core is
> expected to do.

Point taken. I added a description on how it is used.

/Jarkko
