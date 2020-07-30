Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EDF233BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgG3XSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 19:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbgG3XSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:18:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0E3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:18:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m15so15206898lfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcsWvrkJmkldNkR7Og1fU1p0Fe8lfIhMHe3883Sw5AQ=;
        b=Nm909XrN/coCOGd8NKEDwC2r1wN5HlmeeTd4TLu/lY7lxYEtvV8l3/MWkw25JWkeuz
         vwzFtNUPds+t9fEMHzEjWnOEgSL5KC4oxjOVwt2XDRCd6jcpauyB0qIQBwHI7GUnOnjP
         XPJEVJpi3F1oie4huDR1BAOZdqzlmzioLtKDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcsWvrkJmkldNkR7Og1fU1p0Fe8lfIhMHe3883Sw5AQ=;
        b=CTBU3yoT4mZ0QB0sPqR+k+5By0mWB/CiHLm4u8GwQL4sYcMQ9VUs8HDfgBvA6cKLdN
         2MTDwIAg/Mno9fCL34zlnPl82xCSpUnx+R2Uiubwo3zA/RUxTNu2po2/Eah6CI9XR88G
         WEd5a9bWMC4gfYJ0Gw8rMLBAQvJ9LBfzQNSyu1V4aumwL0MsAXjph24KkFmCu9tCWmao
         m75jxNCKEDFUKRnPwvPurpE3V4n2GkaNGVVzushiCjMGDvRi8q21qC+xOGJv2eLCuQFL
         HQzpbrzytLjb4nLtZzMOcM5JHsPJDlfBqvTnjG34qD6Retn4H5oEfCX9Jl0gJFkU0sxX
         6j1A==
X-Gm-Message-State: AOAM531C07VgcyCOYnlO/cubgJr6SSYsBSKRgmyUAmi2JquuixqYLDHb
        SUZvHxwrlvfuk7zs0AHJeBT1pG/+nRw=
X-Google-Smtp-Source: ABdhPJx4zhjuIoJCxLSXyyuPuP4OurrUH86t0XyCGDZ90PfEC0QWyVwQ4sy/NaKmhig02JZSL2xsww==
X-Received: by 2002:a05:6512:3af:: with SMTP id v15mr447697lfp.79.1596151088645;
        Thu, 30 Jul 2020 16:18:08 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id l22sm1561296lje.81.2020.07.30.16.18.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 16:18:07 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id j22so9980168lfm.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:18:07 -0700 (PDT)
X-Received: by 2002:a19:c206:: with SMTP id l6mr459435lfc.152.1596151086728;
 Thu, 30 Jul 2020 16:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <87h7tsllgw.fsf@x220.int.ebiederm.org> <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
 <87d04fhkyz.fsf@x220.int.ebiederm.org> <87h7trg4ie.fsf@x220.int.ebiederm.org>
 <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
 <878sf16t34.fsf@x220.int.ebiederm.org> <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jul 2020 16:17:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
Message-ID: <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 4:00 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The key is the function make_task_wakekill which could probably
> benefit from a little more review and refinement but appears to
> be basically correct.

You really need to explain a lot more why you think this is all a good idea.

For example, what if one of those other threads is waiting in line for
a critical lock, and the wait-queue you basically disabled was the
exclusive wait after lock handoff?

That means that the lock will now effectively be held by that thread.
No, it wasn't woken up, but it had the lock handed to it, and it's now
entirely unresponsive until it is killed.

How is that different from the deadlocks you're actually trying to fix?

These are the kinds of problems that the freezer() code had too, with
freezing things that held locks etc.

This approach does seem better than the freezer thing, and if I read
it right it will gather things in the signal handler code, but it's
not obvious that gathering them in random places where they sleep for
random reasons is safe or a good idea.

I can imagine _so_ many dead systems if you just basically froze
something that holds the mmap lock and is sleeping on a page fault,
for example.

Maybe I'm missing something, but I really think your "let's freeze
things" is seriously misguided. You're concentrating on some small
problem and trying to solve that, and not seeign the HUGE HONKING
problems that your approach is fundamentally introducing.

              Linus
