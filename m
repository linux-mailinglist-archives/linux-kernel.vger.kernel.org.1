Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C011AF40B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDRTAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 15:00:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42032 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727826AbgDRTAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587236421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0Gisw9hWUsG7t2w9OL7DQLlQmWjB8dYgMJG70gQDSw=;
        b=a4Ta2E5+yaJoGONQxs8KxGyA7mkdoORM3CBb2+i7P+5DiyiQe28KhgfCDP6IS3PUtOEmUG
        2eMu0lN61ee7KcSmnBi9OAeMTtaEI7SQGUv0jQRs3r4CBF4HC2lSU9UFG0ei2vb38E9g/k
        RrtdrW5qACr9b29KAJVQyuTXFVEt68A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-WQXmeWD_PAiHtTNAXaZ2Yw-1; Sat, 18 Apr 2020 15:00:18 -0400
X-MC-Unique: WQXmeWD_PAiHtTNAXaZ2Yw-1
Received: by mail-qk1-f198.google.com with SMTP id x5so5507092qkn.20
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0Gisw9hWUsG7t2w9OL7DQLlQmWjB8dYgMJG70gQDSw=;
        b=mUyV0exCSxyTn2iVjfr3RdFLSD61sGblwwIpWySncOoqp8NP4heAVWi3nxllAdhKfZ
         wvTVN3Hub2lvvVQh2EtYI2RUA9qP79OjVQTGVx6x2HifvLLHwKuNgZ48WsEEYKM6Nqqo
         icdVRsGKjCHmrP/WwL5K+77zNZK/qXr8OHpQWp+n1Bw+J4beUu5kHeNsSwVVwwEwPFRd
         JP2dJsRvOEkKYoY57bc0OXOC7xW0jx8cB/Ecr/1V/jiCbz1OxpLgBk1Tg9a97YzNcFfW
         KFrZBuVrLJPXixdKQi0ohZFfKxnry3KpUa9maIivxsgjqdvAk5tuvLZecvPsU6lOiDFv
         6djA==
X-Gm-Message-State: AGi0PuYKZvTGsiKRwnxYX7apUBafLJSFm8/01ztvj+hrblVOXgv2yJKR
        tONGQ2rAsawAqoIWM5Pg4CZ8FDgfDrcwJ8Ez3C1KMc1F6ShHCtTmGtAfXvxTo/5w7My/n4JYXqK
        fCpMLRMLbYnItCk3MQGkZCJmXsyQq9FaCZ+cMR5qH
X-Received: by 2002:a37:d0a:: with SMTP id 10mr8976654qkn.288.1587236417119;
        Sat, 18 Apr 2020 12:00:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2nHN5tNsMq4pPm5ciYHRA5VRWl7aSSu5+P9HKsSo/yFjTBtNzBH3IvuFjBQ139wkhhgPpEk79Jxs2c07SmRA=
X-Received: by 2002:a37:d0a:: with SMTP id 10mr8976624qkn.288.1587236416872;
 Sat, 18 Apr 2020 12:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200416143532.11743-1-mszeredi@redhat.com> <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
In-Reply-To: <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 18 Apr 2020 21:00:05 +0200
Message-ID: <CAOssrKe7RNyReAFLoQGBDm79qMdXEubhP5QhG_+UmGZXgeXBkA@mail.gmail.com>
Subject: Re: [PATCH] vfs: add faccessat2 syscall
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 8:36 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> Hi Miklos,
>
> > POSIX defines faccessat() as having a fourth "flags" argument, while the
> > linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
> > AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.
> >
> > Add a new faccessat(2) syscall with the added flags argument and implement
> > both flags.
> >
> > The value of AT_EACCESS is defined in glibc headers to be the same as
> > AT_REMOVEDIR.  Use this value for the kernel interface as well, together
> > with the explanatory comment.
>
> It would be nice if resolv_flags would also be passed in addition to the
> at flags.
> See:https://lore.kernel.org/linux-api/CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com/
>
> We should avoid expecting yet another syscall in near future.

What is the objection against

openat(... O_PATH)
foobarat(fd, AT_EMPTY_PATH, ...)

?

Thanks,
Miklos

