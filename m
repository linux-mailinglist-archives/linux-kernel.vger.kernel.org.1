Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2151CBF4B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEIInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726063AbgEIInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:43:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708AC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 01:43:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f15so1777646plr.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=MM0pGuoQz+m2i7SaYQltsjhcG+vuQhDEB07kHe3ONp0=;
        b=kcvLKoGHrq9a+5FfTP8I/NSRlRWu8KC1v695rjWAb9PcXDvN9fvLTi2oFBnMQCjBOY
         EPu3A2k0S9rM8sVRt4AllKRGzkMHa+mCg07kNipoGXPLoIxr1zaKy3OPelFzOOmwND7+
         cgkpVRemAhJ+yVySh/spOAaQ5wnLx3cu0pfxBJXEAP3lXJPmIXNN+mJf1OtqtiHIfG7S
         tXDRZBpYBb5eY7ddn+nJ/QeJl3ZniXG4JIaqkvaRwTvEcD3UFG+JGxjLmBFn9rzxPHlj
         TqFHybaSAf2rwWCCo8B7A4jeFE8p5+QkzdYbyT/6RuaJA8ed/2SRuqa7RBk6ZKovLbLK
         JJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=MM0pGuoQz+m2i7SaYQltsjhcG+vuQhDEB07kHe3ONp0=;
        b=KFmch7KBx8Dl1qysFsOwVqnF+t5YXTR1jU4w1bU3IJE+G+f8R7QieugYcc9mnEieCk
         4OexisEA9isBojnSEqz4AJIMuZwxRPZc35zqy/5idqvE7iwxp8hRajGpLXJKd9rse6+r
         dDtNPVAnUCf3u70Z1SLh698mNAGNQRsiBTbacG/S5iP3y0NNAQJ0YfjXeV5iHKVd64CB
         kLIareKxsM1CuOentobEjDSCq1AkQNmAJzJacSzYT9hRDxRT4pWphxppV8BYmNo5zZ1n
         JDrJbWo+233D+jYeTGecLqDIxGuHJNPJXvSLyExxPtdAdroTt8TExD6aFU/BHUVyJwfQ
         5SPQ==
X-Gm-Message-State: AGi0PuZ1r8dSvdqEnvlvGgMNjRwB0SFhC4ZQDdLD85AV3Mahum4G5OaD
        Lc0lHBTKTcBVZ3eyTwWN8kU=
X-Google-Smtp-Source: APiQypJOeWgThOJc+RzZuE2Da5TBy3JNA8q5LcFNGI6CFT06/rcxe512zRiuVgYXqPtfTYAokEoLdw==
X-Received: by 2002:a17:90a:f40f:: with SMTP id ch15mr6228382pjb.178.1589013816321;
        Sat, 09 May 2020 01:43:36 -0700 (PDT)
Received: from localhost (61-68-214-199.tpgi.com.au. [61.68.214.199])
        by smtp.gmail.com with ESMTPSA id v9sm4218268pju.3.2020.05.09.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 01:43:35 -0700 (PDT)
Date:   Sat, 09 May 2020 18:43:30 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
To:     Qian Cai <cai@lca.pw>, Oliver O'Halloran <oohall@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
        <CAOSf1CFNp6+k_y_87r7p2e8cKfX0rK-9wBxeR+K0e0y8R0_TNg@mail.gmail.com>
In-Reply-To: <CAOSf1CFNp6+k_y_87r7p2e8cKfX0rK-9wBxeR+K0e0y8R0_TNg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1589013519.0fzm2px5cz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Oliver O'Halloran's message of May 9, 2020 6:11 pm:
> On Sat, May 9, 2020 at 12:41 AM Qian Cai <cai@lca.pw> wrote:
>>
>>  Booting POWER9 PowerNV has this message,
>>
>> "ioremap() called early from pnv_pci_init_ioda_phb+0x420/0xdfc. Use earl=
y_ioremap() instead=E2=80=9D
>>
>> but use the patch below will result in leaks because it will never call =
early_iounmap() anywhere. However, it looks me it was by design that phb->r=
egs mapping would be there forever where it would be used in pnv_ioda_get_i=
nval_reg(), so is just that check_early_ioremap_leak() initcall too strong?
>=20
> The warning there is junk. The PHBs are setup at boot and never torn
> down so we're not "leaking" the mapping. It's supposed to be there for
> the lifetime of the kernel.
>=20
> That said, we could probably move the PCI setup to a point later in
> boot where the normal ioremap can be be used. We would have to check
> for initcalls which depend on the PHBs being setup and delay those too
> though.

I think it helps to unify code a bit more and take special cases out of=20
ioremap to have all these early calls use early_ioremap.

We actually do want to move these later if possible too, on radix they=20
use memblock for page tables, and on hash they don't even set up proper=20
kernel page tables but just bolt PTEs into the hash table.

Thanks,
Nick
