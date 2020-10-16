Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A548E28FFC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405042AbgJPIKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405000AbgJPIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602835830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raiMjzXfAaqrrxS6tLwOK468SKq4ScIhA6jKxC9X91w=;
        b=UaRhF1nFSYXZkNN580tLJi3UoAZ7jZcaP+vDtoQ2+2FSKD/LQKLyrRVDpyJnYDOXw1W4D6
        F4RmX2zt77tZcpZWE9Q4sTZvXMyuApEtBIaCzmv0ZlpN6bpJ9LqtEscspwemP5lATNT2QE
        g3bBACQ1CQ+EfbFzbgg0Q17UgFwav3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-Y8HgBloHN42pBKad04K4Xw-1; Fri, 16 Oct 2020 04:10:26 -0400
X-MC-Unique: Y8HgBloHN42pBKad04K4Xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E78D31015ECD;
        Fri, 16 Oct 2020 08:10:23 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42B4E5C1BD;
        Fri, 16 Oct 2020 08:10:21 +0000 (UTC)
Subject: Re: [PATCH V2] scripts: spelling: Remove space in the entry memry to
 memory
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joe Perches <joe@perches.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, sfr@canb.auug.org.au, wangqing@vivo.com,
        xndchn@gmail.com, luca@lucaceresoli.net, ebiggers@google.com,
        linux-kernel@vger.kernel.org
References: <20201015132336.1770828-1-unixbhaskar@gmail.com>
 <796974d4de89d1e8483d16f4f1f3d6324b49bf86.camel@perches.com>
 <20201015135407.GB1899805@ArchLinux>
 <f479c3b907279ba79391ae1d4ec27773a79ffd15.camel@perches.com>
 <20201015224919.GA1129531@ArchLinux>
 <d8237d5151e108f969628302c22e27dda3860bdd.camel@perches.com>
 <20201015225558.GB1129531@ArchLinux>
 <a03bbb48d2e8b27a2469e91500b264019bbfc33b.camel@perches.com>
 <20201015230842.GC1129531@ArchLinux>
 <943aabb5a27dc58321cb4a8e53e7b2c12cd791dc.camel@perches.com>
 <20201016034936.GA1142048@ArchLinux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eb71aa65-20c1-44e9-4104-582be44c4f7a@redhat.com>
Date:   Fri, 16 Oct 2020 10:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016034936.GA1142048@ArchLinux>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.20 05:49, Bhaskar Chowdhury wrote:
> On 20:19 Thu 15 Oct 2020, Joe Perches wrote:
>> On Fri, 2020-10-16 at 04:38 +0530, Bhaskar Chowdhury wrote:
>>> On 16:06 Thu 15 Oct 2020, Joe Perches wrote:
>>>> On Fri, 2020-10-16 at 04:25 +0530, Bhaskar Chowdhury wrote:
>>>>> You have all flawed understanding...please stay away ..
>>>>> if you don't understand something...
>>>>
>>>> <chuckle>  You're funny.
>>>>
>>>> You're wrong, but you're still funny.
>>>>
>>>>
>>> ROFL ..you too...what a waste of time ...shame that I am engage this kind of
>>> conversation ...heck
>>
>> Your tone doesn't become you.
> Same  goes you too...
> 
>> Please try to be polite next time.
> 
> Please stop sending unnecessary "reviews" too. Thanks. If I need ,I will ask.
> 
> Well, didn't I appreciate your feedback first time?? It the following that
> stupid and garbage .
> 
>> I'm rather familiar with the appropriate process.
>>
>> $ git shortlog -n -s --author="Joe Perches" --author="Bhaskar Chowdhury"
>>   3227  Joe Perches
>>      8  Bhaskar Chowdhury
>>      1  Joe Perches via samba-technical
> 
> Never doubt that ..but you clinging on something not true is surprise me...I
> believe you do better next time.
> 
> This is the most "useless" thread I have ever been...
> 
> Stop propagating it ...>
> 

Honestly, I really don't want to wake up, check my mails, and read such 
toxic crap. Stop it, this is not how we communicate on these lists. Period.

If you have the urge to scream at each other (or make fun of each 
other), do that off-list (or even better: don't!).


I haven't read the whole discussion, here is my understanding:


A new patch series version supersedes older ones, meaning it should be 
completely self-contained. Just as if you're buying a new version of a 
car, they won't be sending parts to replace.

Imagine you're at V37, no reviewer will go through v1..V37 and apply 
delta updates. When a reviewer sees a new version, the old ones are 
discarded.

Now, when it comes to *simple fixups* like here, the process depends a 
little bit on the subsystem + maintainer, and it's best to ask how to 
proceed.

Option 1: Send a new version that's completely self-contained.

Option 2: Ask the maintainer to fixup while applying/before sending 
upstream.

Option 3: Send an *unversioned* fixup patch as reply to the problematic 
patch and ask to squash that into the original patch.


Of course, it's different when the patch is already upstream. Then, a 
fix/cleanup should mention the original, problematic commit.

-- 
Thanks,

David / dhildenb

