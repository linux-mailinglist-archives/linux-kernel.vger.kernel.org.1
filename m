Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30D126A1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIOJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:11:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 02:11:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42006449c187a2f3906a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6449:c187:a2f3:906a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79C2E1EC058B;
        Tue, 15 Sep 2020 11:11:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600161099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7cElbsFu165XZezhnZrU812OzCS0YyaUHu8PEBoV30Q=;
        b=kEh0yS+AFJe7QKe1jOcpLOXl133/rNnmNZgrFA3QBN5ep8h75s+/ykEAvnl4keObG3wiCo
        mHv53ddkHgb6DApcRVQeal9zajn5bAtFoAOGJgkgk9vRZGSj7Z2g6UYgJJXNCiZSTSYoOD
        AIHYZOS2vJGJjACK5Sv4QNgdGXF11e4=
Date:   Tue, 15 Sep 2020 11:11:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] x86/mce: Provide method to find out the type of
 exception handle
Message-ID: <20200915091132.GD14436@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908175519.14223-4-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:55:14AM -0700, Tony Luck wrote:
> Avoid a proliferation of ex_has_*_handler() functions by having just
> one function that returns the type of the handler (if any).
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/extable.h     |  9 ++++++++-
>  arch/x86/kernel/cpu/mce/severity.c |  5 ++++-
>  arch/x86/mm/extable.c              | 12 ++++++++----
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
> index d8c2198d543b..56ec02e024ad 100644
> --- a/arch/x86/include/asm/extable.h
> +++ b/arch/x86/include/asm/extable.h
> @@ -29,10 +29,17 @@ struct pt_regs;
>  		(b)->handler = (tmp).handler - (delta);		\
>  	} while (0)
>  
> +enum handler_type {
> +	HANDLER_NONE,
> +	HANDLER_FAULT,
> +	HANDLER_UACCESS,
> +	HANDLER_OTHER

EX_HANDLER_* I guess - HANDLER is too generic.

> @@ -125,17 +125,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
>  }
>  EXPORT_SYMBOL(ex_handler_clear_fs);
>  
> -__visible bool ex_has_fault_handler(unsigned long ip)
> +__visible enum handler_type ex_fault_handler_type(unsigned long ip)

Why __visible?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
