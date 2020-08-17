Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B3247B16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 01:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHQXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 19:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHQXdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:33:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A8C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:33:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w14so19373852ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FifRv5fzYglFQPh5FYSGShnZrmnfM3kKbm4D0PEuEs4=;
        b=DSSJYBfqUqSVYbJaGm8rfTY5KjQsyhXCsKHacZ/kCQSTfAoxGgSXtMvR1V71xsVBrN
         a1zMisQovyRSC4K8DhQJOwovatfZudQkWhY+R+orArtSZXTJkF/IXwitF/nVolDqtiax
         0I0uN4N70UZjoQL+52XUho8gWT09yu4VNWmiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FifRv5fzYglFQPh5FYSGShnZrmnfM3kKbm4D0PEuEs4=;
        b=Wa8A9e2r7kXjbFbZ8Zd3r62zFTbDqSBs7MWT2OLMtkN8pdpWo1SHsIt4En7vXyoB/K
         gxBF8UntITsC5Fqk2468hBKoFoGtz7L69iKxDmfe67PBbJodPhTegj6OvCZKwrG1dm4n
         rXXNInNivTa5WOKtaztgbdNodzY+1WRaH1QqcQsU+1FZfU0wPrGQxyY5R5MCcRRCHKEK
         F+1cSCvvFMIB85qer1cqKztAjFjIMeNv9B41c5K+q3Wy6xLw9KClvRfM+pjya7QMoHgV
         TSeKQ3G+/p0cGPKbgPJCUDjfD8btaMbHTyJsvqUXj7KTjsCQtYqrsz7F5vMFZFETILuv
         4Xjw==
X-Gm-Message-State: AOAM531Bl0Etz4pnkjikKU2jPmUjDHJ/TQn8yXH5H5KEjdM5zZLetSWt
        OPy4E34hlPjjgKAOS2Rn8nOgZ1hxc9bR7g==
X-Google-Smtp-Source: ABdhPJwmdWv7DJvrGAXQqEjQoJOxsbCDMpJDnkU2McCMr8sGvmfl8uGyxydQZCdEBrXVf/reqm82fg==
X-Received: by 2002:a2e:164f:: with SMTP id 15mr8692461ljw.68.1597707197119;
        Mon, 17 Aug 2020 16:33:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id x6sm5890504lff.64.2020.08.17.16.33.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 16:33:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id i19so9235658lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:33:16 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr8422105lfo.31.1597707195695;
 Mon, 17 Aug 2020 16:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <20200816225822.GA3222@debian> <CAHk-=wgOaEmFGYhnx7XLe8AbQKYpgMAzyuHuS8dYZoB2hS3C=A@mail.gmail.com>
 <20200817212519.GA11141@debian>
In-Reply-To: <20200817212519.GA11141@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 16:32:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm2fcvovhvtXceNzQGet=hZspqSBRrpoYzwe2ZhX=UNg@mail.gmail.com>
Message-ID: <CAHk-=whm2fcvovhvtXceNzQGet=hZspqSBRrpoYzwe2ZhX=UNg@mail.gmail.com>
Subject: Re: .config file attached for your perusal..build stopped... Linux 5.9-rc1
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 2:25 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> Thanks, Linus ...I have attached the .config file with this mail for your
> perusal.

There's something wrong with your setup - like Randy, I cannot
recreate the problem.

I wonder if you perhaps have some buggy version of ccache installed,
or something like that, which could mess up the build subtly?
Corrupted ccache files can result in some really hard-to-debug stuff,
because what the compiler sees isn't actually what you see when you
look at the source files...

                 Linus
