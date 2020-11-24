Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23AB2C341F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 23:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbgKXWjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 17:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731770AbgKXWjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 17:39:21 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:39:19 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id r16so256347qtn.19
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=w1pRe5qO4hWdIPtx3dddRG0JErQfQ7KqymM1k8kjXOM=;
        b=IPKQENSBOI9l1dzaztzouAOQ2RZPmPCWdc5Exvg+2aezODlRvRstW2ZKzoCKv9KMrW
         xw73D4/Vn1S/YKd8igd0T1190uBH4IixHU9we6l0ovzdUpQBIanDbcxXl3S0t25Yxy7w
         Wps9l/gOFO5Rct1h187sAArkHozznVyNTtWAi9W2s5GdXLNIRcVIYXJEihRxtMLg+5ll
         POJAWQg0cBxIkD+l2jUjaliGTK9QOJFsGIhTnszqHN0cGFO///wiO+nn8tazkpF+MYSk
         leKMjFD9e23Vt2PMZtJ/0QZjNNj6crZcj0ovH6cVIxIxGI/CIbOqBeTxrvYa8K3yDbFT
         wsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=w1pRe5qO4hWdIPtx3dddRG0JErQfQ7KqymM1k8kjXOM=;
        b=BpsrfIO2vkk2F8mh88g7QEvEJ1Fnq5ff0vi3tk2N/rmnw+MsHBZRLQRyoc6z0vistc
         aNaNlhPGre8YAgMixbRDDYJKvlbBl6kyFHxSoQtG+fzNr3RWcChqxFJ5kgK0/GrofpwP
         uEuv9Cn1MNVZROUqd05/+xpJIW6alISr860G6Gjn1ZGWurAi07Myr1aXpEt+StUgXSbo
         F9PksVP7VUrUC0Oj2k3EWuqofuiKhgfR+ktk1LVDc7O5briHmy4ePCHz1mLIp6zFKe8E
         s2rcoG6M9T3f8hnEKEjesynrFz81sWO5WBU5pOec3dNqXb9BYqjgFaAgnDiePF1Gxu8F
         UH6w==
X-Gm-Message-State: AOAM531mGYC1RAW2Ih9wQQ/DeJtBRiydRAYwdSYcHw6XdMpEF7Cpfq20
        1elZfmychAAE4MqbT0Xx45EA7nkPs69w
X-Google-Smtp-Source: ABdhPJzzGkyX5/hWD1hG6aG7RmDF0soVhdzvKb4vRuPKVqg++8G65OQuDjmfO3IqGxZVMScX8nsUMjU2dPh2
Sender: "elavila via sendgmr" <elavila@elavila.c.googlers.com>
X-Received: from elavila.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:25bb])
 (user=elavila job=sendgmr) by 2002:a05:6214:54f:: with SMTP id
 ci15mr838562qvb.49.1606257558900; Tue, 24 Nov 2020 14:39:18 -0800 (PST)
Date:   Tue, 24 Nov 2020 22:39:17 +0000
Message-Id: <20201124223917.795844-1-elavila@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Potential Issue in Tracing Ring Buffer
From:   "J. Avila" <elavila@google.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     gregkh@linuxfoundation.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the ftrace logs we've collected internally, we have found that there are
situations where time seems to go backwards; this breaks userspace tools which
expect time to always go forward in these logs. For example, in this snippet
from a db845c running a 5.10-rc4 kernel[1] (thanks for getting us the trace,
John!), we see:

      android.bg-568     [002] dN.1        26247: rcu_utilization: Start context switch
           <...>-589     [003] ....        26247: sys_enter: NR 73 (b400006f4898c520, 2, 0, 0, 0, 11)
 PowerManagerSer-578     [001] d..2        26248: sched_switch: prev_comm=PowerManagerSer prev_pid=578 prev_prio=116 prev_state=S ==> next_comm=Binder:381_2 next_pid=395 next_prio=120
      android.bg-568     [002] dN.1        26248: rcu_utilization: End context switch
           <...>-589     [003] d..1        26249: rcu_utilization: Start context switch
           <...>-589     [003] d..1        26250: rcu_utilization: End context switch
    Binder:381_2-395     [001] ....        26251: sys_exit: NR 98 = 0
      android.bg-568     [002] dN.2        26251: sched_stat_wait: comm=kworker/u16:3 pid=164 delay=0 [ns]
           <...>-589     [003] d..2        26252: sched_stat_runtime: comm=statsd.writer pid=589 runtime=611094 [ns] vruntime=24367153868 [ns]
      android.bg-568     [002] d..2        26254: sched_switch: prev_comm=android.bg prev_pid=568 prev_prio=130 prev_state=R+ ==> next_comm=kworker/u16:3 next_pid=164 next_prio=120
   kworker/u16:3-164     [002] ....        26256: workqueue_execute_start: work struct 00000000ab3fe95e: function ufshcd_clk_scaling_resume_work
    Binder:381_2-395     [001] ....        26257: sys_enter: NR 98 (b400006fb8984bf0, 89, 185c, 0, 0, ffffffff)
    Binder:381_2-395     [001] d..1        26258: rcu_utilization: Start context switch
   kworker/u16:3-164     [002] ....        26258: workqueue_execute_end: work struct 00000000ab3fe95e: function ufshcd_clk_scaling_resume_work
    Binder:381_2-395     [001] d..1        26260: rcu_utilization: End context switch
   kworker/u16:3-164     [002] d..1        26261: rcu_utilization: Start context switch
    Binder:381_2-395     [001] d..2        26262: sched_stat_runtime: comm=Binder:381_2 pid=395 runtime=100989 [ns] vruntime=40144094287 [ns]
   kworker/u16:3-164     [002] d..1        26263: rcu_utilization: End context switch
   kworker/u16:3-164     [002] d..2        26237: sched_stat_runtime: comm=kworker/u16:3 pid=164 runtime=71614 [ns] vruntime=32851170186 [ns]
   kworker/u16:3-164     [002] d..2        26240: sched_stat_wait: comm=android.bg pid=568 delay=99635 [ns]
   kworker/u16:3-164     [002] d..2        26241: sched_switch: prev_comm=kworker/u16:3 prev_pid=164 prev_prio=120 prev_state=I ==> next_comm=android.bg next_pid=568 next_prio=130

In this trace, we switched the trace clock to counter to rule out hardware
issues, but this has been seen with default settings as well. This is
consistently reproducible - we see it regularly when collecting any trace for
~60 seconds. This seems like it could be a problem in the upstream code, as this
kernel had no modifications made to the ftrace code. Is this a known problem in
upstream? Is there any additional information I could provide to verify this is
an upstream issue? Is anyone else observing this behavior, and if so, do they
happen to be working on a fix? If not, do you have any pointers on how we can
address this?

Thanks,

Avila

[1] Taken from https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline
