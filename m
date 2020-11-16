Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7650A2B54A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgKPWyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:54:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:36744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:54:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61900ACC5;
        Mon, 16 Nov 2020 22:54:07 +0000 (UTC)
Date:   Mon, 16 Nov 2020 14:31:02 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] USB: serial: mos7720: defer state restore to a workqueue
Message-ID: <20201116223102.eliwt7uh5rkiiq5h@linux-p48b.lan>
References: <20201102211450.5722-1-dave@stgolabs.net>
 <20201103204014.3ue37owcras6cx7p@linux-p48b.lan>
 <20201104110657.GW4085@localhost>
 <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
 <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
 <20201113091443.GI4085@localhost>
 <20201114042725.ofs7zbzmxg32tbbi@linux-p48b.lan>
 <X7KyPrY8FDH4C/gm@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X7KyPrY8FDH4C/gm@localhost>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Johan Hovold wrote:

>On Fri, Nov 13, 2020 at 08:27:25PM -0800, Davidlohr Bueso wrote:
>> @@ -1883,21 +1724,17 @@ static void mos7720_release(struct usb_serial *serial)
>>		if (mos_parport->msg_pending)
>>			wait_for_completion_timeout(&mos_parport->syncmsg_compl,
>>					    msecs_to_jiffies(MOS_WDR_TIMEOUT));
>> +		/*
>> +		 * If delayed work is currently scheduled, wait for it to
>> +		 * complete. This also implies barriers that ensure the
>> +		 * below serial clearing is not hoisted above the ->work.
>> +		 */
>> +		cancel_work_sync(&mos_parport->work);
>
>As I mentioned, this needs to be done *after* deregistering the port or
>you could theoretically end up with the work item being requeued.

Hmm sorry yes I forgot to mention this. I was counting on the private_data
already being null to prevent any new work being actually scheduled, so an
incoming restore state, for example, would be a nop.

>
>Yes, the same applies for the "synchronous" requests, but that's a
>preexisting issue.

Per the above I also assumed sync requests were also safe as is.

But I can certainly re-order things, how about:

mos7720_release():
    mos_parport->pp->private_data = NULL;
    parport_remove_port(mos_parport->pp);

    wait_for_completion_timeout();
    cancel_work_sync();

    usb_set_serial_data(serial, NULL);
    mos_parport->serial = NULL;

    parport_del_port(mos_parport->pp);
    kref_put();

Thanks,
Davidlohr
