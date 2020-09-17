Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9D26D554
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIQHzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgIQHys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:54:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B61021D7F;
        Thu, 17 Sep 2020 07:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600329237;
        bh=hxQvHDj4XA0nKwGg/MljTv2Dbma+ahbUgNJmVUIihOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvLxkkqOr4bp3Ic/ODusJ9eyNlPbXzVyamEsagm0DsR8jkSzMnaZbgX+9ltFbzDyc
         ran+/YX704UWqxZUDJXQKFSa9hn0biPE/wZWcogXOg47AQZFviYnD8u+4vLGijGMOC
         5OkkzaqXncf64uy0gcW4EhhDAoL3EBBmBWkUXNlc=
Date:   Thu, 17 Sep 2020 09:54:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 13/13] x86/platform/uv: Update Copyrights to conform
 to HPE standards
Message-ID: <20200917075429.GB3333802@kroah.com>
References: <20200916192039.162934-1-mike.travis@hpe.com>
 <20200916192039.162934-14-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916192039.162934-14-mike.travis@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 02:20:39PM -0500, Mike Travis wrote:
> Add Copyrights to those files that have been updated for UV5 changes.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> ---
>  arch/x86/include/asm/uv/bios.h      | 1 +
>  arch/x86/include/asm/uv/uv_hub.h    | 1 +
>  arch/x86/include/asm/uv/uv_mmrs.h   | 1 +
>  arch/x86/kernel/apic/x2apic_uv_x.c  | 1 +
>  arch/x86/platform/uv/bios_uv.c      | 1 +
>  arch/x86/platform/uv/uv_nmi.c       | 1 +
>  arch/x86/platform/uv/uv_time.c      | 1 +
>  drivers/misc/sgi-gru/grufile.c      | 1 +
>  drivers/misc/sgi-xp/xp.h            | 1 +
>  drivers/misc/sgi-xp/xp_main.c       | 1 +
>  drivers/misc/sgi-xp/xp_uv.c         | 1 +
>  drivers/misc/sgi-xp/xpc_main.c      | 1 +
>  drivers/misc/sgi-xp/xpc_partition.c | 1 +
>  drivers/misc/sgi-xp/xpnet.c         | 1 +
>  14 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
> index 97ac595ebc6a..08b3d810dfba 100644
> --- a/arch/x86/include/asm/uv/bios.h
> +++ b/arch/x86/include/asm/uv/bios.h
> @@ -5,6 +5,7 @@
>  /*
>   * UV BIOS layer definitions.
>   *
> + * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
>   * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
>   * Copyright (c) Russ Anderson <rja@sgi.com>

Gotta love the different ways of text here :(

Anyway, much better than before, thanks.

greg k-h
