Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82DB2BB677
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 21:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgKTUTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgKTUTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:19:44 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D3EC061A48
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:19:43 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x11so5680658vsx.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7acuhIcf2aj+2HfwBkYRj3S/5vwbxxWC1CPfVW74VbQ=;
        b=gyFkFQiGUkXaUSAApDExFsLoGANoyNJrTgq+Uj6paRE46wRNgi6CKDFwmTfHlKvQPj
         Er7YyuPh/Vm7IE8fo7s0qFaQ+J1KSSTh2gKBxnB1wIcKxIDjY6KSardWaLK7oDrc8y2c
         4kdFdNabC+L2Mjs5rrPZnanoVf79hAu3cru/VeNYnxmuOucQz4Zphk15Gez73fSD2CqD
         AQbMyvtkwotDifRaGV6FeXKSexUu1NjZCba58CUErs2OOa74uTI7jGSLqvFrp+lsC6E+
         Ms7cuIiIpj16zzxU5/wxq9BhB8eXHmGgvUZLrwYiI37n7bXiBngkjjGfqQuKlN1BFLWq
         HIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7acuhIcf2aj+2HfwBkYRj3S/5vwbxxWC1CPfVW74VbQ=;
        b=odIU98Lt5VmEG3QthXPUlwnMxi51p9zvtKPWuhxzLSsVHP+kawM3b8gw2vqHFA+vQI
         J2Mwti+ZWmil2nBIQSS+nhuNWM+Aq8kcy7/9r1WdU83mJOHYsFYrPGIwTpf7G6PZDhZr
         z8eEBqyUF4Z3VrycO8sWUa+Ku5EK1mpQKjodxJrfIuk2+k/3Nrc4M22N1Sg8e3NO9KZa
         WGJxfk70YPNLNH32E+nBt2AhK6q9jmDakoEu9Btgj6Z9+uVzqL5SY1EoqQWgVP2SMMUs
         NrSt/FfohSBoyfg9UVyCm1DVrlwvngcvKu4Zfk8O1bgCn0pUMoJljRaww0yk4R+nNE3+
         Gldw==
X-Gm-Message-State: AOAM530NXK1qBA+oTH4qpfGSHBimFLAAHeh1ReDNKVa9evvOWti4s66I
        HD4MXAXOUrMLwCYTnxQGexRVazhdRoZeQLQrSaTOnA==
X-Google-Smtp-Source: ABdhPJxFgydZX2L5XAnYwSfeznScyETG/9FyvzzmXojnDnWISYdoy1l6/FMv24FHnaLHqIodrvwFJpF/G3jjdZFT5xQ=
X-Received: by 2002:a67:7107:: with SMTP id m7mr15151234vsc.17.1605903582865;
 Fri, 20 Nov 2020 12:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com> <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
In-Reply-To: <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Nov 2020 12:19:31 -0800
Message-ID: <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 2:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Thanks for continuing to drive this series Sami.  For the series,
> >
> > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I did virtualized boot tests with the series applied to aarch64
> > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
> > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
> > please drop my tested by tag from the modified patches and I'll help
> > re-test.  Some minor feedback on the Kconfig change, but I'll post it
> > off of that patch.
> >
>
> When you say 'virtualized" do you mean QEMU on x86? Or actual
> virtualization on an AArch64 KVM host?

aarch64 guest on x86_64 host.  If you have additional configurations
that are important to you, additional testing help would be
appreciated.

>
> The distinction is important here, given the potential impact of LTO
> on things that QEMU simply does not model when it runs in TCG mode on
> a foreign host architecture.

-- 
Thanks,
~Nick Desaulniers
