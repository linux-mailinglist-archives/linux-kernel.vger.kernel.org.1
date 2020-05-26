Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74619FB34
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 19:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgDFRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 13:18:47 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:41363 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDFRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:18:47 -0400
Received: by mail-pf1-f176.google.com with SMTP id a24so7859055pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jQ7wuQYMHaQVCn9LchHaEkgqYpnoZVng6rOoAsTh9Cc=;
        b=ZKEhpMG/upRDhp3GHIZt5gCyoWSvcY+BsBj1x5wDuZuOKR6vBd2aOjI9rvXWFSXI8q
         +rBm2wiDSx9zbQSu1OGSIZXoHq+QjaylFSu8+mJlsfl7SL+NbqAnbWOkE8y8aQtceW8c
         CR3WgK9H7jvA+R7F9dQneLneOv4eEjeXPN0Vad/BXtKP/xqz7pVyP72FY6Yro2RZAs9d
         4VZ7gZM5jlwTH23AXISqGU9cCFgoNMZcR6GHAb5Kb2fLmMUBvtWer7PDsDyrvrDrEi+T
         je9ihQEtHmJzAge/j9G2QHymxcqenuJYuVgpDI7MVNl9mjrYPg5aqe0SpL3dA2aLLln1
         0Aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jQ7wuQYMHaQVCn9LchHaEkgqYpnoZVng6rOoAsTh9Cc=;
        b=CzIFNuznAgFJbJJgOwsmpHT5k8lr+uvoftYPnF0hrQg25/WyWKn8+4cwu3fr9rDvWa
         NJTjHJtGmGKx/NCxKOUQxPvD1qvs1Dv5U6OC8YkC/aSdFuTuPpzFFws9wDk0JXgEUSse
         dvudrYILMvAMrrnCw0YqgnLe2unEHG+2TIh97AkZFj595+4RA+U/gf2WgPQ0tZAUmQs7
         jaaZ94Vn0NBjAe4rzx6BBcOU1WXl5w9Bhrl+hXZ2ZY/92SC5zX9xrIoXmHXqDqx6phKZ
         uGgwTqFhEtjmGyS6jsbjcH8eWtYw7mL9HkV8J3Rbb9rCk1KcEmceqDJKToCjBqEk7+cK
         garw==
X-Gm-Message-State: AGi0PuYTXr0StWpiPjKZKknBQz6H/2bNhkMdOL0qbbixsHeNY1yS2Bt9
        0EkMrC7ZUU1wucnXn7QRR76xbg==
X-Google-Smtp-Source: APiQypK1JZ1nn/eL3UlA6iCL0x97ec19UzaTBAGbpW5pRjNVVRRI4p+QVV+ElIpmuLGiI9Fakj+gjA==
X-Received: by 2002:aa7:8750:: with SMTP id g16mr461126pfo.83.1586193524779;
        Mon, 06 Apr 2020 10:18:44 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x71sm11812328pfd.129.2020.04.06.10.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:18:44 -0700 (PDT)
Subject: Re: /proc/sys/user/max_time_namespaces?
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrey Vagin <avagin@openvz.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>
References: <0fbcb669-33a8-9730-f7fa-639707532611@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <027226a2-f77c-0c1c-ee70-54a6c9194437@arista.com>
Date:   Mon, 6 Apr 2020 18:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0fbcb669-33a8-9730-f7fa-639707532611@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 4/3/20 1:21 PM, Michael Kerrisk (man-pages) wrote:
> Dmitry, Andrei
> 
> [Andrei, I mistyped your openvz address in an email of a few minutes
> ago ("[PATCH] ns: Fix time_for_children symlink"). You were CCed
> on your gmail address though.]
> 
> In the namespaces(7) manual page there is documentation for 
> these files:
> 
> $ ls -1 /proc/sys/user/*namespaces
> /proc/sys/user/max_cgroup_namespaces
> /proc/sys/user/max_ipc_namespaces
> /proc/sys/user/max_mnt_namespaces
> /proc/sys/user/max_net_namespaces
> /proc/sys/user/max_pid_namespaces
> /proc/sys/user/max_user_namespaces
> /proc/sys/user/max_uts_namespaces
> 
> These files allow one to limit on the number of namespaces
> of each type.
> 
> However, there is no /proc/sys/user/max_time_namespaces file.
> Was this deliberate, or an oversight?

Thanks a lot for noticing this!
Yes, it's an oversight and examining the code I can see that it's an
actual user-visible regression: max_inotify_instances controls time
namespaces limit.

I've just sent a patch to fix the issue, Cc'ing @stable:
https://lore.kernel.org/linux-api/20200406171342.128733-1-dima@arista.com/

Thanks again,
          Dmitry
