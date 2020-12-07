Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5C62D193C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgLGTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLGTPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:15:07 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B255C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:14:27 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id p22so2888249edu.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jmde5DLX9qAtIBMJ/NIdWYTAYpRwSsr9Odz1F7TWunw=;
        b=lddAqGm3MQoZxuH4PKvKMDzUnTsn3VtxH0cgyRXTomrtszvuHuMHEUxsbPiCkI579U
         9fLOvCMZ8FK8gp5Oih+Q9tI2pQ7qYcs31bw6oW4MHEIZ/omzxGJoZGz9nNefzsTaVQHF
         zZkMg9WyWvthMYZb0F8P5Zv7NnYq/M72blkP/K9mFkUZvM5KWR1VxPsev4AFiaoxqipG
         Y0G+gRTN/2+zVbsi/oNEKdlwpBZOr2RR4YW9/ufDlvzPIw4leFiqYPUcJvBj/SZ5iQDv
         JNMs1F1cZ4eKve8lE2wWc37PRmqXPIpt3zBjnZHmHinxyLyexfxe1orLjjF4vD5L7sRt
         kDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jmde5DLX9qAtIBMJ/NIdWYTAYpRwSsr9Odz1F7TWunw=;
        b=OqxMRKsW6ZNQ2xe2W8H/Aqlvt2HxueXfz1iPu53FH2/dYU4BGLTMRjjxp9f2GF61Ew
         ybnVDMhQzN5/7b3G4man3MSo/svU9/xN7magQy8wQ9LjCRZX6qG652hlHjoCIgcrvdkh
         /pKUzKzFFX+RjQMTN4iajGN7ucp7r8DGuXJm46Zs2BXu8cteIAGcwZsgQXY9Rl1hMXjG
         Y89dIGowRcIxAHzb9OrMg00wJTQBF92+kvOweQ+OB/zoZtRY7PfAZH6mucVf8Qnc3Uz7
         LrlgxWb///NJym/5B0sG8i/TdE/L1KGpgV8noHrhyBO6F4YlJ4qWmosCOxRweUIzcPAa
         jIaw==
X-Gm-Message-State: AOAM530I5SFlfg58DB6FEh513wmBghp5xZ2hPmpyR32lh43WFKDPieH1
        iBbYydqnuUE0ywcKQjQtXh5noQ==
X-Google-Smtp-Source: ABdhPJwAxYlw0xJXIJ41PWVh5rYvbijBwYLzNksYRS3VcSJC/SMdkG5LM2Q6gxg67VeNVe1TazaBGA==
X-Received: by 2002:a50:fe8d:: with SMTP id d13mr20530601edt.132.1607368465788;
        Mon, 07 Dec 2020 11:14:25 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id l1sm5898215eje.12.2020.12.07.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:14:25 -0800 (PST)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Mon, 7 Dec 2020 20:14:24 +0100
To:     Christoph Hellwig <hch@lst.de>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        damien.lemoal@wdc.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, snitzer@redhat.com, selvajove@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207191424.bzwoonfpxknbbqlc@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201207141123.GC31159@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.2020 15:11, Christoph Hellwig wrote:
>So, I'm really worried about:
>
> a) a good use case.  GC in f2fs or btrfs seem like good use cases, as
>    does accelating dm-kcopyd.  I agree with Damien that lifting dm-kcopyd
>    to common code would also be really nice.  I'm not 100% sure it should
>    be a requirement, but it sure would be nice to have
>    I don't think just adding an ioctl is enough of a use case for complex
>    kernel infrastructure.

We are looking at dm-kcopyd. I would have liked to start with a very
specific use case and build from there, but I see Damien's and Keith's
point of having a default path. I believe we can add this to the next
version.

> b) We had a bunch of different attempts at SCSI XCOPY support form IIRC
>    Martin, Bart and Mikulas.  I think we need to pull them into this
>    discussion, and make sure whatever we do covers the SCSI needs.

Agree. We discussed a lot about the scope and agreed that everything
outside of the specifics of Simple Copy requires the input from the ones
that have worked on XCOPY support in the past.

>
>On Fri, Dec 04, 2020 at 03:16:57PM +0530, SelvaKumar S wrote:
>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>> v2020.05.04 ("Ratified")
>>
>> The Specification can be found in following link.
>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>
>> This is an RFC. Looking forward for any feedbacks or other alternate
>> designs for plumbing simple copy to IO stack.
>>
>> Simple copy command is a copy offloading operation and is  used to copy
>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>> LBA within the device reducing traffic between host and device.
>>
>> This implementation accepts destination, no of sources and arrays of
>> source ranges from application and attach it as payload to the bio and
>> submits to the device.
>>
>> Following limits are added to queue limits and are exposed in sysfs
>> to userspace
>> 	- *max_copy_sectors* limits the sum of all source_range length
>> 	- *max_copy_nr_ranges* limits the number of source ranges
>> 	- *max_copy_range_sectors* limit the maximum number of sectors
>> 		that can constitute a single source range.
>>
>> Changes from v1:
>>
>> 1. Fix memory leak in __blkdev_issue_copy
>> 2. Unmark blk_check_copy inline
>> 3. Fix line break in blk_check_copy_eod
>> 4. Remove p checks and made code more readable
>> 5. Don't use bio_set_op_attrs and remove op and set
>>    bi_opf directly
>> 6. Use struct_size to calculate total_size
>> 7. Fix partition remap of copy destination
>> 8. Remove mcl,mssrl,msrc from nvme_ns
>> 9. Initialize copy queue limits to 0 in nvme_config_copy
>> 10. Remove return in QUEUE_FLAG_COPY check
>> 11. Remove unused OCFS
>>
>> SelvaKumar S (2):
>>   block: add simple copy support
>>   nvme: add simple copy support
>>
>>  block/blk-core.c          |  94 ++++++++++++++++++++++++++---
>>  block/blk-lib.c           | 123 ++++++++++++++++++++++++++++++++++++++
>>  block/blk-merge.c         |   2 +
>>  block/blk-settings.c      |  11 ++++
>>  block/blk-sysfs.c         |  23 +++++++
>>  block/blk-zoned.c         |   1 +
>>  block/bounce.c            |   1 +
>>  block/ioctl.c             |  43 +++++++++++++
>>  drivers/nvme/host/core.c  |  87 +++++++++++++++++++++++++++
>>  include/linux/bio.h       |   1 +
>>  include/linux/blk_types.h |  15 +++++
>>  include/linux/blkdev.h    |  15 +++++
>>  include/linux/nvme.h      |  43 ++++++++++++-
>>  include/uapi/linux/fs.h   |  13 ++++
>>  14 files changed, 461 insertions(+), 11 deletions(-)
>>
>> --
>> 2.25.1
>---end quoted text---
