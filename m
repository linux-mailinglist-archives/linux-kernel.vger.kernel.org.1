Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D32A2B6BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgKQRf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgKQRf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:35:28 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F642463D;
        Tue, 17 Nov 2020 17:35:26 +0000 (UTC)
Date:   Tue, 17 Nov 2020 17:35:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] scs: switch to vmapped shadow stacks
Message-ID: <X7QJ3PbYm4kxGAEt@trantor>
References: <20201022202355.3529836-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022202355.3529836-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:23:53PM -0700, Sami Tolvanen wrote:
> As discussed a few months ago [1][2], virtually mapped shadow call stacks
> are better for safety and robustness. This series dusts off the VMAP
> option from the original SCS patch series and switches the kernel to use
> virtually mapped shadow stacks unconditionally when SCS is enabled.
> 
>  [1] https://lore.kernel.org/lkml/20200515172355.GD23334@willie-the-truck/
>  [2] https://lore.kernel.org/lkml/20200427220942.GB80713@google.com/
> 
> 
> Sami Tolvanen (2):
>   scs: switch to vmapped shadow stacks
>   arm64: scs: use vmapped IRQ and SDEI shadow stacks

Will, Mark. Any objections to this series? If not, I can queue it for
5.11 via the arm64 tree.

Thanks.

-- 
Catalin
