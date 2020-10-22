Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF4295F65
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899356AbgJVNJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:09:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442464AbgJVNJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:09:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603372145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnl30XZmbkdq+DrOW7dw1rQEfgCFIhyaC9tjnrTpvhk=;
        b=G3EvcoqIsqGs4aDO2mpBJ1JGmOUd/OPq7oygh7b6FF+0GTcrKqbng6hgIBfCH3Os3t/dIS
        uV/OIsKhlCM/Y5jWNUEQDJNFCgoh3+eFZBMSrsIC/BSdBaokhWtsWh9fyjw5n6pfIj+qVs
        MIV16z6zFR4NJs+Ydt0K7f5fFIaSdI4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A540AAC3F;
        Thu, 22 Oct 2020 13:09:05 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] xen/events: only register debug interrupt for
 2-level events
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20201022094907.28560-1-jgross@suse.com>
 <20201022094907.28560-4-jgross@suse.com>
 <1de24e42-6cb7-4ecb-0eb2-c4a15dc8afc9@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <98f76c98-00d5-3238-a54f-cce52419160f@suse.com>
Date:   Thu, 22 Oct 2020 15:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1de24e42-6cb7-4ecb-0eb2-c4a15dc8afc9@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 12:35, Jan Beulich wrote:
> On 22.10.2020 11:49, Juergen Gross wrote:
>> @@ -2080,10 +2080,12 @@ void __init xen_init_IRQ(void)
>>   	int ret = -EINVAL;
>>   	evtchn_port_t evtchn;
>>   
>> -	if (fifo_events)
>> +	if (xen_fifo_events)
>>   		ret = xen_evtchn_fifo_init();
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>   		xen_evtchn_2l_init();
>> +		xen_fifo_events = false;
>> +	}
> 
> Another note: While it may not matter right here, maybe better
> first set the variable and the call the function?

I don't think this is really important, TBH.

This code is executed before other cpus are up and we'd have major
other problems in case the sequence would really matter here.


Juergen
