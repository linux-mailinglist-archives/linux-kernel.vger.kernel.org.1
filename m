Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B228C178
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbgJLT27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387797AbgJLT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:28:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA9C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:28:57 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d24so14996553ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PBBv8x0EA+jyMbeGbj2AD5+EOk9EuJpVDyEvfsZ1FnQ=;
        b=Sg/dv0+6q/T5D5BigWu87HiS3Oyz1Gx2mRS8WRM0qJR+ZvzBax9hT9Li7FBVJE0ydo
         qxNsvOzo9+2aL74hch0pe/IBE/A3RgBB2mlynpMG99k3j8N5fOXAJq6TsU1kqDdSiWNJ
         88IXcUyrzO2MAL00aCNG8np3MdgE/b4+Tqkog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PBBv8x0EA+jyMbeGbj2AD5+EOk9EuJpVDyEvfsZ1FnQ=;
        b=nerQjHbvekbgiAoQQOVasZJJ3+xoDgHk894UlrrP3TCqdkkBpROmP2e7Bd86Xcj9QA
         TOdncX3QInWIlkBfT9I0/eyvZs7udosob8n2Zu3vZSpjDKyyExNtWN6QOtQ/8RQf2SxY
         LBCsxAPyC1k9+mnS1huCCfwDzs0bM4QCpmBhaNOSplYSU3a6D4bZesH8qZGrxVTQyolm
         ENpxXN8iNpgtODt14MXby18+AoqYF0Q76ack87VeazeplHWl/tEVwXLssvvZlMtxgwhd
         8OXDUzwe5pNjGyzICTyasIfbQZIQ3XarL3KsGZEmt8akIGyeBCOwoIgV7+cooSYxO0Gl
         sr3Q==
X-Gm-Message-State: AOAM531StslY9ilWliR1IiKYdLdQbszSrev5VoQ0ua5de91VFzDXEElh
        /9awhjiLqTBs/mINkFoUUdyhJa9s823bRQ==
X-Google-Smtp-Source: ABdhPJwyMgGR7hH4y7YVAwb1QSun+/MB1c7fH/BKysLUhqFCJ9yVyKxyaivhlVBbptyN6Lje87COWA==
X-Received: by 2002:a2e:990a:: with SMTP id v10mr11454661lji.278.1602530935536;
        Mon, 12 Oct 2020 12:28:55 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s17sm3443506lfp.117.2020.10.12.12.28.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a4so17950183lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr10194176ljg.421.1602530934167;
 Mon, 12 Oct 2020 12:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
In-Reply-To: <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 12:28:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
Message-ID: <CAHk-=wgfydyikU_KfHSLo1uMSs-vksDjYkdnyv1+89C32XwUOA@mail.gmail.com>
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Alexander Viro <aviro@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the old pipe behavior was that it would wake up writers whether
> they needed it or not [..]

That "writers" should be "readers", of course.

Although yes, that commit changed it for both readers and writers: if
the pipe was readable from before, then a writer adding new data to it
doesn't make it "more readable". Similarly, if a pipe was writable
before, and a reader made even more room in it, the pipe didn't get
"more writable".

So that commit removes the pointless extra wakeup calls that don't
actually make any sense (and that gave incorrect edges to the some
EPOLL case that saw an edge that didn't actually exist).

              Linus
