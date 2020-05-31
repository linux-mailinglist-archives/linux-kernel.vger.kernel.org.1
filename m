Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163EE1E95DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 08:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEaGHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 02:07:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39284 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgEaGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:07:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id k26so8160610wmi.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 23:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1buWu58KyOLiS6bQIdgERBquwzHgWz6b4aiAnZlt+M=;
        b=nh13IXBkxnwRH3nZnkjNZNgwg9PNV4eJSc6meHvTS8Ei1KCdSTq3T5HxhkiwoayFRN
         G1qvO1wEw6FFGwfacSDjCqtaONKrvj6fyO8f9eQuOPQ86i1rCSFGnxFwm9A7vR+10TbK
         hCx12V3Rxb5TERYfC5ogXsiGCt3D+VFeqmamQPhvAzsFE//WOOZMoGn4CeQwyFxsUyfP
         lNIe2NtDgvgUHiTbq5Fy+0PNvl5LcAJkOC+DHabmwZRLIVbUG87cC3o5OWifwJxmpbEM
         dupotP/KmM6o1GDN0kRDwPXaAxvsOIfP88Q5gCKszoTrCjagNtbw2yjAJeqPQwhx55SK
         aAWQ==
X-Gm-Message-State: AOAM530FBQW8C3SxVPnZST2vH5orjPg6kWdlP2/Y2faq61gNhbvtcI7E
        kcVHqOkyyFXkOe898nC24yb0RGHL+xb5pEG3PCo=
X-Google-Smtp-Source: ABdhPJyu7sNOuQdUHdXQJM5Z58X/WF3zUzp5Cbym8SfF45CFcLKbUoCtfjYLD0GfiHUaZSwowaEcD3sfpDTqxu44JI0=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr15944573wmg.70.1590905250948;
 Sat, 30 May 2020 23:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200510150628.16610-1-changbin.du@gmail.com> <20200510150628.16610-11-changbin.du@gmail.com>
 <20200520210509.GY32678@kernel.org>
In-Reply-To: <20200520210509.GY32678@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 31 May 2020 15:07:19 +0900
Message-ID: <CAM9d7cijjLcFtNPP28F_MUA4ACgkiTYccO5vMMF_9XS7p2Y+2g@mail.gmail.com>
Subject: Re: [PATCH 10/19] perf ftrace: add support for trace option funcgraph-tail
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:05 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, May 10, 2020 at 11:06:19PM +0800, Changbin Du escreveu:
> > This adds an option '--funcgraph-tail' for function graph tracer.
>
> And I think we should make these available in a compact way, as Intel PT
> has, i.e. instead of doing something like:
>
>    --function-graph-options nosleep_time,noirqs,no_tail,long_info
>
> We could have:
>
>    -G ns,ni,nt,li
>
> To save on typing, or something like that.

Looks good.  What about separate 'no' prefix from two letter alias?

st, nost, ir, noir, ...

Thanks
Namhyung
