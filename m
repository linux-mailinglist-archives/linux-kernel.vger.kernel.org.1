Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BC82B7A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKRJ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:27:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgKRJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:27:42 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E422463B;
        Wed, 18 Nov 2020 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605691662;
        bh=ge8+uvQIKDQ6q4G5HQQOhiK/c/mZbrhHb2Xl7DOMJQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4IKTxPZLcXCCVH9nUkT71UexkvrMDvMIPHb54F0DVUZzmd8S9/Qu1sr8Ag9GD3dK
         SxtrFIuWL7WSS3lKx5CH9oPnUGkO6yhKWACF1wmOUmxlHUW9WFX822rXxPMlTxr01i
         iWm0S+QujZaCuN8LZtN31J/sejCOqMZeso1PqrJI=
Date:   Wed, 18 Nov 2020 09:27:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] scs: switch to vmapped shadow stacks
Message-ID: <20201118092736.GA1577@willie-the-truck>
References: <20201022202355.3529836-1-samitolvanen@google.com>
 <X7QJ3PbYm4kxGAEt@trantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7QJ3PbYm4kxGAEt@trantor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 05:35:24PM +0000, Catalin Marinas wrote:
> On Thu, Oct 22, 2020 at 01:23:53PM -0700, Sami Tolvanen wrote:
> > As discussed a few months ago [1][2], virtually mapped shadow call stacks
> > are better for safety and robustness. This series dusts off the VMAP
> > option from the original SCS patch series and switches the kernel to use
> > virtually mapped shadow stacks unconditionally when SCS is enabled.
> > 
> >  [1] https://lore.kernel.org/lkml/20200515172355.GD23334@willie-the-truck/
> >  [2] https://lore.kernel.org/lkml/20200427220942.GB80713@google.com/
> > 
> > 
> > Sami Tolvanen (2):
> >   scs: switch to vmapped shadow stacks
> >   arm64: scs: use vmapped IRQ and SDEI shadow stacks
> 
> Will, Mark. Any objections to this series? If not, I can queue it for
> 5.11 via the arm64 tree.

It's on my list to review, but I have a tonne of other things I have to get
to first.

Will
