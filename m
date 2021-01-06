Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4E2EC4B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbhAFUTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbhAFUT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:19:28 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8211C061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 12:18:47 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i6so4229578otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iJJgoSbyLyAY5ybGUsqGtrthU9HgytjNnp54LxffTUQ=;
        b=n18YKI9jp+HXb5AmIc1F8DYthoi2MZWrs68850q3/7Y1oC2mbTRPxOlZKOAueyliX7
         1I5V8B8dipw2MlR3de+e6ly9CXjr/nMkUgI5+KEQmPS0qGpgAyWM7/kTtnpHJdkdVZrS
         9HQeY5ROuADlcLJa7VXZC1o9PoWzHpZ8czJhuXEWT6FmoTC4ZLuGma8j0KowQGnJsgRx
         oKHoUWktsvyUZa+6guYPI+pf0knN1C44eNG0sAXIdn7OhDq0xgRjKAJcc4vYqmVt3y6b
         WU8dm/lEz2rKL+6FwmdiJYILhZKWEfV9Jqwim4FFwyOBhyxSN0FQYDKe0YkaqtSW8tS8
         pm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iJJgoSbyLyAY5ybGUsqGtrthU9HgytjNnp54LxffTUQ=;
        b=UzX/0GHa+P7dqm7Y9g15NRHNa0YgkAePpzEJ4lm6ClUh24ZNeehK08cdUT8Qpiqewz
         /qmYhvgPwLijPMxkJoRMqflwMVrUDPzaYN2XezVV+9uGe9k8d3qvoMYFUUSDHGVhll1E
         n00tkkKKKiEXaCx4BfKx/M7zULzEYSh7fS6phy7NO4hoOjWcqoJBI6FOOCaYAFN2Gbqi
         Z/KBsoN9BnJGuPBlgxnFfJ/EHOTwYPiiPK4kRQRn+IzQpBr0QI9Lw7jUQbSaPso+dHiO
         zj+LmAqCOxwSZDvhzgUjaTptb78OleH9YYUFkGVMhAf0K6zGkcxoTFSNO3QplEDpYmvo
         AQIg==
X-Gm-Message-State: AOAM531Dc3EyHsulUKLLydbWnCV8zpiygS1WLqNQBtw3y8T4qC/ECc9D
        Z+KySganM4bKuTVfPFPtLPeP0A==
X-Google-Smtp-Source: ABdhPJwDmJwX/5sniqT/j0TdQ+RiDKq/oekQVIbn0+XlvLry2PSCbGsfXnjr0wqRhpON+IiPk/nRpA==
X-Received: by 2002:a05:6830:20c2:: with SMTP id z2mr4305329otq.322.1609964327126;
        Wed, 06 Jan 2021 12:18:47 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y84sm820819oig.36.2021.01.06.12.18.46
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2021 12:18:46 -0800 (PST)
Date:   Wed, 6 Jan 2021 12:18:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrea Arcangeli <aarcange@redhat.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
In-Reply-To: <X/YY+mjpq15nmryI@redhat.com>
Message-ID: <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com> <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com> <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com> <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org> <X/YY+mjpq15nmryI@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021, Andrea Arcangeli wrote:
> 
> I'd be surprised if the kernel can boot with BUG_ON() defined as "do
> {}while(0)" so I guess it doesn't make any difference.

I had been afraid of that too, when CONFIG_BUG is not set:
but I think it's actually "if (cond) do {} while (0)".
