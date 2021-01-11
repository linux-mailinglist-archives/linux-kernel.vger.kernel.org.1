Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361D92F1DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbhAKS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:28:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbhAKS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610389641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxfmcJGgOjEqNNjOBcqG3Eh0R1vxgiUw0XWy5PD3XRU=;
        b=UeW0xhb7KMS9UAtZ0I/yzlpvmgKFQmcp/UlybATVUAlrV8SBitPuAiJ4uNqAdjTiUt0non
        V3OhH3tKHEd5KMn6Or2xmFj1a9d2c0Y6Q+0PHQcwTRkDjb83ut77qBccbRg0WNWpq58f0Z
        N76hvV8DmKJK6Iip4BDhZHNIva8i6ug=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-JohuIxYDOgakBktJqgE0bg-1; Mon, 11 Jan 2021 13:27:20 -0500
X-MC-Unique: JohuIxYDOgakBktJqgE0bg-1
Received: by mail-ed1-f72.google.com with SMTP id g14so71813edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oxfmcJGgOjEqNNjOBcqG3Eh0R1vxgiUw0XWy5PD3XRU=;
        b=bxHeu0SsvbO+ciPyJTGmRVTl42ObLlvhhnhT63qtUVRx7ZeuXijGhUV6qQpyAxnYdP
         K1qpmkgD9roXNbbItTIlv8jegM13DStjWAFj5e/rlztK8uVpmtqo44VxPwEVR7WFPOCK
         dB8QIEKo9BUzKK41HvTNk9UqzWxLg/Mwkojuz7mQX7pLli2wvocjACiNm9B8namP0Hy8
         +OGmAoRkM+2DR6yV9Abuznbl0+lQGfe0uB2uB/wWiVZB/ikIP1H1jBFHrqh9mpwjLo+V
         nWpwyJ0ng07YVbWBMdu0cV4JdMTFoc9URsgL8OSG1UTkX6oIGiHG/9d+2GgUSq7mPwIy
         j0jg==
X-Gm-Message-State: AOAM533dunhX7NGAaUcLBGxz70++UXWyZbDX+va3/Y/5+M7kwYETN0Xd
        p3+12fkJqG9vLaoqBeKgMgG20ZBAT7S/oMQqhoaBz3BfJDOwiRfMu5SDVy6lJjHxHDbvUZOTrqU
        Etx+43/a7eJ9hMtq5Qn2eMAsn35UtBrwJPBOKJZZ6y8JikgQoyLRxqwXz9aSe+ZJiZKndRRK/iw
        Xa
X-Received: by 2002:a05:6402:379:: with SMTP id s25mr498523edw.367.1610389638529;
        Mon, 11 Jan 2021 10:27:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgPsg6FTbB0qg2wlK57veBaI1r9LGDDhkG+6x1goKCkVIaAhFAg7Q1rf9SQ4qS2BTo9FjWig==
X-Received: by 2002:a05:6402:379:: with SMTP id s25mr498512edw.367.1610389638361;
        Mon, 11 Jan 2021 10:27:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id qu21sm161297ejb.95.2021.01.11.10.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 10:27:17 -0800 (PST)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
 <X/hnF0W+TMj36LDN@kroah.com>
 <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
 <X/h3BAdea48p+L+p@kroah.com>
 <2729803e-c9b2-abc9-e93f-ace19f521945@redhat.com>
 <X/mT/9qKswNUIWTc@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
Message-ID: <429436d3-ddd7-a1d6-4ed6-1f0932f2150e@redhat.com>
Date:   Mon, 11 Jan 2021 19:27:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/mT/9qKswNUIWTc@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/21 12:31, Greg KH wrote:
>> Also considering that there will not be more than one copy of this device
>> (it doesn't make sense as they would all do exactly the same thing), in this
>> case a module parameter really seems to be the simplest way to configure it.
>
> So you never can have more than one of these in the system at one time?
> Because if this ever becomes not true, the module parameter is a mess...

There shouldn't be.  The device is only telling the host about 
panic-related events in the guest.  The multiplexing of events to 
multiple interested listeners happens on the other side.

Paolo

