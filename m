Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE1293E05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407768AbgJTOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407728AbgJTOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603202449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sctD9GroQPGmZjA5ubyMJz3ARe9p1/I2rVYIjHWBII=;
        b=VD3vvc6VrqpjpLg2ThF+0/inu3ys/nbvDygFtp5w/bKc8002/TDjR0xZdfMIuLOXDCzzK5
        /k4XFChgk5NtJPP+q2dl6Ovmy3BGZrKCDFe6+xVGysiEYoLrRCglHwMdMPOz3nmS+j8ZKQ
        xFxa9z1W/emSuS+vGf+8taWgUGyjp4I=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-mAYyRZ4jNbetWLzpOBp6OQ-1; Tue, 20 Oct 2020 10:00:46 -0400
X-MC-Unique: mAYyRZ4jNbetWLzpOBp6OQ-1
Received: by mail-il1-f197.google.com with SMTP id e3so2266045ilq.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4sctD9GroQPGmZjA5ubyMJz3ARe9p1/I2rVYIjHWBII=;
        b=BqKYstzcGs7ZNwRhJjAeV2EQVCx1lAhwAzHJksf05G/H4SNQ/A8GAKF5f9mxWI9h2z
         6dQQ/MKoBrkmjyJlgTsE6tanjygJdTWlsRc2+mBTVyMxfhjOKp1RTjpnouSY3bS/Eibd
         l+7pWkcx6EPP3DRlo7E5bTqcpoPTteSDZmxOA+KeLWRBG9ogHNAPBAunEUAvBCg4KCGr
         rGzMAua/hgnBqf9z0vmrkMQ/ik+QHkVVtkVwXes+L+hzNooUBQH3R1KQCpX29L7oScc4
         f5W3mUYpwQ0Q14CJ1IWSiUxsf3X41BJyDJQFUBr9B1jGfne1BI/u5FblaJPEG0cVQ182
         aiYA==
X-Gm-Message-State: AOAM531BwrXCT/K6gorAsUyIgP/3AfLWPRM8gQbw0pZ3KXQS2IdR9UQR
        ChrnoTIaBshXsL50XqKYdz2Nyl0EGYv0SKQplU6pb9sfzflRHfqhOiGcqbXLnRbhFx66SfibBXA
        Tq1Yvn7USxklerVj1aVdkzFJb
X-Received: by 2002:a92:d84a:: with SMTP id h10mr2186984ilq.39.1603202445101;
        Tue, 20 Oct 2020 07:00:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf1jwBZUSK30L5Aua9DPGWks1GPDv4iyrEdkxaagg/LMxe0yoJf/NaKWNohG7sDyMtkGoHgQ==
X-Received: by 2002:a92:d84a:: with SMTP id h10mr2186961ilq.39.1603202444880;
        Tue, 20 Oct 2020 07:00:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p4sm1960555ilg.79.2020.10.20.07.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:00:44 -0700 (PDT)
Subject: Re: [PATCH] mtd: remove unneeded break
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
References: <20201019191631.9604-1-trix@redhat.com>
 <CAFLxGvwAVbpUe221N-qS19aFSaJ4hM=J=veHfi+4wAkNTNGAog@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fef9fb1c-30ee-14fb-a9bd-4f4a554a8bbc@redhat.com>
Date:   Tue, 20 Oct 2020 07:00:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwAVbpUe221N-qS19aFSaJ4hM=J=veHfi+4wAkNTNGAog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/20 1:04 PM, Richard Weinberger wrote:
> On Mon, Oct 19, 2020 at 9:23 PM <trix@redhat.com> wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A break is not needed if it is preceded by a return
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/mtd/mtdchar.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
>> index b40f46a43fc6..323035d4f2d0 100644
>> --- a/drivers/mtd/mtdchar.c
>> +++ b/drivers/mtd/mtdchar.c
>> @@ -881,7 +881,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>>                 if (copy_from_user(&offs, argp, sizeof(loff_t)))
>>                         return -EFAULT;
>>                 return mtd_block_isbad(mtd, offs);
>> -               break;
>>         }
>>
>>         case MEMSETBADBLOCK:
>> @@ -891,7 +890,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
>>                 if (copy_from_user(&offs, argp, sizeof(loff_t)))
>>                         return -EFAULT;
>>                 return mtd_block_markbad(mtd, offs);
>> -               break;
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Do you want to route this patch through mtd or do you carry it?

Not sure if this question is for me.

I do not maintain a subsystem/branch, so through mtd is what i was assuming.

Tom

>

