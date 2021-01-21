Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E712FEAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbhAUM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbhAUM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:57:21 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:56:40 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 22so1434911qkf.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGllKdkQl1dzjQF+oEV0/buZzhLSlwj6awai/2y06Rc=;
        b=DvSaFGXIpYcHINOe1ssUXXKHBrUabYUPLap8GErwGt22sWOaNAKDMoqWg6/gUj2aWl
         S6fLqbd9bo8btemdsvTfVNsEOAVJOXE1dy969kgJeKRkzItmtWwCQfq5wInJ3IhQzqwH
         9hTVEEv81BvQIYf31Pl9N6FMSxCiARL+7YaZREbNc7wMN/hbB20yR3aHMi7Ilrg9HpnF
         bXLpIi/kYOQrtmub9tRR7KfgDskxjgqWl+0FnNjiYVMB0vvZL5m5JFdAfVnIsiKNsuor
         iefUQJgvR0zZkpLUUjdaQVv2J+k6+v14cnyJHzhbCoWC5K3keZGzHVCE5CZmcNV4WIfJ
         4VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGllKdkQl1dzjQF+oEV0/buZzhLSlwj6awai/2y06Rc=;
        b=gJQ36VKGxKq9ZnCXIJ8t9E4BEQCR3cUXh+L5kgQmUANSwHxi4lLhGVOV9VQ+e78j2/
         lBfDYMEqFyQysQs6zS2um0jfg5rYN+HpNRJmn7oYVgHoGFgDh0lhisXmo2xQaUih3lzb
         sFP94aRxo3GY2G27kJjF1nE7hsPG9Sq7+hxmuB9wccMdh8A+yens1VUhmBxn938+WhkG
         RTE86UrPhgEtAbtT0CAVU6OfmZ+AxH3CcpkzfHJ8hsDOD8cSZ3Sscr0swdR9GE1YiRz+
         IQjqfx/IUWIwYOyf5RNl8EYJZQUktrD/VGSqieqDZ+GVBZsRPVSF34liYThMYJM5ZgxJ
         41FA==
X-Gm-Message-State: AOAM532po66YvpCREAK63OOKbtAsP7o8FOpbwoiu6aE8XDsP1mQKmP1B
        F31xFfQ/W5P4Z5x1L7liLCHDEpjdSNzAlkDZdrT7aG8bZbdYFg==
X-Google-Smtp-Source: ABdhPJw2zLh8J0ro26s+uFnrBswVGONEgQBNiYaAzPv60CCJl2SOdDc3zUKdweWzJKy8oLKgAiX12G63RJIpm9O51Nk=
X-Received: by 2002:a05:620a:5fb:: with SMTP id z27mr427204qkg.326.1611233799509;
 Thu, 21 Jan 2021 04:56:39 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <5ae22590-752e-7ea2-5341-a49a99e7507d@suse.cz>
 <CAG_fn=Vp0b3GX78azCiNsqAVs2Pj3bDikSUsf2kBZh7XiX+hzA@mail.gmail.com>
In-Reply-To: <CAG_fn=Vp0b3GX78azCiNsqAVs2Pj3bDikSUsf2kBZh7XiX+hzA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 21 Jan 2021 13:56:28 +0100
Message-ID: <CAG_fn=XXYUAFfB91AyDM0MzuKG9_DDP8uDb15S497upu-MWiEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add sysfs interface to collect reports from
 debugging tools
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:09 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Fri, Jan 15, 2021 at 2:06 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > Should have CCd linux-api@, please do next time
> Thanks, will do!
> Shall I also CC the v2 ABI patch explicitly?

I'll be dropping the sysfs changes from this patchset, but assume it
still makes sense to CC linux-api@ since v3 will be introducing
tracepoints.
