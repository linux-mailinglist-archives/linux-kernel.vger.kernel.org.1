Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED8A2A85E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgKESPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:15:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43408 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731620AbgKESPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:15:07 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5820E20A0887
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:15:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5820E20A0887
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604600106;
        bh=myfjJwCcX1D4ApFPT3d9XhfE3lJtFyKEiC5FINGvA1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=szwTj/W7S9MHujOxyxKVfsaIOVemHgTU9mHkQKkAocVnKkDhvWldE0VcIBcNHUW6O
         YJyP86zDRVfgq4pjJYWe5yo+vYguSn6JTl/pAZBPXOzLB3laNX8IJQ3XIw0ln++Yb/
         zREpIk6npzOAkKqKURduuzHN75buUlipm5dbNUl8=
Received: by mail-qk1-f170.google.com with SMTP id b18so2045944qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:15:06 -0800 (PST)
X-Gm-Message-State: AOAM5331bZq3ADsbfC0wNQr85TKbGR3inlUIvDT+nHrLsdJxqGDpeMfh
        7srtzNKZYyE2p/EaCcTb7Z/fMjnr61uR7V6ryYw=
X-Google-Smtp-Source: ABdhPJw9u0xDuP+g7YyDJ4atUegsWUYnfAbIolCC99wW2sXJ2AbWnlLlMPpq/k4ObLFQYMgYEO7lJHHJlSxsigpveVc=
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr3456786qkf.436.1604600105353;
 Thu, 05 Nov 2020 10:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
 <20201103214025.116799-3-mcroce@linux.microsoft.com> <20201105180900.GH1602@alley>
In-Reply-To: <20201105180900.GH1602@alley>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 5 Nov 2020 19:14:27 +0100
X-Gmail-Original-Message-ID: <CAFnufp3O5GHPdAuY8tm3jGWfSJXnziinTkiKV5ak7nAYWEnOdw@mail.gmail.com>
Message-ID: <CAFnufp3O5GHPdAuY8tm3jGWfSJXnziinTkiKV5ak7nAYWEnOdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] reboot: fix overflow parsing reboot cpu number
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 7:09 PM Petr Mladek <pmladek@suse.com> wrote:
> > +                     if (reboot_cpu >= num_possible_cpus()) {
> > +                             pr_err("Ignoring the CPU number in reboot= option. "
> > +                                    "CPU %d exceeds possible cpu number %d\n",
>
> ./scripts/checkpatch.pl used to complain that printk() format parameter should stay
> on a single line (ignoring 80 char limit). It helps when people are
> trying to find which code printed a particular message.
>
> It is not a big deal here because %d does not allow to search the
> entire message anyway.
>
> I am not sure if Andrew would like to get this fixed. In both cases:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>

Yes, I saw this warning, but to suppress it I had to write a 133 char
line, much beyond even the new 100 char limit.
I expect a smart user to just grep the first half of the string, like
"Ignoring the CPU number in reboot="

Regards,
-- 
per aspera ad upstream
