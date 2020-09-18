Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07D627032D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRRYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRRYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:24:20 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D411C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:24:20 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b22so6901147lfs.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6vHhMkaPtX++PGx5jiUYCnfKpKOltu478EtiJp8yLA=;
        b=ZU2+5L8SZkXq9a5GNzvsy1XCOuVkPArF8Zqy936bPpKXMZldfada0mBjSt7MQx+6lc
         hYyTkDFpSYfmoKq4BrQNoWe8ScDPcMbZZLLS8RgckiPRICdnSxnbOytIyrECsy8fwWFD
         7uim5Lw1FtAv+RIDbrGb0N9ZMJMlQ+VCnOjAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6vHhMkaPtX++PGx5jiUYCnfKpKOltu478EtiJp8yLA=;
        b=COAbSHJ/66ExopOAzyVEZLaFoNXqMowVcBhgwwkKTO9VcQsROLeDJsiB9JYCJY4GNC
         EcIjD+trf0lPh84ve1hmgF/rMBjL8pppnNhDwIlTKAFjLCykuswdtUAhFOhpxzexKqPY
         FcX5ILkBm3yXH+mlGte88mMlOYwxwTzJwhxvSN/ZWUwaE/YqkFvFjh0TA0AjK+IKEZ6I
         rxDJGxu1JPwiSN5fhCQ+cD7vfM/IQbEa3KmFihnNqEQt/9CUT5TtKHBlWuxzQxi+ev6g
         lxQsvAIkQJ35qlhnLAHfaq62eU8v3xWUTNjmT9373gF2OcmO8mtIdlYo/JKtvTvEb41W
         zh/g==
X-Gm-Message-State: AOAM532FtdbbG+6PpJUpcwQfzzgIIu44oWsxdaF2k+32X4XpetD3v/BF
        c3aNqnMYahsBq1N+FTQFOr9F+e7QIAihDg==
X-Google-Smtp-Source: ABdhPJwjzzvqCZHm0yxLjiAN8UBms3fXdYvNvcirrqIteNwa32dCnm8on11rV4MoxVeBFf0bniX48w==
X-Received: by 2002:a05:6512:2030:: with SMTP id s16mr10580433lfs.277.1600449857958;
        Fri, 18 Sep 2020 10:24:17 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id l4sm707479lfg.296.2020.09.18.10.24.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 10:24:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id s205so5706805lja.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 10:24:10 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr11309516ljp.314.1600449850596;
 Fri, 18 Sep 2020 10:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200917204514.GA2880159@google.com> <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor>
In-Reply-To: <20200918162305.GB25599@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 10:23:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
Message-ID: <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 9:17 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> This bug could have been prevented by either adopting better
> coding practices or through the use[3] of the recent struct_size() helper.

Well, my unspoken point was that coding practices are just
theoretical. Coding practices don't help - actual *checking* of them
helps.

I realize that structures with flexible-array member are allowed to
use sizeof() in standard C, but if we want to make sure this doesn't
happen, we would need to have a stricter model than that. But a quick
google didn't find any flag to enable such a stricter mode.

I guess a sparse warning would work, but sparse already has too many
warnings and as a result most people don't care - even if they were to
run sparse in the first place.

Is there some gcc option that I didn't find to help find any questionable cases?

Because if we have a coding practice that you should use
'struct_size()', then we should also have a way to _verify_ that.

The whole - and really ONLY - point of using flexible arrays was that
it would protect against these things. And as things are now, it
simply doesn't. It's not an actual improvement over just using a
zero-sized array.

(Slightly related: copying a struct has the exact same issue. A
flexible array is no better than a zero-sized array, and generates the
same code and the same lack of any warnings, afaik).

               Linus
