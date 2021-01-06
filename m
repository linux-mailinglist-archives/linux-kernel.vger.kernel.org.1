Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6F22EBC35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbhAFKOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbhAFKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:14:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA836C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:14:20 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v19so1890651pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6FCPGIgiMP2JlFlD/sisq6pNz6DOtP401SwlrOBLx1w=;
        b=pGiUOQvRkeoaT3KiHt9LiZSDjIEc9X4UYqPBGJxcZAvLkW4TADWSMvKCVzHtiLoYD6
         fZ91jZmN6bbNoTDs37xt5AtFJ63p31Av7XeFPQdwHDAeTk8HgN6VE65SvUD/ENaDsGCC
         s55geDqL9Uhx1Ayl09IzRChRkgDGpG9hcn4L8/xIMISXYkufrQV9xDkbd+MXt8A1J+rM
         1Ro/B8dOO9B77WzOhlKamgRtlOsdsSgCoGa77YXCxlcrb3moXONw49SnK9Lp3QT3HpGx
         FhUlkoVqWcIRa/EGo45x46zugBkadSN1oauKi1PrZG5Wf/RhWqE0aQTE5N1HQU83zzj1
         czgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6FCPGIgiMP2JlFlD/sisq6pNz6DOtP401SwlrOBLx1w=;
        b=qlTUrQS7MO8NAQZ312By0CmE8V1+DCSl+YUJQm/lTb/3eEo5s2HDy0ZZYTZGs/vYtk
         Tgz4LTYO2KIDs2mf4z8wjRpyxpdv5murZxPQtihlXqB/YxVWQre6KH2Viy6iSoIiDSk7
         GvP7mKcB7oa+qb/f75ulbsdJkK5UerlWGwKTKQx+L3tlmsFlVQxsHTJR3dVc89kqs7H5
         miR1Il1VhHcqAkj7w3keHrAtGwWcwSEGCicprbnvdzJ7SOoL7EItMFwhx+tpejhOPMxv
         Qm8HvhH6eL1ZOvtvPUFTD4d15HhXam1TYlOXMbG4XXWjVQPUR4bqwza8Exzvdr7RpvG/
         GMCg==
X-Gm-Message-State: AOAM532lecjKaTVEqBYQxmKEp9vhXiUCu7zCqd0RRVVi7DGK1giNKhSA
        RoXhi9IjOQixtulaA5hD0g4=
X-Google-Smtp-Source: ABdhPJwh1Ge33grQL038Fy2jYHWAIu1ASukXxx4eTW+wYxxJFRp5WdXq63KIyjwniMBr9MCNSllLmQ==
X-Received: by 2002:a63:31ce:: with SMTP id x197mr3742173pgx.262.1609928060435;
        Wed, 06 Jan 2021 02:14:20 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 3sm2084537pfv.92.2021.01.06.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:14:19 -0800 (PST)
Date:   Wed, 6 Jan 2021 19:14:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     "chenzhen (R)" <chenzhen105@huawei.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, lukas@wunner.de,
        Sergey.Semin@baikalelectronics.ru, vigneshr@ti.com,
        rose.chen@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/serial/8250: make touch watchdog settable
Message-ID: <X/WNeBikJYm8ncj6@jagdpanzerIV.localdomain>
References: <20210106064641.2621838-1-chenzhen105@huawei.com>
 <X/VnrvmN4k8UrXad@jagdpanzerIV.localdomain>
 <db5f51df-3a3e-41a6-00e3-234575c07ec6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db5f51df-3a3e-41a6-00e3-234575c07ec6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/06 17:28), chenzhen (R) wrote:
> On 21/1/6 15:33, Sergey Senozhatsky wrote:
> > On (21/01/06 14:46), chenzhen wrote:
> >> Since 54f19b4a6(tty/serial/8250: Touch NMI watchdog in wait_for_xmitr), serial8250
> >> will always touch watchdog in write and wait_for_xmitr. However, serial8250 may
> >> become low speed thus take a long time to print. In this process, nmi and soft
> >> watchdog on current CPU will be invalid.
> >>
> >> To resolve this problem, add a cmdline option "tty_watchdog_enable" to control
> >> the touchdog in serial8250.
> > Sorry, I don't understand - what does this fix?
> >
> > 	-ss
> > .
> 
> It fixes that if serial8250 is low speed on some machine, when it
> writes for a long time, NMI/softlockup watchdog will never bark and
> potential rlock will not be detected. So an option to control the
> touchdog in serial8250 may help.

This is the intention. Suppose that serial8250 triggers the lockup
watchdog, how are you going to fix it? If you need to write NNNNN
bytes to the slow 8250 port then there is nothing you can do about
it; triggering watchdog from the 8250 write path is certainly not
going to help. If you have an excessive number of printk()-s then
reduce the number of spurious printk()-s (ratelimit, etc).

	-ss
