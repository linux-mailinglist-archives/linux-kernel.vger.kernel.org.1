Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEE30125D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 03:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAWCpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 21:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbhAWCp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 21:45:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:44:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u4so5032591pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 18:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tx6G0NyYyCminNnw0e7lSv6Cnqeg1L0hM1R/TrC8Dl4=;
        b=GO51j4Sh7bYbndACdhS3HwilVNtRmj1wnZi6UzYpufB8a9wxiITOPQxw8soyqydkV7
         q314yxy6t3MNDXJR714uGQ8YfhD+pWCNQ+ESIxrZ841L93gNA141IaUR36DsCSfTkzvA
         I5XzKhL6jxhevdH5MulJEqOlorHEAbayHQXxbkdnsn3ywZOjkMUDXocbVUvYhfniUnGf
         kT3NozowHK0BqNcmB9ahG/v77hm2IWc2z7DpiBpWsjtdAQYfcyukQwGu4gekSNoGIPQr
         HRboP0qHe+nlCZ8kUoREoTtAun/rTW8F1b6Zs/14zYSzyJGsQExDdmRMxuubHwolhY2J
         Aw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tx6G0NyYyCminNnw0e7lSv6Cnqeg1L0hM1R/TrC8Dl4=;
        b=QtM7p+1edxKgILzNJCaTJdOjOQYVmqiEtQMka9b7zP0oqq+G1f+kdB+KE6QaRt1qKZ
         syc2p7JAeOTaNRpVUlH8GUpO8yWsIo+ft//Wq0F8WslG4YqebllmAZRsqCZ3g0h53E2+
         HzgSFcDiSxerRzJcXbZwOUen+sRwrerEfGTTMfiijsTyeieQiIx8p53YadW7AJvk7Ehh
         RXeaX8PxmZ+jGIb/bAY00AtLgs3sa1cJ0z7HDHUHUPaRiD7lIfB0I0frU4mNG5C0CwPZ
         c4ZzRfClFVNnu6+0y0clHtPchQpn8fTCEtMCxpDRAJSnDIVVKz9i2wzvIgIDuU+kc0nX
         GiNw==
X-Gm-Message-State: AOAM530GHH+XNfdxGBJQ/2gS7xPE34njiTuU9qGBVd6oZr0Ocynratri
        lj48T0VmJ+VApdVKG093KYA=
X-Google-Smtp-Source: ABdhPJzezvT+yeAFenGkNeAxFUNj0gA1wyHKfu4SG4+50UQtQeY/HaRtsG+3IJY8/9vO6TAx14sBew==
X-Received: by 2002:a17:902:a711:b029:dc:2f27:c67f with SMTP id w17-20020a170902a711b02900dc2f27c67fmr8077924plq.74.1611369885980;
        Fri, 22 Jan 2021 18:44:45 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a131sm10441202pfd.171.2021.01.22.18.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 18:44:44 -0800 (PST)
Date:   Sat, 23 Jan 2021 11:44:42 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
Message-ID: <YAuNmjUDhNbiYn0b@jagdpanzerIV.localdomain>
References: <20210122081311.GA12834@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122081311.GA12834@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/22 16:13), kernel test robot wrote:
[..]
> 
> +------------------------------------------------+------------+------------+
> |                                                | 6b916706f8 | b031a684bf |
> +------------------------------------------------+------------+------------+
> | boot_successes                                 | 66         | 18         |
> | boot_failures                                  | 2          | 26         |
> | INFO:rcu_sched_detected_stalls_on_CPUs/tasks   | 1          |            |
> | RIP:enqueue_hrtimer                            | 1          |            |
> | RIP:__memset                                   | 1          |            |
> | RIP:clear_page_rep                             | 2          | 2          |
> | BUG:kernel_hang_in_boot_stage                  | 2          |            |
> | INFO:rcu_sched_self-detected_stall_on_CPU      | 1          | 4          |
> | INFO:rcu_tasks_detected_stalls_on_tasks        | 0          | 22         |
> | RIP:kernel_init_free_pages                     | 0          | 1          |
> | IP-Config:Auto-configuration_of_network_failed | 0          | 3          |
> | RIP:zone_page_state                            | 0          | 1          |
> +------------------------------------------------+------------+------------+


A side note:

> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> # CONFIG_PRINTK_CALLER is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4


Could you please keep CONFIG_PRINTK_CALLER enabled at all times?

	-ss
