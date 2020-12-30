Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52312E79C0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgL3Nms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgL3Nmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:42:47 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB6C061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 05:42:07 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o6so14694857iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUj2WjSpqQLcqlN8UUnmEWJx9j8l+px7OfZqNlRWbo4=;
        b=ptoC1ga1r10YXdrJmNBXpdltzmqvnmO26GrH7dl2K40hEnTGyvi5i96sj2nP42DyQx
         y+ONHv+CdiqoJJ1/zamY8j4DYOgeQADniB7HFORhrjf4ffr5yLhaj6z7v74AyF0x1z34
         p7wH6rLWHsTRBwQ8RrCMpg9RjeO6/lavTFdjRCbcmNkVt347P2Jy+KLgF7OAtpbdYNjF
         VEYDFHrOGlrBjuTzpL/5ZOD/VpAvyJjjaPfguBVqvk1UBLA6Kv89rZxwX/mltOKeig5x
         x5xkccxI/34NkGar/u5SjXw+YnpOIzn8KAU7G0wN0iZGxbFLRIVcxQwS+Teks/fu9j9c
         /VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUj2WjSpqQLcqlN8UUnmEWJx9j8l+px7OfZqNlRWbo4=;
        b=oVfs6PzFZA8s8lPErgM3ESqnbWFi8LZIArCR41ttvTcBKDu9qQNMCxsw5xlY8Y7fUA
         LZBOt9IOdV6xOktJ8Kyd5iUOyzvXlC36hfs5/y5dIW5Qkltz894QEnUUzIUbCYLVuqIu
         F3Vf9RjP/NpHjj8g4MaIW8hJYmV8pXh3QG7hsA8kqQiNSHtqPNdj07QOEnPPeXWQnTSg
         m310QqsaxRcegKJbdaFLkR//vOvjWFFuatpv39MHQVRqDU/PE2XV2QkqKfEgcjZovqWO
         LlMOtRCxny37dUZWW+OxjPXvUBUAN6ZELD+0yeq+cM80sZ27s+9DcHGIufAyb1fCQaT+
         +3qg==
X-Gm-Message-State: AOAM531WosfdqKOzRZB92ZPKI88zYqvMkUskWSbTcMG6eoSE5Noy9n+t
        9SxUvzlAZH8CjRB0R0EGjOsFLshVe/4S5hzBefpuUijNA5c=
X-Google-Smtp-Source: ABdhPJx6Bggd2NgTflZjM7uwaeXoa2NO4c6kYSwA86/s8rOmvwNeeJk5mfcILfSU7t4w0DoIxhXWYOPoK3ucji01LZk=
X-Received: by 2002:a02:cd84:: with SMTP id l4mr46075384jap.141.1609335726798;
 Wed, 30 Dec 2020 05:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20201230114014.GA1934427@ubuntu-A520I-AC> <20201230124233.GE28221@casper.infradead.org>
In-Reply-To: <20201230124233.GE28221@casper.infradead.org>
From:   Muchun Song <smuchun@gmail.com>
Date:   Wed, 30 Dec 2020 21:41:30 +0800
Message-ID: <CAPSr9jHa8nT=Y1R2w9v7UUFJNXhCFohwDGwyv7WOWjKADZEchw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: remove the static for local variable node_order
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hui Su <sh_def@163.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 8:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Dec 30, 2020 at 07:40:14PM +0800, Hui Su wrote:
> > local variable node_order do not need the static here.
>
> It bloody well does.  It can be up to 2^10 entries on x86 (and larger
> on others) That's 4kB which you've now moved onto the stack.

This is not the first time I have seen similar changes. So what
do you think about adding a comment here to avoid another one
do this in the feature?

>
> Please, learn more about what you're doing.  I suggest sending patches
> to drivers/staging; that will help you learn how to submit patches to
> linux.
