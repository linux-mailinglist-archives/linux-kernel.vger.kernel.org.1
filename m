Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE242AF5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKKQOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60283 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgKKQOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605111286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNmitRVzUahYS3GrlN33sdc6QVEpN2b81fRVhBIhVJk=;
        b=MphhOb8HJAWNAm/WfQtdWz/AHxVVcYtrbIeKNKBAId50g8wZRWFb529aaQrk88ZrBGI5z2
        z2aoUxzWlTgxVy9FFW/C030zJD/hdIsBstCYmRy2BaMjN5rySjuxjJGxVuRQ8KEbLHLBiS
        IoHep2xy+UVAvfNsGO9MmSO0YXsdiaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-8kponIxNNXSVh1rBe67kMw-1; Wed, 11 Nov 2020 11:14:41 -0500
X-MC-Unique: 8kponIxNNXSVh1rBe67kMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38F7C10866BD;
        Wed, 11 Nov 2020 16:14:39 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33D8B5C62B;
        Wed, 11 Nov 2020 16:14:29 +0000 (UTC)
Subject: Re: "irq 4: Affinity broken due to vector space exhaustion." warning
 on restart of ttyS0 console
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
References: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
 <871rh1gcck.fsf@nanos.tec.linutronix.de>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <1ca766a6-3acf-9639-82e2-e2dd378d9768@redhat.com>
Date:   Wed, 11 Nov 2020 11:14:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <871rh1gcck.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/20 3:56 PM, Thomas Gleixner wrote:
> Prarit,
> 
> On Tue, Nov 10 2020 at 14:24, Prarit Bhargava wrote:
>> Occasionally when logging out of the ttyS0 aka serial console I see that
>>
>> 	irq 4: Affinity broken due to vector space exhaustion.
>>
>> *** console shutdown, IRQ released for cpu on socket 1
>> *** console starts back up again, IRQ assigned to on cpu on socket 0
>>
>> In this process, however, the smp_affinity is not cleared for IRQ4.  That is, it
>> remains as
>>
>> /proc/irq/4/smp_affinity:ffffff00,0000ffff,ff000000
>>
>> so that the check in activate_reserved() fails and
>>
>> "irq 4: Affinity broken due to vector space exhaustion."
>>
>> is output to the screen.
>>
>> I am not sure of correct fix here.  It looks like the smp_affinity should be
>> reset to default at irq shutdown, however, I cannot determine if that should be
>> done for every IRQ, or (hopefully not) per driver.
> 
> This has been that way forever and there was a discussion about this
> at least 15 years ago. I can't find it at the moment because I can't
> access my archives and I failed to find the conversation on lore.
> 
> But here is the gist:
> 
> At some point I actually wanted to reset the affinity mask to the
> default affinity mask in free_irq() when the last action was
> removed.
> 
> That broke setups where the affinity of the serial console interrupt,
> was set to some specific CPU by the admin and then it was moved to some
> other place due to logout -> shutdown -> startup.
> 
> So we left the historic behaviour untouched.
> 
> So now you are complaining about it the other way round and I have to
> tell you that there is no correct fix neither in the core nor in a
> driver.
> 
> The real problem is irqbalanced aggressively exhausting the vector space
> of a _whole_ socket to the point that there is not a single vector left
> for serial. That's the problem you want to fix.

Thanks tglx.  I'll go figure this out with the irqbalanced team.

P.

> 
> Thanks,
> 
>         tglx
> 

