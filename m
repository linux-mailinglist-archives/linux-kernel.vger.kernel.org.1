Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2F01E8954
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgE2U5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 16:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2U5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:57:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF538C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:57:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 131so411404pfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I7qnNA5u9E5uUI4wgJTYPF3w5RIGour1uu+SHGFMyR8=;
        b=gfXXQEi3F7lEfw5XKdq2Ycm9PadJF4X/S7AhcwYM+o/ov5XAVNTvOAxxNxuiiqRcr4
         f0RINi1vS7mX3nY7iuayHV9J5J1GteK5ItC3EZCzpRyMA2YKdyrNaSnjT6UYsfCtMmqz
         aBTfEJ+euvG/trQccK27Whgk4mDrI+eS1srj6tXIm0gdMZquCwJZMNXTpI/47krBgxAV
         Odioa/cHGqt8pkwcqYiQsJKelIi4ECMKhhnzn7WtFE5ZhQqRjkJLfrv8eY3xRd/F4Wqf
         onyDgUxbp5x2CM3q48lwtdr+A5DUM52I4Kv8gVbjBz0tN/ZdJtUEyUFreppnoFTRrc+o
         rrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=I7qnNA5u9E5uUI4wgJTYPF3w5RIGour1uu+SHGFMyR8=;
        b=Y6eq56eTgbx43h/9bEl0l1sLFWkqUitP9jBv3t795J6GYdIm5KViFBuxw4wxG8eSxk
         9t/v/q6HlJ7x0d/Darl+auxLjHxmV+a5w7o9hK+8bQN4RT4/RiuEoAoTHTvcXiw8391m
         0gfdKlp9vYPaKNuPhJn2ZL5sODr6M7iaD2NvYfgGFDTGJ+ocda9LbJj4gHzLli7Bgh/R
         Q8weDUaqnQ7rWzoT3Sk1yQ2ub5mw7RV81HlM3QgLeimOPDnH/IC7dIokXe2NfI5qN0ru
         5lDwWq3ASIDr2O4Vj4PtJ6NvQfGlu0AfvBdb/yJaUuM2borTs9GpvIy9JZK+IFs3hHdY
         4q7g==
X-Gm-Message-State: AOAM531msF0UM+ytB9pn1eocVRmnkEXqERT8DeIv/H4dYLuTszZyu2mw
        7ySECvELOdAW4M26f+lUx9I=
X-Google-Smtp-Source: ABdhPJw1Dwa3iM8rakrEA/h6dkTu4BNPXddAbGk7dpXZKcxwWGbt08OdyjV0WXlLADocbaTiUVUU/g==
X-Received: by 2002:a63:f00d:: with SMTP id k13mr10154347pgh.263.1590785863245;
        Fri, 29 May 2020 13:57:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm6193916pfd.185.2020.05.29.13.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:57:42 -0700 (PDT)
Date:   Fri, 29 May 2020 13:57:40 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: Use local lock to protect per-CPU data
Message-ID: <20200529205740.GD86436@google.com>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
 <20200527201119.1692513-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527201119.1692513-8-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:11:19PM +0200, Sebastian Andrzej Siewior wrote:
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The zcomp driver uses per-CPU compression. The per-CPU data pointer is
> acquired with get_cpu_ptr() which implicitly disables preemption.
> It allocates memory inside the preempt disabled region which conflicts
> with the PREEMPT_RT semantics.
> 
> Replace the implicit preemption control with an explicit local lock.
> This allows RT kernels to substitute it with a real per CPU lock, which
> serializes the access but keeps the code section preemptible. On non RT
> kernels this maps to preempt_disable() as before, i.e. no functional
> change.
> 
> [bigeasy: Use local_lock(), description, drop reordering]
> 
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Minchan Kim <minchan@kernel.org>
