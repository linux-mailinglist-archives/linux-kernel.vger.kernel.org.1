Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03A2AC513
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgKITgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:36:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgKITgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:36:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6505B028;
        Mon,  9 Nov 2020 19:36:47 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:14:10 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] usb/mos7720: process deferred urbs in a workqueue
Message-ID: <20201109191410.wjywxb5c6ylvekom@linux-p48b.lan>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
 <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
 <574f338f6f0b81fe1e4109f74c6dfcb45aca0d53.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <574f338f6f0b81fe1e4109f74c6dfcb45aca0d53.camel@suse.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Nov 2020, Oliver Neukum wrote:

>Am Donnerstag, den 05.11.2020, 22:17 -0800 schrieb Davidlohr Bueso:
>> @@ -1888,16 +1732,8 @@ static void mos7720_release(struct usb_serial *serial)
>>                 usb_set_serial_data(serial, NULL);
>>                 mos_parport->serial = NULL;
>>
>> -               /* if tasklet currently scheduled, wait for it to complete */
>> -               tasklet_kill(&mos_parport->urb_tasklet);
>> -
>> -               /* unlink any urbs sent by the tasklet  */
>> -               spin_lock_irqsave(&mos_parport->listlock, flags);
>> -               list_for_each_entry(urbtrack,
>> -                                   &mos_parport->active_urbs,
>> -                                   urblist_entry)
>> -                       usb_unlink_urb(urbtrack->urb);
>> -               spin_unlock_irqrestore(&mos_parport->listlock, flags);
>> +               /* if work is currently scheduled, wait for it to complete */
>> +               cancel_work_sync(&mos_parport->work);
>>                 parport_del_port(mos_parport->pp);
>>
>>                 kref_put(&mos_parport->ref_count, destroy_mos_parport);
>
>Hi,
>
>do you really want to cancel as opposed to wait for work in release()?

Well I tried to maintain the current semantics here. tasklet_kill() is
equivalent to cancel_work_sync() in that they both wait for the delayed
execution to finish running and guarantee that it is no longer queued.

Thanks,
Davidlohr
