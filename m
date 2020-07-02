Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F96211A35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 04:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGBCfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 22:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgGBCfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:35:38 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841E8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:35:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k17so2181489lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dO+MYSL5JIFNDDAWCgnk88YYd0Gu8lu4qudIafhsIH8=;
        b=bTqo5ZsG+TwJIPH9BEUoRZxCg6Dlz/Z85DLm7635y496rV2cjz70C5+v96VBOLtiOl
         Rruu4lhV2PhcHK2DpL7/sbJuOMI+t75nQ4D2yGsRZwFXv0lcTxHOzA5ylZi0GBfPRaph
         IhzmyMeIhDyj/OUByXBJb+9nWZPrkSBnqcIKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dO+MYSL5JIFNDDAWCgnk88YYd0Gu8lu4qudIafhsIH8=;
        b=cPOCofvF02F69GO+ubZvdyDpK2LDcOTTYeRidwNv46CD38Jv3T+bWMC1xy5mxXaaia
         BPG8r2OazNNFwxafcQHGJelDciX/cilU5ArpuCtmlmxLytTaLIhg6jRmhcoZkZcy16NQ
         Q0B1hPgdmOfpbT6+OzjUhqfZUv12DrMK//VnVYHEix9yv4mLdei2YLtFDDXUGo6H2z79
         yNMtLM4wjZBEDOR43pkr8ic6DGUiExbqU+kGSpcSXYkzCCdywRDe1Tvo0fJq0SQSj2z/
         e6GPKt6RJED0iqqs/fKvuquebSo8LTB1en/iIQJa+39yyWa6aE5JcX0uSDklEEtDs3o4
         +FKA==
X-Gm-Message-State: AOAM530LLIBe5kVVKyJv2rc52DhNsJeb977O4QR4zvKumacTwlClg9ho
        B9QMXMb2g218IK6BFPT1jsIZtFA37uo=
X-Google-Smtp-Source: ABdhPJzoNm4I/Ycl2sWRcW52HJ6bCNkxT5aWv+n16a0qZ2zMTKm7LwgkxIzB8jafPGKcahzQ/xTesA==
X-Received: by 2002:ac2:4550:: with SMTP id j16mr16955864lfm.37.1593657335729;
        Wed, 01 Jul 2020 19:35:35 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j26sm2761399lfm.11.2020.07.01.19.35.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 19:35:34 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b25so26094385ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:35:34 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr9680ljc.285.1593657334480;
 Wed, 01 Jul 2020 19:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net> <CAHk-=wh0X1YBQm8b6dqu=FpE8jgHriisXDeqJ7jai41Ob+sJDA@mail.gmail.com>
 <CALCETrXpKAR2A0+96b+RWUE0vUmoPwmp-mfF1u=g2270DNi96w@mail.gmail.com> <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjXftMyC93Jg8J=_HiuERsHujPOa-RbOmMLuuxVoJCrfQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jul 2020 19:35:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmS2E26pa=K3QOGfPqPyrJpSaosXDbnUmuBt2dHFP3jQ@mail.gmail.com>
Message-ID: <CAHk-=whmS2E26pa=K3QOGfPqPyrJpSaosXDbnUmuBt2dHFP3jQ@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guess we could do that. Are there cases where this actually helps?

Hmm. Thinking about it., using that approach might make the
"CONFIG_CC_HAS_ASM_GOTO_OUTPUT" choices simpler to handle.

With ASM_GOTO_OUTPUT it generates the perfect non-jump code. And
without it, it generates the (annoying, but inevitable) actual
conditionals.

            Linus
