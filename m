Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC90295F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899468AbgJVNRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:17:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2899459AbgJVNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:17:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603372672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q3XLuJAiAJI40OqF2MlzN6uIGy9R9OJtoodmMnAlqVA=;
        b=R/lMCrLLsJ9oxMG8VYEjoj5XbtqmyCxxnkVfZT529iQ9EyrPI8NQo9Ft0fvftXIwPN/QRw
        WuR6R+i/DjPdKXhmnkCtsIeWGL+zxgLuHolPEnxjO0iiZcsdVvaHoZZg8tE+obiBqgPbb8
        ioZMsgIylAxUhxAT7O3IyhVn5ER3N4w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FCABAE35;
        Thu, 22 Oct 2020 13:17:52 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] xen/events: only register debug interrupt for
 2-level events
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
 <98f76c98-00d5-3238-a54f-cce52419160f@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <b21d3544-2257-dee5-222d-f4dade94d167@suse.com>
Date:   Thu, 22 Oct 2020 15:17:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <98f76c98-00d5-3238-a54f-cce52419160f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2020 15:09, Jürgen Groß wrote:
> On 22.10.20 12:35, Jan Beulich wrote:
>> On 22.10.2020 11:49, Juergen Gross wrote:
>>> @@ -2080,10 +2080,12 @@ void __init xen_init_IRQ(void)
>>>   	int ret = -EINVAL;
>>>   	evtchn_port_t evtchn;
>>>   
>>> -	if (fifo_events)
>>> +	if (xen_fifo_events)
>>>   		ret = xen_evtchn_fifo_init();
>>> -	if (ret < 0)
>>> +	if (ret < 0) {
>>>   		xen_evtchn_2l_init();
>>> +		xen_fifo_events = false;
>>> +	}
>>
>> Another note: While it may not matter right here, maybe better
>> first set the variable and the call the function?
> 
> I don't think this is really important, TBH.
> 
> This code is executed before other cpus are up and we'd have major
> other problems in case the sequence would really matter here.

Fair enough; I was thinking in particular that it ought to be
legitimate for xen_evtchn_2l_init() to BUG_ON(xen_fifo_events).

Jan
