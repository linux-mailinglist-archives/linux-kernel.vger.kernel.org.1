Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DCA275BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIWPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:25:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:58923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgIWPZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:25:12 -0400
IronPort-SDR: OTeINvi3nzndS+8v76fJOomgwfUiueNM1VmM1xJ6BrUWB8cGYXdym97hYNGmnCRc/umXCFToGo
 15eWgXCoARxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225055673"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="225055673"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 08:25:11 -0700
IronPort-SDR: YmR1SxFUzCMegOE29Z7WY8yRAbVnYEa0ijOOqMw2+EsFkZLLsa1UpifzHWDqWDrLKKEVl1TI3o
 RR2e/1UqSUyA==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="486478167"
Received: from linortne-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.223])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 08:25:04 -0700
Date:   Wed, 23 Sep 2020 18:25:02 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jethro Beekman <jethro@fortanix.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Seth Moore <sethmo@google.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 16/24] x86/sgx: Add a page reclaimer
Message-ID: <20200923152502.GI5160@linux.intel.com>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-17-jarkko.sakkinen@linux.intel.com>
 <20200922104538.GE22660@zn.tnic>
 <20200922162437.GA30827@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922162437.GA30827@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 	if (IS_ERR(va_page)) <- needed a new VA page, allocation failed
> 		return PTR_ERR(va_page);
> 	else if (va_page)    <- needed a new VA page, allocation succeeded
> 		list_add(&va_page->list, &encl->va_pages);
> 	else
> 		             <- reused the current VA page

/* else the tail page of the VA page list had free slots. */

I added this comment as "the missing branch".

/Jarkko
