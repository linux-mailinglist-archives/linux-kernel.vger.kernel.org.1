Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3918D2CD383
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgLCKa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387578AbgLCKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:30:27 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1339C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:29:46 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k3so1241387otp.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dD/UF3nKA/vHAeqLilY0XbqwU9Dd3XarhmvDlCA55tM=;
        b=sNAUb/6EpXsXZLgScT2nBxmPy0qJ8cz5eUI+26eOvpwQ34r3z4nNCosaC5QHGRCTTv
         ooKyyAGZP4PiQA2DsJyROx/nzT8LgObcMWN7pHC4vIVt9wVl16nEueIrXK3EPyr4wYDx
         igu1H3z1STu2hP/BAMzv8BB7kcmC0wT/PcFZW4Xx18MJA/F150Z8JWiGW3NFVJF+fpEW
         W7IRu+4ah0axnhkYH2zOKap3cVSCsnWpPTLkMsWn3iEHCFshS7yRkWWsQiLvKbMc9SLU
         jodXExiQPL0dd1K16UWOU1xbH7sJesNfY+8hEtJ9AQpsgbcVdAwtCCMm/kPqCyuxLSmL
         lDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dD/UF3nKA/vHAeqLilY0XbqwU9Dd3XarhmvDlCA55tM=;
        b=CLL0CnYGtheTYXcrEshECzh1aaIEAmM5UuIVm3FitXwQb5vIXR219wvWhigCMDwdGm
         THsiL8Ev8kZ0ERbheunqlxN7tp9otk52v0aWTryKCqyaZWYQCMw+poKI+GZ8oQhqNnsI
         pKv2+1z9oji3nbhVrSN5skLeoPAtQrtl7myIXQLugDy8UynUjXN3xfXrg5ffUB+N6/Js
         ZcwJMz61rNlHwaxqk+0WQDzDUGpy8lWCpTRN3qf4I0D7IWAqa9sASEUNttTGeiTF2vJh
         B7Q+8ijjeV0KmZtKKVLrbb0PxApHQ+tI06C2FDT1gnFApo6YEolMqPtxETIynSWc63Fb
         xIiQ==
X-Gm-Message-State: AOAM532IKx0xN7VTqGg0eY5JkF9LCDK6o8f236DdofCVNMPIHq0k9BHv
        hrSTbgmPsw7GPhGW7DP8E7GS/hW+4UFFl8M6RbEjvw==
X-Google-Smtp-Source: ABdhPJydGvdWaYJOm+Ie12Lw3ZJQHjW/6RDf4PUUEjAcJRpmJDcB86vOtH+sjygI7l3Ka0hhovq+moKy+jtukv+vr9A=
X-Received: by 2002:a9d:7cc8:: with SMTP id r8mr1563625otn.233.1606991385992;
 Thu, 03 Dec 2020 02:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20201203022748.30681-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20201203022748.30681-1-walter-zh.wu@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 3 Dec 2020 11:29:34 +0100
Message-ID: <CANpmjNNdaiN=J0TU_AjAoH=ECNC8dJWS8HTvJs9nxBkJce9AmQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] lib/test_kasan.c: add workqueue test case
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 at 03:27, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Adds a test to verify workqueue stack recording and print it in
> KASAN report.
>
> The KASAN report was as follows(cleaned up slightly):
>
>  BUG: KASAN: use-after-free in kasan_workqueue_uaf
>
>  Freed by task 54:
>   kasan_save_stack+0x24/0x50
>   kasan_set_track+0x24/0x38
>   kasan_set_free_info+0x20/0x40
>   __kasan_slab_free+0x10c/0x170
>   kasan_slab_free+0x10/0x18
>   kfree+0x98/0x270
>   kasan_workqueue_work+0xc/0x18
>
>  Last potentially related work creation:
>   kasan_save_stack+0x24/0x50
>   kasan_record_wq_stack+0xa8/0xb8
>   insert_work+0x48/0x288
>   __queue_work+0x3e8/0xc40
>   queue_work_on+0xf4/0x118
>   kasan_workqueue_uaf+0xfc/0x190
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Acked-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>
> v4:
> - testcase has merge conflict, so that rebase onto the KASAN-KUNIT
>
> ---
>  lib/test_kasan_module.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/lib/test_kasan_module.c b/lib/test_kasan_module.c
> index 2d68db6ae67b..62a87854b120 100644
> --- a/lib/test_kasan_module.c
> +++ b/lib/test_kasan_module.c
> @@ -91,6 +91,34 @@ static noinline void __init kasan_rcu_uaf(void)
>         call_rcu(&global_rcu_ptr->rcu, kasan_rcu_reclaim);
>  }
>
> +static noinline void __init kasan_workqueue_work(struct work_struct *work)
> +{
> +       kfree(work);
> +}
> +
> +static noinline void __init kasan_workqueue_uaf(void)
> +{
> +       struct workqueue_struct *workqueue;
> +       struct work_struct *work;
> +
> +       workqueue = create_workqueue("kasan_wq_test");
> +       if (!workqueue) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +       work = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
> +       if (!work) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       INIT_WORK(work, kasan_workqueue_work);
> +       queue_work(workqueue, work);
> +       destroy_workqueue(workqueue);
> +
> +       pr_info("use-after-free on workqueue\n");
> +       ((volatile struct work_struct *)work)->data;
> +}
>
>  static int __init test_kasan_module_init(void)
>  {
> @@ -102,6 +130,7 @@ static int __init test_kasan_module_init(void)
>
>         copy_user_test();
>         kasan_rcu_uaf();
> +       kasan_workqueue_uaf();


Why can't this go into the KUnit based KASAN test?
