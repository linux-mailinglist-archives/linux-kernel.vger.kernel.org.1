Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9C1E84F3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 19:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE2Re7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 13:34:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:13511 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgE2Rez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:34:55 -0400
IronPort-SDR: 0oK4f+LtEWUP6m/LRl+af91AjsooN6Kc8AFiUK1QFde8bWialBlN0q067LvDEa+6gVk+iLZffX
 NqTTlpuPNHAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 10:24:49 -0700
IronPort-SDR: pjit+dMEA0v2x6153vaNVYMCYKhJQLWoIcDIBmhsu+ASCXhOlJCgyc12otZuQNnEKZPHKk6okx
 kJ5GZswLDfUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="256568441"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2020 10:24:49 -0700
Date:   Fri, 29 May 2020 10:24:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 4/6] x86/entry: Optimize local_db_save() for virt
Message-ID: <20200529172448.GA1074@linux.intel.com>
References: <20200528201937.038455891@infradead.org>
 <20200528202328.588432451@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528202328.588432451@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:19:41PM +0200, Peter Zijlstra wrote:
>  static int arch_bp_generic_len(int x86_len)
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3027,6 +3027,8 @@ static int nested_vmx_check_vmentry_hw(s
>  
>  	/*
>  	 * VMExit clears RFLAGS.IF and DR7, even on a consistency check.
> +	 * XXX how is this not broken? access to cpu_dr7 ought to be with
> +	 * IRQs disabled.

Ah, it's simply broken.  This code is conditional on a module param that's
off by default, i.e. it's not run widely, and odds are intersection with
debugging is rare.

Moving local_irq_enable() below the DR7 restoration is not an issue.

Maybe also add lockdep_assert_irqs_disabled() to hw_breakpoint_restore() or
hw_breakpoint_active()?

>  	 */
>  	local_irq_enable();
>  	if (hw_breakpoint_active())
> 
> 
