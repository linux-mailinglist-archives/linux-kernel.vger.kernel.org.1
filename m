Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4F2FCC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbhATHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729859AbhATHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611129150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Obl4hVrOzCc41rjsElBS4MYaL9yxoBBFhMxhO9jt+S8=;
        b=jP/Flsznm9CHuSglHJwW7dWybwG4TA5PBNPz5eJSsbx9r0Ej5pshP4ekx5LlCuZpr954hv
        bK2Oklv1zLxMOlFK1sDoxzV3LTvLtIx2VnHGcDyslctVEw8zFVnyzjH7j73euzbjMYZ/Mi
        HqymEXblhOqc7hUoWWpVRdUdQAXz7ZM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-av2J8OphPQCh3wQus-J-Lg-1; Wed, 20 Jan 2021 02:52:28 -0500
X-MC-Unique: av2J8OphPQCh3wQus-J-Lg-1
Received: by mail-ed1-f69.google.com with SMTP id ck25so6806456edb.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 23:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Obl4hVrOzCc41rjsElBS4MYaL9yxoBBFhMxhO9jt+S8=;
        b=ZxcSnUg/Q1qtkdG9Q3auTmTPA3Rnm9EyJP6SSlrAl1ZJyfwJP3hzObq9md96rgLL3h
         edqgo9YZWd4j1T+ECZ7SpeD2Nsoj07qBbeY+jvg9y6Kakcf9Cev2LdR40qrG57MJeeTm
         n4zgjO+HDiZpQ6J56TcodqGGC3Way1+smHN6XKW0D+iY+BYavOs2o2rR6JZ+7b34rJTC
         8Qj4vdhUrQCtrzhbdtAM8y0zxUth4+lA7iDiPnX8B16P2qMPW4XshlvkQFvwzKDTsQXa
         X1zbVvQRc0256JN7BQSw6f897gJ4EnyV4DIUXWAmhNKGsCRzOViHFHq/wLW+pQkSnEuI
         N5lQ==
X-Gm-Message-State: AOAM532wITafr4glRsvSJbEzrueVMAcPJFtYuUpW2sQnDhg1cWOmCbZh
        6fT3QMIWmkh7k1+CXmb5syQuoM7TYlifi43jwzqd3ke990Lls+P9so4RL8mygtNmGdLGa8KyPYN
        X/X6Mfj9bMpM4X0+jOIarTh+n
X-Received: by 2002:a17:906:e43:: with SMTP id q3mr5114732eji.493.1611129147632;
        Tue, 19 Jan 2021 23:52:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN/M3Bq/jSmASqFCtK9VpGoLfwDFJt5BXL9BQV3K/IZ56ZdYAFmWapUXhBnMQ4GxIT6O0rLg==
X-Received: by 2002:a17:906:e43:: with SMTP id q3mr5114723eji.493.1611129147459;
        Tue, 19 Jan 2021 23:52:27 -0800 (PST)
Received: from x1.bristot.me (host-79-46-192-171.retail.telecomitalia.it. [79.46.192.171])
        by smtp.gmail.com with ESMTPSA id p89sm639178edb.61.2021.01.19.23.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 23:52:26 -0800 (PST)
Subject: Re: [PATCH] sched/deadline: Reduce rq lock contention in
 dl_add_task_root_domain()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20210119083542.19856-1-dietmar.eggemann@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <eae452b8-ea5c-8787-8292-e3d7d5f7a1f4@redhat.com>
Date:   Wed, 20 Jan 2021 08:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210119083542.19856-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 9:35 AM, Dietmar Eggemann wrote:
> dl_add_task_root_domain() is called during sched domain rebuild:
> 
>   rebuild_sched_domains_locked()
>     partition_and_rebuild_sched_domains()
>       rebuild_root_domains()
>          for all top_cpuset descendants:
>            update_tasks_root_domain()
>              for all tasks of cpuset:
>                dl_add_task_root_domain()
> 
> Change it so that only the task pi lock is taken to check if the task
> has a SCHED_DEADLINE (DL) policy. In case that p is a DL task take the
> rq lock as well to be able to safely de-reference root domain's DL
> bandwidth structure.
> 
> Most of the tasks will have another policy (namely SCHED_NORMAL) and
> can now bail without taking the rq lock.
> 
> One thing to note here: Even in case that there aren't any DL user
> tasks, a slow frequency switching system with cpufreq gov schedutil has
> a DL task (sugov) per frequency domain running which participates in DL
> bandwidth management.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

