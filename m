Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436A62DA247
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 22:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503663AbgLNVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 16:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503614AbgLNVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:06:43 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44667C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:06:03 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id 75so5129733ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 13:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXujo8M1so58bu1bHJQMzIvaxoMCcR2JFvMI6/2SYtw=;
        b=Ea8790/9aGUTS3HYnA37Ah+oEr7UrpiyR0ngkh/QYf0ZRftPH562cxiHxag9HS8/i2
         giw4L8vm132D1ebFROpXaGlMMUVtdircMRE5oFvR8DcuYKDeR1xdxvUfDS8EZoIt621J
         lKbiko7pwfVFv3AMwuX/XFhqzS1c+K+QbyYqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXujo8M1so58bu1bHJQMzIvaxoMCcR2JFvMI6/2SYtw=;
        b=Fh6l+QvRTOEvXpLegnkX0vJ5/DmGmVjhmeF6AOQ6I4+uBIV2l7w/UShOWA5E45XG2Y
         eRdll9C+eDxuUUIsL5enJ4Lt8o2KVxvYI5XaQPN7jOKFtIbIlUj0uoUnbibu1f1Y4gel
         4rdNrgQ3ftHJcKOwm85bGh0MQL4CFYFuT0VFPWZVrhycqSN1B8fwFV/JKM0yhUjctncH
         xBvYYSKYvTUik1630K9Mb+9YWxSAUYuioFdF0LJLORCUQyR/LhVVzmqEHXiUuoSMUJ4d
         0oNHiXtncDmUrK/45j0sQHX4qOH7ZLATAb2hRFpV3CkO95cAFOj1WuR+6fRgCKQGp+sa
         +RMw==
X-Gm-Message-State: AOAM5321bun2DGERkCmzInU0cS2gWXamcyKsf+fCdMUDyISgRzNj3fBE
        OOC4+aOJil3ebpYzrYVuExjWrwJHWVF3E/lPG7gnEA==
X-Google-Smtp-Source: ABdhPJwoiN0Mha/65j9rHwzmflBt6XppkjGZGKXum/T1dG5G7vZg9uMrfm4crnB+SAOnguAMBC0VLe5qrVC6/YKh2kk=
X-Received: by 2002:a92:dc03:: with SMTP id t3mr37104802iln.215.1607979962323;
 Mon, 14 Dec 2020 13:06:02 -0800 (PST)
MIME-Version: 1.0
References: <2659836.1607940186@warthog.procyon.org.uk> <CAHk-=wido5stGfFtRzmW19bB1w2XQAuY8oxUtFN2ZWdk2Grq-w@mail.gmail.com>
In-Reply-To: <CAHk-=wido5stGfFtRzmW19bB1w2XQAuY8oxUtFN2ZWdk2Grq-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 13:05:51 -0800
Message-ID: <CAADWXX83JC0oSVoDxOwsLE1DPm8r6JLWcAsP0UyCLO_X544pkQ@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Collected minor fixes and cleanups
To:     David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Denis Efremov <efremov@linux.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jann Horn <jannh@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Tom Rix <trix@redhat.com>, YueHaibing <yuehaibing@huawei.com>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I suspect the fix is trivial (change the "," to "|"), but I will not
> be pulling this - or anything else that hasn't been in linux-next -
> from you this merge window.

It looks like Stephen Rothwell saw it in next yesterday, and fixed it
up there in his merge.

So somebody was aware of the problem. But unlike Stephen, I don't take
broken code and just silently fix it up in the merge.

I suspect Stephen might have thought it was a merge conflict fix,
rather than just a broken branch.

Stephen: that makes linux-next test coverage kind of pointless, if you
just fix bugs in the branches you merge. You should reject things more
aggressively, rather than make them "pass" in Linux-next.

              Linus
