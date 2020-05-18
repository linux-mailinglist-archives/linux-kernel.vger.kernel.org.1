Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7B1D8B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 00:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgERWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgERWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:55:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6DC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:55:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f13so1088530wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 15:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CbrRoXG+bW2TyulWncy8iTxwjC+YKFA1v7y3l78jKH4=;
        b=xEFLjRTPUSjctOEm0r+4bFklqfQG0ZHiIOdLVfbUyvWMinyZ18EIpM9hBV7EPB6+7I
         3kJESCqxx/37NLhYW11GJbI6vngFWnzVe3/2mN8le+21aarLphA0UDZaTi9oGPklLrWa
         OZSMFSRyJenzxnzVAzcmHYJKfoaymHRUSU08bEVofRCapx8hLvsKqS0PWr0kGKPZT9fj
         Fjy08XYYXs2pzSWZ/9AzoZH0Cbz9PGHKTRvJCAguHNOvZZ8sA/ZMaG2oWw2fBwpSwwor
         AVzHYh2B16/j1enIZpn8Fa8fXJyB7XLzx5z83PdM2EeIf/yTMOn2LV/IU4aBm20c0xTd
         pYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbrRoXG+bW2TyulWncy8iTxwjC+YKFA1v7y3l78jKH4=;
        b=nnM1HEC/lwLRjHqBFrtxYK0r0f8pmqpTY6yfYakTICDym/OFBoiEXjAsIm7NRAiBZZ
         Z8SK02bXe0eaqbf4U17Y1K4XKRgQPilux5y1ujeG+6+8lPS8gE+YX8FlpdiCaj44w/rV
         3RJlvsmAxnTprdYYG0CLFDZII3BQ9PTmq3CoHOKUpojm/C2LLwJi/CYDuSpjKyloPMMD
         cq1WSOQoUc576NNMbSxl7LE1+Gh8QG78DONyz8KZdZXPHLGxpop9g6+88x4Xxed4mubg
         lJ0sA64SZopRbVlje38JqQvo3fDc46AxaLbHXqZ8X+hpPeg2+akhKur3eQpzbSYi+oa9
         yUfA==
X-Gm-Message-State: AOAM532Hw9xiFh605E1BggnyFGr5m//8DPMsKvmwQ8stj9HxAX7li3Z/
        W56loJSoqt5ffWy22oFXHU1/jSA40HpSyBgf6vfTFQ==
X-Google-Smtp-Source: ABdhPJzzZW5NTOwzcd4s6iBlTCAtQm4jPksXvll7EYQRwpd36sd8KR/52N/NSgSAceSB1YnXgptzUg8u7ES88BON9U8=
X-Received: by 2002:a1c:b3c1:: with SMTP id c184mr1726075wmf.36.1589842518091;
 Mon, 18 May 2020 15:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <202005181120.971232B7B@keescook>
In-Reply-To: <202005181120.971232B7B@keescook>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 18 May 2020 15:55:06 -0700
Message-ID: <CALCETrXv82qFRRXvH0ELQScRkKFzp+ND_8pahD+YJ=0OWY8YWg@mail.gmail.com>
Subject: Re: seccomp feature development
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 2:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hi!
>

This is minor, but, if we grow seccomp_data, I would like to add the
other 32 bits of the syscall nr to it.  Syscall numbers are unsigned
long, but they get munged into u32 for seccomp_data.

Sure, no one uses those high bits yet, but if we're extending things
anyway, let's support them.
