Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A077A2F4193
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbhAMCPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbhAMCPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:15:43 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8387C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:14:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f17so761108ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWtOVLLhnfRlekLf7TTZvaRWA1bOE7DsFIut1MbSMrk=;
        b=bDjjHynMAd/WOMFFw4X9/TwdXnzZuwqaeDny4WGpTyzdYpUYDc1hDV+wiswsBOT1rF
         BucwWA9OYFcFvhgupaACwkBfOdTZXdQYm5oMN/A+vtzVL2pQIudCbEKPFWuIUJsKot4p
         IuThZ28Da7vVkvzFDIVq4+oT8gwcMbiVLI9iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWtOVLLhnfRlekLf7TTZvaRWA1bOE7DsFIut1MbSMrk=;
        b=dREmOFvUmjBU1FN19zM7wE1X1rsqhlwV5saMvLTe/14BoNW18p5X3pthnxYQe4c5i4
         4TwUJjfUGFp7UohS71fESzYgdXZRXgspOZObDzS/oTFNyz2Yerc/3rnrKjwPRcjTVyEq
         wXPfxWCqgEMMPIHyrjGW6rCjERiH3i+MhC0VNu8BuoO+ksWQpzRiK9ZXt7n6CoCVO9dx
         Iasu0tq+shDQqxWY0Zc15/q7W5snCxcRh7gH+lO2XX9Lx22iCiuS+HHl5wrmwCLegXmS
         6DTFaLQ5n8QCMSohD+msbs4ycGiweDO+F9wiwnewij+2+rrwDcgSjPDG2QxKFWgD13b6
         NhZw==
X-Gm-Message-State: AOAM531UZWWCOcHN0+L5RqwuTcXo2ngddQahyAXHdUzC8DqhloMwnKP8
        ZCG2zBzNZLm/8ZiFTTSjl8AOJJcPYYODTg==
X-Google-Smtp-Source: ABdhPJz2g43rBKq7D803MFP/4RSUAr4CUwL/yNj5SR/ZE0g4YVGzoVl5A80iea/Dje7zMJ1HHWS4Tw==
X-Received: by 2002:a2e:9757:: with SMTP id f23mr901886ljj.55.1610504094928;
        Tue, 12 Jan 2021 18:14:54 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p6sm50315lfh.50.2021.01.12.18.14.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 18:14:54 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id x20so432434lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:14:53 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr723687lfr.487.1610504093548;
 Tue, 12 Jan 2021 18:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org>
In-Reply-To: <20210112224832.10980-1-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 18:14:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5oACdjFwnaonTWPVpBpwohxeJJJDvLvMS85RzrX5SYQ@mail.gmail.com>
Message-ID: <CAHk-=wi5oACdjFwnaonTWPVpBpwohxeJJJDvLvMS85RzrX5SYQ@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:48 PM Will Deacon <will@kernel.org> wrote:
>
> Life is too short for buggy compilers, so raise the minimum GCC version
> required by arm64 to 5.1.

Ack. I'll assume I get this the usual ways from the arm64 tree..

           Linus
