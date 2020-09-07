Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56425F290
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 06:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgIGEoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 00:44:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24303 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgIGEod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:44:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BlG093H7Vz9twhX;
        Mon,  7 Sep 2020 06:44:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4jSMXyYyLRd9; Mon,  7 Sep 2020 06:44:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BlG091y3mz9twhW;
        Mon,  7 Sep 2020 06:44:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E2E88B779;
        Mon,  7 Sep 2020 06:44:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id J1ciJfXJXz2l; Mon,  7 Sep 2020 06:44:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A193B8B75B;
        Mon,  7 Sep 2020 06:44:28 +0200 (CEST)
Subject: Re: [PATCH] /dev/zero: also implement ->read
To:     David Laight <David.Laight@ACULAB.COM>,
        Pavel Machek <pavel@denx.de>
Cc:     Christoph Hellwig <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
 <20200906182122.GA12295@amd>
 <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
 <f2e9c57db2b548949e6bd570a6dc3c5d@AcuMS.aculab.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7ece832b-e2b7-04af-f4bb-e84c909ee332@csgroup.eu>
Date:   Mon, 7 Sep 2020 06:44:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f2e9c57db2b548949e6bd570a6dc3c5d@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/09/2020 à 22:52, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 06 September 2020 19:36
>> Hi,
>>
>> Le 06/09/2020 à 20:21, Pavel Machek a écrit :
>>> Hi!
>>>
>>>>>> Christophe reported a major speedup due to avoiding the iov_iter
>>>>>> overhead, so just add this trivial function.  Note that /dev/zero
>>>>>> already implements both an iter and non-iter writes so this just
>>>>>> makes it more symmetric.
>>>>>>
>>>>>> Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>>
>>>>> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>
>>>> Any idea what has happened to make the 'iter' version so bad?
>>>
>>> Exactly. Also it would be nice to note how the speedup was measured
>>> and what the speedup is.
>>>
>>
>> Was measured on an 8xx powerpc running at 132MHz with:
>>
>> 	dd if=/dev/zero of=/dev/null count=1M
>>
>> With the patch, dd displays a throughput of 113.5MB/s
>> Without the patch it is 99.9MB/s
> 
> That in itself isn't a problem.
> What was the throughput before any of these patches?
> 
> I just remember another thread about the same test running
> a lot slower after one of the related changes.

> While this speeds up read /dev/zero (which is uncommon)
> if this is needed to get near the old performance then
> the changes to the 'iter' code will affect real workloads.

If you are talking about the tests around the set_fs series from 
Christoph, I identified that the degradation was linked to 
CONFIG_STACKPROTECTOR_STRONG being selected by default, which provides 
unreliable results from one patch to another, GCC doing some strange 
things linked to unrelated changes.

With CONFIG_STACKPROTECTOR set to N, I get stable performance and no 
degradation with any of the patches of the set_fs series.

Christophe
