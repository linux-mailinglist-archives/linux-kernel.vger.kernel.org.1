Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0778227F10D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgI3SJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgI3SI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:08:59 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601489338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bwVgHNsMicX6xX4N2svSFj0C/kV9MVkeyeZ49ASRmfs=;
        b=GpYJcp3u4rsVbe7aMfD8u1z4pO+WNPJa90BmjH0jXOG9v5kol0W9eVt0bhYQtMIKHdd7m0
        lq6ni9rLeHxis7Ehv5VEfbWpA7S+xJDxpMp/LDf9aRcqlw5rYx6KxbGS/czXz3Qa9lm012
        VoHcLwHCjJbFEKHMCAfk5HCADHyCIrA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-b06x7rBwOk-dYoPolTgoGg-1; Wed, 30 Sep 2020 14:08:56 -0400
X-MC-Unique: b06x7rBwOk-dYoPolTgoGg-1
Received: by mail-wr1-f70.google.com with SMTP id 33so895470wrk.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 11:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bwVgHNsMicX6xX4N2svSFj0C/kV9MVkeyeZ49ASRmfs=;
        b=dnXLhswsHZvAeLluSTPb9OiT4V0469ltWaMq8hPxHsYZ0+eQkE+PWcpAIQPwJhvtW7
         PNTZck5wz5FCeh8K+sIhCyqf+7+IKRAA912SLTskIJ6Qdjwty8poy4HN3iVDHTM1BL+O
         MOvvJAUKmtutgxTIsgN4zPliimc2q/vK2rYSmSJZU6EUrYC8Drt1HkQXHUivI+kQ89bt
         r6/stIJ4ETuTWeeELq0bdsUZLWtVP5ctrb1DX3ReZXxM9nRjUYvLtrzPIvdL6fo9KxtE
         +I6iQh9bQzTGntThcFUR1kq3hmr8s31/wGbtAR9Rs3y8wbGV2vgk1sjj03fOPK/9TZGi
         0u+w==
X-Gm-Message-State: AOAM531TN9MMz+D6u1K7jIcOrDH3byUamoddpnUfvqtbHtLPdjW53JTm
        6xCVSgRCJwQcbenkTyjYHJCcDVlXkveEq2jeFIksupo3k7MWFzN9v2I60lnz2KlR8vatRP1io8w
        cDz0ypIQkTo/mC59ffQ4F198N
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr4270292wmh.53.1601489335604;
        Wed, 30 Sep 2020 11:08:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWKG5rLY3U++IuIbw2Titxqz2g0w5Mzxk9AjMYWUD881FXfHgUI1n2X0h2mDVzIUr5SDpUvw==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr4270275wmh.53.1601489335412;
        Wed, 30 Sep 2020 11:08:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id u66sm4113015wme.12.2020.09.30.11.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 11:08:54 -0700 (PDT)
Subject: Re: [PATCH 17/22] kvm: mmu: Support dirty logging for the TDP MMU
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
 <20200925212302.3979661-18-bgardon@google.com>
 <20200930180438.GH32672@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48c927aa-5902-138a-eb93-891325976edd@redhat.com>
Date:   Wed, 30 Sep 2020 20:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930180438.GH32672@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 20:04, Sean Christopherson wrote:
>> +	for_each_tdp_mmu_root(kvm, root) {
>> +		root_as_id = kvm_mmu_page_as_id(root);
>> +		if (root_as_id != slot->as_id)
>> +			continue;
> This pattern pops up quite a few times, probably worth adding
> 
> #define for_each_tdp_mmu_root_using_memslot(...)	\
> 	for_each_tdp_mmu_root(...)			\
> 		if (kvm_mmu_page_as_id(root) != slot->as_id) {
> 		} else
> 

It's not really relevant that it's a memslot, but

	for_each_tdp_mmu_root_using_as_id

makes sense too.

Paolo

