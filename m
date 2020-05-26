Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B8D1B0ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgDTOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgDTOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:45:57 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B9C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:45:56 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p28so6122151vsg.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AeiRaVP6V0jAzRbDBlTgc5wh5zJsytFh4SoKUqnITyc=;
        b=GSK5KUoSJoDO1XqdCdR8d6YuCWxE67mEUc7Vu2T1YDbVOym9NV3sHBxQ49JYbMaqdf
         ZsZSyXSX+W0dP8zjVeL82VYK+swT4pEPohrMfEW9UBb/kWcFVr6fmtS3ZIukGilfKwY7
         BHGp2skzEMRnvsum7erA5ive6o3gNlONGZ7G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AeiRaVP6V0jAzRbDBlTgc5wh5zJsytFh4SoKUqnITyc=;
        b=rI2JyhgTqBDhb17tRLn+Xc0UfmDS/od3MvcsDOnPXlB5EPm7it5uL40AqD6VU9XRJC
         aaySCxaBBiqzvEgwuaqrLg+ZuoO9L+ykrxMYFOloNlRou89RhhKtGzD8iGv8VmzWfNYr
         X/cG1B4NL1BLtu1ZlaKndBqUl/l1pvZ2PaT7pVaEsVO3JDOo3mHrvhrpoZyoLRIYRPz6
         4fJPEILrkZY1vLZ+7CmSTo3eo0G255w3MCcmNm9DyoKWJTZUMk3muIiLFGNNn+dze3B4
         wcNpR4eUWhaH68dhGgyXN7A4O0LklWpngbA5hn6mLCe2hM9hlmZP2JbkzBjHk6vVzcfw
         UmOA==
X-Gm-Message-State: AGi0Puaog9huX46m0m0JWbl069lGJkvhKiWjOoGeY/AO7NE0mOLixSZ4
        0XWCV6DwXrd6w4Aum9qaVCbMXCR+5hQ=
X-Google-Smtp-Source: APiQypIaAlWV14xFBsuifC1UR6FyLIJwu8oOBl4Tey5tYDxO3ddaC5Kdv+uEL7drkSBIHG6nlvCE0g==
X-Received: by 2002:a67:e94d:: with SMTP id p13mr8900299vso.215.1587393954927;
        Mon, 20 Apr 2020 07:45:54 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id h16sm261056vkc.44.2020.04.20.07.45.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 07:45:53 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id n26so2003258uap.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:45:53 -0700 (PDT)
X-Received: by 2002:a9f:27ca:: with SMTP id b68mr8211458uab.8.1587393952755;
 Mon, 20 Apr 2020 07:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200408150402.21208-1-dianders@chromium.org>
