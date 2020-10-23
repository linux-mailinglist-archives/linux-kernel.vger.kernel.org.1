Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640F3296982
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372070AbgJWGIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372056AbgJWGIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:08:54 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88A5C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:08:53 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c129so259214yba.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNjwNm9fr6MOiHhV0c7B5b4MJGULWGcLuUm+GanGsBU=;
        b=WB6pavCAYf594uliGhghOjMsImH7+PHOiF4EDnUqBF3cphrd0ogiBpHJA0MvxDEuOV
         5hIT3vxfJjHJ3/HG0/VprgOT4tWaBuczd3BYiMdLKjD0hnodoQQWLx0tYK+XId22U4t3
         08jfxtgX338IbUxZcR84Qttd6DQZ/3mgnYaSaOO8yawbpyMm+xS1RlJxbty+YICMk62g
         VNSYBDgK2KBkP59oFLxJOS3iHLB3VYycJezY5TWFIDFi57giyRunhJ9wAlrd/kC6r9NW
         Nun2D5o3KJH7cP8cRJ7q1kpvybWAv96qDLieU+aVZq//mvpZ71kk4EyaNAoC0aoaZcXk
         /X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNjwNm9fr6MOiHhV0c7B5b4MJGULWGcLuUm+GanGsBU=;
        b=LxGGxogwGxfN5eZpmZ6Pu/DC5mmG4VExOw/btMdPQZukMKXsPLZPQzHlPIxFfWyO+c
         4rJ6auQ/Z1w7BDU5r1wVKd83jzKvc11oJSseAZ6r4RXC7JMDDJiLADhzSUt4QWRa57EY
         s+lwq10jEa+iUn096VXDgzTT3rNRZrj8bUAsGynC1xd7k0nf2xkXHM1ANdsxYeTI3E5N
         dZs5yXNsXZwwVVb8zPEL/4fjs9ajfk3M99LJXi3xCxWDO48xA2kVL1KBXBD/+VNBAvi3
         zYezxgu+4IeY/QM8lmzkHeflPNYAx7dK6dgxoCQEJGMcDUrm6NUcs5P0mUnolxlsrfiw
         Dqbw==
X-Gm-Message-State: AOAM532h825Ez0d4niOMPG6Wq3EyMfL8qjaJdPOEIFUp75T9XlQi6UKf
        u+bh4E5YVb+KCmut8qjankAfYyVl+TOi+bXDo1Y=
X-Google-Smtp-Source: ABdhPJyteJdZySQkBUEdPJpikZOXrl9LNaw91BcX33OCHSsqxf7Q0oYYhHHdeAdTBBDZ3YWawx69oa7YI1V3OR38nYU=
X-Received: by 2002:a25:d441:: with SMTP id m62mr1263586ybf.422.1603433333137;
 Thu, 22 Oct 2020 23:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
In-Reply-To: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 23 Oct 2020 08:08:42 +0200
Message-ID: <CANiq72nfHjXkN65jy+unz0k66qvAALNhhhDZsxqPRLdtLKOW_Q@mail.gmail.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 4:36 AM Joe Perches <joe@perches.com> wrote:
>
> Use a more generic form for __section that requires quotes to avoid
> complications with clang and gcc differences.

I performed visual inspection (one by one...) and the only thing I saw
is that sometimes the `__attribute__` has a whitespace afterwards and
sometimes it doesn't, same for the commas inside, e.g.:

-  __used __attribute__((section(".modinfo"), unused, aligned(1)))  \
+  __used __section(".modinfo") __attribute__((unused, aligned(1)))  \

and:

-    __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
+    __section("__param") __attribute__ ((unused, aligned(sizeof(void *)))) \

I think the patch tries to follow the style of the replaced line, but
for the commas in this last case it didn't. Anyway, it is not
important.

I can pick it up in my queue along with the __alias one and keep it
for a few weeks in -next.

Cheers,
Miguel
