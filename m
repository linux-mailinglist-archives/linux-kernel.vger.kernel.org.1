Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAFB2FA115
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404460AbhARNQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391750AbhARNPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:15:10 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B09C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:14:29 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z6so4099767qtn.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7A/Elja0tqTh5xl8zVGHbIgBSUloF7XCymm9bzQL4Zg=;
        b=G+02ve1Cp0Ve+zAIDgeCoRcOPI4rO9Xl9bLUnd9i0gsVR7HlMsCDZl5U8bMZ5iau69
         hnFFJYdEUe2AsUjqN+w0g2dI9DUrxO6ki2rBh5ZP59EKBv5ZBkyLu8SShSMKVz4B2QqN
         wPz8j69raE5PeNWNJvHzhM5eGgevOlmBDGrVSMlTN1W4TKuSpzPqrL/EwfqJZADVdpcQ
         r+aUo3mRLFSUd9cSA4ktzCyEnVqpEEsJxnMZMrCkKw3qdyCdDi+KM1d3UVmMqzi3MBb2
         zSF5miT16KEWh2i+48dEusQINaVwQ61fgVoUocCuHlViBZ0xzpJKACaGSl8RIEF5tEQv
         Q0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7A/Elja0tqTh5xl8zVGHbIgBSUloF7XCymm9bzQL4Zg=;
        b=G90B7OH1ANFeyqmCDQoZgxpRkXTO2sknB2REQk9/Cp9J+OL7A6KYRVlgohbyyL5STY
         Vvb3LctUaMLbIb8EcrzMHftYsYdwFj8A8QbkAshPs0jkUJxtzknck+Citi4nk67any3d
         ruGS5Zx+a+SF1eDqol/LSwp1XaDwmyXoWawe21Ydm3BaiR7+/twOAbqoChvqej6mOq2d
         uHiMjQnneNxWUTXNi78q6NSg0/Qsfpmz4nPknBuyVyQ01SrnEXYjbLqH1Eybr9R6HaQo
         6FD3m0dfJr4bQQ948yrS07BPGdZzqnj8My1sNYGllDTpEBV1yfsA3Mrq5WTuf+/W1KID
         pQOg==
X-Gm-Message-State: AOAM533akP9F/i6/AgvGRSGmY34GJrxzuJV8x6x3wo/LwRjow4reNFLx
        0LRPSVAf9PcGywS3AIBMHUyNbclshXUizXj70GflLuY9BbC3tO9B
X-Google-Smtp-Source: ABdhPJzLDo/2mteZepXTtQOjVhCHKhKZV79RV2P6nZNVUem4zZDXXzbBaPATBdtGn6W0mR/vmKjpj0htzgHQRqeYbUo=
X-Received: by 2002:ac8:7512:: with SMTP id u18mr23187629qtq.300.1610975667584;
 Mon, 18 Jan 2021 05:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <20210115130336.2520663-3-glider@google.com>
 <YAVzNrBIlp0UJKfs@alley> <CAG_fn=UmjC2LOCXRpp+vTZ6nr0M7=dCKjFYgVFVvmqftTkjGYw@mail.gmail.com>
In-Reply-To: <CAG_fn=UmjC2LOCXRpp+vTZ6nr0M7=dCKjFYgVFVvmqftTkjGYw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 14:14:16 +0100
Message-ID: <CAG_fn=XEe_ptR718exopJoEVUKgOd5SfaHev_PbW=aq4z8HEtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +
> > > +     /* Pairs with acquire in last_report_show(). */
> > > +     atomic_inc_return_release(&num_reports);
> > > +     schedule_delayed_work(&reporting_done, 0);
> >
> > Why delayed work when it gets queued immediately?
>
> Because error reports may be sent from a place where waiting is
> forbidden (in the case of KFENCE that is the page fault handler).
> A delayed work ensures the notification occurs in a wait-safe context.
>
Agreed, there's actually no point in calling schedule_delayed_work()
instead of schedule_work() here.
