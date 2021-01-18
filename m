Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DED2F9ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733208AbhARH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbhARH5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:57:14 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2984C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:56:33 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so22674308lfd.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPQajUXvtRVcueISbce8TBlixhDeFvW6dba7FCyPUqk=;
        b=jeshrjMJfFdpJFed5fh5s8gW9N8Xg9ku38gS4AQMW9OQzeBHprch2kf02YZGJHCEGm
         4aAlUs77WsiHA+wKE08GjPcYDHpTnXmuuUPcFYpFYnwrDnA+FZ1hG4qi+k127iawZ4yG
         C8RM1KcCGmgg+6mVwmZs/0+ATVEdtQpkmsPCefGBGyL0bgKPcOFMnaM4hrzN1fAHk+DV
         TGIDWx4B9WSCZjpLty9ADYGIylOLa04dNQsJ2zXdNc8eN+EnvqNLfEnMzPOG3+nSkFBv
         QZoXutxXW9A6oSVWp46HXjzlnmqtjomltpj9ttBfRabq2ZlYmnOF02D+4LdLqJtQPBEO
         kA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPQajUXvtRVcueISbce8TBlixhDeFvW6dba7FCyPUqk=;
        b=clwsFKKR9HA41XnGgqbGG2tI5qxmZvrn8fhizSssSyGTkfRob3OTHfeMaiIf6gh2Kg
         c+OQnxIzGsDsjcUZdD9lXfBz2el+2A6Ybh4u/jYLvIjt71M8TnAnbtgL9UhENazWEJXV
         e9BW6QpL02Q+yFlK8zp+mBKC8wn8zTz4bCuup1m2QhgF8aZCSqiw+QyIhFsZhoAVe9oS
         gRGSnp0sWAWvc8NmPDzisa4x1IqvPCN/PgheCviGNZGNYXnBh2sfM5o58gyPbykD6UnA
         Epx9uRYxEcYNZLX++iTU5e3iLaQf5TKVys+uHga2RE0cpj/nvmC+LU6oqBnXTrny+/V2
         s5ow==
X-Gm-Message-State: AOAM530ReHWQtAx/8+uAnvNbSi5aMEw0vS0qt1JIgYXo7+OHcpk9ceLp
        wBPd4qUDSoYRjYjNxqpBsOxc8MmWFMNGBmPeuHXOrQ==
X-Google-Smtp-Source: ABdhPJycTkk5mnBVX8DlKnlf5rDhrhTwX7w1s7qroBNGqsDcXnTfEVVu9Dyy6wVf1DzZL2LcdPHsZ6YIYCEgjx+RneQ=
X-Received: by 2002:a19:7718:: with SMTP id s24mr10982176lfc.277.1610956591818;
 Sun, 17 Jan 2021 23:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20210117123104.27589-1-benbjiang@tencent.com>
In-Reply-To: <20210117123104.27589-1-benbjiang@tencent.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 18 Jan 2021 08:56:20 +0100
Message-ID: <CAKfTPtCPUnhiNF0SxK-=RTaq+h1D0tK-OfRsubb38V23KFEB_w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: add protection for delta of wait time
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 at 13:31, Jiang Biao <benbjiang@gmail.com> wrote:
>
> From: Jiang Biao <benbjiang@tencent.com>
>
> delta in update_stats_wait_end() might be negative, which would
> make following statistics go wrong.

Could you describe the use case that generates a negative delta ?

rq_clock is always increasing so this should not lead to a negative
value even if update_stats_wait_end/start are not called in the right
order,
This situation could happen after a migration if we forgot to call
update_stats_wait_start

>
> Add protection for delta of wait time, like what have been done in
> update_stats_enqueue_sleeper() for deltas of sleep/block time.
>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c0374c1152e0..ac950ac950bc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -917,6 +917,9 @@ update_stats_wait_end(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>         delta = rq_clock(rq_of(cfs_rq)) - schedstat_val(se->statistics.wait_start);
>
> +       if ((s64)delta < 0)
> +               delta = 0;
> +
>         if (entity_is_task(se)) {
>                 p = task_of(se);
>                 if (task_on_rq_migrating(p)) {
> --
> 2.21.0
>
