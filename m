Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101E62E7E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 06:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgLaFsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 00:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgLaFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 00:48:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C58C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 21:47:31 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id q22so24363500eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 21:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LTVWk/JXvWmTiCK8Ij9O2rNPgqJjcwCWf93RbT/Lmi4=;
        b=G1QRvxqPCkA8+5bW9J2YCo3cGDmAhDe7fcHFcCD87+uPDF7S2fB8F2gKJnU+rN9G+Z
         QqFJ2M7n96cx8/bHSvQW1YkVYPQasJF46kg4QVqn6DBpzwFgdTJk7Pk2eloacn3dG3te
         LIzYGBi5Caz6EQJ1Gy8ZxCCP4mZbjqNLPE5dbva72Nj9HKwCpiejVOT0fIlo86t3x6cF
         ZiIT1794tdL2nZ5tLvntox4AdD45kXQ0fJl/CrLz7uj0irmPg07CnfRMgdJveZ8RhfSl
         uKiilOZJY6lY6DBb7iZLEuDWGJf4bI55R1/FVzFXxl5YQ4aLc3lVAiFY5dQpJJoHnm/l
         wZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LTVWk/JXvWmTiCK8Ij9O2rNPgqJjcwCWf93RbT/Lmi4=;
        b=tVOqd2Cz0lvEmSOsKrUfMt1OZMC5Gc0q3kHzYCvpjtOO7HngdFeswwHzqI1SDhIdx0
         5mDZcLPyOQ1kBopmp1KWI87taJQoYNh/fWIAWISESn1MUs/Th9/5z2c16W3wxZL/Gsgy
         Oo6vnqz421MO6Fde5MnCZUPDk92QX3d93QDLWdTSl9nqJ2+tbd37w5O+F9oWZ+JaGuvf
         8O6gfgTq5mvPCSXyNOlSCVZpZpQOtwJgQdaKKyuMFnvcua8t9M61hLbQDLeWHQ3prxul
         vyxs8GyuQ6ox5JgTNQlHPjS29gjH9HtTNnej5Z8fgVWDZuzfLWEpiHjwg4rNvyE24M7e
         ju0A==
X-Gm-Message-State: AOAM532U+MhfRhAB0SYwR9lvtwzg/CVMX58x7p55TY3+wX79wI7cGhPf
        yv42p+ni7eLwIb2j7Gg1oE77M/f+t+s=
X-Google-Smtp-Source: ABdhPJzDnwkQTEPUj4+sPkkGAxR6s36ohFaV8n1ZD5mr5cOtfw56LfobC9Z7Y5cFrsyQGKnU3vgr5w==
X-Received: by 2002:a17:906:7f11:: with SMTP id d17mr51417771ejr.534.1609393650208;
        Wed, 30 Dec 2020 21:47:30 -0800 (PST)
Received: from [10.34.12.4] ([81.215.239.150])
        by smtp.gmail.com with ESMTPSA id k3sm26165653eds.87.2020.12.30.21.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 21:47:29 -0800 (PST)
Subject: Re: wg-crypt-wg0 process
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     WireGuard mailing list <wireguard@lists.zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <d56b4194-2b74-b440-c102-3b379daa8194@gmail.com>
 <CAHmME9oORiNMN6EyAWOy3Fxzo33etkQxQtQbKdPqw_fWdw9wtw@mail.gmail.com>
From:   Fatih USTA <fatihusta86@gmail.com>
Message-ID: <73b49753-da23-eef3-890b-92e85278d882@gmail.com>
Date:   Thu, 31 Dec 2020 08:47:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHmME9oORiNMN6EyAWOy3Fxzo33etkQxQtQbKdPqw_fWdw9wtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Thanks for the detailed research and explanation.That's ok for me.

Regards.

Fatih USTA

