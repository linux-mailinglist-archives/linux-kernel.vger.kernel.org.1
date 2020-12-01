Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508A42CA70C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391903AbgLAP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387678AbgLAP1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:27:03 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD342151B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 15:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606836380;
        bh=0o4SdGumF+JeBxeuBjBm8xVUoxZHRNR2hImrsWslEFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SLTlZyUfEIvDODk0le1vP3Ci2Aba0CGEDO/W7fsLb9wPw4loWpPFn/J/Arrn8dJu2
         PHS4N0olGV9He5Z3lOZ3R3tJYx302cP/qkuH6D1IF18Rbj9wI+kpxzZNBznJlwXcMY
         OP9VuATp2+KaFj9YWqL1cD7T3QmWJTvXMbLULUqc=
Received: by mail-ot1-f43.google.com with SMTP id z24so1982946oto.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:26:20 -0800 (PST)
X-Gm-Message-State: AOAM530QFeHJU7qXjbLr1DiHAUO7ELoHbAK2iHag1bm964R2iywWvY8V
        3C1WxCZ2wpJUqSoqQvbDvj0lNLsfK1yNzOC3ffQ=
X-Google-Smtp-Source: ABdhPJziF8PUZmJ/UcXpuHfWEtbtJBD4kLTFDJ6lgF88YecfGQ7d7foOpkRJGsQ6Dr9SKhRrYLJ47ttl46Vpa/kNbhw=
X-Received: by 2002:a05:6830:3099:: with SMTP id f25mr2108346ots.77.1606836379493;
 Tue, 01 Dec 2020 07:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
 <20201130190331.GI6019@zn.tnic> <8724DF91-5BF0-4265-8091-F9E0C7DC2F1A@linux.alibaba.com>
 <20201201112647.GA22927@zn.tnic> <FD133B32-6FC4-43FC-A6EE-A03FF3F7B1B1@linux.alibaba.com>
 <20201201145415.GC22927@zn.tnic> <8ED75067-DB02-4502-BA03-45B3519E408A@linux.alibaba.com>
In-Reply-To: <8ED75067-DB02-4502-BA03-45B3519E408A@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Dec 2020 16:26:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFkUEAB=65+gLKHKYbEcXWvObhsMRNNtyv3ra9JBfO0oA@mail.gmail.com>
Message-ID: <CAMj1kXFkUEAB=65+gLKHKYbEcXWvObhsMRNNtyv3ra9JBfO0oA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64:msr: Add MSR driver
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        shawnguo@kernel.org, vkoul@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anson.Huang@nxp.com, michael@walle.cc,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>, gshan@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020 at 16:17, Rongwei Wang
<rongwei.wang@linux.alibaba.com> wrote:
>
>
>
> > 2020=E5=B9=B412=E6=9C=881=E6=97=A5 =E4=B8=8B=E5=8D=8810:54=EF=BC=8CBori=
slav Petkov <bp@alien8.de> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 01, 2020 at 10:33:42PM +0800, wangrongwei wrote:
> >> Yes, and x86 also provides two instructions with the same name in the
> >> instruction set, but not in ARM.
> >
> > Sorry, I can't parse what you're trying to say here.
> In the ARM architecture, there are no rdmsr and wrmsr instructions.
> In ARM, the system registers can only be accessed through msr and mrs, so=
 the problem created by MSR driver (depend on rdmsr and wrmsr) in x86 is no=
t necessarily present in ARM, which is very different from x86.
> In addition, we want cross-platform compatabilities, and fill these gaps =
in the ARM.

Apologies for being blunt, but this looks like another occurrence of
the 'compatibility' disease, where everything has to work in the exact
same way as it does on x86, even if it was a terrible idea to begin
with.

One of the nice things of having a [relatively] new architecture is
that we are not being held back by backward compatibility
requirements, given that we cannot break existing use cases that
predate the existence of the architecture.

In other words, there are things that the x86 maintainers would gladly
remove (such as MSR access from userland, and I'm sure there are many
examples), but they simply cannot because it is already being relied
upon in the field. But that does not mean other architectures are
required to provide a similar interface, and especially not ones that
allow you to poke at undocumented, non-architected CPU registers.
