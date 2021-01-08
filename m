Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663922EF18E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAHLon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbhAHLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610106196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctBL/5oSz6RkrBnr0MEEZUVCK5FyLIpgAD8MYSed/SQ=;
        b=eYmG6DWFHrrA++ptV8obC/MjD7uPZgz2jSi/UUkUROV9D88r5itdN/8AYZyUhUT2eDZEnY
        McI5GFf79Xb11VC4M0rMgIw+tpYS6iK/SlPEBucdhICU58OpT6DYbSyFa06zSXUlVO1cYt
        Kksf48S/3Xw+7MMw3iOi+rUrFr4MNC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-_Bzccef3NDWIUiX2Jy-gFw-1; Fri, 08 Jan 2021 06:43:15 -0500
X-MC-Unique: _Bzccef3NDWIUiX2Jy-gFw-1
Received: by mail-wr1-f71.google.com with SMTP id i4so4025902wrm.21
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ctBL/5oSz6RkrBnr0MEEZUVCK5FyLIpgAD8MYSed/SQ=;
        b=hRqFtQx1erdpmj1ObKWfzt27PsvL5S/xntaLQXacJdLBbX8Mu6sV0LfkjPcAcFBGmp
         3LTf8irZ6HfgEYKGSAkH7M8n9XULHfo6CDRCcrTH+0V63B1h6UmbG4qkNKJD4ha0rVAk
         oA5/p3JXieFXCxjajYh/ojmqB4fPGzqIC9A6MakZmkq2HDVT3QQL3bMh0qsDP31dfTqK
         Q53UnkQBOcIqFOshMAJ2IIm+KU3Pi/tNQxhDSzN2PSYrMP8HM1hCHC6EQ05fS37xcygJ
         GklifBEmETnEUAMgmXdShN+s10oaA4JgI+4OvoEW9+bu4deDhMqSlKQIe2oVr5CAVmY0
         FWHw==
X-Gm-Message-State: AOAM531nw9vPFoMZQLdBoqVt5l/+ekHeEhkbZ+lh0zyZRE2ywUcVLuab
        mf5t/BLQAGXf11Z2xuHkwXSFpTQrEyhTS5INqFDuLYglNFk+Vbb++2OZOMVSkGW06rlrQHY9T1m
        0SQaxmzGRTVBJ9ZdFfqR0IFr0qdQhBpN1ES09FcyvYkbyZPDRPV0g6RQYNYRkTrCmq400UP4PHv
        TI
X-Received: by 2002:a5d:5146:: with SMTP id u6mr3283025wrt.46.1610106193614;
        Fri, 08 Jan 2021 03:43:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXlYfELChnMCDAy12qWAx4O8ZhccSQ3iS6OlkpsACSthzQkK8nrEaswpfVSl0bHosSFcM0gg==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr3283001wrt.46.1610106193390;
        Fri, 08 Jan 2021 03:43:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y63sm12077452wmd.21.2021.01.08.03.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 03:43:12 -0800 (PST)
Subject: Re: [PATCH v2] misc: pvpanic: introduce device capability
To:     Greg KH <gregkh@linuxfoundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20210108111710.2665279-1-pizhenwei@bytedance.com>
 <X/hB7ejy7XtjNO68@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12aebc37-aaba-2ed2-d944-c80eeac6f052@redhat.com>
Date:   Fri, 8 Jan 2021 12:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/hB7ejy7XtjNO68@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 12:28, Greg KH wrote:
>>   static void __iomem *base;
>> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
>> +module_param(capability, uint, 0444);
>> +MODULE_PARM_DESC(capability, "capability of pvpanic device");
> This is not the 1990's, please do not add new module parameters:(

Note that the parameter can also be used to _limit_ which capabilities 
the driver uses:

v1:

> +	/* initlize capability by RDPT */
> +	capability = ioread8(base);

v2:

> +	/* initlize capability by RDPT */
> +	capability &= ioread8(base);

Of course it would have helped if there was a summary of v1->v2 changes 
in the message. :)

Paolo

> Use sysfs, and properly document the file in Documentation/ABI/

