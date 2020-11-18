Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22A2B8593
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKRU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgKRU1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:27:43 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80AA2145D;
        Wed, 18 Nov 2020 20:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605731262;
        bh=d7FWe1BlbjtKurhfO3KPp8dTCNr5OMgkoHGS+KpPmec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tk2xsfB/R6tOW3k/29KEexiOlVuxNA4v/ReKorLLX9HVJpkwTcxJ5gyP7oCRyajTz
         VEJpetjg7Oh8ynq42pA903K1njKQrWVsUF0aBbnglvCZWVzD4fciTRs9Nnsa2OTbRO
         dzlwfEBlF9MzzSKr9setF8IqPsLKUtMdLxaGn+uY=
Date:   Wed, 18 Nov 2020 14:27:42 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] PPC: Fix -Wimplicit-fallthrough for clang
Message-ID: <20201118202742.GA15147@embeddedor>
References: <20201118000751.845172-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118000751.845172-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick,

On Tue, Nov 17, 2020 at 04:07:48PM -0800, Nick Desaulniers wrote:
> While cleaning up the last few -Wimplicit-fallthrough warnings in tree
> for Clang, I noticed
> commit 6a9dc5fd6170d ("lib: Revert use of fallthrough pseudo-keyword in lib/")
> which seemed to undo a bunch of fixes in lib/ due to breakage in
> arch/powerpc/boot/ not including compiler_types.h.  We don't need
> compiler_types.h for the definition of `fallthrough`, simply
> compiler_attributes.h.  Include that, revert the revert to lib/, and fix
> the last remaining cases I observed for powernv_defconfig.

I've added the series to my -next tree, together with Miguel's
suggestions.

Thanks for the Acks and comments, Michael.

--
Gustavo
