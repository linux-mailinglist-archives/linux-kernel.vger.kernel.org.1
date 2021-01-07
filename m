Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A5B2ECCEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbhAGJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:39:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8797C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EVqP79nL9SAhqJQfMwCKQrDaTJtNttKzCx/0iIrZQmg=; b=B1c0Ijs5LwQGbTeOhQLWEEpB5E
        FkfldyRO1d68I+dNpnb2OSKB2HP4cDZwU000lq0XYD1S+0m2juDmMkUdvyQ1r0pzPs2APA2KyhCt2
        HrqhQI9oEE215vxQYtMObiHBhjAXfWmwG91vXhLLwptoM8e8oFeCtD0JBQtedVSuOftluLQer2oNJ
        GUOoNuccd9axt/XxqWaygssZi6KnykZU+vi/9d73Xc95DW8eSWsYLDJTvhywe+rxkD5fpDOitv/Gh
        8L15K/HcpLV59wIC4SZZPnxx1mmDC80nMrzIwS7q+wP7+GtoYnAY/q1KmpAzNB4eGBhVh4urYKK+w
        FAMj/hSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kxRip-003FBY-A0; Thu, 07 Jan 2021 09:37:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B34F3013E5;
        Thu,  7 Jan 2021 10:36:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D83772029C718; Thu,  7 Jan 2021 10:36:43 +0100 (CET)
Date:   Thu, 7 Jan 2021 10:36:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        sfr@canb.auug.org.au, tony.luck@intel.com
Subject: Re: [PATCH 2/6] x86/sev: Fix nonistr violation
Message-ID: <X/bWK1tNB6mtm0Bu@hirez.programming.kicks-ass.net>
References: <20210106143619.479313782@infradead.org>
 <20210106144017.532902065@infradead.org>
 <dc6e7e19-881a-c778-22df-15176db4aeb9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6e7e19-881a-c778-22df-15176db4aeb9@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 09:59:17AM -0800, Randy Dunlap wrote:
> On 1/6/21 6:36 AM, Peter Zijlstra wrote:
> > When the compiler fails to inline; we violate nonisntr:
> > 
> >   vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xc7: call to sev_es_wr_ghcb_msr() leaves .noinstr.text section
> 
> I am still seeing (a variant of) this one:
> 
> vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xce: call to __wrmsr.constprop.14() leaves .noinstr.text section

Gah, sorry, I managed to mess up my .config :/ /me goes try again.