On 30.12.2020 15:39, Jason A. Donenfeld wrote:
> Hi Fatih,
>
> Thanks for the report and the detailed test case. From what I can see,
> this behavior presents itself both with the explicit ip link del and
> without. When running with debugging enabled, I can see this in dmesg:
>
> [558758.361056] wireguard: wg0: Keypair 244 destroyed for peer 21
> [558758.546649] wireguard: wg0: Peer 21 (10.150.150.2:51820) destroyed
> [558758.563317] wireguard: wg0: Interface destroyed
> [558758.567803] wireguard: wg0: Keypair 243 destroyed for peer 22
> [558758.733287] wireguard: wg0: Peer 22 (10.150.150.1:51820) destroyed
> [558758.749991] wireguard: wg0: Interface destroyed
>
> The fact that I see "Interface destroyed" for both interfaces means
> that wg_destruct() is being called, which includes these calls:
>
>          destroy_workqueue(wg->handshake_receive_wq);
>          destroy_workqueue(wg->handshake_send_wq);
>          destroy_workqueue(wg->packet_crypt_wq);
>
> In doing so, the output of ps changes from:
>
> $ ps aux|grep wg0
> root      200479  0.0  0.0      0     0 ?        I    13:06   0:00
> [kworker/0:2-wg-crypt-wg0]
> root      201226  0.0  0.0      0     0 ?        I    13:08   0:00
> [kworker/1:4-wg-crypt-wg0]
> root      201476  0.0  0.0      0     0 ?        I<   13:11   0:00
> [wg-crypt-wg0]
> root      201484  0.0  0.0      0     0 ?        I<   13:11   0:00
> [wg-crypt-wg0]
>
> to:
>
> $ ps aux|grep wg0
> root      200479  0.0  0.0      0     0 ?        I    13:06   0:00
> [kworker/0:2-wg-crypt-wg0]
> root      201226  0.0  0.0      0     0 ?        I    13:08   0:00
> [kworker/1:4-wg-crypt-wg0]
>
> What I suspect is happening is that destroying the workqueue does not
> actually destroy the kthreads that they were using, so that they can
> be reused (and eventually relabeled) by other drivers. Looking at the
> stack of those indicates this is probably the case:
>
> $ cat /proc/200479/stack
> [<0>] worker_thread+0xba/0x3c0
> [<0>] kthread+0x114/0x130
> [<0>] ret_from_fork+0x1f/0x30
>
> So it's just hanging out there idle waiting to be scheduled by
> something new. In fact, while I was writing this email, that worker
> already seems to have been reclaimed by another driver:
>
> $ cat /proc/200479/comm
> kworker/0:2-events
>
> Now it's called "events".
>
> This is happening because the kthread isn't actually destroyed, and
> task->comm is being hijacked. In proc_task_name we have:
>
>          if (p->flags & PF_WQ_WORKER)
>                 wq_worker_comm(tcomm, sizeof(tcomm), p);
>         else
>                 __get_task_comm(tcomm, sizeof(tcomm), p);
>
> That top condition holds for workqueue workers, and wq_worker_comm
> winds up scnprintf'ing the current worker description in there:
>
>                          /*
>                          * ->desc tracks information (wq name or
>                          * set_worker_desc()) for the latest execution.  If
>                          * current, prepend '+', otherwise '-'.
>                          */
>                         if (worker->desc[0] != '\0') {
>                                 if (worker->current_work)
>                                         scnprintf(buf + off, size - off, "+%s",
>                                                   worker->desc);
>                                 else
>                                         scnprintf(buf + off, size - off, "-%s",
>                                                   worker->desc);
>
> But worker->desc isn't set until process_one_work is called:
>
>          /*
>          * Record wq name for cmdline and debug reporting, may get
>          * overridden through set_worker_desc().
>          */
>         strscpy(worker->desc, pwq->wq->name, WORKER_DESC_LEN);
>
> And it's never unset after the work is done and it's waiting idle in
> worker_thread for the scheduler to reschedule it and eventually call
> process_one_work on a new work unit.
>
> It would be easy to just null out that string after the work is done
> with something like:
>
>          worker->current_func(work);
>          worker->desc[0] = '\0';
>
> But I guess this has never sufficiently bothered anyone before. I
> suppose I could submit a patch and see how it's received. But it also
> looks like the scnprintf above in wq_worker_comm distinguishes these
> cases anyway. If there's a + it means that the work is active and if
> there's a - it means that it's an old leftover thread. So maybe this
> is fine as-is?
>
> Jason
