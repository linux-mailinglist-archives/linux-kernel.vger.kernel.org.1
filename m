Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D628C37A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgJLU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgJLU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:57:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120DC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:57:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a4so18154030lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/LYGoq/lI9Tl5DfVL0GaLjNlPCyY1inweanl2fDTj4=;
        b=Eg58Ys4XN74Of+HzKNeNW/lH0XGJIweA0H3s7P+aFgGKjUneT5p64hwW8or/OsBnVh
         zjo9hC4Wy7dzUaHBvQnGchB+LNOi0g3wyZU9ijWv8mSaVUqKtOqGZioseXNVD+KvC7Tr
         t3qWYqSy2ua9R+gMCl+/gsCz1E/k/LnD5aEiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/LYGoq/lI9Tl5DfVL0GaLjNlPCyY1inweanl2fDTj4=;
        b=CyDiHBPTZyRaGZNRjHUitfjSZiIuQdxIGIDahcnYYL7nvFjB8eE/czh+29GzGEMq7A
         BqOYepjGVvtLmECqlido6ONmk49Z1IQXBLAiUvwp9sN1Ib8wpB+hZfCSQrWvVD4M1Bla
         YdxCiTWmYw7fzmhkU33X5fnnou9CzxqM+oZ9qRSp/zOi3r0U6pcX7KC/uXA66rjU7zky
         PYOKW8PKTuswRLKcv2xh/QeePyU+79455alBzs4WgsdRMl+j7W1zeZoxRxaFhU0C2UWv
         uc1gPiv2TPFZG25sFDtrof1262GI1PLICDQAtQaA5vee+NgqvGHV4iibQdRX3d3E0M7L
         YqAA==
X-Gm-Message-State: AOAM5301zgaH1An5sX8rbc0bpiEK1lk3tLp9IQ6BCnXv1kvfudYCo8Fn
        ryuPr1opEzHDWCwiTBtiEJluVba4qt32fA==
X-Google-Smtp-Source: ABdhPJw5sBmr7s4X828BtIIDheFsHzcleoOsBbRo5xqwao6ei4J610ZRJ+y7h6E7Sjv+tvgMNbH4ow==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr2418822ljc.187.1602536238066;
        Mon, 12 Oct 2020 13:57:18 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w10sm4321327ljo.130.2020.10.12.13.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 13:57:17 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a5so18164075ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:57:17 -0700 (PDT)
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr10529209ljj.371.1602536236682;
 Mon, 12 Oct 2020 13:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201012110557.GK25311@zn.tnic> <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
 <CAHk-=whbEhjSHR7D=8Q_xARd=UKHGcz750LoT1BeRdgTR+6uSw@mail.gmail.com>
 <CAHk-=wgBHgmAoLG9A0b-2_2ZiL_OaXLyO2pbKOHm=u93NttSBQ@mail.gmail.com>
 <CAFULd4bHpJQau5kw8J93B2Xu1J_tYhShG6eWP88vRvhwxRZmdQ@mail.gmail.com>
 <CAHk-=wg2hkPc049k01fxZ0p0K3QSABi0O0uN-NHoqLa0yz-DJw@mail.gmail.com> <CAFULd4YQ5dNPU5mFuT9GHNH8-UVdcHLz7NYnvPi=kmhaUk1mcw@mail.gmail.com>
In-Reply-To: <CAFULd4YQ5dNPU5mFuT9GHNH8-UVdcHLz7NYnvPi=kmhaUk1mcw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 13:57:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnq+JmKsRwCbUnpZm4ZJLgaiX-KSFMkp7OeeE-RXwRGg@mail.gmail.com>
Message-ID: <CAHk-=whnq+JmKsRwCbUnpZm4ZJLgaiX-KSFMkp7OeeE-RXwRGg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 1:22 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> No, this fact is not documented, although there are close to zero
> chances it will ever change. High registers are independent from their
> 8bit lowparts, but they still clobber corresponding 16bit, 32bit and
> 64bit representations. I guess this limitation is so severe that the
> compiler writers will be more than happy to document that %ah and %al
> can't be independent.

Ok, if we can get that agreed upon (and the clang people too), then I
have no concerns about the patch.

Just so that we don't have any nasty surprises in the future where
some clever compiler change ends up breaking this (very rare)
exception case.

                Linus
