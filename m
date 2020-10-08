Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD75287C26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgJHTNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgJHTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:13:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5705C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 12:13:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g4so6996341edk.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD5qdM4y5+/ccgMrP1k9E25iq0CoiOLNN0HNPRrcG58=;
        b=DpUGB6BQRDH9BaQ/nG5mUoHH829Ux6FtNtcd+nkC8CiUE8c1mEQs7AWde9cccHglT8
         RobwOlxnUx2OXfk4Z26M+CPplbYejMpNczwVzuDRuWRTOvuTeRG+bTkj3lpMYo+BeRrw
         8tgWi5vDC19TLxM+3cUv6svbvUwW08/5agjfPL3zbg/kH0rE6X+fqw9MwSeSd+lKAJN4
         jEzbY08O6moENOKeth0R6XeLpyk1+eeZmDUQiS+O0uvGVujEQZtfdnoGwJ1KTs8VXvhh
         TPZQhFVbTJYG2cEW2sjfOlq5NxTV+aftWRS2CdgEq3G6xCCZ3tcdRFCPPY1BU73uRI3p
         qxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD5qdM4y5+/ccgMrP1k9E25iq0CoiOLNN0HNPRrcG58=;
        b=ZY0/3nsbFma2uqYpMPS4d+0/ookL+IZelcqkNzDMmvj4Itgn6UGqulXOwpvwdiNwvw
         0UU4Ob4yMmG5dyLzSZei/RDv/CIXdo1PuhopWOunhJq+xD0GWLwjS/jyOO/pqCbGYhFq
         PlShN9ClolCbO31DZjWW+SsUP2OtBI4togBtMo/n56lZJcYrsN5/Af4yQoRQpmJVbl45
         OGj06Z2nTtFfQQdt3Sq1DxSlUnIYbO7pVHs5IvVFoRut6RohX5jdqmyvv32jaxXxSamo
         Sb4qE32KmDLjofnXLaGSaREJdejVlbMyyVBNyEXegbVf4j52z/jTgGp9cg55hbUVKHIt
         L5Iw==
X-Gm-Message-State: AOAM532hiF6gjvSowrjYycaZfFehi2vIxtJnCnpIzOVptZLOfotjTTeO
        DqOfJO2Re2egz8L1YkmZHBMKpmdlRGC4AnIE3eFBzQ==
X-Google-Smtp-Source: ABdhPJxVKRIAyl2fZrCxv9N7Eg/tbxJSi5Z2oIn7bsd9l66WVVHOpypjPgqQjftYXt+nzoF3S1j8JESEXwKTQ2nv25U=
X-Received: by 2002:a05:6402:74f:: with SMTP id p15mr1470411edy.69.1602184422053;
 Thu, 08 Oct 2020 12:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <f7ac4874-9c6c-4f41-653b-b5a664bfc843@canonical.com>
In-Reply-To: <f7ac4874-9c6c-4f41-653b-b5a664bfc843@canonical.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 21:13:15 +0200
Message-ID: <CAG48ez1i9pTYihJAd8sXC5BdP+5fLO-mcqDU1TdA2C3bKTXYCw@mail.gmail.com>
Subject: Re: io_uring: process task work in io_uring_register()
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 8:24 PM Colin Ian King <colin.king@canonical.com> wrote:
> Static analysis with Coverity has detected a "dead-code" issue with the
> following commit:
>
> commit af9c1a44f8dee7a958e07977f24ba40e3c770987
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Sep 24 13:32:18 2020 -0600
>
>     io_uring: process task work in io_uring_register()
>
> The analysis is as follows:
>
> 9513                do {
> 9514                        ret =
> wait_for_completion_interruptible(&ctx->ref_comp);
>
> cond_const: Condition ret, taking false branch. Now the value of ret is
> equal to 0.

Does this mean Coverity is claiming that
wait_for_completion_interruptible() can't return non-zero values? If
so, can you figure out why Coverity thinks that? If that was true,
it'd sound like a core kernel bug, rather than a uring issue...
