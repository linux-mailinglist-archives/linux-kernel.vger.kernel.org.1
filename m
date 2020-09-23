Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2812759D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIWOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbgIWOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600871058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S3+XlwGZbFIsIgBY1zyuOCGqClTJDRCCN2cgr0snetc=;
        b=VvbyZASBrdU0zXGlVjc7eYboyoSpfj1EUUVncxpH0n/mVNc0wfvr8s6OQTUm4jsqsHEZTw
        5eJ1Fgjl6XLbMHFwERnIVyePMjQdQz0s1OYt3XivohoQ83NvYUikTi1FIJ2DNsEqdaF7Sn
        YpjefhGyqk7HPSwU+RGgPABkPIsazL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-UoFZMRGvPjWPvg-d_RilFQ-1; Wed, 23 Sep 2020 10:24:17 -0400
X-MC-Unique: UoFZMRGvPjWPvg-d_RilFQ-1
Received: by mail-wr1-f71.google.com with SMTP id f18so8894084wrv.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S3+XlwGZbFIsIgBY1zyuOCGqClTJDRCCN2cgr0snetc=;
        b=H9I4Q8lr7MPSVqPPaulrnVE77oCOPbGnhdBteFuFk/XKn1mJVwxgP/qm/mbLFq13gn
         mngibI7QAaaLEd2RudxjxbtbJKYUTYZAmxOCxeNVU2FMl5WDJtJ5lyhKH1JX1kqTYDQ7
         szWWny/B/tisH/OfT4oyo48BerWmvdujAH2NdEwSnmXOnjbtBHF/0ZzU+jM9eputkYqs
         iIDvSIHX3IrD0q+HdiAGevBJkj8m1qYoEh7BpUqZLAyp5im7QSFXIPCHXl85HTknk/Gu
         MGBWVD7th0KdozhsXdKCJlpxjJwN9MV1gPKYRJtYB1xZiRBZb3NCDPhJWY4UsRwoRgiD
         yYuA==
X-Gm-Message-State: AOAM531Db6u9FJx7MbUjwjkT9ccrCDRR0ZnBTomdahHPt5gpk3ehbgo0
        Qa91isGm4ZZ1IReKCTLtq3EtTNsYLUnz8YVrYYtZKi6gRZ4TGLHoyHLosGabUG8975QkN9bufmC
        9kFS3VJGiip0O5ry7//UVfE68
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr1133782wrw.199.1600871055309;
        Wed, 23 Sep 2020 07:24:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn1rVI+lklZm2YsGtnUhjFXMRZPm38QxJE5ctn6MZ7p3x1GP6nA/zN8TZuSUC3R6UedL5kCg==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr1133757wrw.199.1600871055067;
        Wed, 23 Sep 2020 07:24:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id x2sm31221286wrl.13.2020.09.23.07.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 07:24:14 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: Fix assert failure in single-step test
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
References: <20200826015524.13251-1-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <076c24ae-948a-48ed-99ec-c7d43753c802@redhat.com>
Date:   Wed, 23 Sep 2020 16:24:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826015524.13251-1-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/20 03:55, Yang Weijiang wrote:
> This is a follow-up patch to fix an issue left in commit:
> 98b0bf02738004829d7e26d6cb47b2e469aaba86
> selftests: kvm: Use a shorter encoding to clear RAX
> 
> With the change in the commit, we also need to modify "xor" instruction
> length from 3 to 2 in array ss_size accordingly to pass below check:
> 
> for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
>         target_rip += ss_size[i];
>         CLEAR_DEBUG();
>         debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
>         debug.arch.debugreg[7] = 0x00000400;
>         APPLY_DEBUG();
>         vcpu_run(vm, VCPU_ID);
>         TEST_ASSERT(run->exit_reason == KVM_EXIT_DEBUG &&
>                     run->debug.arch.exception == DB_VECTOR &&
>                     run->debug.arch.pc == target_rip &&
>                     run->debug.arch.dr6 == target_dr6,
>                     "SINGLE_STEP[%d]: exit %d exception %d rip 0x%llx "
>                     "(should be 0x%llx) dr6 0x%llx (should be 0x%llx)",
>                     i, run->exit_reason, run->debug.arch.exception,
>                     run->debug.arch.pc, target_rip, run->debug.arch.dr6,
>                     target_dr6);
> }
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  tools/testing/selftests/kvm/x86_64/debug_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> index b8d14f9db5f9..2fc6b3af81a1 100644
> --- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
> +++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> @@ -73,7 +73,7 @@ int main(void)
>  	int i;
>  	/* Instruction lengths starting at ss_start */
>  	int ss_size[4] = {
> -		3,		/* xor */
> +		2,		/* xor */
>  		2,		/* cpuid */
>  		5,		/* mov */
>  		2,		/* rdmsr */
> 

Queued, thanks.

Paolo

