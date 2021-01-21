Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41902FEE03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbhAUPFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732485AbhAUPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611241342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5ZJBAFE/dpWgJgGy+WRiaDv+4qyXSXIA8BiVewPRXg=;
        b=S5Zy0Kk0AACywZM7O7Yq4WiwGbGsoyO1+0184sd5YnlyohG+6aI+xHGrdAUhA/Qj4DJYXH
        mO/l5xRhTFOd3z09KJRrwU26CvHDoNz5l0Lj7AH36NyA0jTM22kRgcaQNCNEAR21IPkAWQ
        PIgAa8MqofqXF4qMKPGnn/FxyBFBg3I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-1l1DK7gkPUS0OCG52AKL4w-1; Thu, 21 Jan 2021 10:02:20 -0500
X-MC-Unique: 1l1DK7gkPUS0OCG52AKL4w-1
Received: by mail-ej1-f69.google.com with SMTP id jg11so862123ejc.23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v5ZJBAFE/dpWgJgGy+WRiaDv+4qyXSXIA8BiVewPRXg=;
        b=qcY653LGxaTtjMVJ766LAuEw1LQZHDyEvex3j5gEKt++3RjvHRsCLK3kfX5JEISd0X
         fvG+xSDNiUEiLbCnWJJKAaA7TtUG3ROgBfqrvHHBD8o1NUwevTXzw2xYywCQwRSUdMQl
         j49EAHqjcat5oeoQfFZRI5yJMwlGAkKbH4uooHLn2RLXYJkL4imbjc3HoFh0AxRDa5PE
         xmUi+VvqOc8ELSX/RBLF+Cz2gwd2XvwycpVEMYfu0FoTmXTJcIIZ3ymjEuBKcRIawbmW
         8ZaXXcF4OVuxoH3F5YToKXyJI0u4utZDb8Zc52EIrsIttZ6Vk+PH+ZxEfiqqV4lMpauZ
         1whQ==
X-Gm-Message-State: AOAM530fWvq8FLyrMUXb/yv/qQcBFSQvxM60IG18BSpXeFqdaQ386kr3
        xOjfddxFb+gWcutOZZlQv8JFOKRQeyJwwwNbKypBfkZFB++CbGW0FyG2aIZmvVqj3hEu6pVOVU4
        vu4+oQDsuD67KiKdcW275F6FQ
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr11338547edw.88.1611241339254;
        Thu, 21 Jan 2021 07:02:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhj7tsuHL8LeeLW26jaZLOTEWepj0VMCjXTY/MLlSVJ7mDAQ89Ie+ss8mPDl8VdQWyN94HZQ==
X-Received: by 2002:a05:6402:134b:: with SMTP id y11mr11338520edw.88.1611241339103;
        Thu, 21 Jan 2021 07:02:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id w2sm2377655ejn.73.2021.01.21.07.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 07:02:18 -0800 (PST)
Subject: Re: [PATCH 0/2] Enumerate and expose AVX_VNNI feature
To:     Yang Zhong <yang.zhong@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kyung.min.park@intel.com
References: <20210105004909.42000-1-yang.zhong@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eee07399-df81-83ed-d410-18b42d51e26c@redhat.com>
Date:   Thu, 21 Jan 2021 16:02:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105004909.42000-1-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/21 01:49, Yang Zhong wrote:
> A processor supports AVX_VNNI instructions if CPUID.(EAX=7,ECX=1):EAX[bit 4]
> is present.
> 
> This series includes kernel and kvm patches, kernel patch define this
> new cpu feature bit and kvm expose this bit to guest. When this bit is
> enabled on cpu or vcpu, the cpu feature flag is shown as "avx_vnni" in
> /proc/cpuinfo of host and guest.
> 
> Detailed information on the instruction and CPUID feature flag can be
> found in the latest "extensions" manual [1].
> 
> Reference:
> [1]. https://software.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html
> 
> 
> Kyung Min Park (1):
>    Enumerate AVX Vector Neural Network instructions
> 
> Yang Zhong (1):
>    KVM: Expose AVX_VNNI instruction to guset
> 
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   arch/x86/kvm/cpuid.c               | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 

Queued, thanks.

Paolo

