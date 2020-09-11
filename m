Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B41A266653
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIKRZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38670 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726392AbgIKRYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599845087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTZXM9ptUnJ0xEP6DUmb1wgp/BBQlEDO0De4uqNpfTg=;
        b=aF+8AMfaSFqizUp1bMCyda0HA6xgwVxpUbeAIBgYWQ6bo3c9uN57kA2EyDObp8Jw+EqW1R
        jPYx0tgYplRzo9lPd71m/H2qmsskm9MHfr3xFkD+QAPNkV2+vBrMIlDSNLkJ5IfdvEhOck
        4QdatWP89liCjzMoRRPCtAxq16bqpf4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-CgTpHwMQPaWHZT17V6TS_A-1; Fri, 11 Sep 2020 13:24:45 -0400
X-MC-Unique: CgTpHwMQPaWHZT17V6TS_A-1
Received: by mail-wm1-f70.google.com with SMTP id s19so1624563wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 10:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTZXM9ptUnJ0xEP6DUmb1wgp/BBQlEDO0De4uqNpfTg=;
        b=R9a7upG4z9ytaezOuCGjaUZ6Ta/EUlyrEELLTpbJ4MqpWNSFhtNEuzOXjlWffWYDr+
         X9S1AVeaMwNhwGApqPp40nQOgAOYSPZvr9yPaPMUgobTeZPR5b9HKx6DNDuev6Q+1e8K
         n72kaT5jBwTZNmeB8wt3cuwphpIrCPoZXV7E6jxGiGQ8LWK2Hw4dO2lx3+L7R185utlr
         /+VF3G6nzjudzz0WsPd4MyC3ioS96I9TnRSgMpSXKjBLwpJuVIdIA5yx9t045XQvCuZX
         CbzigAzcHwuCvNOVInw69EbRa97erco0frwoPk6cfy8xB5k5AIYYw14o6DYPKsoESWnM
         X31Q==
X-Gm-Message-State: AOAM531K+hrZa5CFkUI9hk6AF1FMDNouEX+Ndc5blV0NfYQJ3cUNpVZs
        TgfkIw5RpIgGEdOKOtjP5t1dTEKARe4FJJiTDwDyhj78GWTyoXNTkmFSpxT75/mdOzeX9U6MjAQ
        PVNmbW58dooluL8l3nUxKnLfx
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr3080291wru.248.1599845083711;
        Fri, 11 Sep 2020 10:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTo6ySxP9uRzVQ/ulExL6XxUV8Kw/YxJCmDZGFtV1pnzQkh4dHLtC9DmRIe0/Y7vWAQtSBYQ==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr3080266wru.248.1599845083506;
        Fri, 11 Sep 2020 10:24:43 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id o128sm5640022wmo.39.2020.09.11.10.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 10:24:43 -0700 (PDT)
Subject: Re: [patch] KVM: SVM: Periodically schedule when unregistering
 regions on destroy
To:     David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org
References: <alpine.DEB.2.23.453.2008251255240.2987727@chino.kir.corp.google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baabe38e-c277-bce8-4fd2-a33ab7e4cc72@redhat.com>
Date:   Fri, 11 Sep 2020 19:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.23.453.2008251255240.2987727@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/20 21:56, David Rientjes wrote:
> There may be many encrypted regions that need to be unregistered when a
> SEV VM is destroyed.  This can lead to soft lockups.  For example, on a
> host running 4.15:
> 
> watchdog: BUG: soft lockup - CPU#206 stuck for 11s! [t_virtual_machi:194348]
> CPU: 206 PID: 194348 Comm: t_virtual_machi
> RIP: 0010:free_unref_page_list+0x105/0x170
> ...
> Call Trace:
>  [<0>] release_pages+0x159/0x3d0
>  [<0>] sev_unpin_memory+0x2c/0x50 [kvm_amd]
>  [<0>] __unregister_enc_region_locked+0x2f/0x70 [kvm_amd]
>  [<0>] svm_vm_destroy+0xa9/0x200 [kvm_amd]
>  [<0>] kvm_arch_destroy_vm+0x47/0x200
>  [<0>] kvm_put_kvm+0x1a8/0x2f0
>  [<0>] kvm_vm_release+0x25/0x30
>  [<0>] do_exit+0x335/0xc10
>  [<0>] do_group_exit+0x3f/0xa0
>  [<0>] get_signal+0x1bc/0x670
>  [<0>] do_signal+0x31/0x130
> 
> Although the CLFLUSH is no longer issued on every encrypted region to be
> unregistered, there are no other changes that can prevent soft lockups for
> very large SEV VMs in the latest kernel.
> 
> Periodically schedule if necessary.  This still holds kvm->lock across the
> resched, but since this only happens when the VM is destroyed this is
> assumed to be acceptable.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  arch/x86/kvm/svm/sev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1106,6 +1106,7 @@ void sev_vm_destroy(struct kvm *kvm)
>  		list_for_each_safe(pos, q, head) {
>  			__unregister_enc_region_locked(kvm,
>  				list_entry(pos, struct enc_region, list));
> +			cond_resched();
>  		}
>  	}
>  
> 

Queued, thanks.  Sorry for the delay.

I am currently on leave so I am going through the patches and queuing
them, but I will only push kvm/next and kvm/queue next week.  kvm/master
patches will be sent to Linus for the next -rc though.

Paolo

