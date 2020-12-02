Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F362CC9C4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgLBWmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgLBWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:42:01 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4270EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:41:21 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z24so3230867oto.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=11wb0BIy9KYmd8STDFsPLG3fLptgLa5I2UPINy3fpN8=;
        b=YFbiQ5jQBxOv+kXTOUL2InMZmILym39Hx47qa6/wP7hvyz0AG+2ljzCpzaFNzWzxmN
         vIEauxf4ua2P1ukNVDiaAb+LX4pPxzJbcJUCQoAdgiYwsk1q45sVlXYp3/9VeO8StWUD
         oefBszTsX8p+JYsfqQ7B/jGSZzXWx5uWhIKthwxvdi6uBhTdmuVAaVPgrudKRy8jrPiB
         CSy+UdEFA0m+U8oWWJbeiSgIbBBBgDhQ3k0KA4zGXmVw6jOstB+wXjUXn5ddxmd2jfEG
         X8X6ol+OZZHl4hmNB9hGjjrGyCJL0Fz1a/+FeZIhofdfH9Q+3I6FMSqEEozqTJpIB5MX
         etJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=11wb0BIy9KYmd8STDFsPLG3fLptgLa5I2UPINy3fpN8=;
        b=jZFNJycwv+dbYWUjrWwJ94RgI/Uw/wFnioxT1HdKDsTfIKdgVHTdOiBcU1TIKSEw5n
         1H25zz2swbumzm1RRV1FiRG486X7q1w4EmvnsS36w0LTMxkuVOJIAxcwyylBGzORiy8o
         N+EXk7GPvirFGpzV5zKbuBD4xIk3P6JbqPev6mBN59GyRcDfMfSgpskh73FHis9V9vI/
         z/Ys7SKVauyVVVz6XDinz+d6K7FekgLT/z9wxOKeCvEvcXn4jiZxwzjFWO+CtFhB8iFb
         Rkg6QNuCHYjLAnU5+2eCZfAztaRoJ7qNSjC+CXc+lq0UMlyfK5MZAlOVhmHsEKfc9z/x
         rJAw==
X-Gm-Message-State: AOAM533/eUlenP/IPjrNc3dbm43EswOBTzZiYhZl2tHKYrXHtxiH44Kv
        iT5QQN9jFIJ+ikbHvtQ2W9ZY6g==
X-Google-Smtp-Source: ABdhPJyjq/pLSAr28mfUmJi7kN/HwyWkzb4KqUhCvTyw/oKgDG/UXaB6Hy3ccF+LY6+ylBIzNaMZDg==
X-Received: by 2002:a9d:32b6:: with SMTP id u51mr62957otb.119.1606948880460;
        Wed, 02 Dec 2020 14:41:20 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h2sm46452otn.15.2020.12.02.14.41.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Dec 2020 14:41:19 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:41:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] tmpfs: fix Documentation nits
In-Reply-To: <20201202010934.18566-1-rdunlap@infradead.org>
Message-ID: <alpine.LSU.2.11.2012021437570.4989@eggly.anvils>
References: <20201202010934.18566-1-rdunlap@infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Dec 2020, Randy Dunlap wrote:

> Fix a typo, punctuation, use uppercase for CPUs, and limit
> tmpfs to keeping only its files in virtual memory (phrasing).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks Randy: not so much for these nits,
but for keeping your eyes open and helping generally.

> Cc: Chris Down <chris@chrisdown.name>
> ---
>  Documentation/filesystems/tmpfs.rst |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- linux-next-20201201.orig/Documentation/filesystems/tmpfs.rst
> +++ linux-next-20201201/Documentation/filesystems/tmpfs.rst
> @@ -4,7 +4,7 @@
>  Tmpfs
>  =====
>  
> -Tmpfs is a file system which keeps all files in virtual memory.
> +Tmpfs is a file system which keeps all of its files in virtual memory.
>  
>  
>  Everything in tmpfs is temporary in the sense that no files will be
> @@ -35,7 +35,7 @@ tmpfs has the following uses:
>     memory.
>  
>     This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
> -   set, the user visible part of tmpfs is not build. But the internal
> +   set, the user visible part of tmpfs is not built. But the internal
>     mechanisms are always present.
>  
>  2) glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
> @@ -50,7 +50,7 @@ tmpfs has the following uses:
>     This mount is _not_ needed for SYSV shared memory. The internal
>     mount is used for that. (In the 2.3 kernel versions it was
>     necessary to mount the predecessor of tmpfs (shm fs) to use SYSV
> -   shared memory)
> +   shared memory.)
>  
>  3) Some people (including me) find it very convenient to mount it
>     e.g. on /tmp and /var/tmp and have a big swap partition. And now
> @@ -83,7 +83,7 @@ If nr_blocks=0 (or size=0), blocks will
>  if nr_inodes=0, inodes will not be limited.  It is generally unwise to
>  mount with such options, since it allows any user with write access to
>  use up all the memory on the machine; but enhances the scalability of
> -that instance in a system with many cpus making intensive use of it.
> +that instance in a system with many CPUs making intensive use of it.
>  
>  
>  tmpfs has a mount option to set the NUMA memory allocation policy for
