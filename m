Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC921427B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 03:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGDBM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 21:12:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726474AbgGDBMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 21:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593825142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8o3SmCvG5EDMPf5SeEgtVL0n4pj+i02jDqrnT9kbL70=;
        b=ep2jcG/OU1c/BuKD+lrDa5W321SlHtTDVNVPNk1f/cAZAaZbL9jOVa3/MgfhKe+0tozfmd
        iKXuaJ9AqPZ73VMg7uWLDlAAl8yUNBHqEiHqZcAYtz5djVriYmOVTJCoUA11tsfnDjnrWp
        zDlNODlz2WdDzkI3BlceINb4JNU0qXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-psOph18HMrexNlfmfs6uGw-1; Fri, 03 Jul 2020 21:12:18 -0400
X-MC-Unique: psOph18HMrexNlfmfs6uGw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E6261005510;
        Sat,  4 Jul 2020 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-175.pek2.redhat.com [10.72.12.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 857655F9DC;
        Sat,  4 Jul 2020 01:12:09 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
 <87zh8imgs5.fsf@jogness.linutronix.de>
 <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
 <20200702133110.GE14288@alley>
From:   lijiang <lijiang@redhat.com>
Message-ID: <56266e04-56b2-41fa-fff1-c3437ddec929@redhat.com>
Date:   Sat, 4 Jul 2020 09:12:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200702133110.GE14288@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020年07月02日 21:31, Petr Mladek 写道:
> On Thu 2020-07-02 17:43:22, lijiang wrote:
>> 在 2020年07月02日 17:02, John Ogness 写道:
>>> On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
>>>> About the VMCOREINFO part, I made some tests based on the kernel patch
>>>> v3, the makedumpfile and crash-utility can work as expected with your
>>>> patch(userspace patch), but, unfortunately, the vmcore-dmesg(kexec-tools)
>>>> can't correctly read the printk ring buffer information, and get the
>>>> following error:
>>>>
>>>> "Missing the log_buf symbol"
>>>>
>>>> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
>>>> in the makedumpfile and crash-utility.
>>>
>>> Yes, a patch for this is needed (as well as for any other related
>>> software floating around the internet).
>>>
>>> I have no RFC patches for vmcore-dmesg. Looking at the code, I think it
>>> would be quite straight forward to port the makedumpfile patch. I will
>>
>> Yes, it should be a similar patch.
>>
>>> try to make some time for this.
>>>
>> That would be nice. Thank you, John Ogness.
>>
>>> I do not want to patch any other software for this. I think with 3
>>> examples (crash, makedumpfile, vmcore-dmesg), others should be able to
>>
>> It's good enough to have the patch for the makedumpfile, crash and vmcore-dmesg,
>> which can ensure the kdump(userspace) work well.
> 
> I agree that this three are the most important ones and should be
> enough.
> 
> Thanks a lot for working on it and testing it.
> 
My pleasure. I will test the vmcore-dmesg later.

Thanks.
Lianbo

> Best Regards,
> Petr
> 

