Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92452A4622
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKCNVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgKCNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:21:52 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C5C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 05:21:51 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CQVmq12kQz9sVK;
        Wed,  4 Nov 2020 00:21:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1604409707;
        bh=MYU/GYY7WjVexPVFkQjnwSJPt6lSEwILNYT0f9czXic=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QsyOdLU8adwVcT8UXmok40+HZGKDVAJxNBuEZyOMHRguFeBnxFXHjqdOHTKaffzfS
         wdeFcw9uRV+38twP0uAPQLraN5Zp6zBx2hCo9GY68ewshFt3+2KqbPlDO/mDE0Kaqa
         EWI8MYDfDuNxBRAAGYFa8JAJd2AHRTqdmEwIyv0LsoB0LDNmS1MhMfqa9t1DXbt9Wh
         oKS/hzSsPavOyqGB+RqJN4UXzDHa28vADzT3beGbYUO66JOwCwB6oYLyYKMwcBu/Bz
         ZeChRJ2wt/RymbPo471jHnfIQplSkHegyyBoijeIvl24k21fMgeediCcNj/HrBT+rn
         z9PnukoBH6xtQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc/uaccess: Switch __put_user_size_allowed() to __put_user_asm_goto()
In-Reply-To: <871rhgwzcg.fsf@igel.home>
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy__44535.5968013004$1599217383$gmane$org@csgroup.eu> <87mu079ron.fsf@igel.home> <87imav9r64.fsf@igel.home> <87pn53vsep.fsf@mpe.ellerman.id.au> <871rhgwzcg.fsf@igel.home>
Date:   Wed, 04 Nov 2020 00:21:44 +1100
Message-ID: <875z6mvamv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/powerpc 5.10.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="gcc-4.9 (SUSE Linux) 4.9.3"

So it seems to be a combination of GCC 4.9 and ...

> # CONFIG_PPC_RADIX_MMU is not set

That ^, which specifically causes PPC_KUAP=n.

When PPC_KUAP=y allow_user_access() inlines an isync and mtspr, both of
which contain a memory clobber, and that seems to hide the bug.

I think for now we just have to stop using asm goto for put_user() on
GCC 4.9.

I'll send a patch for that.

cheers
