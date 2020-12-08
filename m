Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9602D26BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgLHJAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgLHJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:00:07 -0500
X-Greylist: delayed 1682 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Dec 2020 00:59:27 PST
Received: from centrum.lixper.it (centrum.lixper.it [IPv6:2a01:4f8:221:3c81::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DC9C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sguazz.it; s=centrum;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=y2w05WLUaDoLIJEGFosg2qYKD3kDFIU2iQVDte6m0a0=;
        b=I1RSCRZSLLHT0s8V9eSBIvJYbmBxtWQImegAo8x+ZlXV0WA9l0B5Q/7WG/+zs7eMuQdlqage6FwBAtatE2woQpdfUbj5PPGKISK+MbaSieDBkGFhQcq92UBfJ56BeqzhhzNhr+qKGhbkQwATWwtfnj7JKNKFS/YKpHRSNa/FLD0=;
Received: by centrum.lixper.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <giuseppe@sguazz.it>)
        id 1kmYOe-0000Rp-JM; Tue, 08 Dec 2020 09:30:58 +0100
Message-ID: <45348197b657d9051a7dcdf711a110388ab41900.camel@sguazz.it>
Subject: Re: [PATCH v2] powerpc/powermac: Fix low_sleep_handler with
 CONFIG_VMAP_STACK
From:   Giuseppe Sacco <giuseppe@sguazz.it>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 08 Dec 2020 09:30:50 +0100
In-Reply-To: <e3e0d8042a3ba75cb4a9546c19c408b5b5b28994.1607404931.git.christophe.leroy@csgroup.eu>
References: <e3e0d8042a3ba75cb4a9546c19c408b5b5b28994.1607404931.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GeoIP: IT
X-SRS:  Sender address rewritten from <giuseppe@sguazz.it> to <SRS0=S1CN=FM=sguazz.it=giuseppe@centrum.lixper.it> by centrum.lixper.it.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christophe,

Il giorno mar, 08/12/2020 alle 05.24 +0000, Christophe Leroy ha
scritto:
> low_sleep_handler() can't restore the context from standard
> stack because the stack can hardly be accessed with MMU OFF.
> 
> Store everything in a global storage area instead of storing
> a pointer to the stack in that global storage area.
> 
> To avoid a complete churn of the function, still use r1 as
> the pointer to the storage area during restore.
> 
> Reported-by: Giuseppe Sacco <giuseppe@sguazz.it>
> Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> This is only build tested. Giuseppe can you test it ? Thanks.
> 
> v2: Changed an erroneous 'addis' to 'addi' ; Using bss instead of
> data section
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/Kconfig.cputype  |   2 +-
>  arch/powerpc/platforms/powermac/sleep.S | 132 +++++++++++-----------
> --
>  2 files changed, 60 insertions(+), 74 deletions(-)
[...]

I just tested the v2 patch against latest kernel. Please note that
yesterday patch was on a kernel named 5.10.0-rc6+, while today's patch
is on a kernel named 5.10.0-rc7+. Even with the latest kernel updates,
the patch apply correctly and machine boots normally, fixing the
problem.

$ uname -a
Linux titanium4 5.10.0-rc7+ #3 Tue Dec 8 09:11:20 CET 2020 ppc GNU/Linux
$ grep VMAP /boot/config-5.10.0-rc7+
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y

Thank you again.

Bye,
Giuseppe


