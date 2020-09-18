Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B2270139
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRPla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:41:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24122084C;
        Fri, 18 Sep 2020 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600443690;
        bh=P+5p+Hl4jp4wyXrxir+B57juRprAl6qYKUjJvvxnRhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qh3uBkJBWAkD7iLx2XsyU8Sg2sdOP6+8k/0nVh5TFku/PcM2P6KseEPQob7AP4u5F
         OjSn3iKI44yoOupKxBeZSpKS6X6Q86LLf812T+WZETeIyUcZHiV/zFulpI82pR48gQ
         ni0U4EyrbAQw52yDdsnp+RhIrP2vsDDjD4K7ij68=
Date:   Fri, 18 Sep 2020 16:41:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ipi_teardown() should depend on HOTPLUG_CPU
Message-ID: <20200918154125.GB31676@willie-the-truck>
References: <20200918153548.836986-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918153548.836986-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 12:35:48AM +0900, Sergey Senozhatsky wrote:
> ipi_teardown() is used only when CONFIG_HOTPLUG_CPU is set.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  arch/arm64/kernel/smp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I think this is a duplicate of:

  https://lore.kernel.org/r/20200918123318.23764-1-yuehaibing@huawei.com

which Marc is aware of (and I'm assuming he'll fix it in his series).

Will
