Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0241F6161
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 07:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFKFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 01:47:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45006 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKFrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:47:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49jCYZ6KPbz9v1pT;
        Thu, 11 Jun 2020 07:47:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3dq_3n0ijY0I; Thu, 11 Jun 2020 07:47:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49jCYZ4y0gz9v1pS;
        Thu, 11 Jun 2020 07:47:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C35408B7DE;
        Thu, 11 Jun 2020 07:47:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jMw_Z2umHmV6; Thu, 11 Jun 2020 07:47:31 +0200 (CEST)
Received: from [172.25.230.104] (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B2248B7DC;
        Thu, 11 Jun 2020 07:47:31 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc: Remove inaccessible CMDLINE default
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200611034140.9133-1-chris.packham@alliedtelesis.co.nz>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <34bb20ad-8522-6071-7a36-9f615204561f@csgroup.eu>
Date:   Thu, 11 Jun 2020 07:46:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611034140.9133-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2020 à 05:41, Chris Packham a écrit :
> Since commit cbe46bd4f510 ("powerpc: remove CONFIG_CMDLINE #ifdef mess")
> CONFIG_CMDLINE has always had a value regardless of CONFIG_CMDLINE_BOOL.
> 
> For example:
> 
>   $ make ARCH=powerpc defconfig
>   $ cat .config
>   # CONFIG_CMDLINE_BOOL is not set
>   CONFIG_CMDLINE=""
> 
> When enabling CONFIG_CMDLINE_BOOL this value is kept making the 'default
> "..." if CONFIG_CMDLINE_BOOL' ineffective.
> 
>   $ ./scripts/config --enable CONFIG_CMDLINE_BOOL
>   $ cat .config
>   CONFIG_CMDLINE_BOOL=y
>   CONFIG_CMDLINE=""
> 
> Remove CONFIG_CMDLINE_BOOL and the inaccessible default.

You also have to remove all CONFIG_CMDLINE_BOOL from the defconfigs

Christophe

> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> It took me a while to get round to sending a v2, for a refresher v1 can be found here:
> 
> http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190802050232.22978-1-chris.packham@alliedtelesis.co.nz/
> 
> Changes in v2:
> - Rebase on top of Linus's tree
> - Fix some typos in commit message
> - Add review from Christophe
> - Remove CONFIG_CMDLINE_BOOL
> 
>   arch/powerpc/Kconfig | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9fa23eb320ff..51abc59c3334 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -859,12 +859,8 @@ config PPC_DENORMALISATION
>   	  Add support for handling denormalisation of single precision
>   	  values.  Useful for bare metal only.  If unsure say Y here.
>   
> -config CMDLINE_BOOL
> -	bool "Default bootloader kernel arguments"
> -
>   config CMDLINE
> -	string "Initial kernel command string" if CMDLINE_BOOL
> -	default "console=ttyS0,9600 console=tty0 root=/dev/sda2" if CMDLINE_BOOL
> +	string "Initial kernel command string"
>   	default ""
>   	help
>   	  On some platforms, there is currently no way for the boot loader to
> 
