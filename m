Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253422F21AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbhAKVUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbhAKVUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:20:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDEC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:19:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lj6so312093pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n97oZNXIEipHpRZCUvWuyIU1bjCU11iLeg9wFjnwI/U=;
        b=bdIIFp6LYe4j4mymR82w+8TxiLK9PqLThqlRxlGzzrFLYp+xZ4Rsq4BCBASlq6x7uo
         DdDLlWaRnx88/UwnnQ7HyEatlfF0+jnhCppOyhhrZkrI+y0WThEE8B31v5+K9Dgt0vXv
         /tbTGdl3xVFN8RnbwknuMxY7IQC3f36ca9zifnBaOk08EVrajWHkUSs9oorOGNLGGnzZ
         gB0iW+CpWkRWSI6L8P//tbk6N0KUomGy5hpr2PucqutFAX0I7VTHmcronVbvmyaFjJbn
         QkebwHEoAYdpJP9De1OV859mAPwnvCbZ9NJRjtpTtYvWYq1Fs/k1yrctbVnI9VFSpcEr
         K/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n97oZNXIEipHpRZCUvWuyIU1bjCU11iLeg9wFjnwI/U=;
        b=StFFVNuvKYIba270GwkPQ6LcAmyly/udnj86Fl54g2cVAma7a22XSJXjnq8aUetb7R
         6nBkhxKI7LuNOcNVZMwOIaV1imtnFXcT0LDUe0yUs966Sn51ePxjmzV5PxeJlKc848UQ
         o07m6FFtwbZkxIuVg03hRpfLhdP2NHrYDnY4ZbLkf4yTuzu2jyToOiAU67raHaRiXWBf
         HIAEGO6TL4v9Dj1TvooaiYhZijz5PDR3yE1+70dIYG3LkDDl2yAMYBXhEFuxp8gMRA8G
         /LK0/0zmrg8ssYrPhpobtHv9v31tsToqgY2EtzdetcuOoSd+We68hCF1odXkfQ6d/bxn
         ISlw==
X-Gm-Message-State: AOAM53198uqaSKm8CWOTl06jsl2EkVQUHdp/bHAaC0i7Vxtl214oJ4hH
        byXP3T2dKlEYcjhIG+8giLT+r3rl6j7Lgclhi57aPA==
X-Google-Smtp-Source: ABdhPJy2zuBFI2WxQFh+zswk7vvE1Ll9jQA8Ir6fK3ClgvLdL6voF0yNaP0jwxohL/w7CmFOXaK4xdaZlB928E/RPxU=
X-Received: by 2002:a17:902:f686:b029:de:18c7:41f8 with SMTP id
 l6-20020a170902f686b02900de18c741f8mr255538plg.65.1610399995802; Mon, 11 Jan
 2021 13:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20210107234803.1096592-1-dlatypov@google.com> <20210107234803.1096592-2-dlatypov@google.com>
In-Reply-To: <20210107234803.1096592-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 11 Jan 2021 13:19:44 -0800
Message-ID: <CAFd5g46HKkj3heY+jOYDZH9uaNwcDE6UsQwcC0gULBJD22Bv7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: tool: fix minor typing issue with None status
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The code to handle aggregating statuses didn't check that the status
> actually got set to some non-None value.
> Default the value to SUCCESS instead of adding a bunch of `is None`
> checks.
>
> This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
> fail test suites if one of them is empty").
>
> Also slightly simplify the code and add type annotations.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
