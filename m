Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7818C24216C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHKU4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 16:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgHKU4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:56:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A5C061788
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:56:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bs17so10135675edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIwwgXuVYR9J8FN3Q7OBMSeO2MRyPkPN2N5o9h2ay8w=;
        b=eKcrw8bQXY0ON3Tby3NTqixV/DjoLpozBmhQ9Wxh8CrzQKneLuoqFBgMjT6gAHEG5x
         zYyv+zLUzEwpSrr4OU+QfyjH1a/L/3382mM+GuZnpa9mC47RvCYGIpTbFcfYEHdSy8L3
         lYq0C+Xov6wYQlMCdmDB+OTEIdrvHwkv9okCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIwwgXuVYR9J8FN3Q7OBMSeO2MRyPkPN2N5o9h2ay8w=;
        b=guxY2TjIdxA4NmqtHBxE5Eyt+NWvLkGExceV90D+ZRtTEfne5U0n6bMmKbbaxMfrhA
         DPaYAepzcAxSl96iW6zzgbvOUvJ4IJABEmntrKifbRKBF3Z1NCDNm/9BYfliG3ksBIhe
         XecFVf3uWM1zolvr6Lltikgd3fIt4Qo6l7yZ+X7HqII5Xry4s5S9DDduei2qV4oSaB4I
         jOFsZhIAH0c5CTUa/zhtJQKCEyf1LqItWmcrM5XczoZ0KRtoaqZlxUVwuuXYN0tDkwWP
         nxg53R++x0Py/YWRhkAfORIpQR7LZyyc8/qICwa+soGMFc4qdvkOJQmgfUjyVT8teYqj
         k/mg==
X-Gm-Message-State: AOAM530nAkM+Yl6wbNY6DEwI3ghKDma87Z3Xp+IazAJaJK1LSiugQzJB
        FYG8bQOq0+YUNyjGxdZDq513+mgww6NZyEO0eq82Cg==
X-Google-Smtp-Source: ABdhPJy0K+Fs+OPN9rfm6Efrlr92XTN+ignCX68MAQVFzGb3drIK9V+44cU7wIUR+/6aonnP7KkpSeyJKYyxyPce3Ms=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr27523537edx.358.1597179388290;
 Tue, 11 Aug 2020 13:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com> <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
In-Reply-To: <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 22:56:17 +0200
Message-ID: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Jann Horn <jannh@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:37 PM Jann Horn <jannh@google.com> wrote:
> If you change the semantics of path strings, you'd have to be
> confident that the new semantics fit nicely with all the path
> validation routines that exist scattered across userspace, and don't
> expose new interfaces through file server software and setuid binaries
> and so on.

So that's where O_ALT comes in.   If the application is consenting,
then that should prevent exploits.   Or?

Thanks,
Miklos
