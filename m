Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FA2A4604
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgKCNNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbgKCNNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:13:34 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0B72224E;
        Tue,  3 Nov 2020 13:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604409213;
        bh=edRL5vtp4UROAk8/UZchdi8Kc9ie+fR/3lbZyGEaEFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nW9trrfaMaPkLCAzLMM/FnvqZRGSr7WdRcehCQL8uHDQ60eZt09Ns9cOCK3lK+1W0
         H0ucgrgfXuc9U9pecI2pF9DbWNLycCqIMYBJXVx03yQwWX84z9EwMRpYVazqCnsE+I
         SBbK9POfUQRXZF7TMK/Zy7BZna7uocOlQhYNozQE=
Date:   Tue, 3 Nov 2020 13:13:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: lto: Strengthen READ_ONCE() to acquire
 when CONFIG_LTO=y
Message-ID: <20201103131328.GC5219@willie-the-truck>
References: <20201103121721.5166-1-will@kernel.org>
 <20201103121721.5166-5-will@kernel.org>
 <20201103125845.GD40454@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103125845.GD40454@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:58:45PM +0000, Mark Rutland wrote:
> On Tue, Nov 03, 2020 at 12:17:21PM +0000, Will Deacon wrote:
> > When building with LTO, there is an increased risk of the compiler
> > converting an address dependency headed by a READ_ONCE() invocation
> > into a control dependency and consequently allowing for harmful
> > reordering by the CPU.
> > 
> > Ensure that such transformations are harmless by overriding the generic
> > READ_ONCE() definition with one that provides acquire semantics when
> > building with LTO.
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> [...]
> 
> Could we add a note above __READ_ONCE() along the lines of the commit
> message, e.g.
> 
> /*
>  * With LTO a compiler might convert an address dependency headed by a
>  * READ_ONCE() into a control dependency, allowing for harmful
>  * reordering by the CPU.
>  *
>  * To prevent this, upgrade READ_OONCE() to provide acquire semantics
>  * when building with LTO.

It's not halloween any moooore :)

But yes, I'll add something to that effect, cheers.

Will
