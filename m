Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480327069D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgIRUQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIRUPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:15:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85FFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:15:16 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y9so7578190ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7wRTSQKv2G8T9rvlgl07npRBcyQo+x1v+qxYjLlUtg=;
        b=a/MoGb74B+N/fY+wzX0p6UfnTR4H8tn9bFK/sJo7+36IcYVIGPxHvIe7oFXqONZ9BG
         FsSO8I51cgdirTidYKn8jrJzUwAavL5wMgP1Pa9+6vKLCAZ4T2dEgoDSOzfVZ9w+dk84
         fOklnwiL3ZSHcU6cPG5zDq/2dAZMUiIPw7TWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7wRTSQKv2G8T9rvlgl07npRBcyQo+x1v+qxYjLlUtg=;
        b=ohJmYxjaz85jIw7Izmdlce0m/q2VuAJ/+5c0TzkRnFImkpPpXFAXgUkpBQgZcGYfEB
         xWLlQUGOC6gdqjPpOuidflARgr8GGLGh6rPDmuPZk7qFXew8Y5vLSlAm7uttscaVvmig
         dlsINJ8jXW1abyjyuUCaK9BuvSuJrX/5YJNLMah56hB/SJNY0MFv4sxoirx+YcCQH2z+
         TmTRRYpoVNSsxCfBYqJ3jIh59mFWxusFKTgJKkW4DXakd6Vqq/T4f16gBjcEhwWUmSz0
         c5mW7zrKsnX2tBhoDHgrWrWvFtGVPR10k2secR3PMfLKCsQoSAvim2Xm0H1zys/X0oeN
         8GNQ==
X-Gm-Message-State: AOAM531yJBMMMZE1ZLr2lZAJq2tilISIX4/PKwOAst3wH2gefUJLBFPi
        uj7E58pothd2iamaFmkg2nmBTEkv0uKVoA==
X-Google-Smtp-Source: ABdhPJwDkUc4o5/D88CNUIA2VKfIFD1tLJNRqdE2P+RDwBAQMjEqYnpe7eXqh96sbYYq4VoAyTlQ4A==
X-Received: by 2002:a92:194b:: with SMTP id e11mr30369227ilm.43.1600460115954;
        Fri, 18 Sep 2020 13:15:15 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id c7sm2055812ilo.61.2020.09.18.13.15.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 13:15:15 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id t18so7550030ilp.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:15:15 -0700 (PDT)
X-Received: by 2002:a92:2e0b:: with SMTP id v11mr32233591ile.112.1600460114870;
 Fri, 18 Sep 2020 13:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200917204514.GA2880159@google.com> <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
 <20200918162305.GB25599@embeddedor> <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor> <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org>
In-Reply-To: <20200918200252.GH32101@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 13:14:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
Message-ID: <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 1:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I suppose it's not really necessary, we could do offsetof here, right?

Yup, that would make a lot more sense.

But right now, the sizeof() obviously silently works.

As do a number of other fairly nonsensical things, like assigning a struct etc.

And yes, I realize we may well do that too. But I think that's a
dangerous pattern too, ie doing

   *a = *b;

silently works, and copies everything but the final array.

And yes - none of this is _worse_ than using zero-sized arrays, but
the point is that it isn't better either.

            Linus
