Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAEF292AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgJSQBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730335AbgJSQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603123281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnOeLfGLTUy5AgN8jhCNmXzK0dSH/7S/Ox3jrYuwhp4=;
        b=ftVRY4qu6nI+Z2/V9SIS05/5eYoPI8q4OR2BR1Ai9QiMkkoD9p2ivP9OJwAvzB3+uNgqd0
        ZyD99IM+FyDWQGwMNcuu3+ZpPc47VX94JTb+iOSLRj84dpMPj9wpFU0shCeSt7f/Lp2WuM
        Llvv2szos9uKxtl5CGpTLk9Zz2i0cNQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-xhj7I0zUOjy-IN0TCWjofg-1; Mon, 19 Oct 2020 12:01:19 -0400
X-MC-Unique: xhj7I0zUOjy-IN0TCWjofg-1
Received: by mail-wm1-f71.google.com with SMTP id d197so5203wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xnOeLfGLTUy5AgN8jhCNmXzK0dSH/7S/Ox3jrYuwhp4=;
        b=co+aYTcRGRBkFlgEe0C9R2Xg6AAcKgaM2GsFocDSo3bPMHizRMibK7drlDhqmzVNC6
         jll+5A8Fbpyo1KtaO6YNdNO/Aea3+6NTvot1bj5Y51dzcz2avgaabnhIcDei2JRa6fDg
         Eg19LaX0FPxIms9NpgjLSFk6jvtE8L//LFo06pC/wc2uTrkevCTgiiGwYm1SRVhi1yjV
         P4MzBohzW5bauxSCz7HGKvioUSJOnvfwwt6gCy0pUyEkpjuETNgRlzmaCQCyoFanJXgl
         mUieR07Me1FVww0Ynkgy8gvh7+sncc4VQs9cfJ0i9tDO/w/5qMUVPVNHAiDM8g9pX17o
         vcsw==
X-Gm-Message-State: AOAM532qzBIZ1xP8UwFuP6zhDrLU1gEUW9/NuTGVxJanIrqw+so0ZET8
        iN0xPmj1TAY3JqL7+PZSY8XGPWPS9ByksiW8Bl6f4C/yjMgM7Xn0hNro2Qv2Vk6J9JRUmAQw2Rk
        BD5KbdN/lgEZzHOG+aE50JxLJ
X-Received: by 2002:adf:fa05:: with SMTP id m5mr245235wrr.57.1603123277255;
        Mon, 19 Oct 2020 09:01:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKxOu81uqDh+9uxrRSdxg88EvBO4mlL2AidEN3mjsJSrEou8SdfIvWp/NkY5z0pMi9CEOU/Q==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr245196wrr.57.1603123277038;
        Mon, 19 Oct 2020 09:01:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x65sm55385wmg.1.2020.10.19.09.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 09:01:16 -0700 (PDT)
Subject: Re: [PATCH 1/4] KVM: PPC: Book3S HV: Make struct kernel_param_ops
 definition const
To:     Joe Perches <joe@perches.com>, Paul Mackerras <paulus@ozlabs.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Davidlohr Bueso <dave@stgolabs.net>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1601770305.git.joe@perches.com>
 <d130e88dd4c82a12d979da747cc0365c72c3ba15.1601770305.git.joe@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1945b90-c97c-f998-56b2-e5635992848a@redhat.com>
Date:   Mon, 19 Oct 2020 18:01:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d130e88dd4c82a12d979da747cc0365c72c3ba15.1601770305.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/20 02:18, Joe Perches wrote:
> This should be const, so make it so.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 4ba06a2a306c..2b215852cdc9 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -111,7 +111,7 @@ module_param(one_vm_per_core, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(one_vm_per_core, "Only run vCPUs from the same VM on a core (requires indep_threads_mode=N)");
>  
>  #ifdef CONFIG_KVM_XICS
> -static struct kernel_param_ops module_param_ops = {
> +static const struct kernel_param_ops module_param_ops = {
>  	.set = param_set_int,
>  	.get = param_get_int,
>  };
> 

Queued, thanks.

Paolo

