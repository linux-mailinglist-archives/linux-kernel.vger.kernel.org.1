Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33962D4E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbgLIXGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbgLIXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:05:55 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9F7C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 15:05:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a8so5471356lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 15:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjapXZlRvPol1Fdb25tCQ4If3pC/GgbOJVNQ8ykfK8s=;
        b=c31BOie+2yAAa3YQCJKD2zHSpEUhTjjA6XI/jJSDGzjBF7X2zPj5qzC1zOPnGkwafo
         tEdisdWwFm/qbi8tVbAVDxTwFZzPKBjYdf+43YDcdu8/0gyyVAveYsvdNgKa8jNbtBmf
         4OC/LT4BZ/+eY6hdk6qMmLxTb1UfGifzPIkRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjapXZlRvPol1Fdb25tCQ4If3pC/GgbOJVNQ8ykfK8s=;
        b=joQe0FWOjJRo5WD6QnWECQyFmW9jbDqZ5ehTgydS4NKWgVShQOPoZz1pWe44dD0XiU
         C9fF/6tL/1yu00c0TljSIzb/nTzVBu7pY5lp7kGa/1tjXsOexCvQ9wyXiLrmdjlqcZpP
         zCyAhe9gme/Dt4YCXhG0aXn4XqM+6XsB6a75CZeEwzRQ88XXHhy8JdEFp9TAF2IzPICv
         DFmVsud8gQ1Sx3pbTZih8ktssZ7Kw4d5/kuoEARgRWMQiLobyNOfSovw4VcLVMxAJqmi
         B7t+YQqh97hr66eyqHbKIkSmBHTsl4ToxPvhq0hs3Y+yeTM5N35Z16GZBVroVHqFn9uT
         PXJg==
X-Gm-Message-State: AOAM531KMuJLeqfeYz6wyiWDC3LMbC+1/d/Luw1DWToQAnf68hXOPMQF
        fzcUL6CU+E+1NJaO81qHE9kFXKGJSyUEbg==
X-Google-Smtp-Source: ABdhPJxPavkZG7YeRFutDp8c9zcXP4O5dtlp2pUYle5F/EzNjZs+3PCX4jSAC83TZNuOL+a5jOXwKw==
X-Received: by 2002:a19:4196:: with SMTP id o144mr1859465lfa.342.1607555112830;
        Wed, 09 Dec 2020 15:05:12 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r9sm388576ljj.127.2020.12.09.15.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 15:05:11 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id y19so5408747lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 15:05:11 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr1594049lfg.40.1607555111139;
 Wed, 09 Dec 2020 15:05:11 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-15-ebiederm@xmission.com>
 <20201207232900.GD4115853@ZenIV.linux.org.uk> <877dprvs8e.fsf@x220.int.ebiederm.org>
 <20201209040731.GK3579531@ZenIV.linux.org.uk> <877dprtxly.fsf@x220.int.ebiederm.org>
 <20201209142359.GN3579531@ZenIV.linux.org.uk> <87o8j2svnt.fsf_-_@x220.int.ebiederm.org>
 <20201209194938.GS7338@casper.infradead.org> <20201209225828.GR3579531@ZenIV.linux.org.uk>
 <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
In-Reply-To: <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 15:04:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGEE9vB2Pw6g=+YqnXMz6z5paK3sxNOtN5CB68VQw=Ng@mail.gmail.com>
Message-ID: <CAHk-=whGEE9vB2Pw6g=+YqnXMz6z5paK3sxNOtN5CB68VQw=Ng@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 3:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> rcu_assign_pointer() itself already does the optimization for the case
> of a constant NULL pointer assignment.
>
> So there's no need to manually change things to RCU_INIT_POINTER().

Side note: what should be done instead is to delete the stale comment.
It should have been removed back when the optimization was done in
2016 - see commit 3a37f7275cda ("rcu: No ordering for
rcu_assign_pointer() of NULL")

            Linus
