Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70058294422
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409675AbgJTU5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409666AbgJTU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:57:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78D1C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:57:23 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id q4so2036300plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/RGCU7ap3HF2iad3K5ifvAbm1VKVest4nIA1lp5zRUg=;
        b=Nsjih2BM6k0hwoOiuAl3xXh/LkIZ7E4F8ELN3CaIOLjDRipQgydKDAmcdqKm/0OuK5
         1X7kNdlMXyZzBjPc95TVgTMEbEM/i1tsUZl11c4KztvaFoJ1WFyasl3VYY2WOvuTw/kW
         DOt0dZLdJoW60lzdqjr5XiepVyc2SEIKbf9GwmOqFICJmRz85qR65cPrWrQ5JNXlPucT
         VOzMIl074h83cN+8mpD8Kq8nnpmLdK+BZtgssiUs99c+B4q62cOwtYG1cUL5Pxhr6GEH
         34nIishRuq9r2LJQ+9OvEwkmXDdwPT/RxLxQA6eStBhWci1bKfidJ0AvQPzcYTjVHEHT
         4ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/RGCU7ap3HF2iad3K5ifvAbm1VKVest4nIA1lp5zRUg=;
        b=i4YoHckC8pzlxNjv5V69mQM+n8v2O0i0ZEIEWGv4DJLTmGkU6elT6PCKt6PsksE91M
         /hDia7PM5K/QyFYPZUuD/7zU6SoYP8boq3C+EY/9n6nNZEhvTmrypGdpj7kj89GvPg9s
         IpL7hzS5WRHCdtVJqEd0ePNCLTNM8xW0GxSvoKjBIFtjSh0nFWAEEmY+3yp6GqJGfUor
         3A3SMhQtJi2+qQzMqat1jgRegcBD05LQevZB+1HALLGY85fKPWOsarGi6BFOD/Ov6HQ1
         KDBdKc1G4uZKT535cXiVbrD37NQ1CZ83T6tS42OhRJrXVfgBrUzSOjiTbQ1fqUBlP61u
         c4EQ==
X-Gm-Message-State: AOAM531F3dd4OoD27Nw80DGGEUGB3mE2eAMIGWdriUZ6psEK1Gx7oNr3
        kY+i5e7X6d0MtaFGhDTWUQk6Zx4=
X-Google-Smtp-Source: ABdhPJwiY6L7c4ZSUDvGKzhoFwXOunuGUJKPBV8l4cAguKrfhX9IOnUtvrjXf5hs8iA+oqQZT74ruBU=
Sender: "xii via sendgmr" <xii@hvdc.svl.corp.google.com>
X-Received: from hvdc.svl.corp.google.com ([2620:15c:2cd:202:cad3:ffff:feb5:feb4])
 (user=xii job=sendgmr) by 2002:a17:90a:109:: with SMTP id b9mr92280pjb.35.1603227443065;
 Tue, 20 Oct 2020 13:57:23 -0700 (PDT)
Date:   Tue, 20 Oct 2020 13:57:03 -0700
Message-Id: <20201020205704.1741543-1-xii@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 0/1] Touch kernel watchdog with sched count
From:   Xi Wang <xii@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Xi Wang <xii@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of kernel watchdog is to test whether scheduler can
still schedule tasks on a cpu. In order to reduce latency / jitter
from periodically invoking watchdog reset in thread context, we can
simply test if pick_next_task can run. This is done by forcing resched
and checking rq->sched_count. Compared to actually resetting watchdog
from cpu stop / migration threads, we lose coverage on: a migration
thread actually get picked and we actually context switch to the
migration thread. These steps are unlikely to silently fail. The
change would provide nearly the same level of protection with less
overhead.

With this patch we can still switch back to the old method with the
boot option watchdog_touch_with_thread. However code for the old
method can be completely removed in the future.


v2:
 - Use sched_count instead of having sched calling into watchdog code
 - Remove the sysctl and add a boot option, which can be removed later
 - Changed the subject line
  


Xi Wang (1):
  sched: watchdog: Touch kernel watchdog with sched count

 include/linux/sched.h |  4 ++++
 kernel/sched/core.c   | 23 ++++++++++++++++++++--
 kernel/sched/sched.h  |  6 +++++-
 kernel/watchdog.c     | 44 +++++++++++++++++++++++++++++++++++++------
 4 files changed, 68 insertions(+), 9 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

