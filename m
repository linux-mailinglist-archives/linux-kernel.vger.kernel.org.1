Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24682A93C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKFKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbgKFKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604657414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/uaQ+ciO8/RfcKxsgCor1/p7DcJNB2wEujPSnKBSz8=;
        b=NoqRII8Ovb620QIDD+tPfWyzAAv6IYdTovnZIAmFCxht6SeqN8RrcoOBgUj/fFTzz95ki0
        /EvRsmMFmnr2OL2vekGgd+MLE+/OeaTEdE79Amww4zvncNOG/86BvMoNv1DCSSBW2nZuh7
        NSyygg8BlZmg6C11zfHDEJshvd6k3QY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-L9Qda-gjNiaBou4RE-crUQ-1; Fri, 06 Nov 2020 05:10:12 -0500
X-MC-Unique: L9Qda-gjNiaBou4RE-crUQ-1
Received: by mail-wm1-f69.google.com with SMTP id 8so246380wmg.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/uaQ+ciO8/RfcKxsgCor1/p7DcJNB2wEujPSnKBSz8=;
        b=p90VUqmr2tRyatsU0pVdSsBpBdPZ5P1anndOVJJcEA8tVK5dNjEdjCYLeoHKM3ggwH
         dAmSPf5bkXouOOkAlCwhIeouVNx+2+qqJTxifL526k8EuxspbDXhlrrnYLVS1YwXomOi
         6S1DIf+j5ybEpVY4ifbX5YYs8hA81kwjVPNCVjkOoYJj46iV4JaG7OKqAJ7l9P3nNdV0
         bza+j4/sRoRijlL1NQjWBunm1MGR2VfL2j+V8mf3Ri1vNkwfwWFYfe0O6FRWX94RgZ1O
         7Znrh0/HQcPBKmP08L87so6m21zYXf9K4npteQ7lnVhIOa3hYutTP5IfHmuhfkyuHKk1
         9/8w==
X-Gm-Message-State: AOAM5314RPp1j4g6k2BJNYdv1u9JlYkoLqbVygPIuOmWTsQM65S+3sgi
        hJ8svz/ad6knmSm6/lW4GoC8xgz5MDl+a2m/Xc6UMMI6S5E/7iVeG5ZSK6tC7LdLf2BEGTVcU3P
        4RVyD9lDfD1eRv/tXGDG1sovA
X-Received: by 2002:a1c:6484:: with SMTP id y126mr1511521wmb.141.1604657408338;
        Fri, 06 Nov 2020 02:10:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPhPkVRuFuerZB14L4+UH5k2bN4LoZqc13UQUmyxQLeHQ2h9vhRQEAWQyFzPA1g4J2AmjJfw==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr1511504wmb.141.1604657408176;
        Fri, 06 Nov 2020 02:10:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id q7sm455306wrg.95.2020.11.06.02.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:10:07 -0800 (PST)
Subject: Re: [PATCH v2 2/2] KVM: x86: emulate wait-for-SIPI and SIPI-VMExit
To:     yadong.qi@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201106065122.403183-1-yadong.qi@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5c0071c-101a-a2ff-4ced-2f5ec8b38896@redhat.com>
Date:   Fri, 6 Nov 2020 11:10:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106065122.403183-1-yadong.qi@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/20 07:51, yadong.qi@intel.com wrote:
> @@ -4036,6 +4060,8 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>   
>   	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED)
>   		vmcs12->guest_activity_state = GUEST_ACTIVITY_HLT;
> +	else if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED)
> +		vmcs12->guest_activity_state = GUEST_ACTIVITY_WAIT_SIPI;
>   	else
>   		vmcs12->guest_activity_state = GUEST_ACTIVITY_ACTIVE;
>   

Updated, thanks.

Paolo

