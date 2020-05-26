Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EBB1DEC7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgEVPyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 11:54:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:7087 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgEVPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:54:10 -0400
IronPort-SDR: jxj2/ysFv2UNR3NsFBh6PBJ7oIQi8g138OA9OPYjFk3SRH27O+TfwmiLU0Tc0h6wgcxllGNU+g
 NE75EncFp7Vg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 08:54:09 -0700
IronPort-SDR: Z/GEN1Q/OcNpG9hot53WdrBifq1V2GOrtxXOAQ752IK6J4poLbaPI/Y+PreBTDj4OOzz6VfB7O
 1us0vtQDP27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="412794228"
Received: from omillerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.59])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2020 08:54:05 -0700
Date:   Fri, 22 May 2020 18:54:05 +0300
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
Subject: Re: [PATCH v30 04/20] x86/sgx: Add SGX microarchitectural data
 structures
Message-ID: <20200522155405.GA8377@linux.intel.com>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-5-jarkko.sakkinen@linux.intel.com>
 <20200520184745.GJ1457@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520184745.GJ1457@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 08:47:45PM +0200, Borislav Petkov wrote:
> On Fri, May 15, 2020 at 03:43:54AM +0300, Jarkko Sakkinen wrote:
> > +/**
> > + * struct sgx_sigstruct_header -  defines author of the enclave
> > + * @header1:		constant byte string
> > + * @vendor:		must be either 0x0000 or 0x8086
> 
> Out of pure curiosity: what is that about?
> 
> Nothing in the patchset enforces this, so hw does? If so, why?
> 
> Are those vendor IDs going to be assigned by someone or what's up?
> 
> Thx.

In SGX1 world 0x8086 was used to mark architectural enclaves and 0x0000
user run enclaves. In SGX2 world they are irrelevant. In order to retain
compatiblity I'd add an explicit check to:

1. Allow vendor ID of 0x0000 or 0x8086.
2. Reject other vendor ID's (-EINVAL).

/Jarkko
