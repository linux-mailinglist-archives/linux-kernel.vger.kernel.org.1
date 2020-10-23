Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CA2977D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbgJWTsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:48:02 -0400
Received: from ms.lwn.net ([45.79.88.28]:51894 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754840AbgJWTsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:48:01 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 996EA7DE;
        Fri, 23 Oct 2020 19:47:59 +0000 (UTC)
Date:   Fri, 23 Oct 2020 13:47:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/56] refcount.h: fix a kernel-doc markup
Message-ID: <20201023134757.628f91b7@lwn.net>
In-Reply-To: <20201023193907.GI2974@worktop.programming.kicks-ass.net>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
        <202010231039.DE05B63@keescook>
        <20201023193907.GI2974@worktop.programming.kicks-ass.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 21:39:07 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > >  /**
> > > - * struct refcount_t - variant of atomic_t specialized for reference counts
> > > + * struct refcount_struct - variant of atomic_t specialized for reference counts  
> > 
> > Hm, this is a weird one. Yes, it's actually "struct refcount_struct",
> > but the usage should be refcount_t (through the typedef). I'm not sure
> > what the right way to document this is.  
> 
> Yeah, this is wrong. If this is due to a kernel doc warning, the kernel
> doc machinery is wrong *again*.

...except that, since refcount_t is a typedef, "struct refcount_t" doesn't
actually exist.  Whether it works properly after doing s/struct// remains
to be seen...

jon
