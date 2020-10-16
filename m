Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212ED290C48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411017AbgJPT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406432AbgJPT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:28:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E792C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:28:22 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f21so3699259ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRVo2b4ecg4fSLmj2WDTdho466tlop5d3GW1xgN23Yc=;
        b=LtWF4l2zb33bsp8mIFoo0zYwm+TW2Ly3PPuLPnO3A6OUPkIxlrpqhj+yE02ERp9D8e
         0A0I6jUZa/WGIdYT0aSYrO4r6yS7SV3b+44IbPu6gddOdh4PBi/bfl/WzLB9bNZRZpZK
         br4Z/e7aE9SCW3jSJY/PBQYNJS9XMkpaijjNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRVo2b4ecg4fSLmj2WDTdho466tlop5d3GW1xgN23Yc=;
        b=FzpfjWxQ0EajZEPfXQYBg8KRrPd9ruOnod2Syz/T8RSRv8iJGF3jf1V/R+hSQ8Gq7b
         hhKJcxrhv96qxHACLgiHnS2OBemmHMeQfkI/82lyNF7Qcb563e/mQzAfd+xgu48CJ+rB
         nO489Sc+cIch03qKAtHiSsAEBywQiavfaV+XwvGjK58CkjkMCXEVBXrIyqulBu7ggCO8
         fXvQBf9Ef/Qxp0EF05DKatU5wLAlx6+Ydk70DoeHhjdKsdjiD+KOhynp9sZB3v/kA7/J
         2PIa7DuKVxJ4SL/IrNZqXOBZ9pOHIVpY5y00u4aFNPAz4i1j4RsLiGuhSW1fhd619gmI
         FboA==
X-Gm-Message-State: AOAM530dJbZruENAcjFKFbxHBa9oeTT47rLbj846bkZgKM98zUiaSHlj
        5F9TnnVO2wHD/m80bV9E4OezM81h1zPjlw==
X-Google-Smtp-Source: ABdhPJxiUAd/cQryWpU95BxttnpDrqurWaPkg17KIXESxEg82ZwciktU9O6J7B8DS2dqUaBrA13pEQ==
X-Received: by 2002:a2e:1614:: with SMTP id w20mr2346851ljd.103.1602876500313;
        Fri, 16 Oct 2020 12:28:20 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id t17sm1093002lff.147.2020.10.16.12.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 12:28:20 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c141so4383156lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:28:19 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr2066193lfz.344.1602876159691;
 Fri, 16 Oct 2020 12:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <87a6wmzwco.fsf@mpe.ellerman.id.au>
In-Reply-To: <87a6wmzwco.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Oct 2020 12:22:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTwLKR1YhVHv5UzvCag5jxBeKVxLLxN9-CoxQYhi_=Kw@mail.gmail.com>
Message-ID: <CAHk-=wjTwLKR1YhVHv5UzvCag5jxBeKVxLLxN9-CoxQYhi_=Kw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
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
        "Oliver O'Halloran" <oohall@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 8:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Just two minor conflicts I'm aware of. The only slight subtlety is the conflict
> in kasan_init() where "int ret" needs to move out of the for_each_mem_range()
> and up to the function scope.

Well, there was also a conflict for the dependencies of OCXL.

I resolved that by ruthlessly simplifying the dependency:

-       depends on PPC_POWERNV && PCI && EEH && HOTPLUG_PCI_POWERNV
 -      depends on PPC_POWERNV && PCI && EEH && PPC_XIVE_NATIVE
++      depends on HOTPLUG_PCI_POWERNV

because all the other dependencies seem to be pointless.

HOTPLUG_PCI_POWERNV already has a

        depends on PPC_POWERNV && EEH

so there's no point in repeating those.

And PPC_XIVE_NATIVE is selected by PPC_POWERNV, so if PPC_POWERNV, we
know PPC_XIVE_NATIVE is set.

Maybe I missed something strange, so I'm just letting you know so you
can blame me if I broke something.

              Linus
