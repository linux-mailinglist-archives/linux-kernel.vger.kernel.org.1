Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED527EDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgI3PpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3PpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:45:06 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:45:06 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a16so1170427vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApvBKc8Khxg0IoEksSg3GInYcR+U6xm2yDW9gWHbZWY=;
        b=peW6K2GBAkpVrhNuGiGONtsbqNn3KO8HZw8ixAOOhnbRJIZabs2ua7ORJscfylzLKD
         0dA911UyQL46gahT488TSi9oZZNJYgvIeCpKeJpQcQLr2Q0oqN0MH+CAlfYyn98t55Z8
         IyhwzOppuPYsddcdr4di4nVskmt73wt6fK3+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApvBKc8Khxg0IoEksSg3GInYcR+U6xm2yDW9gWHbZWY=;
        b=ROCesQ4H5Z8cx0B9DhIT7XnYBI9BMakimqMUPp0WL33q1p+kXnaGGvuaZ3fe6QbAS4
         4B5PWkCpOg4eO/8j7r4NbDAM+1peZ1KcdsazSSgZdB5qcnWgSuyf6FMWBblQnkXQMl/C
         0BhGo2sumibGXX0ToQC3pgQJPnacrmmBGmFkdgKImbesEaT0B0oPutCzKGYDZh1YzsUL
         QNIRIGUVb5GRw8m9nFBc5cgLJay0F9HfPc+izjkkLV3igJTbaYdDw2A3ZiJIkoq0YxAO
         7wHJUVukzjO/DSxvh08IRrqfHNoLP4JdAPUuF54o7fx9kif+arztQrdY5F15LAVnu22Q
         jN6g==
X-Gm-Message-State: AOAM532KLJPnX2A+/UWCqgbxUtKIq+VvCOpJdTW5gbXDJATlgu+NYS0Z
        lV/gAoTa3QpgOwDa6nQ87L/c7w+E+EkxLiWZiGYmIQ==
X-Google-Smtp-Source: ABdhPJxumN4h6iGLvR5ObOrFqwk8EkF5bJbF39rhN5043r3Ml389oAO96ocWz71kNFzko+iDwCClq7JcI8Kx7XOz5qg=
X-Received: by 2002:a67:6855:: with SMTP id d82mr1876811vsc.46.1601480705468;
 Wed, 30 Sep 2020 08:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200924131318.2654747-1-balsini@android.com> <20200924131318.2654747-2-balsini@android.com>
In-Reply-To: <20200924131318.2654747-2-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 30 Sep 2020 17:44:54 +0200
Message-ID: <CAJfpegvB7XJH7sPni7Vj7R4ZwSrDfevfeRRBgvESSgGg=C5tdQ@mail.gmail.com>
Subject: Re: [PATCH V9 1/4] fuse: Definitions and ioctl() for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
>
> Introduce the new FUSE passthrough ioctl(), which allows userspace to
> specify a direct connection between a FUSE file and a lower file system
> file.
> Such ioctl() requires userspace to specify:
> - the file descriptor of one of its opened files,
> - the unique identifier of the FUSE request associated with a pending
>   open/create operation,
> both encapsulated into a fuse_passthrough_out data structure.
> The ioctl() will search for the pending FUSE request matching the unique
> identifier, and update the passthrough file pointer of the request with the
> file pointer referenced by the passed file descriptor.
> When that pending FUSE request is handled, the passthrough file pointer
> is copied to the fuse_file data structure, so that the link between FUSE
> and lower file system is consolidated.

How about returning an ID from the ioctl (like the fuse2 porototype)
and returning that in fuse_open_out.passthrough_fh?

Seems a more straightforward interface to me.

Thanks,
Miklos
