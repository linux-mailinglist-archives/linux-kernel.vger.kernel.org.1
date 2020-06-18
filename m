Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F71FEB11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFRFnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Jun 2020 01:43:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40952 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgFRFnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:43:23 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jlnKa-0007sd-FN
        for linux-kernel@vger.kernel.org; Thu, 18 Jun 2020 05:43:20 +0000
Received: by mail-pg1-f197.google.com with SMTP id s7so2478632pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 22:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hpReBh04zJuE6akLMdgrR/XleUZUhfWEi7EtHlEkm+4=;
        b=W1xtjlcnZpictnkJSyOcJPB6RyjtGRAa3wROoYWqxZ5P6lGx2bvAiapWBg4njPMQog
         gXZmixw4jEUG2DFvyXG8BYcSblf2dISKo51MWhOo/W3Eb418qcOuLvcbwHoI/XQ0nV+a
         gfZf7bVWcM9jpHNuBcdRK5LDCClitSaqiXg835V8QhTz/fumr1rrbfSPleVXhlf2xJrj
         Gc/Hlgd6mKFn3v3U9W/FW1AmER7KdyZIBNxK0VnAgvvDEAYoFDfKLXELzChWq5D9pqqq
         H0pBpL/X4s1sKPlZe4B40//uOsxmtQzAlq8UQ18IFrADrLD84cUwV5zVbaAZVxS/6Gg6
         GL+A==
X-Gm-Message-State: AOAM532/lJxhGeWy0huPmVkzTKzY3D9IlL0qpYzGRg86bkr+Wm2gnFCa
        UkMsz4bM3V0SOI7Zee8RTM1sfVbIM5+W4WkDYx+u+4kwsVPUqi6yCksqL/BB7KxbQLoN9mLixxU
        yYIq2wK6MIb92WaY1HREFi4Hlh6+S0QVfcrtyhZwk8A==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr2005511pgn.276.1592458999121;
        Wed, 17 Jun 2020 22:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdlCKuPt1ZqwRemIvUiGwaS5f8DjLPnXIOvngSvwGWsPHbN7yv4vcUZUO6bMf/WV68CaEgfg==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr2005493pgn.276.1592458998758;
        Wed, 17 Jun 2020 22:43:18 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id a29sm1470774pfg.201.2020.06.17.22.43.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 22:43:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] libata: Use per port sync for detach
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <b13888c3-d1f9-7e6e-d25e-0287b3d7ba9b@huawei.com>
Date:   Thu, 18 Jun 2020 13:43:16 +0800
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EEE4D9BA-8BE4-4502-A256-C54BC373A73A@canonical.com>
References: <20200603074819.21639-1-kai.heng.feng@canonical.com>
 <b13888c3-d1f9-7e6e-d25e-0287b3d7ba9b@huawei.com>
To:     John Garry <john.garry@huawei.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

> On Jun 3, 2020, at 16:40, John Garry <john.garry@huawei.com> wrote:
> 
> On 03/06/2020 08:48, Kai-Heng Feng wrote:
>> Commit 130f4caf145c ("libata: Ensure ata_port probe has completed before
>> detach") may cause system freeze during suspend.
>> Using async_synchronize_full() in PM callbacks is wrong, since async
>> callbacks that are already scheduled may wait for not-yet-scheduled
>> callbacks, causes a circular dependency.
>> Instead of using big hammer like async_synchronize_full(), use async
>> cookie to make sure port probe are synced, without affecting other
>> scheduled PM callbacks.
>> Fixes: 130f4caf145c ("libata: Ensure ata_port probe has completed before detach")
>> BugLink: https://bugs.launchpad.net/bugs/1867983
>> Suggested-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> thanks,
> Tested-by: John Garry <john.garry@huawei.com>

Can you please review or merge this patch?

Kai-Heng

> 
>> ---
>> v3:
>>  - Move the comment to properly align with the code.
>> v2:
>>  - Sync up to cookie + 1.
>>  - Squash the synchronization into the same loop.
>>  drivers/ata/libata-core.c | 11 +++++------
>>  include/linux/libata.h    |  3 +++
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 69361ec43db5..b1cd4d97bc2a 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -42,7 +42,6 @@
>>  #include <linux/workqueue.h>
>>  #include <linux/scatterlist.h>
>>  #include <linux/io.h>
>> -#include <linux/async.h>
>>  #include <linux/log2.h>
>>  #include <linux/slab.h>
>>  #include <linux/glob.h>
>> @@ -5778,7 +5777,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
>>  	/* perform each probe asynchronously */
>>  	for (i = 0; i < host->n_ports; i++) {
>>  		struct ata_port *ap = host->ports[i];
>> -		async_schedule(async_port_probe, ap);
>> +		ap->cookie = async_schedule(async_port_probe, ap);
>>  	}
>>    	return 0;
>> @@ -5920,11 +5919,11 @@ void ata_host_detach(struct ata_host *host)
>>  {
>>  	int i;
>>  -	/* Ensure ata_port probe has completed */
>> -	async_synchronize_full();
>> -
>> -	for (i = 0; i < host->n_ports; i++)
>> +	for (i = 0; i < host->n_ports; i++) {
>> +		/* Ensure ata_port probe has completed */
>> +		async_synchronize_cookie(host->ports[i]->cookie + 1);
>>  		ata_port_detach(host->ports[i]);
>> +	}
>>    	/* the host is dead now, dissociate ACPI */
>>  	ata_acpi_dissociate(host);
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index af832852e620..8a4843704d28 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -22,6 +22,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/cdrom.h>
>>  #include <linux/sched.h>
>> +#include <linux/async.h>
>>    /*
>>   * Define if arch has non-standard setup.  This is a _PCI_ standard
>> @@ -872,6 +873,8 @@ struct ata_port {
>>  	struct timer_list	fastdrain_timer;
>>  	unsigned long		fastdrain_cnt;
>>  +	async_cookie_t		cookie;
>> +
>>  	int			em_message_type;
>>  	void			*private_data;
>>  
> 

