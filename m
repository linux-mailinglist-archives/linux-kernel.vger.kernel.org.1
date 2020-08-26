Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83A4252437
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 01:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHYXct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 19:32:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbgHYXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598398367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iNZwRJs0PD9iKsaLBqotm4UwZlEiqVWYFVG+uF+ypPo=;
        b=aCptvD7RnRLZc5E7/MoBHRbfmS/7zcuAikd6vdEeIgJtTpjbvFTKnT+g6v4v6R1GKwbR21
        u+yX65AwlmvVLPoCKZNNI5YZ2q/5h+9hbQdw8XMEKLNRYfXS+MYeUdi4M82ufct0+Zzc2+
        jrUA/MaRhXJtjt3pOVZI6P2ddIIjxdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-nQGTg9oSMM-q7GISHw33yQ-1; Tue, 25 Aug 2020 19:32:43 -0400
X-MC-Unique: nQGTg9oSMM-q7GISHw33yQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 279CA805EE2;
        Tue, 25 Aug 2020 23:32:42 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E0271002396;
        Tue, 25 Aug 2020 23:32:41 +0000 (UTC)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwg?=
 =?UTF-8?Q?cpu_hotplug_callback?=
From:   Waiman Long <longman@redhat.com>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "elver@google.com" <elver@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20200820032453.5222-1-qiang.zhang@windriver.com>
 <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
 <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
Organization: Red Hat
Message-ID: <d1255075-e273-a74d-3bc7-d97b320470db@redhat.com>
Date:   Tue, 25 Aug 2020 19:32:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 6:26 PM, Waiman Long wrote:
> On 8/25/20 12:53 AM, Zhang, Qiang wrote:
>> ________________________________________
>> ������: linux-kernel-owner@vger.kernel.org 
>> <linux-kernel-owner@vger.kernel.org> ���� qiang.zhang@windriver.com 
>> <qiang.zhang@windriver.com>
>> ����ʱ��: 2020��8��20�� 11:24
>> �ռ���: tglx@linutronix.de; elver@google.com; longman@redhat.com
>> ����: linux-kernel@vger.kernel.org
>> ����: [PATCH] debugobjects: install cpu hotplug callback
>>
>> From: Zqiang <qiang.zhang@windriver.com>
>>
>> When a cpu going offline, we should free objects in "percpu_obj_pool"
>> free_objs list which corresponding to this cpu.
>
> The percpu free object pool is supposed to be accessed only by that 
> particular cpu without any lock. Trying to access it from another cpu 
> can cause a race condition unless one can make sure that the offline 
> cpu won't become online in the mean time. There shouldn't be too many 
> free objects in the percpu pool. Is it worth the effort to free them? 

Or if you can make the to-be-offlined cpu free the debugobjs before it 
is offlined. That will work too.

Cheers,
Longman

