Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839FD277052
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgIXLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:51:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:61315 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIXLvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:51:36 -0400
IronPort-SDR: l8lAhbA0vyXR6OfmwRhmcmf7eJxgdGmwHnD4FV5X82KkzOBlaxE9cH81Oemk59SUMjWB5wJ/9U
 8/qZabo++/lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="158543409"
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; 
   d="scan'208";a="158543409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 04:51:36 -0700
IronPort-SDR: axKEzJ+naiD8BxaCi/Sqvbsokl8YS4+Pmp/HC3IPcg0my/4p960nQFUsDaJ81EJc3z0Kel5bqi
 1tGkQsTnXNDw==
X-IronPort-AV: E=Sophos;i="5.77,297,1596524400"; 
   d="scan'208";a="486873220"
Received: from gkleinma-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.32.187])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 04:51:30 -0700
Date:   Thu, 24 Sep 2020 14:51:28 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 17/24] x86/sgx: ptrace() support for the SGX driver
Message-ID: <20200924115119.GD56811@linux.intel.com>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-18-jarkko.sakkinen@linux.intel.com>
 <20200922154424.GL22660@zn.tnic>
 <20200923132037.GA5160@linux.intel.com>
 <20200923161733.GP28545@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923161733.GP28545@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 06:17:33PM +0200, Borislav Petkov wrote:
> > Add 'access' implementation to vm_ops with the help of these functions.
> 
> "Add an ->access virtual MM function for accessing the enclave's memory... "

Thank you. I wrote the last paragraph like this:

"Add an '->access' virtual function for accessing the enclave's memory
to vm_ops by using these functions. This allows to use ptrace() with
debug enclaves."

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

/Jarkko
