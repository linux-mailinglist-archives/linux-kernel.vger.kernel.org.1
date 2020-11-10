Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211BD2AD097
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKJHoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:44:17 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 23:44:17 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b17so929353ljf.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 23:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sekTus97mHsi9jFdvTcgScvJxfYD1QrR3Zdvt+L6iSQ=;
        b=UJ4cLR5lYqNgCxNmSDehUepur7enZnuHajc7VgYX4HWNOgZH8NM2yMLBXMLVClyC1V
         9hIJgjqV+Y3n/CReWsM5d89nFsaw0iRfIDXodB95IP0aJgtAD5NnIekVv83fF1ObyxWH
         vlrY5n6iBtT+s0a/RgP8X9SqS5/Ro2SAmyWCk7Ssf+jXmI3JmuueT2gnBx6Y8q7xBb1g
         x3SZJReVyOIYJdK0m+phkouzHxKm6OGGCUiRsfpE1UT/giZ+H4cim751vBs6WZRBMAjo
         SQ0VGXyZIjE7nKMmDHTt0KeXqKONxZ4xESC2GvPAVWR/G2ICLQtEuy1T/obaeloID9Em
         6/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sekTus97mHsi9jFdvTcgScvJxfYD1QrR3Zdvt+L6iSQ=;
        b=XXlKnDWQb72sw41NaPFyX+0tmaLc+Usy/EGkj7NZEL+YaYEVxdpK9gKb2OK98R4TlT
         /ubiWLLjqmNXYfd2CDfLnNKBlb9XKlKpEiHN09CInAKge2C3qG0TqR8ftEyNexYxdVhb
         6dpT2i9FcvcjLxBkzfiey1j0M2yMnYQ+qf8VIJxYOluguUddSOazZWSljFtHPwUbYVGx
         I0jrG+Czc32OjLOx9RXl+ez8yUExfs/ujekiU4OF3LfHiNPa07Qouk97CUwSGV08+2i+
         xI2/fZL8D/VS7DTWD/Tp6Y+Uuv48WNn4LMXo/kFmoF8+G6L+9ucRSjUbwaQ3Pg/K1c4h
         UhRA==
X-Gm-Message-State: AOAM531CXSydvB0fxZnKQUhPTR+ORvVsXEx02QbqEctgSHmjq7I+TLSS
        nWZ/QJkzuEtKx2Q2+tmwk25KdvAuuXA=
X-Google-Smtp-Source: ABdhPJyj7Z3ZOhAZLh9+G+rqU5oTRpthnnSilq0DGnDhhkp6qK66UHoy7yLZFEv1cnRvQc5vla0Mog==
X-Received: by 2002:a05:651c:8a:: with SMTP id 10mr7299000ljq.275.1604994255792;
        Mon, 09 Nov 2020 23:44:15 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id n5sm2017481lfl.175.2020.11.09.23.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 23:44:14 -0800 (PST)
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
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
 <f4b4f5ca-2c0c-c1f0-9329-a95967b99bd0@gmail.com>
 <CAMj1kXEJL31KOMs7h_XzxFKXgqi2jOXCmLaxfKwW=wgo2so_RA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <a438f99d-26a4-a1b5-9fc3-5abd2e76edb3@gmail.com>
Date:   Tue, 10 Nov 2020 10:44:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEJL31KOMs7h_XzxFKXgqi2jOXCmLaxfKwW=wgo2so_RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.11.2020 10:25, Ard Biesheuvel пишет:
...
>>> So the options are
>>>
>>> a) merge my patch that adds 2 bytes of opcode to the Thumb2 build
>>> b) merge Dmitry's patch that adds an unconditional literal load to all builds
>>> c) remove kernel mode handling from vfp_support_entry() [my other patch]
>>> d) move sections around so that vfp_kmode_exception is guaranteed to
>>> be in range.
>>> e) do nothing
...
>> The performance argument is questionable to me, to be honest. In
>> practice the performance difference should be absolutely negligible for
>> either of the proposed options, it should stay in a noise even if
>> somebody thoroughly counting cycles, IMO.
>>
>> I'm still thinking that the best option will be to apply a).
>>
> 
> Can we take that as an acked-by?

Are you asking me for the ack? I think this is a more appropriate
question to Russel. I'm not arm/ maintainer, but could give r-b and t-b.

If you're going to follow approach that I'm suggesting with a) + d),
then could you please resend the two patches in a single series? The
first one-line patch-fix should contain the fixes tag.
