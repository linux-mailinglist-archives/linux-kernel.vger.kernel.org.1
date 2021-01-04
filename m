Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656DC2E9279
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhADJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:20:45 -0500
Received: from ptr.189.cn ([183.61.185.104]:11121 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbhADJUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:20:45 -0500
HMM_SOURCE_IP: 172.27.8.53:45007.854460484
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [172.27.8.53])
        by 189.cn (HERMES) with SMTP id 10A2F100765;
        Mon,  4 Jan 2021 17:17:42 +0800 (CST)
Received: from  ([123.150.8.42])
        by SZ-WEBMAIL05 with ESMTP id 5446c96dc6fd4d3a80c4ddea2129cbf1 for hsweeten@visionengravers.com;
        Mon Jan  4 17:17:58 2021
X-Transaction-ID: 5446c96dc6fd4d3a80c4ddea2129cbf1
X-filter-score: 
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Subject: Re: [PATCH v2] staging: board: Remove macro board_staging
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        sfr@canb.auug.org.au, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
References: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
 <X/LauHVX4EPvuzU4@kroah.com>
From:   "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <267d48f8-395f-c14b-b166-e2e6c5a5be44@189.cn>
Date:   Mon, 4 Jan 2021 17:17:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/LauHVX4EPvuzU4@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/1/4 ÏÂÎç5:07, Greg KH Ð´µÀ:
> On Mon, Jan 04, 2021 at 04:55:46PM +0800, Song Chen wrote:
>> Macro is not supposed to have flow control in it's
>> statement, remove.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>>
>> ---
>> Changes in v2:
>> 1, kzm9d_init and armadillo800eva_init are not compatible
>> with the definition of device_initcall, fixed.
> 
> I already applied v1, so what am I supposed to do here?

In https://lore.kernel.org/lkml/20170220175506.GA30142@kroah.com/, it
seems that kernel can live with the checkpatch warning messages of 
"Macro is not supposed to have flow control in it's statement" in
driver/staging/board. If so, please drop the patch.

Sorry for the trouble.

Song
> 
> thanks,
> 
> greg k-h
> 
