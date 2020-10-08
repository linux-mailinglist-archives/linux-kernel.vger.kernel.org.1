Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC7328725D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgJHKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgJHKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:18:57 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564DC061755;
        Thu,  8 Oct 2020 03:18:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a7so4770270lfk.9;
        Thu, 08 Oct 2020 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5BDQwX6hfXLbNbBaNj/hfOCt5e4YPuWKguHYeFqFuhI=;
        b=IyJvaM5KxBqQJCPsJA7HGvO93wK7PzxTEJ3caZm1ehYN+wLiHovHhHZH3RshLemLBB
         CtfVA2TYwrXJnGG3El47dEWd7CJXM1xLgWwWTXC9vrPk8FpGPdKOaYdmWwZZscfZ8fDP
         pGtxjoaB6xZu1kl6YO5k5u/iG3RQXfvT5tSbvPoaYxIbwghVRW9bNyaiTT7z/W0vI7UR
         HIH1+FeHdchlDt31qnddpcXxfCwZs/VJhJzFsnW5U+ratSl+ZXhjyX98bAhEWtmQKugj
         sxJLeyJWo0symYYFtt3zmjNW/6FGilP80VSnJWAQG9K4Bx22c8WeHco4ZJdAfCHHn5ar
         2Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5BDQwX6hfXLbNbBaNj/hfOCt5e4YPuWKguHYeFqFuhI=;
        b=tZI14m0Eol1YSxKBOP6peRtXwd5N6Y8ZLdhLZnGawh4TXrenIKWFk+VvG8SWNcDkHU
         g3df4fjyKbp7d0uM/Wz25U//mdYP495+ALbLySpnsKzKLJzmUnWfFnNRCTzdBQW1rwHW
         B7ynXXrQgpH522L3B9YlHmoUpVDw9UhwUMo0VSeUbe1/Kh0OlpCtSg/Y9jJVSuLGOgXh
         82UpoljSC+aXIW1MHesT0RfviD7Z/O8yQpn+gcMa9M4YhnOxU6jwNnksLel2py1QJBgz
         O5MgrqUqvSS5+zrP4++zARTY+usmiP7H6LdVM1/p799ODlaoGoApE9KRPhF9tiwiSpvk
         EkCg==
X-Gm-Message-State: AOAM532i6PVwefbkPloDL31QfFu8OGW3dkXse+SjVcgUZR/kF/pUxDBP
        5hyHpYqOYaFR3uT5gyI0uuk=
X-Google-Smtp-Source: ABdhPJze1hHwJlv7JW4/HROfUFRxOWXoJAcp3q/TJIs8KuUMIXxcQ+4Sdq6WPEWba1cjhhaL9/2TTA==
X-Received: by 2002:a19:4151:: with SMTP id o78mr2255308lfa.408.1602152335053;
        Thu, 08 Oct 2020 03:18:55 -0700 (PDT)
Received: from [192.168.1.100] ([213.87.146.0])
        by smtp.gmail.com with ESMTPSA id j13sm787945lfb.205.2020.10.08.03.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 03:18:54 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIHVzYjogY2RuczM6IFZhcmlhYmxlIOKAmGxl?=
 =?UTF-8?Q?ngth=e2=80=99_set_but_not_used?=
To:     Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Cc:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
References: <20201007033932.23050-1-pawell@cadence.com>
 <8994106d-2cc5-fa2c-bbcc-6526632ff80b@ti.com>
 <18bf46b7-d86a-fbf0-9ce7-c2d0765758f1@gmail.com>
 <DM6PR07MB552984371C356A6E31D8D116DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <527428cb-704b-a92f-ca7c-938527a91280@gmail.com>
Date:   Thu, 8 Oct 2020 13:18:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <DM6PR07MB552984371C356A6E31D8D116DD0B0@DM6PR07MB5529.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08.10.2020 6:57, Pawel Laszczak wrote:

> Siergei,

    Sergei, or, more correctly, Sergey. :-)

> 
>>
>> On 10/7/20 11:15 AM, Roger Quadros wrote:
>>
>> [...]
>>>> Patch removes not used variable 'length' from
>>>> cdns3_wa2_descmiss_copy_data function.
>>>>
>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>
>>> Fixes: commit 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")
>>
>>    No "commit" is needed here.
> 
> Can you explain why?
> 
> I guess it's because commit 141e70fef4ee is quite new and it's not yet included in any stable kernel version,
> or because it's only warning - not error.
> 
> Am I right ?

    No, it's because the format is:

Fixes: <SHA1> ("<summary>")

no word "commit" is needed. :-)

>>> Acked-by: Roger Quadros <rogerq@ti.com>
>> [...]
> 
> Regards,
> Pawel

MBR, Sergei
