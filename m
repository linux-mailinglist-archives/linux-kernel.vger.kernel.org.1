Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60728EA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgJOB34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387861AbgJOB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:29:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D127C00216A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:13:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v6so1411179lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LURiEnBAw2K4z9zIAiaFYTyrr5u9bQTopZRlsHwZQ30=;
        b=PgKjpNgrHeicAl8QzyJWoTs5A6rmp6R8Pmum8VjneOxNanE02C3iR0xMHPEKXRSwiA
         hgbPuEmU4Y/KvHEeIBgVzlegtYfQL/e1IYCy/LveXiVHXjGwp6JSkRsgM1KwAIfKJcKw
         xjiOyeSTmvlceona3bncz+d4u8W6hA+58+IV74pozmLNmVEOzj6zHtFH6BbvMPGb1Q1N
         SCAyW7rDspMISGiSvIfRrqTnMCItj6RGBKiMdjZQs84SXB/tH/0v/+6ZNBKtXVi4giBx
         5O+k8MWQSqRdXTBoaXJdV4Sbx9ykfhv8CIwDyMJZ5tK/7VE1ZpxXSBqDafewuTLQ+EfB
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LURiEnBAw2K4z9zIAiaFYTyrr5u9bQTopZRlsHwZQ30=;
        b=qjXmvKyRi2jy5FCg4AvCwtWZ0Ha6lO//gRy4vlYoeMHfCoOnFDFPRK9aWUV9WCqtOS
         kdLNvfaqcCVAKRRXrL4Q7xrwXm70QzZ+iiqAe12hXhxy8KP4w0Dco6uIqulyi4MRpaB5
         nb0/SNqbRVX9H64XB03/sJyfzYrhJOeN4k42ysDG99olgbdc7f13Ed4HYCTo1fM+RMlv
         6XbTAnDhGyJ96ZY8nnGCQaqbh5X4KjGEWrQra/fVE3PVl1HbTjxDRhrKHKXaf4M6mvL6
         MebWFBl7cJ1FpD2lYlipzNrycnddj+IPJni18ce5XP/73DXLWfy+oLbaXRhjaYJXFdmY
         9Trg==
X-Gm-Message-State: AOAM530pDusxhwg+L1/KrpQZMABF5hjRMBwO9CNntai1TRc3DSfRFh+o
        AMgo42JhvpzJA+j9WgXTU9ann5I6Gb6I6RdsS35Kvg==
X-Google-Smtp-Source: ABdhPJzXFIHFpKtLKeaohPSTTFSTn1moPmFA2URXdVrEpwDK24AygeIW08WWsjsl1A8u32KKXSdaLbgxjj+v3FNFXjU=
X-Received: by 2002:a05:6512:52f:: with SMTP id o15mr141586lfc.381.1602720794371;
 Wed, 14 Oct 2020 17:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com> <20201013003203.4168817-17-samitolvanen@google.com>
In-Reply-To: <20201013003203.4168817-17-samitolvanen@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 15 Oct 2020 02:12:47 +0200
Message-ID: <CAG48ez26uiRBKS06_DQXB_GSmNjJjRiT+YA6pgLBGYCbVi2NNg@mail.gmail.com>
Subject: Re: [PATCH v6 16/25] init: lto: fix PREL32 relocations
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 2:34 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> With LTO, the compiler can rename static functions to avoid global
> naming collisions. As initcall functions are typically static,
> renaming can break references to them in inline assembly. This
> change adds a global stub with a stable name for each initcall to
> fix the issue when PREL32 relocations are used.

While I understand that this may be necessary for now, are there any
plans to fix this in the compiler in the future? There was a thread
about this issue at
<http://lists.llvm.org/pipermail/llvm-dev/2016-April/thread.html#98047>,
and possible solutions were discussed there, but it looks like that
fizzled out...
