Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106B32FE435
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbhAUHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbhAUHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611214709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kVSG4L8Yartqrk7tDiDkwAUqYMAcqaSatvYzcqcPL4=;
        b=LeyADgyy7B/yfHSABRbvr9CaiScoqat/7ksyORy3oOXwtLIxSZ0pLQuju6oMowdzkE12s2
        LpzKUj8Gl8gh9qStXB/3D01pyGqGbr2CIl3jrCXMtWcr3kq2MOlAsjnTluWoONz4v7nJeM
        fcCcFQVROuKYwT9+Uw8g66/mTo6H66w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-YbZxZ0wXPO-YwWDrDHKBBA-1; Thu, 21 Jan 2021 02:38:27 -0500
X-MC-Unique: YbZxZ0wXPO-YwWDrDHKBBA-1
Received: by mail-ej1-f70.google.com with SMTP id x22so422725ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 23:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kVSG4L8Yartqrk7tDiDkwAUqYMAcqaSatvYzcqcPL4=;
        b=SyBRcJnapyKX9LYRi1aDM1zI3ws8gQY2SeTbhk0jP8oQCSFWOMi9N1ENt+cmR2+yD4
         I8+OSTH+dFRPE8ByzYe5As4LdTDxpAknAhhKrothc9a9p0KU2GR+cSXAbNgmVUXk+wbD
         tpm/Z/eFZxgfVJvthBZE+SyZAKPOHSpuObW+aT4p4q3+a07K5ZrtjDxmoOAWiAuCTHZ6
         I4535mN3A3sw6yqtFkiRJBD9zy6JYE1G93huFwql/7wLWTwOi43yheycbHDNs/WFCrJv
         h4z9E/f2z9z4xXHWbIUo1zPrbc+FrrZlDxXbEgRkf5DIKku2CT9dolpRATmyY2HHPpMm
         7xUQ==
X-Gm-Message-State: AOAM532Fp8gTog1mJ6Oib8fBI2kpDYjKY4rv48nmZwVa6FNEokdCeQBF
        vAgcdrHGH6EUS6EbuPK7gQGhf58Gn3kBOr6Cs9YLT/aD3ciKLFozxsZuEraqTw2I4xI6Genlf0v
        WX1CDIJiLFjkormR6tP4W40GSy/PGkivSZ6GDX4t7IUwH2a+o+5lKgHaVvILkVxZghSs09VraEi
        fU
X-Received: by 2002:a50:8a90:: with SMTP id j16mr9604914edj.334.1611214706413;
        Wed, 20 Jan 2021 23:38:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/lOSqu6uXUKuOy+1WLJIYPND6L/NE5QVph99g7Qdwq/QUL/k9KAYBc6DnaADWuUUprMQxtg==
X-Received: by 2002:a50:8a90:: with SMTP id j16mr9604907edj.334.1611214706243;
        Wed, 20 Jan 2021 23:38:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id he38sm1790782ejc.96.2021.01.20.23.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 23:38:25 -0800 (PST)
Subject: Re: PING: [PATCH v5 0/2] misc: pvpanic: introduce capability & event
 attribute
To:     Greg KH <gregkh@linuxfoundation.org>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20210110115358.79100-1-pizhenwei@bytedance.com>
 <cee80030-dab1-fe79-f14c-24e45532d814@bytedance.com>
 <YAhuD04p4daZd/1W@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7b9e8a9-d5de-3b29-8bf3-3d002b984dda@redhat.com>
Date:   Thu, 21 Jan 2021 08:38:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAhuD04p4daZd/1W@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/21 18:53, Greg KH wrote:
> On Mon, Jan 18, 2021 at 09:42:57AM +0800, zhenwei pi wrote:
>> Hi, Greg
>>
>> What's the next step I should take?
> 
> I need some reviews by the people who will be doing the qemu portion of
> this, or someone else, please.

QEMU bits are already part of the last release, so all good from our 
side.  As far as the "hardware" spec is concerned,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

