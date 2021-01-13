Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5322F4213
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbhAMCwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbhAMCwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:52:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3804DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Y3cSTQ7bwTuCw33mdA1gB8+xZ8waUgpIwwqi/7rCY+M=; b=VwRLdWCa3EozsDMTNj4Hs/PJhH
        3WU1I0bIT37QvoPraUFi4CbsdFqxPBPSRvxWsu0GTXJK5dGk/qJ+mgakId3r781X49+S3HNh1Yc80
        SQbFIBQEV0cXY09CA2LNqAeRCsqiK0yoo+5KPKlxkuJzuWzhqbyXz0RN8ArXVBt2cb2f4KD3up5JE
        6lyMLVJARPcFmMuzDvifxIJslCDQw6xoYs8dFyzFyIlp4OKakZpsou/s/y8PTYTmuci7a5zWpTyoN
        B63KTkeeKafh7SLd/APOMsomd/l6aV6iB0lgiFzv2coGz4sVOJAb2QhjeJzCxii+pXeUsbqjK7RG9
        ZXO2ZEOw==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzWGE-0007uQ-Jb; Wed, 13 Jan 2021 02:51:50 +0000
Subject: Re: [PATCH V4] arch: kernel: cpu: x86/resctrl: Takes a letter away
 and append a colon to match below struct member
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
References: <20210113020333.29803-1-unixbhaskar@gmail.com>
 <f20be5e1-a2a6-14d4-5813-1fb716783bb2@embeddedor.com>
 <20210113024838.GA28337@debian>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6e94a78-9841-96bb-f07f-4bd01d6a6903@infradead.org>
Date:   Tue, 12 Jan 2021 18:51:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113024838.GA28337@debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 6:48 PM, Bhaskar Chowdhury wrote:
> On 20:24 Tue 12 Jan 2021, Gustavo A. R. Silva wrote:
>>
>>
>> On 1/12/21 20:03, Bhaskar Chowdhury wrote:
>>> s/kernlfs/kernfs/
>>> s/@mon_data_kn/@mon_data_kn:/
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>> Changes from V3: Fix the subject line typo stuc to struct and mention cpu architecture
>>
>> ...and what changed from v1 to v2 and from v2 to v3?
>>
> 
> Gustavo, it seems you are not following up properly ....could you please put
> little more effort for know it????
> 
> There were mails....pls scan and read ..


All of these version change logs should be in this patch, under the "---" line.


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
