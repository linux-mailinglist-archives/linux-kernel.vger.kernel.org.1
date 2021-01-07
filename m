Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21C2ED6ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbhAGSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAGSsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:48:07 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B69C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 10:47:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b26so16968408lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 10:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJosGuTGjFGiQOArz8WB33oJPYbeWxHUsYQ3liwnqn0=;
        b=EVJWocHSDFmZUGh6LKXdgpAtCFaP835B85CWlzzAjce0Z5+PdQ/PA6KDqtZhws6uxC
         8zW87o8ykXwy6eWqzkkRLL5X8AXanLUN506hS+q8nw3f0z5tN543qqZSURarIgJdGTfS
         1po4rNHCgFq4oaip+aSExLK74QrFRnK8DZvjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJosGuTGjFGiQOArz8WB33oJPYbeWxHUsYQ3liwnqn0=;
        b=L+9qZ/gPnmQNna6ad37sjZXzBrA1J1bAr+ixHpMdTr+7mvYWpmC/qGesYUJ412RYlQ
         1pWb9IIcoykj8U6WMlRZuxVnTnaZiicpmuoPav+fF4RtfJSNBXK+uT9noS7nfa5i9JUh
         B1B59bGSZw+jRM8XFDIiCR69NxapYn9iHHHEpfQR14c+IYfFJl9imGndnBQLq64HNzea
         0WNTE4JXN12lCqAUQP+HmHRgoMf5MlqtiCFhn+civUqZE7RKbodt1klV9Q1XcsV1Z6Ji
         E+y+rWza+mjgBosVmbdOxpO2N2X2ryZyjQXwlGFXKjiD/Ki+9BNFbE96tjkBna6bPZ95
         V9/g==
X-Gm-Message-State: AOAM531+Z9Xv4Mp/KbzRr/oJZfDC51ymlQFrdfl6b4DtQDOzcxgjTwOQ
        Ivxk9rpMs160yeY6/nHtnzDoF8G530F1Ew==
X-Google-Smtp-Source: ABdhPJyCNO070oVJWEv6DfnRV344LhZCzZxBy99ddvl+ShxeWlswMySv1nPLZzehLY1k0a8CRxXg/w==
X-Received: by 2002:ac2:5472:: with SMTP id e18mr37556lfn.489.1610045245162;
        Thu, 07 Jan 2021 10:47:25 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id s19sm1321177lfc.41.2021.01.07.10.47.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 10:47:23 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id l11so17088688lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 10:47:23 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr58820lfg.40.1610045243204;
 Thu, 07 Jan 2021 10:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20210107134723.GA28532@xsang-OptiPlex-9020> <CAHk-=wgQ5EEH3-GTK9KDB5mBmWjP25YHXC6_-V_KfWd0UTDTDQ@mail.gmail.com>
 <20210107183358.GG3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210107183358.GG3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 10:47:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
Message-ID: <CAHk-=wiZaFRt9hGen9=eOr7LA+Q8o5f980eGEvtxBD6+os7nqA@mail.gmail.com>
Subject: Re: [x86] d55564cfc2: will-it-scale.per_thread_ops -5.8% regression
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 10:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'm not sure it's the best approach, TBH.  How about simply
>         for (walk = head; walk; ufds += walk->len, walk = walk->next) {
>                 if (copy_to_user(ufds, walk->entries,
>                                  walk->len * sizeof(struct pollfd))
>                         goto out_fds;
>         }
> in there?  It's both simpler (obviously matches the copyin side) and
> might very well be faster...

I started doing that, but ..  Nope.

It's not copying the whole entry. It's literally just modifying one
16-bit word in each entry.

Now, the "whole entry" is just 8 bytes, so it's possible that it would
actually be faster to do a copy of the whole thing rather than write
just the 16 bits. But I got very nervous about it, because I could
easily see some threaded app actually changing the 'fd' (or the
'event' field) in place (ie writing -1 to it as they close and re-use
it)

The man-pages even document that only the 'revent' field is an output parameter.

So I think my patch is a _lot_ safer than your arguably simpler one,
because mine keeps the original semantics.

             Linus
