Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58F42C7C29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgK3Az2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 19:55:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgK3Az2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 19:55:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73200AC75;
        Mon, 30 Nov 2020 00:54:46 +0000 (UTC)
Subject: Re: [PATCH v2 18/18] MAINTAINERS: Add linux-actions ML for Actions
 Semi Arch
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <5845b7a323c65adaa1566c3bee68b5ca1f1bb17e.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128074350.GE3077@thinkpad> <20201129194824.GC748744@BV030612LT>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <fed29816-561a-7187-302f-09ab37beddca@suse.de>
Date:   Mon, 30 Nov 2020 01:54:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201129194824.GC748744@BV030612LT>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.20 20:48, Cristian Ciocaltea wrote:
> On Sat, Nov 28, 2020 at 01:13:50PM +0530, Manivannan Sadhasivam wrote:
>> On Fri, Nov 20, 2020 at 01:56:12AM +0200, Cristian Ciocaltea wrote:
>>> Add the linux-actions mailing list for the Actions Semi architecture.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
>>
>> There was a patch from me for this change but I don't mind taking yours
>> as long as we keep the list updated :)
> 
> Sorry about that, I often forget to manually append this mailing list
> before submitting related patches and therefore I considered this is
> a good opportunity to have this issue fixed once and for all.. :)
> 
>> I have just one comment below, with that fixed:
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>>> ---
>>>  MAINTAINERS | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a85c1881cf07..8428aba52581 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1497,6 +1497,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
>>>  M:	Andreas Färber <afaerber@suse.de>
>>>  M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>
>> No need to keep the generic list, please remove.

Why? They're not mutually exclusive.

Regards,
Andreas

> 
> Done, thanks!
> 
>> Thanks,
>> Mani
>>
>>> +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
>>>  S:	Maintained
>>>  F:	Documentation/devicetree/bindings/arm/actions.yaml
>>>  F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
>>> -- 
>>> 2.29.2
>>>


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
