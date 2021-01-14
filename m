Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8B2F5B91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbhANHuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbhANHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:50:51 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A85C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:50:10 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 22so6237509qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37Fv/F4r2vxPobSCHkPJCrrTkh1JQZ6SNQNtiN3ae9E=;
        b=cPvhtX+rvG2F+gwNH7qLyN19RmrVL56YWFyZGdcO/1X1aEOpCupPPWvgLaqfPV24Jt
         LU8aIWl+/ebetyfJtLdKOZRbDjCw/H/FpG0jlsfrJocG9XxQCro5h30bI/s2+MuxJalM
         Yhi0R3K8FAAjXsHcXE3Drhgv4FlGY7CTzcYEWCSie9t5lbCb58/0KPpo1pZLTmjI15Ol
         yN6fjIsyphPwr5jyhKcacrX0VEREyO7K1XDC3tKRFrRmI/PDinUX7BE0nD3GhSMdk+Lm
         kstDdNjGd8UBnMNRIk0DdzHIjGfO/lQqtYw5NAQLKTO4AERRmuRR8HYhyg8sf4kpIyYu
         Na8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37Fv/F4r2vxPobSCHkPJCrrTkh1JQZ6SNQNtiN3ae9E=;
        b=JKjXBKTpTDEGL2RIM1RakuVuVxZzsN/LMsDdK9VnMWQ7FIw42XLOSjMFJ7X/VWKZz9
         pr/70u+e5di9tJj05COOpp7TIP9kS2GqPLQ9+/ZfWib4VdkVRJXhgiQoYUgZDrc32ufc
         h1aYztPCxmrFX0KeuAEEchCX+njO3Bi3Vnq6+SRpqJpl2O1RCMuV0pmZ5qkXWDch4YhT
         gNr0heAtdlbNS5V798AtT0HLOZdYa1l2UVALtaLZoEAii1AxCKgXtO02bdVopA1AoFBR
         zqeP3P95iyjtjcp7uuyQJqvOUIJN0WstzDRO30I49Z9LOTBpXc9vcwCyZLDNYeoREKZD
         fXfg==
X-Gm-Message-State: AOAM533flOz+ltHHg4Y4uIJ82/mqBgD6X96wjduICrTxLSNdn3Y7X6H8
        nvj5ri1mGM78udRNX4qIEfjD9B9eL+xZjg4+86HFY8HmzPhTfBGU
X-Google-Smtp-Source: ABdhPJyKGqkbBrW77m4ChzF2oBS1Qu234IeKUVlYT7Vbhz0/brzPUCnuoEIXN/Lg/cO6zsK9eYdV0jEA/KJwK2yroyM=
X-Received: by 2002:a05:620a:1372:: with SMTP id d18mr5932329qkl.6.1610610609518;
 Wed, 13 Jan 2021 23:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com> <20210113091657.1456216-2-glider@google.com>
 <20210113161044.43bc1c1a@gandalf.local.home>
In-Reply-To: <20210113161044.43bc1c1a@gandalf.local.home>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 14 Jan 2021 08:49:57 +0100
Message-ID: <CAG_fn=XSkOChCwBp=Vg6jWhZ8K44seCo=0Zu38iUpAj6eCUxjQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] tracing: add error_report trace points
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:10 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 13 Jan 2021 10:16:54 +0100
> Alexander Potapenko <glider@google.com> wrote:
>
> > +DECLARE_EVENT_CLASS(error_report_template,
> > +                 TP_PROTO(const char *error_detector, unsigned long id),
>
> Instead of having a random string, as this should be used by a small finite
> set of subsystems, why not make the above into an enum?

You're probably right.
I just thought it might be a good idea to minimize the effort needed
from tools' authors to add these tracepoints to the tools (see the
following two patches), and leave room for some extensibility (e.g.
passing bug type together with the tool name etc.)

> > +                 TP_ARGS(error_detector, id),
> > +                 TP_STRUCT__entry(__field(const char *, error_detector)
> > +                                          __field(unsigned long, id)),
> > +                 TP_fast_assign(__entry->error_detector = error_detector;
> > +                                __entry->id = id;),
> > +                 TP_printk("[%s] %lx", __entry->error_detector,
>
> Then the [%s] portion of this could also be just a __print_symbolic().

We'll need to explicitly list the enum values once again in
__print_symbolic(), right? E.g.:

enum debugging_tool {
         TOOL_KFENCE,
         TOOL_KASAN,
         ...
}

TP_printk(__print_symbolic(__entry->error_detector, TOOL_KFENCE,
TOOL_KASAN, ...),
