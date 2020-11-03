Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306642A3F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgKCInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbgKCInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:43:15 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D71C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:43:14 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id f9so21097920lfq.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eZ78QKU5zhNl2xLl/0nTlqEQQ1NMs6MqfyMY7wLeUDg=;
        b=IK3z930i181SzAuLUeu4fNiXRL9B2oCpHUE+mLelv6Deeb2aWtUNWITAQPlC7COqTU
         rru+pvRFbDPrx7fFg78hyMCOPutzN/l8DxBapDnVghTXPuv8kxncHH9QOBOdRXT+bwYe
         HV2nSk4j6GEQZ02zYnhugE6ip0PX3jNRaiR+w/l1l81IUgMSAPN5L9sfDRTIY/PFDBAz
         LFQzApLe9jNEbT1DvysB/Y2M0aaKERH8y/396eecpO2e+cJDfC6ADyAXvhhz1NDx8oe6
         EZtrqm+7LX/f8h+QmfkIL57NMtm+SDK87B6as2vN3V8DwTVj93YKoU7NyCejXM2UnMEZ
         PG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZ78QKU5zhNl2xLl/0nTlqEQQ1NMs6MqfyMY7wLeUDg=;
        b=m0uxFfPjv4xsDcIq9KRAXYhIV5SruTCUJ0LO1zXGcnfRxQrV8IkQqmJ+S0pfCMwBGZ
         JgNG/6HOMXIFcuAWZTeFu4LHSiCwoMy4ReX/i+EKrwpViDoJHs1aDGq6hjKphgb0ag/L
         NTG9QHXKavL8mg8leSD+kxZYENoK/Dc563U3HT6254teY9MuzOwwUbM39wat7Jur5cMu
         xTBwtb9LI2uuEUJ8IWzfByVXvVBnUz4p/OUOUgwTsOT10PN+EJQjdnCWL5MyIFmuSHlx
         tKWG7caXAir0NYOz833keizCT+cqO3nabxHpom8vW0RxfyJ11rcJiQK8RV8YTEScNFjk
         imFw==
X-Gm-Message-State: AOAM532FDYA5skQ2Pv2wg2W0bOlYZ2D8AxMoG+S9Ywzidh+cThNhMy4n
        0yEjQgx92ptTOlG1lPrbs8I=
X-Google-Smtp-Source: ABdhPJxVPBHcJHkpY5wYc7dGIS0n4eb4MNmsNeLW5ZUMr6l4nvXbdjRkWSN2lf87u15FA29qg6v/5A==
X-Received: by 2002:a19:8d3:: with SMTP id 202mr6743681lfi.600.1604392992679;
        Tue, 03 Nov 2020 00:43:12 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-17.dynamic.spd-mgts.ru. [109.252.192.17])
        by smtp.googlemail.com with ESMTPSA id c133sm2473422lfd.92.2020.11.03.00.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 00:43:11 -0800 (PST)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
 <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk>
 <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk>
 <CAMj1kXF+2kJrUaDyA-Xw4rz2bsuEipX3P4JyPrY1bim76LQvoA@mail.gmail.com>
 <20201022174826.GS1551@shell.armlinux.org.uk>
 <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
 <CAMj1kXGok50R+2FZ=LqRAx5N3otC3AvC26=+NUqNC6kSvY2-Lg@mail.gmail.com>
 <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
 <CAMj1kXFMiTSakUGnopb8eWRHTM9-0XM0kDaJvTXWDhRPJ3Vsow@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4b4f5ca-2c0c-c1f0-9329-a95967b99bd0@gmail.com>
Date:   Tue, 3 Nov 2020 11:43:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFMiTSakUGnopb8eWRHTM9-0XM0kDaJvTXWDhRPJ3Vsow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.11.2020 10:24, Ard Biesheuvel пишет:
> Still broken today
> 
> https://kernelci.org/build/id/5fa0c1a74bdb1ea4063fe7e4/
> 
> So the options are
> 
> a) merge my patch that adds 2 bytes of opcode to the Thumb2 build
> b) merge Dmitry's patch that adds an unconditional literal load to all builds
> c) remove kernel mode handling from vfp_support_entry() [my other patch]
> d) move sections around so that vfp_kmode_exception is guaranteed to
> be in range.
> e) do nothing
> 
> Given the lack of reports about this issue, it is pretty clear that
> few people use the Thumb2 build (which I find odd, tbh, since it
> really is much smaller).

I waited for about a month, hoping that somebody will fix this problem
before bothering with bisection, which took quite some time and effort
because intermediate commits were broken, and then with creating and
sending a patch :)

Thumb2 usually is untested by CI farms and in a case of personal use
it's easier to wait for a fix. Hence no much reports, I suppose.

> However, that means that a) is a reasonable
> fix, since nobody will notice the potential performance hit either,
> and it can easily be backported to wherever the breakage was
> introduced. (Note that eff8728fe698, which created the problem is
> marked cc:stable itself).

The performance argument is questionable to me, to be honest. In
practice the performance difference should be absolutely negligible for
either of the proposed options, it should stay in a noise even if
somebody thoroughly counting cycles, IMO.

I'm still thinking that the best option will be to apply a).

> Going forward, I can refine d) so that we can get rid of the kernel
> mode path entirely.

And then improve it using d).
