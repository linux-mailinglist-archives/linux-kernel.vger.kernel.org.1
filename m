Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A31D8AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 00:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgERW1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 18:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgERW1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:27:16 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F45B207ED;
        Mon, 18 May 2020 22:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589840835;
        bh=Mc5wZR6935NKKgGq3HpDn/de/Md1HC2p9pCOvKfW0k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOo2+UvHiPZA3GmWml8k/2bFs4i/qMTPPqSGWPtSlrIw+dlq6graqyHxT9Bd/63qi
         a2x9hO4U4YGztj3+oTdalkOQw3hoTo8HQBrdlCXMYmAMR7vSkJciqggudB1GgvWnLA
         EzkCdUSEBEim2V5zFX7dramyTIVEFIuznVWUp9ec=
Date:   Mon, 18 May 2020 17:32:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/uv/time: Replace one-element array and save heap
 space
Message-ID: <20200518223202.GD9868@embeddedor>
References: <20200518190114.GA7757@embeddedor>
 <b03d196cdbbbc6e9e8456910c6c6673ab67f76cb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03d196cdbbbc6e9e8456910c6c6673ab67f76cb.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:09:16PM -0700, Joe Perches wrote:
> On Mon, 2020-05-18 at 14:01 -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of one-element arrays in the following
> > form:
> > 
> > struct something {
> >     int length;
> >     u8 data[1];
> > };
> []
> > This issue has been out there since 2009.
> > This issue was found with the help of Coccinelle and fixed _manually_.
> []
> > diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> > index 7af31b245636..993a8ae6fdfb 100644
> > --- a/arch/x86/platform/uv/uv_time.c
> > +++ b/arch/x86/platform/uv/uv_time.c
> > @@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
> >  	struct {
> >  		int	lcpu;		/* systemwide logical cpu number */
> >  		u64	expires;	/* next timer expiration for this cpu */
> > -	} cpu[1];
> > +	} cpu[];
> >  };
> >  
> >  /*
> > @@ -156,9 +156,8 @@ static __init int uv_rtc_allocate_timers(void)
> >  		struct uv_rtc_timer_head *head = blade_info[bid];
> >  
> >  		if (!head) {
> > -			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
> > -				(uv_blade_nr_possible_cpus(bid) *
> > -					2 * sizeof(u64)),
> > +			head = kmalloc_node(struct_size(head, cpu,
> > +				uv_blade_nr_possible_cpus(bid)),
> 
> It's probably safer to use kzalloc_node here as well.
> 

Thanks for your feedback, Joe. I'll wait for comments from the
maintainers on this and the rest of the patch.

Thanks
--
Gustavo

> >  				GFP_KERNEL, nid);
> >  			if (!head) {
> >  				uv_rtc_deallocate_timers();
> 
