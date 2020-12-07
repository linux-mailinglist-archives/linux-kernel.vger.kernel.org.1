Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B11D2D0B95
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 09:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgLGIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 03:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLGIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 03:17:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F7C0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 00:16:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lt17so18245988ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYj4pUoj9o5PR+qG7Qn3L1SJKXMPS3+hvYYnqb4yHOw=;
        b=c8bMSHij6AKZgKH+1ByBckieZlo8OFHunwfNP3RwYtvl8jJLycmvKIxOaM4lp7R6Tq
         J77atErU5l67mJKevaaZa/t/IxL7KDMZ+oVGF4ByZgjcBMPGpSjhDufp+mafUCxYHQHC
         sPFSwK8FE75EGl7MdmqRDUtu8wNc6RyyOpGI2Z9EfTCLOX4DkcF1TlrPkfPThRdJkHpF
         LADyRXTKZkRbxnRbIZtZAqhqgPW2NOSTwBqEm5j+vMd8zla2AkVtqu16osBQn2ebKEtE
         hRS17c3Ls9p+CI9OZUI8M11tO35e98qpS75Ye1i3M7TuoWiQt9eYbbooJbgkXQq/0YEy
         42Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYj4pUoj9o5PR+qG7Qn3L1SJKXMPS3+hvYYnqb4yHOw=;
        b=lLXGn98xLU0tDL3Y9HukT+YTemAGOVIQjLscC09rRtD/MHMrAydJQczAAzQhvmQ+Jm
         iwIvsDCl5ct0faDSCunWtvYnD463ixMoywTPwdxr2/a6oMpItmCctR7vIA7h6LSExobM
         o5hlabyVIhx0PjHL9HhvYcJx4RzJzPL42ixGz3rkA5p+C6iLvTfL6YAkxq9sDQteLxKy
         zBQHb9b6vFZSoplX3E3Jf96ebvKN9nxWPocSnR5SP9wYeL5y059fgnUQ2AEX6yBte7sK
         4zOejPe8+r1SgyeB9xeiRDs4jdU0Up89GmZdDrHnzkg/nHI0R2zw8s7REZIFM7lOGsFu
         cKVw==
X-Gm-Message-State: AOAM531ArisYt7vcg5GK7UEZ7hUx4DPHgZ7xByHPQUpDz0oufLv6Rm7H
        VcXa7SZFgEiBW8aE5qLFgxxzqA==
X-Google-Smtp-Source: ABdhPJwb4jRV2xylIOGlV+IbqS3THEEk1xv/TWj/PDOLR2zfUPpGUmwka3CjMKimmTAV6Dyou0TXtA==
X-Received: by 2002:a17:906:7b8d:: with SMTP id s13mr1630369ejo.479.1607328992695;
        Mon, 07 Dec 2020 00:16:32 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id n22sm12100137edr.11.2020.12.07.00.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 00:16:32 -0800 (PST)
Date:   Mon, 7 Dec 2020 09:16:31 +0100
From:   "javier.gonz@samsung.com" <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207081631.usapwn5jj35c5633@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
 <20201207074616.mocdy6m5qgsn6yqg@mpHalley>
 <CH2PR04MB6522623991D84D67B13DDF66E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6522623991D84D67B13DDF66E7CE0@CH2PR04MB6522.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.2020 08:06, Damien Le Moal wrote:
>On 2020/12/07 16:46, javier.gonz@samsung.com wrote:
>> On 04.12.2020 23:40, Keith Busch wrote:
>>> On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
>>>> On 2020/12/04 20:02, SelvaKumar S wrote:
>>>>> This patchset tries to add support for TP4065a ("Simple Copy Command"),
>>>>> v2020.05.04 ("Ratified")
>>>>>
>>>>> The Specification can be found in following link.
>>>>> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>>
>>>>> This is an RFC. Looking forward for any feedbacks or other alternate
>>>>> designs for plumbing simple copy to IO stack.
>>>>>
>>>>> Simple copy command is a copy offloading operation and is  used to copy
>>>>> multiple contiguous ranges (source_ranges) of LBA's to a single destination
>>>>> LBA within the device reducing traffic between host and device.
>>>>>
>>>>> This implementation accepts destination, no of sources and arrays of
>>>>> source ranges from application and attach it as payload to the bio and
>>>>> submits to the device.
>>>>>
>>>>> Following limits are added to queue limits and are exposed in sysfs
>>>>> to userspace
>>>>> 	- *max_copy_sectors* limits the sum of all source_range length
>>>>> 	- *max_copy_nr_ranges* limits the number of source ranges
>>>>> 	- *max_copy_range_sectors* limit the maximum number of sectors
>>>>> 		that can constitute a single source range.
>>>>
>>>> Same comment as before. I think this is a good start, but for this to be really
>>>> useful to users and kernel components alike, this really needs copy emulation
>>>> for drives that do not have a native copy feature, similarly to what write zeros
>>>> handling for instance: if the drive does not have a copy command (simple copy
>>>> for NVMe or XCOPY for scsi), then the block layer should issue read/write
>>>> commands to seamlessly execute the copy. Otherwise, this will only serve a small
>>>> niche for users and will not be optimal for FS and DM drivers that could be
>>>> simplified with a generic block layer copy functionality.
>>>>
>>>> This is my 10 cents though, others may differ about this.
>>>
>>> Yes, I agree that copy emulation support should be included with the
>>> hardware enabled solution.
>>
>> Keith, Damien,
>>
>> Can we do the block layer emulation with this patchset and then work in
>> follow-up patchses on (i) the FS interface with F2FS as a first user and
>> (ii) other HW accelerations such as XCOPY?
>
>The initial patchset supporting NVMe simple copy and emulation copy, all under
>an API that probably will be similar that of dm-kcopyd will cover all block
>devices. Other hardware native support for copy functions such as scsi extended
>copy can be added later under the hood without any API changes (or minimal changes).

Sounds good. That we can do. We will add a new patch for this.

>
>I am not sure what you mean by "FS interface for F2FS": the block layer API for
>this copy functionality will be what F2FS (and other FSes) will call. That is
>the interface, no ?

Essentially yes.. I mean adding the F2FS logic and potentially some
helpers to the block layer to aid GC.

>
>> For XCOPY, I believe we need to have a separate discussion as much works
>> is already done that we should align to.
>
>I think Martin (added to this thread) and others have looked into it but I do
>not think that anything made it into the kernel yet.

Exactly. Looking at some of the code posted through time and recalling
the discussions at LSF/MM, seems like there are a number of things we
are not addressing here that could be incorporated down the road, such
as dedicated syscalls / extensions, multi namespace / device support,
etc.
>
