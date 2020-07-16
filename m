Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0032F2226B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgGPPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 11:18:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39659 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGPPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:18:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5so7456781wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0H5Bd3kw4GjkewKQ3kKww4Zq5793dgkMaSPrkSNreRc=;
        b=Xyz0se5pWWf/dvBst211JV/+g9RNAxyvN/ePpbifxlgA6P5Hokdzka3Cb6dWG2bUgM
         erFD0Cp0/WFnRb0aQ9VJ/posGVI70L/cEF5ShvAI5Z5i/7H/xNLbHWi6oIS1ySvr1dbx
         C+unFfm7Zs385mNZ0oMGdSYkSvLgbfXNqsOdTlKhu45bVV5s0zAGX/OMhMoiVsfVo6oW
         oxreM0SxWTQnJFtGbrSqI0Pi79Zc57mfMRmK2NMEcLZCukm59WISfFMGz4SYg24h7ls1
         S4zJHdKyo+DOPH+RGSMB0c2tLHXepz+t4F8C2eTXL2F7s7iDu0OhuOyPm4KUevzBB65Z
         HC2Q==
X-Gm-Message-State: AOAM531qv2Ei4Y4WBFH6ef1OTyEAhkMhbRrPpZSQ3zUIzLrQZnENh/UQ
        MB4nvdqgJedOz+ljQKbXeQM=
X-Google-Smtp-Source: ABdhPJzWAPL7nRYRrf93ZSHHh8l/vk69TykNKhpQHF5kPWiSF8g7Pw9z/3d4LZQMoR+WzcGZhBSj6Q==
X-Received: by 2002:adf:8521:: with SMTP id 30mr5325964wrh.238.1594912679077;
        Thu, 16 Jul 2020 08:17:59 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id b17sm9755636wrp.32.2020.07.16.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:17:57 -0700 (PDT)
Date:   Thu, 16 Jul 2020 17:17:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v2] binder: Don't use mmput() from shrinker function.
Message-ID: <20200716151756.GO31089@dhcp22.suse.cz>
References: <0000000000001fbbb605aa805c9b@google.com>
 <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
 <20200716083506.GA20915@dhcp22.suse.cz>
 <36db7016-98d6-2c6b-110b-b2481fd480ac@i-love.sakura.ne.jp>
 <20200716135445.GN31089@dhcp22.suse.cz>
 <4ba9adb2-43f5-2de0-22de-f6075c1fab50@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba9adb2-43f5-2de0-22de-f6075c1fab50@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-07-20 00:12:15, Tetsuo Handa wrote:
> syzbot is reporting that mmput() from shrinker function has a risk of
> deadlock [1], for delayed_uprobe_add() from update_ref_ctr() calls
> kzalloc(GFP_KERNEL) with delayed_uprobe_lock held, and
> uprobe_clear_state() from __mmput() also holds delayed_uprobe_lock.
> 
> Commit a1b2289cef92ef0e ("android: binder: drop lru lock in isolate
> callback") replaced mmput() with mmput_async() in order to avoid sleeping
> with spinlock held. But this patch replaces mmput() with mmput_async() in
> order not to start __mmput() from shrinker context.
> 
> [1] https://syzkaller.appspot.com/bug?id=bc9e7303f537c41b2b0cc2dfcea3fc42964c2d45
> 
> Reported-by: syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Reviewed-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 42c672f1584e..cbe6aa77d50d 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -947,7 +947,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
>  	mmap_read_unlock(mm);
> -	mmput(mm);
> +	mmput_async(mm);
>  
>  	trace_binder_unmap_kernel_start(alloc, index);
>  
> -- 
> 2.18.4

-- 
Michal Hocko
SUSE Labs
