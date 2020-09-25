Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6982793A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgIYVf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbgIYVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:35:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601069727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHYOituAb5LHhfAlt1w3CoTgvVmTmpk5jRg1ddQ3b2w=;
        b=R8wa7GwNLiqfNBgnKsaw/XgknZnyVfI6NtVv7IsuRNMaagBHS5oeanWMF7qvGugdAyf/ol
        jCPfL9hcUa0xdrlANghLcssrO6vntOlXSZMXzluKXiaQz1WrYdc6rTV6U21Ol0rTWcjjez
        1A1mS60pFe6097sHxd1ISGhLGP26q70=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-nuGRDN4BNk-dvSTukEMbJA-1; Fri, 25 Sep 2020 17:35:25 -0400
X-MC-Unique: nuGRDN4BNk-dvSTukEMbJA-1
Received: by mail-wm1-f72.google.com with SMTP id b14so167557wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZHYOituAb5LHhfAlt1w3CoTgvVmTmpk5jRg1ddQ3b2w=;
        b=kd9RCqUyFdg/TQeSDGd9VZMZuezHUoQmBxGeP7fDi1oogz8NEqypXRRVvPyG1DWMuI
         DlZWzD1XtGy987tbmdl2abiZd6xkp9ATsov/S8J3GfxRgJpveeUA2O6xVnUz9JY1g2Zd
         wm7zN/K9YyODMzmdOv+0gUkzH6G5EH7y42dga6gi7W8yxYSCKnHk9RvBPAyyX58igiJF
         ulbTvARxfdoQgyjNF8Q0SaAPLm9NPhtJW+JfEg9okufEc0lmvvmteeCcab9FeIv957Lr
         e+gba8wEDgjqhIOGld8YSKd5BcGIkHbHYeKH+Q+XoEiwccBgcVEo0uzqZwHRPTPCde5Z
         wskA==
X-Gm-Message-State: AOAM532P0fqz7cHHy6KJQ4BhoHG/JbDKRE9/wq8VmEuom7Y3R8RCzEnn
        2algidnbWfcFR4u6jbn5jCl3lV6MxY9zouu+0kO/g5vP84yti8mFOB9INNFhTfXzxIPJoXhnqO0
        42hnYkatB4MqudNwkpOgfz4rI
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6420852wrs.227.1601069724452;
        Fri, 25 Sep 2020 14:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn4RbXMFzPCp/BRf7V+eMbYZhwwKiG1kHbl7V/C024orzQO8thzzG/QBFKTzqW0VKFvPrHCg==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr6420834wrs.227.1601069724186;
        Fri, 25 Sep 2020 14:35:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id k5sm329421wmb.19.2020.09.25.14.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 14:35:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] KVM: nVMX: Bug fixes and cleanup
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Cross <dcross@google.com>,
        Peter Shier <pshier@google.com>
References: <20200923184452.980-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08e40284-201f-2d18-ff4e-c85b4f767f20@redhat.com>
Date:   Fri, 25 Sep 2020 23:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923184452.980-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 20:44, Sean Christopherson wrote:
> Fix for a brutal segment caching bug that manifested as random nested
> VM-Enter failures when running with unrestricted guest disabled.  A few
> more bug fixes and cleanups for stuff found by inspection when hunting
> down the caching issue.
> 
> v2:
>   - Rebased to kvm/queue, commit e1ba1a15af73 ("KVM: SVM: Enable INVPCID
>     feature on AMD").
> 
> Sean Christopherson (7):
>   KVM: nVMX: Reset the segment cache when stuffing guest segs
>   KVM: nVMX: Reload vmcs01 if getting vmcs12's pages fails
>   KVM: nVMX: Explicitly check for valid guest state for !unrestricted
>     guest
>   KVM: nVMX: Move free_nested() below vmx_switch_vmcs()
>   KVM: nVMX: Ensure vmcs01 is the loaded VMCS when freeing nested state
>   KVM: nVMX: Drop redundant VMCS switch and free_nested() call
>   KVM: nVMX: WARN on attempt to switch the currently loaded VMCS
> 
>  arch/x86/kvm/vmx/nested.c | 103 ++++++++++++++++++++------------------
>  arch/x86/kvm/vmx/vmx.c    |   8 +--
>  arch/x86/kvm/vmx/vmx.h    |   9 ++++
>  3 files changed, 65 insertions(+), 55 deletions(-)
> 

Queued, thanks.

Paolo

