Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E422977CC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbgJWTjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbgJWTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:39:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA6C0613CE;
        Fri, 23 Oct 2020 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9q59dJKpQX8nTZH0b75mhaG2Wx0jHG0nvtcUF6WI3k=; b=sjZdRrrCEhq90m8iU3JACCux66
        voAIF2q/rW8fOUuHcVnoo4PaWCMnNIWGlrD3P4+srGdqOhbVMxhfrbHolAU7k/RsbVUgd1yEq+y2a
        Qf/UdmcasmKzinF/VmsPj+9pS/oZetKijsA1cW0qyipzO52AiuHtqxGL4t4PIhEXrFgYiO+6So04R
        RFX9CiECcqpXYfE1P9ARMgSayOLxE32BGD/PnxwO13Ju/uotCzoScFVcPX3glbE/TaJedeMWo/k+K
        hnR2CfLhf2cHBioIXu16bm72CDeqVakfKpyTIHy66U4L5RDLPYG/0rKKpJ7NjLAtykcfzqA/yn0qQ
        avbu+W1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kW2u5-0007SU-NN; Fri, 23 Oct 2020 19:39:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 157E798104F; Fri, 23 Oct 2020 21:39:07 +0200 (CEST)
Date:   Fri, 23 Oct 2020 21:39:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/56] refcount.h: fix a kernel-doc markup
Message-ID: <20201023193907.GI2974@worktop.programming.kicks-ass.net>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
 <202010231039.DE05B63@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010231039.DE05B63@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 10:40:09AM -0700, Kees Cook wrote:
> On Fri, Oct 23, 2020 at 06:33:36PM +0200, Mauro Carvalho Chehab wrote:
> > The documented typedef just after the kernel-doc markup
> > is named "refcount_struct".
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  include/linux/refcount.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> > index 497990c69b0b..8f431b0e69e4 100644
> > --- a/include/linux/refcount.h
> > +++ b/include/linux/refcount.h
> > @@ -101,7 +101,7 @@
> >  struct mutex;
> >  
> >  /**
> > - * struct refcount_t - variant of atomic_t specialized for reference counts
> > + * struct refcount_struct - variant of atomic_t specialized for reference counts
> 
> Hm, this is a weird one. Yes, it's actually "struct refcount_struct",
> but the usage should be refcount_t (through the typedef). I'm not sure
> what the right way to document this is.

Yeah, this is wrong. If this is due to a kernel doc warning, the kernel
doc machinery is wrong *again*.
