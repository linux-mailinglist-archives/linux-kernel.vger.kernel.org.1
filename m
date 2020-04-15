Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6ECE1AAB02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371069AbgDOOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:52:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S371065AbgDOOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586962363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HcURD5RLU4AHJzLsroTnnqfqtIhRpKSmMCjT+ORb04=;
        b=Rb72kaWFCHNaVFRMijpz+Gvk7QaoIpnaYAlYGkR8TbD8Dx21GHpdsRRpYvC2Nfg3j9eK/m
        xOmou7KJ6cmYqAR3IcToC71OxPENLYIXgXFatoLExZtdAUny8AJUpt9PArK51jgzhGQQy0
        rX63pvjmEv9IqSp2Wp+TyiNyiNE5srM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-HxN2yBStMyG9_7-y4lZ3Qw-1; Wed, 15 Apr 2020 10:52:41 -0400
X-MC-Unique: HxN2yBStMyG9_7-y4lZ3Qw-1
Received: by mail-wm1-f71.google.com with SMTP id h6so5419791wmi.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1HcURD5RLU4AHJzLsroTnnqfqtIhRpKSmMCjT+ORb04=;
        b=EDH4+a+fNCkWMiI1KcyzdpGISNXRsj4gkKdbHYWY1zsmq5OMPuki3KbMAUEVTOLaOd
         8V3Hb/rxoa/50SkJdqiBYk2w1L0sPs61UIlt1R2QBxLUy61L+0G2v6Yd91XkzE+4ql0Y
         zQstxuqsq7fAIXrVmpcMppi4VIm++nK+frIJOwMfyNR4YjwgmpGKPPxIf5Fe+SxHj6ra
         KNYPMUiSTjyCjcKO2Npsh36GKqc6a5XDAVq/5PtFXShC5nk+VTlq+lVJ6OgGaS1hOwnA
         OXoE9/9645plNU1TQconmI+6/KO08N25VLm7A5LaAjh1L73o+LApxqypsBD0QwMo15dm
         GB5A==
X-Gm-Message-State: AGi0PuaiKrFbvjYebIFqtTXvl01egh3Q+6yqvj9OBJtfsiHLuP+319X3
        g8tBh3a0yAZVdVRCq2b5Mihde4bgXFjZYOMckm7iQqzetYiuRXOtisQ84vmBxyTj2ziNYtqU93J
        wVGYUbi0IEaAQ+bi3e8XjdyPU
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr5478283wmm.131.1586962357332;
        Wed, 15 Apr 2020 07:52:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJpmTfXvAfh6VQ7NYsROjF39AkmtViNfPLXAcTjNMlDROjb6qcLhhfNyYsa+WbDh/+5TjzYXg==
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr5478267wmm.131.1586962357128;
        Wed, 15 Apr 2020 07:52:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id p10sm22950455wrm.6.2020.04.15.07.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 07:52:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] KVM: pass through CPUID(0x80000006)
To:     Eric Northup <digitaleric@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jon Cargille <jcargill@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Northup <digitaleric@google.com>
References: <20200415012320.236065-1-jcargill@google.com>
 <20200415023726.GD12547@linux.intel.com>
 <20200415025105.GE12547@linux.intel.com>
 <CAPC9edWgcrC+mc1pQSYmJjPs17VZ-Af1LJ+s6PaeY=9fPA89NQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c351cec8-fb35-c34f-edbf-2117fa147082@redhat.com>
Date:   Wed, 15 Apr 2020 16:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPC9edWgcrC+mc1pQSYmJjPs17VZ-Af1LJ+s6PaeY=9fPA89NQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 07:27, Eric Northup wrote:
>>>   Return the host's L2 cache and TLB information for CPUID.0x80000006
>>>   instead of zeroing out the entry as part of KVM_GET_SUPPORTED_CPUID.
>>>   This allows a userspace VMM to feed KVM_GET_SUPPORTED_CPUID's output
>>>   directly into KVM_SET_CPUID2 (without breaking the guest).
> This is a much better commit message, thanks.
> 

Queued, thanks.

Paolo

