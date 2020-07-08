Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD321822A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGHIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 04:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgGHIZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:25:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F569206DF;
        Wed,  8 Jul 2020 08:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594196724;
        bh=Xq8WxMIJ5au6LWJ2NQRhkLUVFSQxA8qnihUYmtBcxPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlJsDcswX9/ttFiNhIeYMqGOG2dogoSP4jqNED11NqBSEphw9HOf3aL/99QAyTyHU
         yqGAoiaAsvtFlOmrXDl/U38HYICnNHfFyrrhiQn2zuUOLa7DJfwDB+FZycGYqhyUum
         JYdMS5qiS4XCx2cAQS8flqRu7Tf8WLi85c9MQODg=
Date:   Wed, 8 Jul 2020 09:25:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Peng Hao <richard.peng@oppo.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH] arm64/module-plts: Consider the special case where
 plt_max_entries is 0
Message-ID: <20200708082519.GA25634@willie-the-truck>
References: <20200707114608.24197-1-richard.peng@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114608.24197-1-richard.peng@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Ard]

On Tue, Jul 07, 2020 at 07:46:08AM -0400, Peng Hao wrote:
> If plt_max_entries is 0, a warning is triggered.
> WARNING: CPU: 200 PID: 3000 at arch/arm64/kernel/module-plts.c:97 module_emit_plt_entry+0xa4/0x150

Which kernel are you seeing this with? There is a PLT-related change in
for-next/core, and I'd like to rule if out if possible.

> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---
>  arch/arm64/kernel/module-plts.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index 65b08a74aec6..1868c9ac13f2 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -79,7 +79,8 @@ u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
>  	int i = pltsec->plt_num_entries;
>  	int j = i - 1;
>  	u64 val = sym->st_value + rela->r_addend;
> -
> +	if (pltsec->plt_max_entries == 0)
> +		return 0;

Hmm, but if there aren't any PLTs then how do we end up here?

Will
