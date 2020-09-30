Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA527E117
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgI3GaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46343 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgI3GaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601447410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j86M+7uzw2vXNKqDCk9DKrNbVH+omew22uwCG12+/cY=;
        b=SOJeIr5zacf+uAUbm0JIVIgLZDRHUhU2X5PYJWjcvOHDdqu2TRB3WKrVovnfAk5JeG6nW7
        ho+x+/HKXl94FP/mnuig423KAm5NswYbyqyO4jUsF16VzvL0ztLpiWlkxW2ZWnc2MLZtnH
        APEzxNlhPVkHMtnyIrTGnUUWwDIXGx4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-TVSMIYQzNL26s75IzM3Y4g-1; Wed, 30 Sep 2020 02:30:08 -0400
X-MC-Unique: TVSMIYQzNL26s75IzM3Y4g-1
Received: by mail-wm1-f71.google.com with SMTP id b20so310121wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j86M+7uzw2vXNKqDCk9DKrNbVH+omew22uwCG12+/cY=;
        b=DselNTTGUvSjgFDs5LnKcuZDgWpiOQRY6MmvL1ds999e/yopa0ZjDTTzMg1F9Fco2s
         zg0cDU4t42V7I/pUKd2W0eEn/7uuuKxV/wcEYqe5xCcVQZhzbopDDW+q0Ys0cA3+pQVO
         WBBlx6C9B+zirbua22607Fder/K4wXHjuFPDUMS72C4nM8MLXCaZII48KoHbIBk5QPKy
         m9emSE9OE583GLlbMSGrAAsV55+GKRS6R2XqM9cr+paRNg1qKpWbmTgy4b0gdy/9hVVz
         3v+OebgompAV5Tb7oDW/e65Ns445Io0suJ31U4zQhQgbOstJTLdVDYx/RzxdwUb1GwqY
         gKow==
X-Gm-Message-State: AOAM531SO6PXNtWX86RqjZlfPLfkQRKV1kXD6iwEL+awIaZRtQLRV+31
        cSN0B5kt69BzCJChY/LXv2Yq29sV5Y/UeuTh40qjROVdO6urbx7adVhb23Xzbzsx4+u6x8HzJla
        4eM8wIWLEPs8OXx6YYkNrfUBG
X-Received: by 2002:a5d:6691:: with SMTP id l17mr1305374wru.10.1601447407147;
        Tue, 29 Sep 2020 23:30:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyASWaG3yl3m26xkbJUdvbhGIpEfJMjIX5qb3Td12Uo50xunQLlbIDptoRdxeQDVz3TMDgW1Q==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr1305344wru.10.1601447406965;
        Tue, 29 Sep 2020 23:30:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id m13sm1022054wml.5.2020.09.29.23.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 23:30:06 -0700 (PDT)
Subject: Re: [PATCH 00/22] Introduce the TDP MMU
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200930061903.GD29659@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13590996-ac0c-71bc-1946-7966fcbf94ba@redhat.com>
Date:   Wed, 30 Sep 2020 08:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930061903.GD29659@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 08:19, Sean Christopherson wrote:
> In case Paolo is feeling trigger happy, I'm going to try and get through the
> second half of this series tomorrow.

I'm indeed feeling trigger happy about this series, but I wasn't
planning to include it in kvm.git this week.  I'll have my version
posted by tomorrow, and I'll include some of your feedback already when
it does not make incremental review too much harder.

Paolo

