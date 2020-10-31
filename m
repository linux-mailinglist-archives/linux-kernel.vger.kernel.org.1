Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D554E2A1A95
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgJaUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgJaUoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:44:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC8C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 13:44:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b18so8215447qkc.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muc0kVwivNXzGUfAH7TU9Xb3fqNFKltfoR7TwK0/np4=;
        b=N3h2A4a5sqoc2YkkSvR+llcB0PmusXb1nybQ23YFBNEMv9luRBYcgDQe+Ns9yDYZyE
         h73nk1aF8wU0CBWM329J0HO4POExnRfJEPhts49f6HRIFlbXplR0ujOJL78VdqDTUyRF
         IEikuVcs+YVLybFhxP5avOMANN4Zw2XAoQFpJxwdtWH8HMo1kwRFYlTeXwlXowXGjawU
         +3C781rZqg7IW5GLJgWJRXOi1oVTlPT4rarqWtoNEDoyabGSKV9ZRZd95ywNXVrDJLfH
         KAssFMepmTLh/8+XM9QL4TxTwXUBz/ihkWhbRlhc5RDZ6oNZ5XfEr3zh5lNvqaLU9kSe
         W5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muc0kVwivNXzGUfAH7TU9Xb3fqNFKltfoR7TwK0/np4=;
        b=M62c0aV8WhaI+wLRvRZYUB0Ch+O4pQ6x1CrhnXKUhhVltdVDDv9UIkrmdoZPJ6Rluf
         9HJkYGVcvVhEGmh91Js3k6DPYDdzUKNRlIXrj0P5MnkWSrc+TGyT7LGlOXqZH+ozI9Jj
         gKuqLdHrZmGzJ8m6XmylbUTetWaqrTYv/O3ljfRV2UZD40zlfQ4qn5iwpF1n6r+47qhZ
         eUfDzHRTcdaCqSr6K41RROaJmZ6IICw3vuABCAEG/tnijWYe5UeY5ajOirwgJ8WOf2Xh
         LPcQug3T1NkUUncDazMAM02Aud1ZUKBQO7mJvV8LM5mXDGA+jaj4iQstcCYT7oSA7Vf2
         VkHw==
X-Gm-Message-State: AOAM533TwYP6sXianzpHBRmqPZmzK9SagZOQKbMbUMdqjfFYQCm4m5cv
        usBSf6krCuoOWNraU1NYIAC2Z2AgkGCzS5p4dVs=
X-Google-Smtp-Source: ABdhPJxFstStOYPuZdlbN7GmDhPQ7MzKgC0gumNK13a+9afl0w4AxcL03uU/AW1WK2pRywoYrD3u3MmM9QTcCZtW5nE=
X-Received: by 2002:a37:7183:: with SMTP id m125mr8375331qkc.237.1604177063121;
 Sat, 31 Oct 2020 13:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201031085420.1316-1-kechengsong@huawei.com>
In-Reply-To: <20201031085420.1316-1-kechengsong@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sat, 31 Oct 2020 21:44:12 +0100
Message-ID: <CAFLxGvxB3-ryVLPtS0XhZnu+4w-gSzzw=BV+1mKTGt3mOKbeiw@mail.gmail.com>
Subject: Re: [PATCH v2] ubifs: Fix the printing type of c->big_lpt
To:     Chengsong Ke <kechengsong@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        wangfangpeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 9:56 AM Chengsong Ke <kechengsong@huawei.com> wrote:
>
> Ubifs uses %d to print c->big_lpt, but c->big_lpt is a variable
> of type unsigned int and should be printed with %u.

Well, it is:
unsigned int big_lpt:1;
So, either 0 or 1.

Does changing it to %u silence some static checker or is there some
other problem I don't
see right now? :-)

Thanks,
//richard
