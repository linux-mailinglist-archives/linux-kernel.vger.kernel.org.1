Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC19F2675CF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgIKWW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:22:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D20DC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=oH4+VZ5qNTrxbXD6qZNE4hi3fUey1bDby/KSt3LE3hA=; b=zRHFg11fPZXt8J8CzVGvX13pok
        aUbQTklTiyP49IKV5wJPwFdE9fgXNKZ8Icd81H1KlhyiFwYLd258VjGRmfvPN7SoSTtUY292wyrUV
        y8HsZMc/b049GqfjN+b5cyk4+Tqf7RSWEqQWEGHbjjdS3id0nvvOjAB/n95nRNwYFWxFoKcp42IgI
        S3rpPfaU7+McwFjUSqlatYtrBLD10zZZSlMAi+AXdl0qtml4sChYWcYaj/NHKIENXfGd+N1LKAjP7
        rZZTCtyrLROm8Mr1WtPzTDpMS0r1LQYjRG6Bgs/jaU1wNhDgo5xX4sD/0bkaTj8AmbS2MRvRGu9Fd
        6+x0f+7Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGrQy-0000D4-IG; Fri, 11 Sep 2020 22:22:20 +0000
Subject: Re: first bad commit: [5795eb443060148796beeba106e4366d7f1458a6]
 scsi: sd_zbc: emulate ZONE_APPEND commands
To:     Borislav Petkov <bp@alien8.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200911195312.GA4110@zn.tnic>
 <20200911221759.GA2869@nazgul.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d7549a8f-ec57-7cee-577e-902f70c8bd42@infradead.org>
Date:   Fri, 11 Sep 2020 15:22:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911221759.GA2869@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 3:17 PM, Borislav Petkov wrote:
> On Fri, Sep 11, 2020 at 09:53:12PM +0200, Borislav Petkov wrote:
>> Now, looking at that patch:
>>
>>   5795eb443060 ("scsi: sd_zbc: emulate ZONE_APPEND commands")
>>
>> yeah, that doesn't revert cleanly. But it talks about zoned-something
>> devices and that rings a bell because you guys broke my zoned device
>> once already:
> 
> Ok, so Johannes and I poked a bit on IRC and here it is:
> 
> # CONFIG_BLK_DEV_ZONED is not set.
> 
> Enabling it, fixes the issue.
> 

Uh, you are not saying that enabling that CONFIG_ is the final fix, are you?

If so, do I need to enable it, even if I don't have a zoned block device?


-- 
~Randy

