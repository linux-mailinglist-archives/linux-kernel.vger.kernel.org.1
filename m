Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79102675FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgIKWib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgIKWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:38:30 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9104BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=t7Z/d4twZtMQadL8AhLcFYmnmDZ4zjmrd51K7ZpbTXg=; b=vl/Sw9RYKUQXjFkK8CASehBBVD
        dK79d+YG8eGaMIkRqbH7GkHW0e+tAaH7wCaRTL2Q3GIK8G9ENjoS7mMVJ9Rodz82Aord0C4GsaHSD
        cwhyK4pnEyTZGGQyDlxyDCsYRG4fL7olt97ISMWEkWUlQGHMxi8NIKn2ExpH/lTZpdn6z7iDB65qx
        H2ujlSEW99aING+WSmpumVL8LsLZBggHlShd4Y44Ku99KufzURuY7q56VExzIAj8s885/DI1RUP6T
        /Z2ZLwtFMAsRpZA2yjHngHwTDUfU9S54PfCStG+MuT1yT7V6+hKcKiZy09kchGP4L+npRm0K9Ykbz
        5wP6Nbyw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGrgX-0001fp-Jk; Fri, 11 Sep 2020 22:38:25 +0000
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Borislav Petkov <bp@alien8.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic>
 <d7549a8f-ec57-7cee-577e-902f70c8bd42@infradead.org>
 <SN4PR0401MB3598C3B9A281C3748D24954C9B240@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f714044-3254-fca4-172a-a947d725c316@infradead.org>
Date:   Fri, 11 Sep 2020 15:38:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598C3B9A281C3748D24954C9B240@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 3:26 PM, Johannes Thumshirn wrote:
> On 12/09/2020 00:22, Randy Dunlap wrote:
>> On 9/11/20 3:17 PM, Borislav Petkov wrote:
>>> On Fri, Sep 11, 2020 at 09:53:12PM +0200, Borislav Petkov wrote:
>>>> Now, looking at that patch:
>>>>
>>>>   5795eb443060 ("scsi: sd_zbc: emulate ZONE_APPEND commands")
>>>>
>>>> yeah, that doesn't revert cleanly. But it talks about zoned-something
>>>> devices and that rings a bell because you guys broke my zoned device
>>>> once already:
>>>
>>> Ok, so Johannes and I poked a bit on IRC and here it is:
>>>
>>> # CONFIG_BLK_DEV_ZONED is not set.
>>>
>>> Enabling it, fixes the issue.
>>>
>>
>> Uh, you are not saying that enabling that CONFIG_ is the final fix, are you?
>>
>> If so, do I need to enable it, even if I don't have a zoned block device?
>>
> 
> No he does have a zoned block device and no this is not the final fix, I 
> think one of the stubbed out functions is broken, but it's midnight here
> so we're calling it a day and chime back in on Monday.

Sure, thanks for the answers.


> And this setup is a bit special, as Boris is using partitions on a host-aware
> zoned block device which is somewhat exotic (see add_partition()).
> 
> Byte,

?  :)


-- 
~Randy

