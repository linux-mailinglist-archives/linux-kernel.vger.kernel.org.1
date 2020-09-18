Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB652705A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRTiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:38:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:38:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n25so6018833ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTYP9lzdMuEsLcEEbP3eG/Aqwvw5Aw1MDKs1S/KOj/E=;
        b=MBCZU3OumBM4Z82fuom8BcZty7G0Qz/ve7guNBZ43fQiGkU3tQxZTbLR7fpibI0fN4
         Jzjl9OrRWaGrUL3pYQAoUPU810Wc72CuBIrtDSHOy9AhNIgCvMUyQZNjtQtuSLr8IBAR
         0k6Xs/6k0pswS8TAgjPDJVo/r17WtkHexsKb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTYP9lzdMuEsLcEEbP3eG/Aqwvw5Aw1MDKs1S/KOj/E=;
        b=MPYttiZBXQMcPqU7L7oli6Zs2/REH/3Mp1j6ZCiYrFTiuVS2tkAiQlzbZUNCmjfRas
         RqMbwQDFbHN+qnpaLtDZIBr8FGBuXX6GKfYQHYUdzto7xJzeys+AlRO/5aCuewZjl4Vc
         Ch7URzyjVFZPh57BvVgq8+P23+jcV28Wwlb9QMCvny8CGSKAN9b4kQGJYeudLRTLbBBR
         dqb+X+EQ1PQhUZalVmZ7td63Z4uC6aKI8HfWdJTc1mt15e4RPPtSrPjj1HRyiN6YMC9d
         EynSuwmvcdxMG9Zgb/nSMuN2uFnC0SzVlXjdKkDyCOD2Wo1nAw2Ja50aXfhGxF2+iyk1
         4c4A==
X-Gm-Message-State: AOAM531/WsnhJKYZ6oHdc5Il7EP7UGcFA81F3t0cEshFOsbS7a3ePu40
        QbwPKU17oHY2lRXWNcU0F4KUq/Nf8zNfww==
X-Google-Smtp-Source: ABdhPJzW4HYx34lF9uqLbkelT6zF2mNu1qC5QT99JRcvwZk2Z5FZvjXtBQA5ZJpL/iR0+O7ECDTG8A==
X-Received: by 2002:a2e:9bc2:: with SMTP id w2mr11224362ljj.236.1600457889079;
        Fri, 18 Sep 2020 12:38:09 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d6sm774125lfb.177.2020.09.18.12.38.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 12:38:05 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id n25so6018672ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:38:04 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr9828886ljj.102.1600457884550;
 Fri, 18 Sep 2020 12:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200917204514.GA2880159@google.com> <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor> <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor>
In-Reply-To: <20200918193426.GA15213@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 12:37:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
Message-ID: <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 12:28 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> OK. It seems that we are talking about two different things here. One thing
> is to apply sizeof() to a structure that contains a flexible-array member.
> And the other thing is to apply sizeof() to a flexible array. The former
> is allowed, the latter is wrong and we already get a build error when that
> occurs.

The latter I'm not even interested in, it's such a pointless thing to do.

> Applying sizeof() to a structure containing a flex-array member is allowed,

Yes, and that's wrong and inconsistent, but what else is new about the
C standard. It's what allows these kinds of bugs to slip through.

I sent Luc a couple of examples in the hope that maybe sparse could do
better, but..

> > Is there some gcc option that I didn't find to help find any questionable cases?
>
> If the questionable case is the application of sizeof() to a flex-array
> member or a flex-array member not occuring last in the containing structure,
> then yes, GCC already generates a build error for both cases. And that's
> what we want, see at the bottom...

No.

The questionable thing is to do "sizeof(struct-with-flex-array)".

The point is, it's returning the same thing as if it was just a
zero-sized array, which makes the whole flex array entirely pointless
from a type safety standpoint.

The *only* thing it protects against is the "must be at the end" case,
which is almost entirely pointless and uninteresting.

Yeah, we've had that bug too, but that doesn't make it very interesting.

              Linus
