Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01A27436E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVNnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIVNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600782221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RjqZZpcz133eDPIDFweleVoraiJQPcRg1Z09eullZA=;
        b=QwXC7xYwdpbWvrTTJcuyl9vH31Z25aqFGBr0iLqMJU+fO8qQpfWfDIUaEDRJmY4Mog2n6J
        Ri0ZB+f34RS/4x5aW9t/Ahjnml8Az08ezc1pxw8Xp4G5gbZN4MAhuRo6cMtKcarvrD4BFT
        4GgyYb2Nqwq47SM51JAMdaDm7H7VgLs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-26BbOyNyOOSe3WsSTqOvYQ-1; Tue, 22 Sep 2020 09:43:38 -0400
X-MC-Unique: 26BbOyNyOOSe3WsSTqOvYQ-1
Received: by mail-wm1-f71.google.com with SMTP id t10so585473wmi.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RjqZZpcz133eDPIDFweleVoraiJQPcRg1Z09eullZA=;
        b=MhajYWpVgVmrUEapfEXZ8roKC8yMVHgsDF4pEEyxLzZu9wUCfvZJ6P+0NeYmuUjJcD
         4tii2xyUe05e8LZFNovfWFvwdnFVCQmj/K4CVbJ8TOAWTse6jSeJbULQp7ZV6RReeq3K
         r+j4Q+MQsWASx1Sjcb1PivUaYJtraln3A+uXUBuG3UgIMlRD8lQngeZM8vZHldntLjBK
         G+J41h5QOlFun+cKSPitIrkavYpbo10jEtYRdP5s80gwtOyw9P0uatrYC5GDNZC3C21g
         LK1WWS2MXWDGhqYqi3X8a3/cJGz7N1UhBjNMwRgGoD7y5h18PTrFWjIswD/bnYo01yIT
         ptww==
X-Gm-Message-State: AOAM5332I6CWn/uMXKHpe+ExoRQVUzhwwPIpbMwuVhwIiBtTNU/WYmd0
        6wqaVHbkue9zIiKLMAX5S+aAb7dM1WLKUQirP2rZ2A3bWeHyhh1UscOerldpKOdt2XNgbdGR9UK
        fXj5wrqZj6HLC7j8OOof3xRTZ
X-Received: by 2002:a5d:4811:: with SMTP id l17mr3442599wrq.252.1600782217720;
        Tue, 22 Sep 2020 06:43:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyglyepT72u0u8qRUeIVHeaIrPCxmCf6cGs6FlYed7irsbKA367/aa58zjJODiu1leT5jKnpg==
X-Received: by 2002:a5d:4811:: with SMTP id l17mr3442574wrq.252.1600782217526;
        Tue, 22 Sep 2020 06:43:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id l10sm25008213wru.59.2020.09.22.06.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:43:36 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Analyze is_guest_mode() in svm_vcpu_run()
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1600066548-4343-1-git-send-email-wanpengli@tencent.com>
 <b39b1599-9e1e-8ef6-1b97-a4910d9c3784@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91baab6a-3007-655a-5c59-6425473d2e33@redhat.com>
Date:   Tue, 22 Sep 2020 15:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b39b1599-9e1e-8ef6-1b97-a4910d9c3784@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 22:43, Krish Sadhukhan wrote:
>>
> 
> Not related to your changes, but should we get rid of the variable
> 'exit_fastpath' and just do,
> 
>         return svm_exit_handler_fastpath(vcpu);
> 
> It seems the variable isn't used anywhere else and svm_vcpu_run()
> doesn't return from anywhere else either.

Yes (also because vmx will do the same once we can push
EXIT_FASTPATH_REENTER_GUEST handling up to vcpu_enter_guest)...

> Also, svm_exit_handlers_fastpath() doesn't have any other caller. 
> Should we get rid of it as well ?

... and no, because svm_vcpu_run is a very large function and therefore
it's better to keep its flow streamlined.

Paolo

