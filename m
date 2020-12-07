Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2967B2D0B49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgLGHrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLGHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:47:05 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF1FC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 23:46:18 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id g20so18126279ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H37Uk/40yzLuHJ510VKEIUp0RQ+PZefPT2yeqkErhUg=;
        b=YByJcKFlSczTgeZhju2uMm2NIdVWlh4zrHYMrf3feowxRHe1DgmrNadEvKp0ryXkAD
         PHlRZYwLszOen49P72OgOB7Yj0Z+HpY1GCwebiYBeEE/z7vT/YGPsh93c59nBPxmmiTF
         oMYzfSvvVxEU5/c4xGYgMBzq8masamx5nngKqEMmSEXAyVMHp6qZcJJqPn1Zu44/rhaZ
         tXoZT2sgg7ez8d/yjs3MjMK78x+gcGqAWfBTY5z6XJw3imuAh+P42MgKSVg5pKTepXA8
         3cSIMENmKsR1Qaq6H/bI2QwgvzubzwqfBEhgaqqb9BHqcMWehuHIBKrE1aGcH44iRWjx
         hTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H37Uk/40yzLuHJ510VKEIUp0RQ+PZefPT2yeqkErhUg=;
        b=n8yFDzCrwRPRz78v+ciFAia7OXRoKCGfNMfmSAke/r3c4hYMQZ95JhOHFiTDh2ccJZ
         m2gBMIh5qQZc0znwTTKaQ0gqUCPKpz2IWl9BJO6msyxP1g/DVLOBBNZKhTRLrwD8xZUq
         Hb1lDMNJo+73Flv5Xlof+dIveC3voGoToAz+HPi3OebvHQE7jd+v4uyb0ttZ5XM8Ni3q
         H6bIZutFq9ieZfOMyyj7aXHxosBtin833HyBL1fikiDoAz+2prLRTjJKyh5VRICPZXOq
         glV1NBOBpuPx31S+Z6Z83QZtYB1vfC6std2icaRk4tTkHLCRi1Sh/wBcofm+wrkMdvJI
         HILA==
X-Gm-Message-State: AOAM532fZ4yfzX1RF0U7uBGOTP6aql01f8YLtiYMIpRttZc2+CQyMxbV
        gHlx9JsVxlsGkRNhBpthVMYPXA==
X-Google-Smtp-Source: ABdhPJzIa5O3cMvuafw6M6JqsvV9/GygQAIh8T7eOMf7z+MaNcc/rzLLg6xADVx25y95wFRUKMw1cg==
X-Received: by 2002:a17:906:12cf:: with SMTP id l15mr17565338ejb.540.1607327177482;
        Sun, 06 Dec 2020 23:46:17 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id z96sm5951767ede.81.2020.12.06.23.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 23:46:16 -0800 (PST)
From:   "javier.gonz@samsung.com" <javier@javigon.com>
X-Google-Original-From: "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Date:   Mon, 7 Dec 2020 08:46:16 +0100
To:     Keith Busch <kbusch@kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
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
        "joshi.k@samsung.com" <joshi.k@samsung.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201207074616.mocdy6m5qgsn6yqg@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <CH2PR04MB6522F1188557C829285ED5E8E7F10@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201204144003.GA8868@redsun51.ssa.fujisawa.hgst.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.2020 23:40, Keith Busch wrote:
>On Fri, Dec 04, 2020 at 11:25:12AM +0000, Damien Le Moal wrote:
>> On 2020/12/04 20:02, SelvaKumar S wrote:
>> > This patchset tries to add support for TP4065a ("Simple Copy Command"),
>> > v2020.05.04 ("Ratified")
>> >
>> > The Specification can be found in following link.
>> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>> >
>> > This is an RFC. Looking forward for any feedbacks or other alternate
>> > designs for plumbing simple copy to IO stack.
>> >
>> > Simple copy command is a copy offloading operation and is  used to copy
>> > multiple contiguous ranges (source_ranges) of LBA's to a single destination
>> > LBA within the device reducing traffic between host and device.
>> >
>> > This implementation accepts destination, no of sources and arrays of
>> > source ranges from application and attach it as payload to the bio and
>> > submits to the device.
>> >
>> > Following limits are added to queue limits and are exposed in sysfs
>> > to userspace
>> > 	- *max_copy_sectors* limits the sum of all source_range length
>> > 	- *max_copy_nr_ranges* limits the number of source ranges
>> > 	- *max_copy_range_sectors* limit the maximum number of sectors
>> > 		that can constitute a single source range.
>>
>> Same comment as before. I think this is a good start, but for this to be really
>> useful to users and kernel components alike, this really needs copy emulation
>> for drives that do not have a native copy feature, similarly to what write zeros
>> handling for instance: if the drive does not have a copy command (simple copy
>> for NVMe or XCOPY for scsi), then the block layer should issue read/write
>> commands to seamlessly execute the copy. Otherwise, this will only serve a small
>> niche for users and will not be optimal for FS and DM drivers that could be
>> simplified with a generic block layer copy functionality.
>>
>> This is my 10 cents though, others may differ about this.
>
>Yes, I agree that copy emulation support should be included with the
>hardware enabled solution.

Keith, Damien,

Can we do the block layer emulation with this patchset and then work in
follow-up patchses on (i) the FS interface with F2FS as a first user and
(ii) other HW accelerations such as XCOPY?

For XCOPY, I believe we need to have a separate discussion as much works
is already done that we should align to.

