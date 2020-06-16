Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF471FBFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgFPUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 16:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgFPUJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:09:24 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FBAC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:09:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id r11so30693vsj.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVMWjFScpVollEOaNkFT8lSb179zymvf6bAuLU3nZ8g=;
        b=F1NFK1Isz0JIvcb9r87G9yspaDOOrupvCmuU/LAcJSn7u8WAmPr5qOibsWhJDSAbxP
         a3OFOdRsjDt2zI3ptL+pYtfB9xBHqQ1RomcjZJBHiFpqV62dqNSQeN2FOGXbOLTvpslr
         KCNa6gR+VdOLXF2ivweaOgfh0WnSXhr584BplLueb24vGG/nk7eyDGz3i5ki9iXSI1Zg
         xZbFe/s7r11uFZVsMNYZq2yn39WEI0gcZGvz1KdRR6uTNZ6mlayN+LdgQY5J+V/g/mjQ
         b0DqZJtwpP1nmW32d+jO9IpF0Efg54SkbLlgdjem9NxI8bUHZ1DE1hHii3bQPyE0J4BE
         fJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVMWjFScpVollEOaNkFT8lSb179zymvf6bAuLU3nZ8g=;
        b=VIumRW9b/nmz99Fd8G5o53F1apIwXwEjneXUmeEAmJhGM/6wju7MSLeHt37q0UhwmI
         8Xn7hMnqsfyreuxVU/wA80htCf3AEixVieb8jLSLa8XJ3niWbR6pkyp0ituR6rnmJrs9
         n+vNjsW7j3SqSN4qPwoed0/APgOFwxss2ss5Lx7VDntnN6eNMTZ5NXyDT0CjOwBcpMqL
         Q6mITlaYAD5RQAa6jR0F9Z5Nq9SnSlkGQKL2dNZ/yy0mGi2e4A3rvzF+7M12myuO0h24
         dOn0IrAWMDp0s9TaERJX2YxhnAKAf/O5fPp/3e8QFrrJD/NPJDqYG367XF4ACUB4m/N8
         hvdg==
X-Gm-Message-State: AOAM531xQO/y5zc67HLwOE7h7Vz7zLmVx/BQGi2rebQit+GxHlInz6cc
        QMGHSe+FC3J158j2NPCdjPRbjMIBNXYtSNwm4ak=
X-Google-Smtp-Source: ABdhPJw/4cuYPDUCD3Xns9GGeuzMZTuvKA8qrzsY4d6/0el53JdYE/CqpRJaf9WdfVmlQY8zIW6vIVR4Rh0gDJBoqcw=
X-Received: by 2002:a67:3211:: with SMTP id y17mr3218081vsy.56.1592338163782;
 Tue, 16 Jun 2020 13:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-20-jim.cromie@gmail.com> <20200616115727.GN31238@alley>
In-Reply-To: <20200616115727.GN31238@alley>
From:   jim.cromie@gmail.com
Date:   Tue, 16 Jun 2020 14:08:57 -0600
Message-ID: <CAJfuBxwmMNzt6ffQkYX7vU1qRa12=mCbO9T4SMzF7RXV5UwkYQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] dyndbg: accept query terms like module:foo and file=bar
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 5:57 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2020-06-13 09:57:33, Jim Cromie wrote:
> > Current code expects "keyword" "arg" as 2 space separated words.
> > Change to also accept "keyword:arg" and "keyword=arg" forms as well,
> > and drop !(nwords%2) requirement.
> >
> > Then in rest of function, use new keyword,arg variables instead of
> > word[i],word[i+1]
>
> I like the idea. But please allow only one form. IMHO, parameter=value
> is a common way to pass values to commandline parameters.
>

I dont see a basis to prefer one over the other.
we already now accept  " file   foo.c:func "
that might argue for file=foo:func
but file:foo:func is what youd expect reading left-to-right


> Note that "keyword" and "arg" is strange naming, especially "arg".
>

I think keyword is clear in context. query_term is suitable, but no better.

arg is pretty generic, without overloaded meaning like value ( like
lvalue ? rvalue ?)
almost as old as 'i', but generally a string (not an int)
Is there an alternative you favor ?

> Best Regards,
> Petr
