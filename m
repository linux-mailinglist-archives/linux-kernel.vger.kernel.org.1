Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE50C1C4040
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 18:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgEDQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgEDQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:41:58 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC399C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 09:41:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s10so11851149iln.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o+OExAmgyirreBNQZz1mdzV+UOlsl91T24IoRPDTUCA=;
        b=F1xfOa3kXWTYolMLtey19TxDsFE0OVOmGFGXXfzZzeHq6Gq2eYJNzidg0G69JvwZY8
         lVv/XrEzU8O49UtzvJe6YqyZi7d3+ayYhbnmazX9FZvG1VpGuTYl/CTkfWWGxw7dxKGX
         8RB1X5d0fInxVY/9CA/mbxNjIYPCO85Vj5z2ChREefZA8zvo0a7ptA3YRya/4ZmucFwO
         D/MG+YTf8WvACUS2237dItdL+U9M7unu3NRWe7Fltx72XWkqwz2qMlWSP3E5XlCnBGx9
         DK9KMNtHed00BpweFl5P8s9V8xDsWysRZrUsyMAYHKjgxAvyG0OJE2rhI37J0GsBKNhm
         nwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+OExAmgyirreBNQZz1mdzV+UOlsl91T24IoRPDTUCA=;
        b=c8pfDjEa3V1grTjyR8OiCmKCnj0eKVZXEMUVFQ8vIY95U/PqBCMENZ5WvIPCC5ObIz
         jxyqyKEIoJzqOODIbgb8SNc5RXlmgazysPuqGXKY1u9/JX4vwVeYAsYFM98j7UViHmsD
         07ZAB5LXRQgB1Bug/USBN9ZuRQmP0OLG0nN0g9z3698OZr2SsH0xHkaX5VdOm8NdIaYK
         M0vjOjVXMzjnGHgcM/zwBrzsb7cZ+rej2nhjJoOiNXly8IQSNKsu4jXfHhPa4WPuJ14S
         B/m4+msHNvPdbUyaBrn7JYcHDKU8Q0an8oSypD1bQmAAfsgnK4ILGevrfp3gdELHmAlq
         7T1A==
X-Gm-Message-State: AGi0PuZ+PUSglJI/mVff17XaV/6VChpURzyN223WeoH3M2Ltb9dCf/YP
        mL5A4b2GDXba5l+QeV5WLeBHMA==
X-Google-Smtp-Source: APiQypK3isUqB2C2sabeTTpk6n8V8noFEi6QUtgDDorDERlY5R+gZMBGol53QwqsH9zC6HzIIbmnWg==
X-Received: by 2002:a92:41c6:: with SMTP id o189mr16632128ila.157.1588610516971;
        Mon, 04 May 2020 09:41:56 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t88sm5381273ild.30.2020.05.04.09.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:41:56 -0700 (PDT)
Subject: Re: [PATCH 5/7] hfsplus: stop using ioctl_by_bdev
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20200425075706.721917-1-hch@lst.de>
 <20200425075706.721917-6-hch@lst.de>
 <6c47f731-7bff-f186-da55-7ce6cffacdc3@kernel.dk>
 <20200504162114.GA637@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6cbb8166-a419-9322-78ee-51fbec22b59d@kernel.dk>
Date:   Mon, 4 May 2020 10:41:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504162114.GA637@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 10:21 AM, Christoph Hellwig wrote:
> On Mon, May 04, 2020 at 10:16:40AM -0600, Jens Axboe wrote:
>> On 4/25/20 1:57 AM, Christoph Hellwig wrote:
>>>  	if (HFSPLUS_SB(sb)->session >= 0) {
>>> +		struct cdrom_tocentry te;
>>> +
>>> +		if (!cdi)
>>> +			return -EINVAL;
>>> +
>>>  		te.cdte_track = HFSPLUS_SB(sb)->session;
>>>  		te.cdte_format = CDROM_LBA;
>>> -		res = ioctl_by_bdev(sb->s_bdev,
>>> -			CDROMREADTOCENTRY, (unsigned long)&te);
>>> -		if (!res && (te.cdte_ctrl & CDROM_DATA_TRACK) == 4) {
>>> -			*start = (sector_t)te.cdte_addr.lba << 2;
>>> -			return 0;
>>> +		if (cdrom_read_tocentry(cdi, &te) ||
>>> +		    (te.cdte_ctrl & CDROM_DATA_TRACK) != 4) {
>>> +			pr_err("invalid session number or type of track\n");
>>> +			return -EINVAL;
>>>  		}
>>
>> I must be missing something obvious from just looking over the patches,
>> but how does this work if cdrom is modular and hfsplus is builtin?
> 
> In that case disk_to_cdi will return NULL as it uses IS_REACHABLE
> and the file systems won't query the CD-ROM specific information.

Got it, looks like that'll do the trick without nasty Kconfig
dependencies.

-- 
Jens Axboe

