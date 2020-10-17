Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F65291153
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 12:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411798AbgJQKMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 06:12:40 -0400
Received: from ozlabs.org ([203.11.71.1]:55599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411749AbgJQKMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 06:12:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CCzND41jbz9sTc;
        Sat, 17 Oct 2020 21:12:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1602929558;
        bh=jx4jSwXojnGEjdS06THopQmjsKwy9vnpGRU1Yg/+LR0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=r85jUpGpfzFa3HUnz79ZDtfjkwJ+DwrPKFjCJGv9/w2mu4qGoFqeRNc2QGTYltSaG
         E4jx2/IodEThTcc4AvWpxhLTRA51ehQgsZuAveOK2ebZ3fUJH7Tn2zj+BqK+o63K1R
         QjHAECCtGh1c2uQhTeCNJN69rZQ4lzphWdJMggnIOLI7cNjPSzGPVTKXnFBz/RW7Se
         R7BJTPTIWKlkGMDRB1poeBZpYlpxlaZLVIGnC1gGPorAtKTEizH4easat4dMS/jDou
         Yd+QQ1yJEzVtDhqbRqyz8/Xp0xoJ+vnvgZhp5HvuATyo9FSMWBQCYakWW0ApeEiLYf
         FIqZSFFueYFIw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ajd@linux.ibm.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        atrajeev@linux.vnet.ibm.com, bauerman@linux.ibm.com,
        biwen.li@nxp.com, Qian Cai <cai@lca.pw>, cheloha@linux.ibm.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>, clg@kaod.org,
        Colin King <colin.king@canonical.com>,
        David Miller <davem@davemloft.net>,
        Daniel Axtens <dja@axtens.net>, ego@linux.vnet.ibm.com,
        fbarrat@linux.ibm.com, fthain@telegraphics.com.au,
        gromero@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
        hofrat@osadl.org, jniethe5@gmail.com,
        Joel Stanley <joel@jms.id.au>, kjain@linux.ibm.com,
        leobras.c@gmail.com, Li Yang <leoyang.li@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        liushixin2@huawei.com, mahesh@linux.ibm.com,
        miaoqinglang@huawei.com, mrochs@linux.ibm.com,
        nathanl@linux.ibm.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Stephen Kitt <steve@sk2.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, wangwensheng4@huawei.com,
        Wolfram Sang <wsa@kernel.org>, yanaijie@huawei.com,
        yangyingliang@huawei.com, zhengbin <zhengbin13@huawei.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-1 tag
In-Reply-To: <CAHk-=wjTwLKR1YhVHv5UzvCag5jxBeKVxLLxN9-CoxQYhi_=Kw@mail.gmail.com>
References: <87a6wmzwco.fsf@mpe.ellerman.id.au> <CAHk-=wjTwLKR1YhVHv5UzvCag5jxBeKVxLLxN9-CoxQYhi_=Kw@mail.gmail.com>
Date:   Sat, 17 Oct 2020 21:12:27 +1100
Message-ID: <874kmtyxdg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Thu, Oct 15, 2020 at 8:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Just two minor conflicts I'm aware of. The only slight subtlety is the conflict
>> in kasan_init() where "int ret" needs to move out of the for_each_mem_range()
>> and up to the function scope.
>
> Well, there was also a conflict for the dependencies of OCXL.

Yep, it was so trivial I didn't think it was worth calling out.

> I resolved that by ruthlessly simplifying the dependency:
>
> -       depends on PPC_POWERNV && PCI && EEH && HOTPLUG_PCI_POWERNV
>  -      depends on PPC_POWERNV && PCI && EEH && PPC_XIVE_NATIVE
> ++      depends on HOTPLUG_PCI_POWERNV
>
> because all the other dependencies seem to be pointless.
>
> HOTPLUG_PCI_POWERNV already has a
>
>         depends on PPC_POWERNV && EEH
>
> so there's no point in repeating those.

And PPC_POWERNV selects FORCE_PCI, which takes care of the dependency on
PCI.

> And PPC_XIVE_NATIVE is selected by PPC_POWERNV, so if PPC_POWERNV, we
> know PPC_XIVE_NATIVE is set.
>
> Maybe I missed something strange, so I'm just letting you know so you
> can blame me if I broke something.

No, that looks good to me. Thanks.

cheers
