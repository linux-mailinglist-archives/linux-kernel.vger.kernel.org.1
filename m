Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21773284BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgJFMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgJFMlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:41:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 411342075A;
        Tue,  6 Oct 2020 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601988112;
        bh=2r1WP9jFb1nyywqRLbFLZxRgZSVPOu7Mb+8+Y7SuVho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPZF59M6T8ZM2jzPwRLQLe2ri+LQWM8sEEnnTXjUw+9Rv1r5JkhBTdC6CC0C2KMtk
         T8Fl1GF4nunw4XLafVnZBA7teh9mr/r2lsPfGz5JWpHYN1MIunUkwnUDvTS9dEAPMp
         WN+yVwhtLXFkrl9Qd8fEDWTP2v6QCMSPIq3lLRPY=
Date:   Tue, 6 Oct 2020 13:41:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc
Message-ID: <20201006124147.GA25562@willie-the-truck>
References: <20200924154851.skmswuyj322yuz4g@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924154851.skmswuyj322yuz4g@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 05:48:51PM +0200, Sebastian Andrzej Siewior wrote:
> ctags creates a warning:
> |ctags: Warning: include/linux/seqlock.h:738: null expansion of name pattern "\2"
> 
> The DEFINE_SEQLOCK() macro is passed to ctags and being told to expect
> an argument.
> 
> Add a dummy argument to keep ctags quiet.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/seqlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 962d9768945f0..4a69e74dc7ce9 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -735,7 +735,7 @@ typedef struct {
>  	} while (0)
>  
>  /**
> - * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
> + * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
>   * @sl: Name of the seqlock_t instance
>   */
>  #define DEFINE_SEQLOCK(sl) \

Acked-by: Will Deacon <will@kernel.org>

Will
