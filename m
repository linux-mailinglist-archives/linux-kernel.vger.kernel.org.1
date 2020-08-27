Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186E6254C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgH0SGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 14:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgH0SGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:06:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BFCC061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:06:48 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y2so7480392ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U2YQUo5PvChApZK/cKK/V+bD5P2TFvYUwUUfL3IKr8=;
        b=V+YFpBqcArUu/7w7NBd4zYiujYYZd0XbXg3pMzUSnwQHkdzIY7nP3mP+VimDcTthyi
         LlD3xPgdurxv9ctSZwPOT/zU/BV4vftgYTphIZCwjwJtNjyaIwWnhXCoLDg9QLVljgtJ
         MDCUHybVVKKZURhQ+X8r3p5PJ1lUGBFZYBCuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U2YQUo5PvChApZK/cKK/V+bD5P2TFvYUwUUfL3IKr8=;
        b=UN9KKoBWeDyftw8YlkC9ZKRYMKgL1qManXYXtyR8qC74az3+3fZVCGUU4jdWjE78tQ
         uAybULSQw/chCOq0w8W/l9sa71/ynHP0PIDofEJNmfj0Jtpi2SKXv7tGCFBycqmmRHBJ
         DHqjSUbLl04c0oWNVNwbW2h37f4aeuCiaYZ4Rw+l2ml1SLbbNhZd07f51W/ITxu7l+G+
         oYqN6g34VyalK6WYmPyop+GPZZ8pgPWw5f64YRAS0G7623HjdsfTizpd5s+5jFxnDNkj
         BhLsgPsB5mYH27byj0xIESi21rgTS9d8emvJEHhdK9XqjE0AxSlge5Kz1iodU8MOS5GS
         QPtQ==
X-Gm-Message-State: AOAM5303DazYQLezA+vgKVWk9rD44hHlUdjH2P/CIdEXf32LnO6nxGMU
        34DwGFxKUGvVuNf4WLwpLxRe0S2pGXBNvw==
X-Google-Smtp-Source: ABdhPJy7BH8smnX7HHP0bGd00CLwldRGzdSVLI1007ni2BM+HiK/ikwR0PQBP6E1bwMmwoHIX3Y7BA==
X-Received: by 2002:a2e:5018:: with SMTP id e24mr10909857ljb.261.1598551606397;
        Thu, 27 Aug 2020 11:06:46 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j17sm686934lfr.32.2020.08.27.11.06.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:06:45 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d2so3416082lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:06:45 -0700 (PDT)
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr3180051lfb.192.1598551604725;
 Thu, 27 Aug 2020 11:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-6-hch@lst.de>
In-Reply-To: <20200827150030.282762-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 11:06:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
Message-ID: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for !CONFIG_SET_FS
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Once we can't manipulate the address limit, we also can't test what
> happens when the manipulation is abused.

Just remove these tests entirely.

Once set_fs() doesn't exist on x86, the tests no longer make any sense
what-so-ever, because test coverage will be basically zero.

So don't make the code uglier just to maintain a fiction that
something is tested when it isn't really.

                 Linus
