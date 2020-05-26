Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E91E1B0103
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 07:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTFgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 01:36:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28188 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgDTFgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:36:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 495FmC2y0Cz9tyFs;
        Mon, 20 Apr 2020 07:35:55 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IDpwaVO2; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id eED5noZUcD5x; Mon, 20 Apr 2020 07:35:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 495FmC1W0Lz9tyFq;
        Mon, 20 Apr 2020 07:35:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587360955; bh=gbvV/0yUNCxbrnMP2PABrPUQIbZfdpXkHJe2K9NCY3M=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=IDpwaVO2uqNHZ1HQUx5DEwfo4UyoPWPh4v68CJhUA2BF960jS/IUU2ak/iFHymki1
         6Q7Ul/t15W0eiGSL5e1zXDWNRDdEjWfxj3EXY9MkQTXpdqqn+fNxRe+wXnYsCi6buC
         xn3Amae/bvKFx459VMc+QYMFumRdZNDKMdRf+/SM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A68D8B776;
        Mon, 20 Apr 2020 07:36:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5Pu0Xd3vKtx1; Mon, 20 Apr 2020 07:35:59 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 02DC88B752;
        Mon, 20 Apr 2020 07:35:58 +0200 (CEST)
Subject: Re: [PATCH] powerpc/8xx: Fix STRICT_KERNEL_RWX startup test failure
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0231963e81d6e72ff725212c14f4011d2ee36a9e.1587360530.git.christophe.leroy@c-s.fr>
Message-ID: <37627d56-6338-768a-d82a-397c55974607@c-s.fr>
Date:   Mon, 20 Apr 2020 07:35:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0231963e81d6e72ff725212c14f4011d2ee36a9e.1587360530.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/04/2020 à 07:29, Christophe Leroy a écrit :
> WRITE_RO lkdtm test works.
> 
> But when selecting CONFIG_DEBUG_RODATA_TEST, the kernel reports
> 	rodata_test: test data was not read only
> 
> This is because when rodata test runs, there are still old entries
> in TLB.
> 
> Flush TLB after setting kernel pages RO or NX.
> 
> Fixes: d5f17ee96447 ("powerpc/8xx: don't disable large TLBs with CONFIG_STRICT_KERNEL_RWX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/kvm/Makefile    | 2 +-

Oops, this change shouldn't be there. Will send v2.

>   arch/powerpc/mm/nohash/8xx.c | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)


Christophe
