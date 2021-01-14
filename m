Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D82F6CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbhANVNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:13:50 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:38479 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhANVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:13:50 -0500
Received: by mail-pl1-f174.google.com with SMTP id d4so3567351plh.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lILcV9lGpcYwLH/f4hE5iJYnR0RUSWFbyKBcHaYumrw=;
        b=Y5om9A0nsurB2tRFhe2+UN1nvc86a+rIBnsMH+aQNHoVa4nMoju0JJkSpf0JzIRaYk
         5XW9NQ25WEErtv2WxRXmeNOQyD/QIOpPvTm4HTkpKyYjTxsCfQ0j8bPxcrJtBeOhsTC9
         50t5ydpUeZYOTkL0khrNW39sv2C6loANC8s/hmQnt+V6stUwark7SVuCTYJa57LE3jl8
         zyQMBTF+AfhgTb3R+2UkIUUyxHBizqOu9wL336rxAo5Z/MNG5Gqnd19nRvcXbChRK9cs
         cyf95v9AJeMTAuGVws6v2BeUzIQMk2ZE5jJGu9tUYJ2bbFxhGfjWIGDUTyAAYc8PqvD0
         a7PA==
X-Gm-Message-State: AOAM533SVaGJOu56kIkO9890xSDSV+3XAz1kwCAI9tG7hb0fUIHw/nxv
        own3w3LjDtzaWjV90JH9sUvslejvNBI=
X-Google-Smtp-Source: ABdhPJysZe9vATAenDzmAiexF6dizEPR9KSIE1x4wusHm6L+J7Q9GDs5sT7yBXsyS2sYDwbSJi4wOw==
X-Received: by 2002:a17:90a:4689:: with SMTP id z9mr6953932pjf.87.1610658789665;
        Thu, 14 Jan 2021 13:13:09 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:9240:50d6:cd00:1b14? ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
        by smtp.gmail.com with ESMTPSA id 186sm6067519pfx.100.2021.01.14.13.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 13:13:08 -0800 (PST)
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Li Feng <fengli@smartx.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lifeng1519@gmail.com" <lifeng1519@gmail.com>
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
 <20210114174311.GB31188@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <74a92460-d681-8ec6-9df1-e33a5530160a@grimberg.me>
Date:   Thu, 14 Jan 2021 13:13:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114174311.GB31188@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> But this only catches a physical block size < 512 for NVMe, not any other block device.
>>>
>>> Please fix it for the general case in blk_queue_physical_block_size().
>>
>> We actually call that later and would probably be better to check here..
> 
> We had a series for that a short while ago that got lost.

What was it called?
