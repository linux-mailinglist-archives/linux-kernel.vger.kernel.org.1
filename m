Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C472279F1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgI0Gy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730384AbgI0Gyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:54:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601189694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bd/ZPlUtGfcavMMYXo7QbCua2yw75N9F0WV8AxCRw+M=;
        b=Ays+rJYGwzCJ1wVEtXw57oR1kGZIvUCSjVTAWpI4GoU5XKB0izS56ElsLH8ASfX/eilwG6
        k1LPdrbfTp93o7pS5s/xBXSIH653Es5Pfza73GeupugO4Ga98xXX5iePACON1LLC92a7/T
        puBThd0qOfpopy+LMO0B8pOiRMVD2AU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-74-ihrVjPgaitDBC_v16gQ-1; Sun, 27 Sep 2020 02:54:51 -0400
X-MC-Unique: 74-ihrVjPgaitDBC_v16gQ-1
Received: by mail-wr1-f72.google.com with SMTP id v12so3220055wrm.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 23:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bd/ZPlUtGfcavMMYXo7QbCua2yw75N9F0WV8AxCRw+M=;
        b=m1qxFchwq+YRmpEYx7FSbGKuS/F9fMj0IBxdlqZysI2SM/RiQq+bSmgl/3jGzXPRlP
         Zl6MAxAZf/a1FJdK0MLNf8BQDd2AqElmPPoCCFvBgYznOCQJyV/QestUH11yFXZZPEQR
         mq53cv0j9oScjgD3E4cwpXNTTNMnE3j1YHJCxt4S6SGy9B6KI/4+2qtTKvLuvRao6fly
         1Rmdw5VG28d7X3WkzSXEt9fvGh3XiFyCMjqbgoMdcYlLBq9uet3tkP4zT59spMMOTQCA
         BEi4yITWWtJmHLVYmUyLlAq4JHIKEOwtcALf7WV+EEs2JawebDzI67cDyUqnO3mj3UVj
         or5g==
X-Gm-Message-State: AOAM5310uJNOQJcXpsxLrkIDkzs8+evtIfg1jUntYEnT8XtbHJ++Qq9V
        Eq1wU7HDmhfP/tegVpFLHBqNtdEX66LrlYyhX54Um63/5Ye2epqkMOWahiCJOTzAWd4G+QZKXxg
        58SK3YGLvVe/+4C0AeSXCiRie
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr5488349wmm.115.1601189690317;
        Sat, 26 Sep 2020 23:54:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHzGTRSMAbCCKFrPZbp4Zv97tRct/WUPEKLmIQIF9Yuq5mVmVNaU8KzZHi/AcXFfyqzJEjXw==
X-Received: by 2002:a1c:26c3:: with SMTP id m186mr5488333wmm.115.1601189690096;
        Sat, 26 Sep 2020 23:54:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fc81:b99a:aac0:e256? ([2001:b07:6468:f312:fc81:b99a:aac0:e256])
        by smtp.gmail.com with ESMTPSA id k12sm8527873wrn.39.2020.09.26.23.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 23:54:49 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: emulate wait-for-SIPI and SIPI-VMExit
To:     "Qi, Yadong" <yadong.qi@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "nikita.leshchenko@oracle.com" <nikita.leshchenko@oracle.com>,
        "Gao, Chao" <chao.gao@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Wang, Kai Z" <kai.z.wang@intel.com>
References: <20200922052343.84388-1-yadong.qi@intel.com>
 <c0157014-d1bb-ef81-b92f-ebecb72396c9@redhat.com>
 <MWHPR11MB196858E9DC7AF08DC87E9261E3380@MWHPR11MB1968.namprd11.prod.outlook.com>
 <MWHPR11MB1968CD560E8BB15613F3EA73E3340@MWHPR11MB1968.namprd11.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5019ebd5-4612-ae15-f976-a95000d0e1ad@redhat.com>
Date:   Sun, 27 Sep 2020 08:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1968CD560E8BB15613F3EA73E3340@MWHPR11MB1968.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/20 03:51, Qi, Yadong wrote:
>> Subject: RE: [PATCH] KVM: x86: emulate wait-for-SIPI and SIPI-VMExit
>>
>>> Again, this looks good but it needs testcases.
>>
>> Yes, the unit test development is WIP.
>>
> 
> Hi, Paolo
> 
> I have sent out the unit test patch.
> https://patchwork.kernel.org/patch/11799305/
> Could you help review it? Thanks a lot.

Yes, I've seen it.  Tomorrow. :)

Paolo

