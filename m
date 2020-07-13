Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B011A2194AF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 01:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgGHXyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 19:54:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52750 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgGHXyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594252479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtrdIs9PFK4eESgNJshnXKkRcQvqs7rbt6XjlBm0KbQ=;
        b=gVEkId32pSu3TsCKcuMDerd9OCvfEATEpSGmSEv25aqpxmzrCH0oOwDVuR+QRSSDMKQaT2
        ZD6t+JX2Bi90jgfiRuCbey+okavXUkgiQkAKyuukHSNsoG7EbcJJ6s/PehPi/rZtI4kpZR
        LDRve4/NU7wrtMEnBnEq+S5Z9GcWf4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-uUzGLLqxNBSRxBpviTCmyg-1; Wed, 08 Jul 2020 19:54:37 -0400
X-MC-Unique: uUzGLLqxNBSRxBpviTCmyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA4D98027B1;
        Wed,  8 Jul 2020 23:54:35 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-205.rdu2.redhat.com [10.10.116.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 986922C2BC;
        Wed,  8 Jul 2020 23:54:34 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
To:     Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
Date:   Wed, 8 Jul 2020 19:54:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200708084106.GE597537@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 4:41 AM, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
>> Yes, powerpc could certainly get more performance out of the slow
>> paths, and then there are a few parameters to tune.
> Can you clarify? The slow path is already in use on ARM64 which is weak,
> so I doubt there's superfluous serialization present. And Will spend a
> fair amount of time on making that thing guarantee forward progressm, so
> there just isn't too much room to play.
>
>> We don't have a good alternate patching for function calls yet, but
>> that would be something to do for native vs pv.
> Going by your jump_label implementation, support for static_call should
> be fairly straight forward too, no?
>
>    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
>
Speaking of static_call, I am also looking forward to it. Do you have an 
idea when that will be merged?

Cheers,
Longman

