Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2BC27228F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIULbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIULbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:31:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172A520874;
        Mon, 21 Sep 2020 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600687908;
        bh=mQMoozXfMbMIA41YDL+R5M4NLSveohvZ2+XilKLda2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTlmD3uFzf+Vd8CsV49dYXhCdaLjWWRtke/wwkf2y0VQ5wn/nHdTPK75n7mlTuatw
         U4a9FzLEw7ZxwjYubJ1f/g3k2BS6kFVF/fevLgKMu81vcS0begBUPWYyB2P1B7Hy+R
         bL4BtlZ4bFqlVXaltI5a096ixn/5v50rWifnJa6U=
Date:   Mon, 21 Sep 2020 12:31:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     ardb@kernel.org, keescook@chromium.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: fix incomplete comment in
 refcount_dec_and_lock_irqsave()
Message-ID: <20200921113143.GD2139@willie-the-truck>
References: <20200921112358.14841-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921112358.14841-1-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 07:23:58AM -0400, Miaohe Lin wrote:
> The description of arg flags is incomplete. The flags is saved IRQ-flags
> when the @lock is acquired.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  lib/refcount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/refcount.c b/lib/refcount.c
> index ebac8b7d15a7..dcfd092f66c7 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -161,7 +161,7 @@ EXPORT_SYMBOL(refcount_dec_and_lock);
>   *                                 interrupts if able to decrement refcount to 0
>   * @r: the refcount
>   * @lock: the spinlock to be locked
> - * @flags: saved IRQ-flags if the is acquired
> + * @flags: saved IRQ-flags if the is @lock acquired

This still isn't quite right. If we go with:

  @flags: saved IRQ-flags if @lock is acquired

then:

Acked-by: Will Deacon <will@kernel.org>

Will
