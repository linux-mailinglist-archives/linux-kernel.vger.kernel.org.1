Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404C01E42D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgE0NA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:00:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbgE0NA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:00:27 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1438220873;
        Wed, 27 May 2020 13:00:24 +0000 (UTC)
Subject: Re: [PATCH 4/4] m68k: pass -D options to KBUILD_CPPFLAGS instead of
 KBUILD_{A,C}FLAGS
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org
References: <20200526123810.301667-1-masahiroy@kernel.org>
 <20200526123810.301667-4-masahiroy@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <59d886a9-2ebd-8fab-9b42-f71808288968@linux-m68k.org>
Date:   Wed, 27 May 2020 23:00:20 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526123810.301667-4-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/5/20 10:38 pm, Masahiro Yamada wrote:
> Precisely, -D is a preprocessor option.
> 
> KBUILD_CPPFLAGS is passed to for compiling .c and .S files too.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
> 
>   arch/m68k/Makefile | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index ae6e29da3a3e..c28f9f917ac0 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -70,9 +70,8 @@ ifdef CONFIG_MMU
>   KBUILD_CFLAGS += -fno-strength-reduce -ffixed-a2
>   else
>   # we can use a m68k-linux-gcc toolchain with these in place
> -KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
> -KBUILD_CFLAGS += -D__uClinux__
> -KBUILD_AFLAGS += -D__uClinux__
> +KBUILD_CPPFLAGS += -DUTS_SYSNAME=\"uClinux\"
> +KBUILD_CPPFLAGS += -D__uClinux__
>   endif
>   
>   KBUILD_LDFLAGS := -m m68kelf
> 
