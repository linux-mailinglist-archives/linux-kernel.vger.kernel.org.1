Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89696213459
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGCGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 02:41:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44322 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCGlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:41:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id b6so31416193wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0eudNO2U/9S8dh5id/m4WsVCdyUBOyJCt8W5p1bm91c=;
        b=lpyMM1xuUDBr26bHxK+QcDxWZ70Dk2SzAeHLtfUBF+7eaWmJdNkqOVdNCbDe9I2PN2
         dsWm0m/Ec05IUqfgbqRp/4yyut3ZFgMF1uQxAy+EsMF6RU2EVPCepLlue9YiZPHJEPz0
         V/QY9qwBp9FLXDc1WktcZ3Ap3xpFEV/mBz6ptuvYEsAlBeNNCn+gjhDzsUqpMlNR1COt
         5/KSd09MM3MxrOZAzvbwrsrfXGTQSz/IgokEzeI7h2t0OfaPmow27jYc1pNYsz6l78C9
         VhBz9Ql/daDiDGzzOn5wK+7j5KWw0XBSxdqZSIVLjB7LAcbkHSdwJ6HnJW3Zx2qp3Fgq
         LKeA==
X-Gm-Message-State: AOAM5326Xp27k+ukD1WIRCGn+T9zakNKKKC3nvQTS1YcqoXD+yc9SLHJ
        z4xFbEgdUW5k9QeVSL/1W+vxCOeX1xM6fdIUZz0=
X-Google-Smtp-Source: ABdhPJwqfr5+Eh8a0osER/jzwMVQhTGHvOS5ioEXJSWLPbjWaZSKPnJxw2HZ18VR4NKgQShg2InXZDtGtG5/b0FTneU=
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr35182164wrr.391.1593758470280;
 Thu, 02 Jul 2020 23:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200627133654.64863-1-changbin.du@gmail.com> <20200627133654.64863-11-changbin.du@gmail.com>
In-Reply-To: <20200627133654.64863-11-changbin.du@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 15:40:59 +0900
Message-ID: <CAM9d7chsn9_5FBR5nPW_gc+k0hq9whOGSa67uZ2XKzM147OaLg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] perf ftrace: add support for trace option sleep-time
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 10:38 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> This adds an option '--graph-nosleep-time' which allow us only to measure
> on-CPU time. This option is function_graph tracer only.

I'd suggest --graph-sleep-time instead and set it by default.
Then we can have --no-graph-sleep-time as well.

By the way,  didn't we agree to have something like --graph-opts instead?

Thanks
Namhyung

>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
