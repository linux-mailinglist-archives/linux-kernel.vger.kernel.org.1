Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0F2ABFCB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 16:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgKIP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 10:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 10:27:17 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F77C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 07:27:17 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id p12so2900289uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QC5FHZ1X1/PZam+NsCeIUtWUr/OiX3u5F7vj8wTQSIo=;
        b=TZWdpaXR4wUJwMonwNlSo3OTC/qsDxggW35onf1TCvbd0i4foe92Hz3iCpRVYUSeML
         N3TQ+m24KYVG0TZnSUuP+yGO7twvVzionzcpAQgM3GSDOF9RyxFKEA6C/RWvtJ2Fp0zs
         VY0A4waw4GTL53Ka756yCaYI6rHyKvxTC0XGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QC5FHZ1X1/PZam+NsCeIUtWUr/OiX3u5F7vj8wTQSIo=;
        b=m1v1zepTa+6SPpV9yY//jOM7N3JzcPnAGuu4h6nJfZrracpaH05/WnFYXfclvC5dT/
         z3+aKBvS2b/tiEYqwgnhs+MDavGS0tSC7BFPm7xR4bq/xa3GUapbYEvLpJ4dIDqrzdfH
         g5LGZqeaidVVKxKH4uu3SGp1n12YzJmtG5qaPymFm/Z7g+TVGUwJx34iJkmkGS+7o6Qe
         DdVyk4N6hVYh9Hd+mTbbnS4mEAABJKylXrI1eT5g87JIPcGUskOMgLkhbKF6FrpZlG6c
         LK4S/mF7nGFJnh0+DGfTYyz6iaX7VBsGj8P46QOo1nOpOLV5jnWoeGRs4kY7u8YqTz6i
         b5uQ==
X-Gm-Message-State: AOAM531JodMnVl6OBCqA+XrIN0dqGj/WhMSb59L55Xi1x1tYbAwcsszL
        1t+xsYvh/t7MBU4NbrM42CQcd3eYoyPz1mbCBidZWg==
X-Google-Smtp-Source: ABdhPJz/FTpDS76pZAZFnZy1tGyA7dVPU97SCg5t6g94cDAJBjoVD31hS9aBGwCLPSfehAKXtrOmhVT4uPQ8oVyN4as=
X-Received: by 2002:ab0:2a11:: with SMTP id o17mr7023753uar.8.1604935636368;
 Mon, 09 Nov 2020 07:27:16 -0800 (PST)
MIME-Version: 1.0
References: <1e796f9e008fb78fb96358ff74f39bd4865a7c88.1604926010.git.gladkov.alexey@gmail.com>
In-Reply-To: <1e796f9e008fb78fb96358ff74f39bd4865a7c88.1604926010.git.gladkov.alexey@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 9 Nov 2020 16:27:05 +0100
Message-ID: <CAJfpegua_ahmNa4p0me6R10wtcPpQVKNiKQOVKjuNW67RHFOOA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3] fuse: Abort waiting for a response if the
 daemon receives a fatal signal
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 1:48 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This patch removes one kind of the deadlocks inside the fuse daemon. The
> problem appear when the fuse daemon itself makes a file operation on its
> filesystem and receives a fatal signal.
>
> This deadlock can be interrupted via fusectl filesystem. But if you have
> many fuse mountpoints, it will be difficult to figure out which
> connection to break.
>
> This patch aborts the connection if the fuse server receives a fatal
> signal.

The patch itself might be acceptable, but I have some questions.

To logic of this patch says:

"If a task having the fuse device open in it's fd table receives
SIGKILL (and filesystem was initially mounted in a non-init user
namespace), then abort the filesystem operation"

You just say "server" instead of "task having the fuse device open in
it's fd table" which is sloppy to say the least.  It might also lead
to regressions, although I agree that it's unlikely.

Also how is this solving any security issue?   Just create the request
loop using two fuse filesystems and the deadlock avoidance has just
been circumvented.   So AFAICS "selling" this as a CVE fix is not
appropriate.

What's the reason for making this user-ns only?   If we drop the
security aspect, then I don't see any reason not to do this
unconditionally.

Also note, there's a proper solution for making fuse requests always
killable, and that is to introduce a shadow locking that ensures
correct fs operation in the face of requests that have returned and
released their respective VFS locks.   Now this would be a much more
complex solution, but also a much more correct one, not having issues
with correctly defining what a server is (which is not a solvable
problem).

Thanks,
Miklos