In-Reply-To: <20200408150402.21208-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 Apr 2020 07:45:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Upkdz_7TG8gde9jC+iWBFHckVf3yZe5Zyz9gq27Ys0GQ@mail.gmail.com>
Message-ID: <CAD=FV=Upkdz_7TG8gde9jC+iWBFHckVf3yZe5Zyz9gq27Ys0GQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] blk-mq: Fix two causes of IO stalls found in
 reboot testing
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-scsi@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Salman Qazi <sqazi@google.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Apr 8, 2020 at 8:35 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> While doing reboot testing, I found that occasionally my device would
> trigger the hung task detector.  Many tasks were stuck waiting for the
> a blkdev mutex, but at least one task in the system was always sitting
> waiting for IO to complete (and holding the blkdev mutex).  One
> example of a task that was just waiting for its IO to complete on one
> reboot:
>
>  udevd           D    0  2177    306 0x00400209
>  Call trace:
>   __switch_to+0x15c/0x17c
>   __schedule+0x6e0/0x928
>   schedule+0x8c/0xbc
>   schedule_timeout+0x9c/0xfc
>   io_schedule_timeout+0x24/0x48
>   do_wait_for_common+0xd0/0x160
>   wait_for_completion_io_timeout+0x54/0x74
>   blk_execute_rq+0x9c/0xd8
>   __scsi_execute+0x104/0x198
>   scsi_test_unit_ready+0xa0/0x154
>   sd_check_events+0xb4/0x164
>   disk_check_events+0x58/0x154
>   disk_clear_events+0x74/0x110
>   check_disk_change+0x28/0x6c
>   sd_open+0x5c/0x130
>   __blkdev_get+0x20c/0x3d4
>   blkdev_get+0x74/0x170
>   blkdev_open+0x94/0xa8
>   do_dentry_open+0x268/0x3a0
>   vfs_open+0x34/0x40
>   path_openat+0x39c/0xdf4
>   do_filp_open+0x90/0x10c
>   do_sys_open+0x150/0x3c8
>   ...
>
> I've reproduced this on two systems: one boots from an internal UFS
> disk and one from eMMC.  Each has a card reader attached via USB with
> an SD card plugged in.  On the USB-attached SD card is a disk with 12
> partitions (a Chrome OS test image), if it matters.  The system
> doesn't do much with the USB disk other than probe it (it's plugged in
> my system to help me recover).
>
> From digging, I believe that there are two separate but related
> issues.  Both issues relate to the SCSI code saying that there is no
> budget.
>
> I have done testing with only one or the other of the two patches in
> this series and found that I could still encounter hung tasks if only
> one of the two patches was applied.  This deserves a bit of
> explanation.  To me, it's fairly obvious that the first fix wouldn't
> fix the problems talked about in the second patch.  However, it's less
> obvious why the second patch doesn't fix the problems in
> blk_mq_dispatch_rq_list().  It turns out that it _almost_ does
> (problems become much more rare), but I did manage to get a single
> trace where the "kick" scheduled by the second patch happened really
> quickly.  The scheduled kick then ran and found nothing to do.  This
> happened in parallel to a task running in blk_mq_dispatch_rq_list()
> which hadn't gotten around to splicing the list back into
> hctx->dispatch.  This is why we need both fixes.
>
> Most of my testing has been atop Chrome OS 5.4's kernel tree which
> currently has v5.4.30 merged in.  The Chrome OS 5.4 tree also has a
> patch by Salman Qazi, namely ("block: Limit number of items taken from
> the I/O scheduler in one go").  Reverting that patch didn't make the
> hung tasks go away, so I kept it in for most of my testing.
>
> I have also done some testing on mainline Linux (most on what git
> describe calls v5.6-rc7-227-gf3e69428b5e2) even without Salman's
> patch.  I found that I could reproduce the problems there and that
> traces looked about the same as I saw on the downstream branch.  These
> patches were also confirmed to fix the problems on mainline.
>
> Chrome OS is currently setup to use the BFQ scheduler and I found that
> I couldn't reproduce the problems without BFQ.  As discussed in the
> second patch this is believed to be because BFQ sometimes returns
> "true" from has_work() but then NULL from dispatch_request().
>
> I'll insert my usual caveat that I'm sending patches to code that I
> know very little about.  If I'm making a total bozo patch here, please
> help me figure out how I should fix the problems I found in a better
> way.
>
> If you want to see a total ridiculous amount of chatter where I
> stumbled around a whole bunch trying to figure out what was wrong and
> how to fix it, feel free to read <https://crbug.com/1061950>.  I
> promise it will make your eyes glaze over right away if this cover
> letter didn't already do that.  Specifically comment 79 in that bug
> includes a link to my ugly prototype of making BFQ's has_work() more
> exact (I only managed it by actually defining _both_ an exact and
> inexact function to avoid circular locking problems when it was called
> directly from blk_mq_hctx_has_pending()).  Comment 79 also has more
> thoughts about alternatives considered.
>
> I don't know if these fixes represent a regression of some sort or are
> new.  As per above I could only reproduce with BFQ enabled which makes
> it nearly impossible to go too far back with this.  I haven't listed
> any "Fixes" tags here, but if someone felt it was appropriate to
> backport this to some stable trees that seems like it'd be nice.
> Presumably at least 5.4 stable would make sense.
>
> Thanks to Salman Qazi, Paolo Valente, and Guenter Roeck who spent a
> bunch of time helping me trawl through some of this code and reviewing
> early versions of this patch.
>
> Changes in v4:
> - Only kick in blk_mq_do_dispatch_ctx() / blk_mq_do_dispatch_sched().
>
> Changes in v3:
> - Note why blk_mq_dispatch_rq_list() change is needed.
> - ("blk-mq: Add blk_mq_delay_run_hw_queues() API call") new for v3
> - Always kick when putting the budget.
> - Delay blk_mq_do_dispatch_sched() kick by 3 ms for inexact has_work().
> - Totally rewrote commit message.
> - ("Revert "scsi: core: run queue...") new for v3.
>
> Changes in v2:
> - Replace ("scsi: core: Fix stall...") w/ ("blk-mq: Rerun dispatch...")
>
> Douglas Anderson (4):
>   blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
>   blk-mq: Add blk_mq_delay_run_hw_queues() API call
>   blk-mq: Rerun dispatching in the case of budget contention
>   Revert "scsi: core: run queue if SCSI device queue isn't ready and
>     queue is idle"
>
>  block/blk-mq-sched.c    | 18 ++++++++++++++++++
>  block/blk-mq.c          | 30 +++++++++++++++++++++++++++---
>  drivers/scsi/scsi_lib.c |  7 +------
>  include/linux/blk-mq.h  |  1 +
>  4 files changed, 47 insertions(+), 9 deletions(-)

Is there anything blocking this series from landing?  All has been
quiet for a while.  All the patches have Ming's review and the SCSI
patch has Martin's Ack.  This seems like a great time to get it into
linux-next so it can get a whole bunch of testing before the next
merge window.

Thanks!


-Doug
