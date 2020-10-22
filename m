Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318AA295A52
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507753AbgJVI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:28:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:55748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502321AbgJVI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:28:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603355326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ak4XkyQcVmIRaA1l0Rz4F8yZmad7xR9rPkb2Zs/I4w=;
        b=bXrR6ECZL37VdSqI0vbVU00hc8qxobp23r7xk9scCpOzO847J+xYSponAUnuU1AAaIy92H
        dWF/+ipteKPoLAHbzcWOadipU+15mcv73HClKvqBGugMCUoNjgWhxr2WMrxem55T6urPTr
        a95IHGfvdlCLfbV6wKdta6PHMmDYrAw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 531E4AFA8;
        Thu, 22 Oct 2020 08:28:46 +0000 (UTC)
Subject: Re: [PATCH 4/5] xen/events: unmask a fifo event channel only if it
 was masked
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20201022074214.21693-1-jgross@suse.com>
 <20201022074214.21693-5-jgross@suse.com>
 <e6dcce7e-acfb-0ca1-8ff1-e303932bc3c5@suse.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <72cb09c0-4fc7-f02e-c1fb-314e5add381f@suse.com>
Date:   Thu, 22 Oct 2020 10:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e6dcce7e-acfb-0ca1-8ff1-e303932bc3c5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 09:55, Jan Beulich wrote:
> On 22.10.2020 09:42, Juergen Gross wrote:
>> --- a/drivers/xen/events/events_fifo.c
>> +++ b/drivers/xen/events/events_fifo.c
>> @@ -236,6 +236,9 @@ static bool clear_masked_cond(volatile event_word_t *word)
>>   
>>   	w = *word;
>>   
>> +	if (!(w & (1 << EVTCHN_FIFO_MASKED)))
>> +		return true;
> 
> Maybe better move this ...
> 
>>   	do {
>>   		if (w & (1 << EVTCHN_FIFO_PENDING))
>>   			return false;
>>
> 
> ... into the loop, above this check?

Yes, that should be better.


Juergen

