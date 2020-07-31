Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E7234011
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 09:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgGaHgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 03:36:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731649AbgGaHgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596180990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=553KQ1qNVymmVc2Jbs3bPD4YZyJND+P5R8Nz7Iw3uxY=;
        b=gWxQJWcKWMRqsEmV6rmV34vl1w/EIlulavU3LmnhHMdTMQPxUke9ZXMNPAuAmySm3V3zIg
        EP/2k9BJl035U11Pbhl7jAoN7XccsZASNfjK2NfURxAPyf7Av03NGvPqbbWsmdD+nkLSQr
        9aOyJbGcKEtDzjvBG21Y7Ph5AbfYDQs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-07UMWe3HMke9RT92JxvYag-1; Fri, 31 Jul 2020 03:36:27 -0400
X-MC-Unique: 07UMWe3HMke9RT92JxvYag-1
Received: by mail-wr1-f71.google.com with SMTP id w1so6829379wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=553KQ1qNVymmVc2Jbs3bPD4YZyJND+P5R8Nz7Iw3uxY=;
        b=QNoygVZmPOEz4/twoZBdmgM3tyaDD3PPHAsyK7MBWt366Y7zwvtaElDTaDjj/s3toB
         YT1yjtIPzfzTQosOTN7rkrHxtKY5EEgBbdk5eRNs0THfNV4UaQfgSImC2y8knG8kTAmC
         bjJ5xQH9B0rrK04dGOVuvgG2XcTMpZHgh2fScx1y4EjySQda+u1fn5N1PzSnWKN188O7
         CB1jQQwT1QUF2P4+qgq9ofArBC3B1LrlOYiaXSCQbr8Z3eAlVPcvW4/RUOG8GjZyLADi
         Tg9E1HYJjxmf325ceZiLWwK0k9CATfUdqV508Znv8lU5KSLHLu6TXC1BF9Dz1Z0IW6oo
         fD2g==
X-Gm-Message-State: AOAM5321Yastc+1+Qc6QDcKN2ytPF2ayc2eXhII24iJTd5Ow10f5AFxy
        tJef5QAe8wRcPhMWyJ8mc6oufBLV8TLJn8NAXPYM6VivQDMt5Nfbne9woZUI+xsoE9Qau1u7eQM
        d8P9eqhiu2AcuORoTb1OwBKfM
X-Received: by 2002:a5d:5609:: with SMTP id l9mr2180877wrv.86.1596180985662;
        Fri, 31 Jul 2020 00:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK5Kv8TZaxnsghX4+eREYu/xA6eXNCFl4Iau4DmmrIF5oz1lEHRcJA6j4qFKcbXil6qN/DmQ==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr2180862wrv.86.1596180985472;
        Fri, 31 Jul 2020 00:36:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445? ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
        by smtp.gmail.com with ESMTPSA id t11sm11878979wrs.66.2020.07.31.00.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:36:24 -0700 (PDT)
Subject: Re: [PATCH -next] emulate:Fix build error
To:     Peng Wu <wupeng58@huawei.com>, tsbogend@alpha.franken.de
Cc:     chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
        colin.king@canonical.com, tianjia.zhang@linux.alibaba.com,
        huanglllzu@gmail.com, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1596179807-17713-1-git-send-email-wupeng58@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ddee30c4-6190-5cbc-6340-c138bd1550b5@redhat.com>
Date:   Fri, 31 Jul 2020 09:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1596179807-17713-1-git-send-email-wupeng58@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/20 09:16, Peng Wu wrote:
> The declaration of function kvm_mips_complete_mmio_load
> has only one formal parameter,but two parameters are passed
> when called. So, the following error is seen while building
> emulate.c
> 
> arch/mips/kvm/emulate.c: In function ‘kvm_mips_emulate_load’:
> arch/mips/kvm/emulate.c:2130:3: error: too many arguments
> to function ‘kvm_mips_complete_mmio_load’
>    kvm_mips_complete_mmio_load(vcpu, run);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from linux/include/linux/kvm_host.h:36,
>                  from linux/arch/mips/kvm/emulate.c:15:
> arch/mips/include/asm/kvm_host.h:1072:30: note: declared here
> extern enum emulation_result
> 	kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu);
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> ---
>  arch/mips/kvm/emulate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 1d41965..7037823 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -2127,7 +2127,7 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
>  			run->mmio.phys_addr, run->mmio.len, run->mmio.data);
>  
>  	if (!r) {
> -		kvm_mips_complete_mmio_load(vcpu, run);
> +		kvm_mips_complete_mmio_load(vcpu);
>  		vcpu->mmio_needed = 0;
>  		return EMULATE_DONE;
>  	}
> 

This is queued already, I' will push it shortly.  Thanks!

Paolo

