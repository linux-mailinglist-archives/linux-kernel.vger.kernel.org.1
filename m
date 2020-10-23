Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E7F296C26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461534AbgJWJdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461518AbgJWJdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603445598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhjktOBoRTQaSYJPiSgNw60+MzGJGvfEgx56IsafvOg=;
        b=gZhw/q0ZC/Wkt/7MpUoTB9P+Vm3DhGSHRSS0Uy1nXDtcSFm0LM1BSvZbLvtJKNUYhYkmfP
        mKAUYNl8mLUVz1Zby8tVyDjwvm54un9A8Bdy5BysREnRya36bi2N/jV8Dn1o+VHp2Mz7wz
        X3ogQYweIwW4ilGyk8wIvO+STnLs/64=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-oTmDe5kyOPOHF8alBjkYqw-1; Fri, 23 Oct 2020 05:33:15 -0400
X-MC-Unique: oTmDe5kyOPOHF8alBjkYqw-1
Received: by mail-wr1-f70.google.com with SMTP id p6so367653wrm.23
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhjktOBoRTQaSYJPiSgNw60+MzGJGvfEgx56IsafvOg=;
        b=hVsMF+2oEs8epxhvg/oEbG75/j0WnO11ZIDPqJBCBzGhhfFQ9w1vUgmGNpCvZJLf6x
         ppSnQS1CIRpHMO180BGy+ppWv+70fPf2WQmh6SXEbBBNYSHMR61oxSZFlR/IAA5QFhhn
         ThVihr1Eq/4xujXnxwfJSoY/RmW+dUASpjIv4DChiA4mGtKY/96INKMe66P3OdVNqG6o
         n3ptfUaj57XPEEMWS4k1AQhlXeMTLLrCOT56CKMqAARE8vIFUjQCdobdT7hS1iVRqQ2U
         FZHyPOsSeBzqXvNuMA899twap/FnavfNeqVZj3DY7VoNFY8iTAdzhxGEYxn7nc20m0gn
         Ufsg==
X-Gm-Message-State: AOAM533clQsYHjtUm8NK0lArurl2QJz2OZkZkVgnMRmwyKNA8cZ46PfQ
        d3hX7NvQkQbBgxVIA4hxFHDwWxr6Y80EPESHldFA07nr5Lwn+N5KXIpBAHpzKv8Ul9BMVgLLDcS
        8cvngV0+yGNM684V1CZ3jbMRP
X-Received: by 2002:a1c:4306:: with SMTP id q6mr1448464wma.189.1603445591332;
        Fri, 23 Oct 2020 02:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw03dE4BvokvwSb4DY1v456I8rv/1zCQjMQg386djUX5vLasV/K1FS7SwEMTZT11Lnp0+2jXQ==
X-Received: by 2002:a1c:4306:: with SMTP id q6mr1448442wma.189.1603445591095;
        Fri, 23 Oct 2020 02:33:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id q8sm2147629wro.32.2020.10.23.02.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 02:33:10 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Don <joshdon@google.com>,
        g@hirez.programming.kicks-ass.net
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, Xi Wang <xii@google.com>
References: <20201023032944.399861-1-joshdon@google.com>
 <20201023071905.GL2611@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] sched: better handling for busy polling loops
Message-ID: <ef03ceac-e7dc-f17a-8d4d-28adf90f6ded@redhat.com>
Date:   Fri, 23 Oct 2020 11:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023071905.GL2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/20 09:19, Peter Zijlstra wrote:
>> +	/*
>> +	 * preemption needs to be kept disabled between prepare_to_busy_poll()
>> +	 * and end_busy_poll().
>> +	 */
>> +	BUG_ON(preemptible());
>> +	if (allow_resched)
>> +		preempt_enable();
>> +	else
>> +		preempt_enable_no_resched();
> NAK on @allow_resched
> 

Since KVM is the one passing false, indeed I see no reason for the
argument; you can just use preempt_enable().  There is no impact for
example on the tracking of how much time was spent polling; that
ktime_get() for the end of the polling period is done before calling
end_busy_poll().

Paolo

