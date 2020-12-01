Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FF2CADFB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgLAVCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:02:19 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAECC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:01:38 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id x16so7215364ejj.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b2FxREJM4KjZutceZCm25hg4BRQNyF6TpYcPtf6exnY=;
        b=GLG/t2IxW3mCp/BetlRq/BBwsv1JBsWUmjds4/r+84jUi4qOZBYI4YgNj6dkWkAAgc
         VRLtr7jzIUEdV9wnan52IjIHjbHQCicerFBxYUwnfvwSUQSKChATqntW/0vlbD+aWvbv
         Xkb1LwSjHWHJ5Q04GghKiOHp3Lmg9RjmfmbtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2FxREJM4KjZutceZCm25hg4BRQNyF6TpYcPtf6exnY=;
        b=VDThladsBfKVDFdwCuMPXgQU3e8RmXXz3y3LwChACN6B+5rmAnZkHBw9SAoEJqxDty
         RIQaB59DqNgThjHkgoj91lK1jmook0bBU9zljldhza7SXl592+IQ1p9leuPZcdtHcrmw
         4b/WCuGTQL+sR1nNy7L5PgNTKOiBmExiaEE0rzNJ8XmkWjtJTIKgKPtXtTn9PPKufCNc
         +6HgIcZW+dlYRqsSw2ZN9GK0USbFw4FAbM6EBGxRuIRnf8JlQmMXX2/Fr6V6scEl1Ef6
         fUB2um+nsiNLKPXrbyrg4zoTWA3vUQpFsXUOeUfwgQamTN5WC8uukg4ITjo3Snuu8Rsg
         wxRw==
X-Gm-Message-State: AOAM530z9d+s23oSeI/EkmY+7Pa4WFX12UKH30lBA6maQXvxG3j4CgN6
        00ji5WAylPgpjsi/Wxv5CU0Cbg==
X-Google-Smtp-Source: ABdhPJzkd58bgZ96BqBkB1Sg03ulI20Urh8kP5Lgd9L+zrBRafSOh7CYNmsxGvyfN2gZ6H9ouq4iDg==
X-Received: by 2002:a17:907:28ca:: with SMTP id en10mr4806924ejc.268.1606856497381;
        Tue, 01 Dec 2020 13:01:37 -0800 (PST)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id n22sm445316edo.43.2020.12.01.13.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 13:01:37 -0800 (PST)
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, George Burgess <gbiv@google.com>
References: <20201201152017.3576951-1-elver@google.com>
 <20201201161414.GA10881@infradead.org>
 <20201201170421.GA3609680@elver.google.com>
 <CAKwvOdkhBTjjtEm9dc9irp8hpWoEDEAMj_Zp4ntKspgDkjrATg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <764b18d4-b519-9f27-f66b-7cfdab61b313@rasmusvillemoes.dk>
Date:   Tue, 1 Dec 2020 22:01:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkhBTjjtEm9dc9irp8hpWoEDEAMj_Zp4ntKspgDkjrATg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2020 20.56, Nick Desaulniers wrote:
> On Tue, Dec 1, 2020 at 9:04 AM Marco Elver <elver@google.com> wrote:
>>
>> On Tue, Dec 01, 2020 at 04:14PM +0000, Christoph Hellwig wrote:
>>> Why not use the kernels own BUILD_BUG_ON instead of this idiom?
>>
> And to proactively address the inevitable: why do we have both?  We
> looked into wholesale replacing BUILD_BUG_ON's implementation with
> _Static_assert, but found that they differ slightly in the handling of
> integer constant expressions; BUILD_BUG_ON was reliant on some
> compiler optimizations in expressions making use of
> __builtin_constant_p that cannot be evaluated when the compiler
> performs the _Static_assert check. 

... and _Static_assert() is a declaration, so even many of the
BUILD_BUG_ON() that have a bona fide ICE cannot be converted because
declaration-after-statement.

Rasmus
