Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F528C440
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgJLVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgJLVqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:46:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DD4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:46:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so19853573lfj.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcj0FDQEdTyI9jLGbrsM++CDc4aPSACJ/ntrnYfOykU=;
        b=E8beS6Vul0tNp9f6I3CYvbBngOfB/LbOo0hsQystbwHbkaK7vAg5a6ntf8euvt1GhG
         xqLG1Qp8S+i29TM98JEsWajE6jpS751UC7jzJ5lVCuo+T+JFNChpcqQCLyEqxFwF/q+i
         1RDd0k8PwgncGNOalDPmrDaVryOuwESOnHG1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcj0FDQEdTyI9jLGbrsM++CDc4aPSACJ/ntrnYfOykU=;
        b=TGonG+hb+clWGySjvoDGjajq2GYjLxmGztBaoA1eqDyDovXiPIl9gLkYYUZH7gTx1l
         usR7N3hAvZZWnW5xk7/E8Wk5XDUx4o6KxarNy8BJFYxAJMpfGbwSBwJ2c3J44Gin/Jwu
         Rr+qOOJPLIj9tjBH6Ty04nLeaNlRGmQ5nJTJCK+C3lLWBmnePo3X+B/3OJqTzzdnEC9s
         JehpKo3+H58xkgZStZDN8LKgJcDWjZKjbtH2MYtIunzCq/LscyiLkbjJ5CL7ZXlDda0M
         h+Ijm8TahURgWgK2qyQ2JjD4hV9l4tn0K4CYuvXP+aiUGSfWeJdZk5hMh0ADfScQM8pG
         fZNg==
X-Gm-Message-State: AOAM53207ZNC60AUhcPsPk6OXXbE+w00Bapk9NPaVFCoAHnGejcmCOYa
        uNBkVu8AStlnVMTEAU7OKi2AptKXUDH0+w==
X-Google-Smtp-Source: ABdhPJzD0ZF43GdsvlbRTkqbBxzMoGsf602FOygXbGKH29ENlegs5oWOAI1RuFUDTVzm4NO2vsg8cQ==
X-Received: by 2002:ac2:446b:: with SMTP id y11mr5713864lfl.403.1602539187717;
        Mon, 12 Oct 2020 14:46:27 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b14sm1472352lfo.39.2020.10.12.14.46.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 14:46:27 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a4so18261135lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 14:46:26 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr10484981ljg.314.1602539186509;
 Mon, 12 Oct 2020 14:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201012101012.GD25311@zn.tnic> <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com> <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
In-Reply-To: <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Oct 2020 14:46:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6MBLPzRrRYGQ6EeoUGV+-MdMraFiUiiQyenVk=t6=Bw@mail.gmail.com>
Message-ID: <CAHk-=wg6MBLPzRrRYGQ6EeoUGV+-MdMraFiUiiQyenVk=t6=Bw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/platform updates for v5.10
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 2:42 PM Mike Travis <mike.travis@hpe.com> wrote:
>
> It should have been an unsigned long instead of an int as Linus
> suggested.  I'm not sure it's a write only variable as I think the mask
> is used to check if the interrupt occurred (I'll have to look closer).

At least "git grep" only shows two assignments to it.

Of course, that would miss any cases that play games with preprocessor
token pasting etc, so it's not entirely meaningful, but it's certainly
a hint..

And yes, I expect that the fix is to just make it "unsigned long", but
if it truly isn't actually used, maybe removal is better.

             Linus
