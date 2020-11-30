Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8B42C7E00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgK3GD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3GD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:03:29 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5266DC0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 22:02:49 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k5so5895979plt.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 22:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pJv7VvrnTFE2e/S4EEGaqG2NxGxQS8LiH4rC85el3jU=;
        b=rcsj0TnPgBcz5X3llmMor76Npwj6U7VAOSot2BN1gjzY0Um/rI5pNgxOFYmq+U6J1Z
         bHlt4WsMMVkPx8xhjwGZukiDd9I9ZN9upU6F3plfCyBVF/DSCaaVfqqKb0SFI3dq4KNz
         9kF77OmpfcvlvI9mE9wGXtQd7o7l9fdMvQPCsIONkbYHGitNaEKXaMvwv09JO4u+j7xF
         pcQxJzwhj4PWYwpp5TBEilU3N3NHbQ5nGVymh/FSr8zKIOg8wtgenka4r4sRumvk4U22
         aTeBOmLvpjYrHUav9/WhDvkjxrUPjlGXF8/naGaL7UK92Cgwua6Zz8sTjuUsuHDu30Hj
         tiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pJv7VvrnTFE2e/S4EEGaqG2NxGxQS8LiH4rC85el3jU=;
        b=WwF+NSh17FQob7IM8b70hYakCxdTx5hR0H4wW+Df1tgPwD7nlySn+G+LcKpMq8g53r
         vWXM2yJ8I9GkmwDoVIDDG7hlEc/kP4HxOdKPbg8Jnm5EI9l8Th4CWfgSYR2AjDcGiEOx
         8Huptou0krFnksxsIVxz9nd3f6sq/LkWC0a0Ouvd7rMPpQ84YQUQX3uw0k+PVgA1u1ik
         8NMratFy9UyzuaWDmG5nNwss8ciGrGJLV4Vz0yXVknsO6qUAk+hZKB3CnFvBRsM6aMz9
         vPLbBkCHQTIrKT7GanCzgkcIVWpCWBoJ2s7Oi93f0I2SOKlTE0udP18i0i1I9eiOgHFy
         W9jA==
X-Gm-Message-State: AOAM53304aAl33Az3B5iKld8uGapSCpdsm6SmOczv66IDEHdbEsF0wiK
        zVKX1gSpRs1F7P1bcmyFKos=
X-Google-Smtp-Source: ABdhPJxE42VPjFJEg494drZWCjVskrdguINJ0R8+1cDpj+Dfr2POLCZbOz/JeNJbv44QS0F6SiN5Ng==
X-Received: by 2002:a17:90b:a14:: with SMTP id gg20mr25042169pjb.46.1606716168930;
        Sun, 29 Nov 2020 22:02:48 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id p1sm2249333pfb.208.2020.11.29.22.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 22:02:48 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:02:45 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <X8SLBcONiM5bQt4x@jagdpanzerIV.localdomain>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <X8ElwBh9tw+OLHF+@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8ElwBh9tw+OLHF+@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/27 17:13), Petr Mladek wrote:
> 
> + Move clear_warn_once from debugfs to a location that is always
>   available. For example, into /proc

Or a printk module param, which user-space can write to from crontab?
Hmm, but this has potential of becoming another /proc/sys/vm/drop_caches
though.

	-ss
