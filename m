Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB151D7A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgERNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgERNj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:39:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F98206D4;
        Mon, 18 May 2020 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589809167;
        bh=D1sgcR3s0/mmhpAOarOMiHpa1UutLMQ17UcgkBniPGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaWcYukF7z4VgGM1jdLOfON+zSJmb3CJvVMUi1xzQomqJ8I8az/Zwv94rOK/iKu2m
         dIz6hHWpuhxKlABDxtR3LYXoxU19qGZs79TP90mfHwNwlir9vLL5wqeE+XuKzL2ecH
         qweBr+RV3AEhvzAOCyMoKGFwrI/LVcpKM9YqgPLk=
Date:   Mon, 18 May 2020 14:39:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 2/6] scs: Move accounting into alloc/free functions
Message-ID: <20200518133922.GG32394@willie-the-truck>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-3-will@kernel.org>
 <20200518113858.GB1957@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518113858.GB1957@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:38:58PM +0100, Mark Rutland wrote:
> On Fri, May 15, 2020 at 06:27:52PM +0100, Will Deacon wrote:
> > There's no need to perform the shadow stack page accounting independently
> > of the lifetime of the underlying allocation, so call the accounting code
> > from the {alloc,free}() functions and simplify the code in the process.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/scs.c | 45 +++++++++++++++++++++------------------------
> >  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> One (super trivial) nit below, but regardless this looks like a sound
> and sensible cleanup, so:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> > diff --git a/kernel/scs.c b/kernel/scs.c
> > index 5ff8663e4a67..aea841cd7586 100644
> > --- a/kernel/scs.c
> > +++ b/kernel/scs.c
> > @@ -14,25 +14,35 @@
> 
> >  static void *scs_alloc(int node)
> >  {
> 
> > +	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
> > +
> > +	if (!s)
> > +		return NULL;
> 
> Super trivial nit, but could we omit the line space between these two,
> to fit with usual style?

I really like having the empty line after the last variable declaration.

Sorry,

Will
