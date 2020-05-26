Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8729E19C67C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbgDBPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 11:53:15 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39158 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388677AbgDBPxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:53:14 -0400
Received: by mail-ua1-f66.google.com with SMTP id z7so1367556uai.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eeld/knQPBWgODPyyjL7AYipdgQCeX/lwMGVDPIUXk=;
        b=SlMrIQk0FbHoFXUBmYGR7SVnFVueYsbknDCKTTsm/4DdvhFw51M47Aud6C5bAz+mNm
         8X2lmjNIltMcbGrJmZHzKbETTaqLKN5+QVDKB5vOKRufB7KdcrpYeFkXsydwyB5QUMHY
         ZHw0WVrZwx4lC3Baz+zy9xLHyMUJOVHXBJtHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eeld/knQPBWgODPyyjL7AYipdgQCeX/lwMGVDPIUXk=;
        b=QK7wrRL8bQ79oesjJZ+VzY654hdGj767O7YsM2ri201q0NgS49NIRMdDwqRx9cDje3
         ZggVTaRYHVyFguC8ezMPssoUtkAnv/1ea7xnpeDhTuj1KcC+EE3jBZ4r/Tqe+FlbHeFz
         Vx19sOWP5iClH1Uq+kcxM5TAjOJos8DmMvzlhx91ctl+a6mVxl2BQrKAQN2E6WFyms0F
         S63n4BN+GTZPDmvHlkxHEH/ANtwTtPH6Fm8zNe8y3JZpeuWRpCcQae89CiLCzpUgcEVK
         Xg6GFzp+Ay0X2JYXSNJmHIQ0kSJ/U2wB5xL7q5nXvpypUAHmzLmhDyZuL2trkc1AA3yn
         sWvg==
X-Gm-Message-State: AGi0PuZq5ZGsyXAuLlqNuzjmJw2lTTsmPVyXBedm3UknNSZy7fWzfrYU
        zmOeaXXy4rH0ttmlZlWhLDcrkY6LS+g=
X-Google-Smtp-Source: APiQypLqN5IMv6z8wIz0+9hA7axLJSQ21YZmW0foqBvfPL+l4aDE3AkREUEGyytt7+8RFSVR8dpjTA==
X-Received: by 2002:ab0:e5:: with SMTP id 92mr3037902uaj.83.1585842793671;
        Thu, 02 Apr 2020 08:53:13 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id b63sm1369875vse.13.2020.04.02.08.53.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 08:53:12 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id r47so1352547uad.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:53:11 -0700 (PDT)
X-Received: by 2002:a9f:2478:: with SMTP id 111mr3073972uaq.0.1585842791113;
 Thu, 02 Apr 2020 08:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200330144907.13011-1-dianders@chromium.org> <20200330074856.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid>
 <20200331014109.GA20230@ming.t460p> <D38AB98D-7F6A-4C61-8A8F-C22C53671AC8@linaro.org>
 <d6af2344-11f7-5862-daed-e21cbd496d92@kernel.dk> <CAD=FV=WHYFDoUKLnwMCm-o=gEQDCzZFeMAvia3wpJzm9XX7Bow@mail.gmail.com>
 <02968c1d-bd3a-af9c-77e7-23a9d9aa9af4@kernel.dk> <1D4B63FC-FA4B-4C73-B70F-6639CC41D3A6@linaro.org>
In-Reply-To: <1D4B63FC-FA4B-4C73-B70F-6639CC41D3A6@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 08:52:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XX+S==bz1OQFYyQxNmsPdMQoJ7AJSs++D9dP_r0Rc93A@mail.gmail.com>
Message-ID: <CAD=FV=XX+S==bz1OQFYyQxNmsPdMQoJ7AJSs++D9dP_r0Rc93A@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: core: Fix stall if two threads request budget
 at the same time
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-scsi@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 1, 2020 at 12:48 AM Paolo Valente <paolo.valente@linaro.org> wrote:
>
> >> 28977309us - PID 2167 got the budget.
> >> 28977518us - BFQ told PID 2167 that there was nothing to dispatch.
> >> 28977702us - BFQ idle timer fires.
> >> 28977725us - We start to try to dispatch as a result of BFQ's idle timer.
> >> 28977732us - Dispatching that was a result of BFQ's idle timer can't get
> >>             budget and thus does nothing.
> >> 28977780us - PID 2167 put the budget and exits since there was nothing
> >>             to dispatch.
> >>
> >> This is only one particular trace, but in this case BFQ did attempt to
> >> rerun the queue after it returned NULL, but that ran almost
> >> immediately after it returned NULL and thus ran into the race.  :(
> >
> > OK, and then it doesn't trigger again? It's key that it keeps doing this
> > timeout and re-dispatch if it fails, not just once.
> >
>
> The goal of BFQ's timer is to make BFQ switch from non-work-conserving
> to work-conserving mode, just because not doing so would cause a
> stall.  In contrast, it sounds a little weird that an I/O scheduler
> systematically kicks I/O periodically (how can BFQ know when no more
> kicking is needed?).  IOW, it doesn't seem very robust that blk-mq may
> need a series of periodic kicks to finally restart, like a flooded
> engine.
>
> Compared with this solution, I'd still prefer one where BFQ doesn't
> trigger this blk-mq stall at all.

I spent more time thinking about this / testing things.  Probably the
best summary of my thoughts can be found at
<https://crbug.com/1061950#c79>.  The quick summary is that I believe
the problem is that BFQ has faith that when it calls
blk_mq_run_hw_queues() that it will eventually cause BFQ to be called
back at least once to dispatch.  That doesn't always happen due to the
race we're trying to solve here.  If we fix the race / make
blk_mq_run_hw_queues() reliable then I don't think there's a need for
BFQ to implement some type of timeout/retry mechanism.


> > But BFQ really should be smarter here. It's the same caller etc that
> > asks whether it has work and whether it can dispatch, yet the answer is
> > different. That's just kind of silly, and it'd make more sense if BFQ
> > actually implemented the ->has_work() as a "would I actually dispatch
> > for this guy, now".

I prototyped this and I think it would solve the problem (though I
haven't had time to do extensive testing yet).  It certainly makes
BFQ's has_work() more expensive in some cases, but it might be worth
it.  Someone setup to do benchmarking would need to say for sure.

However, I think I've figured out an inexpensive / lightweight
solution that means we can let has_work() be inexact.  It's mostly the
same as this patch but implemented at the blk-mq layer (not the SCSI
layer) and doesn't add a spinlock.  I'll post a v2 and you can see if
you hate it or if it looks OK.  You can find it at:

https://lore.kernel.org/r/20200402085050.v2.2.I28278ef8ea27afc0ec7e597752a6d4e58c16176f@changeid

-Doug
