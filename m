Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C757E2F1F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404106AbhAKTXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:23:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:33836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404152AbhAKTX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:23:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6432AB7F;
        Mon, 11 Jan 2021 19:22:47 +0000 (UTC)
Date:   Mon, 11 Jan 2021 11:22:40 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     jacmet@sunsite.dk, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/c67x00: Replace tasklet with work
Message-ID: <20210111192240.osls6hi5wmnw76ts@offworld>
References: <20210111044050.86763-1-dave@stgolabs.net>
 <20210111090533.1450-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210111090533.1450-1-hdanton@sina.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021, Hillf Danton wrote:

>On Sun, 10 Jan 2021 20:40:50 -0800 Davidlohr Bueso wrote:
>> Tasklets have long been deprecated as being too heavy on the system
>> by running in irq context - and this is not a performance critical
>> path. If a higher priority process wants to run, it must wait for
>> the tasklet to finish before doing so.
>>
>> c67x00_do_work() will now run in process context and have further
>> concurrency (tasklets being serialized among themselves), but this
>> is done holding the c67x00->lock, so it should be fine. Furthermore,
>> this patch fixes the usage of the lock in the callback as otherwise
>> it would need to be irq-safe.
>
>Can you add a couple of words about the need to be irq-safe because
>no lock is taken for scheduling either tasklet or work?

I was refering to the locking in the c67x00_do_work() tasklet callback.
Because it is currently under irq it should be disabling irq (or at least
BH) but after this patch that is no longer the case.

>>
>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>> ---
>>  drivers/usb/c67x00/c67x00-hcd.h   |  2 +-
>>  drivers/usb/c67x00/c67x00-sched.c | 12 +++++++-----
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
>> index 6b6b04a3fe0f..6332a6b5dce6 100644
>> --- a/drivers/usb/c67x00/c67x00-hcd.h
>> +++ b/drivers/usb/c67x00/c67x00-hcd.h
>> @@ -76,7 +76,7 @@ struct c67x00_hcd {
>>	u16 next_td_addr;
>>	u16 next_buf_addr;
>>
>> -	struct tasklet_struct tasklet;
>> +	struct work_struct work;
>>
>>	struct completion endpoint_disable;
>>
>> diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
>> index e65f1a0ae80b..af60f4fdd340 100644
>> --- a/drivers/usb/c67x00/c67x00-sched.c
>> +++ b/drivers/usb/c67x00/c67x00-sched.c
>> @@ -1123,24 +1123,26 @@ static void c67x00_do_work(struct c67x00_hcd *c67x00)
>>
>>  /* -------------------------------------------------------------------------- */
>>
>> -static void c67x00_sched_tasklet(struct tasklet_struct *t)
>> +static void c67x00_sched_work(struct work_struct *work)
>>  {
>> -	struct c67x00_hcd *c67x00 = from_tasklet(c67x00, t, tasklet);
>> +	struct c67x00_hcd *c67x00;
>> +
>> +	c67x00 = container_of(work, struct c67x00_hcd, work);
>>	c67x00_do_work(c67x00);
>>  }
>>
>>  void c67x00_sched_kick(struct c67x00_hcd *c67x00)
>>  {
>> -	tasklet_hi_schedule(&c67x00->tasklet);
>> +        queue_work(system_highpri_wq, &c67x00->work);
>
>Better if one line comment is added for highpri, given this is not a
>performance critical path.

I'm not sure the value here, considering the highprio is not being
changed here. There are a few drivers who use highpri workqueue and
care about latencies but they are still not performance critical (to
the overall system that is, which is what I meant by that).

Thanks,
Davidlohr
