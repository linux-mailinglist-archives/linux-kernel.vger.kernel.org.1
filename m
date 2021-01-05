Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDF32EB359
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbhAETJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:09:14 -0500
Received: from gecko.sbs.de ([194.138.37.40]:42433 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbhAETJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:09:14 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 105J8N2F006362
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jan 2021 20:08:23 +0100
Received: from [167.87.32.120] ([167.87.32.120])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 105J8MIv030651;
        Tue, 5 Jan 2021 20:08:22 +0100
Subject: Re: [PATCH v2] scripts/gdb: fix list_for_each
To:     George Prekas <prekageo@amazon.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <4ae23bb1-c333-f669-da2d-fa35c4f49018@amazon.com>
 <04baeb3e-4b46-ae3a-b4e1-4663d1510b05@amazon.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cef588b9-ad70-e840-7cc6-f1896ccfcbbf@siemens.com>
Date:   Tue, 5 Jan 2021 20:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <04baeb3e-4b46-ae3a-b4e1-4663d1510b05@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.21 17:51, George Prekas wrote:
> On 9/24/2020 9:20 AM, George Prekas wrote:
>> If the list is uninitialized (next pointer is NULL), list_for_each gets
>> stuck in an infinite loop. Print a message and treat list as empty.
>>
>> Signed-off-by: George Prekas <prekageo@amazon.com>
>> ---
>>  scripts/gdb/linux/lists.py | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/scripts/gdb/linux/lists.py b/scripts/gdb/linux/lists.py
>> index c487ddf09d38..bae4d70b7eae 100644
>> --- a/scripts/gdb/linux/lists.py
>> +++ b/scripts/gdb/linux/lists.py
>> @@ -27,6 +27,11 @@ def list_for_each(head):
>>          raise TypeError("Must be struct list_head not {}"
>>                             .format(head.type))
>>
>> +    if head['next'] == 0:
>> +        gdb.write("list_for_each: Uninitialized list '{}' treated as
>> empty\n"
>> +                     .format(head.address))
>> +        return
>> +
>>      node = head['next'].dereference()
>>      while node.address != head.address:
>>          yield node.address
> 
> Happy New Year!

Same to you!

> 
> Any updates on this?
> 

Sorry, slipped through.

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Andrew, please pick this up.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
