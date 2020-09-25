Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCD427940D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgIYWWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728410AbgIYWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:22:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601072542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnXTkz+/ctmLQQwvaDR7Qd+4H4vqY3Yke9ZK1sUrI2Q=;
        b=QpYghhvepwrBSO9ltbSUbjv7d3BceBrAvM0UQfK5FakTW9tD1JqycBPyQ8WcFVmKD2L2ry
        BeBhjypSqHTeDhZpUiSGZLVV30lLsEffaCSQugDbd6lpaKpasmhuvqchU9MzDnlrIx+dvC
        0tEaR5MFBVlX4YVCj1+NvmfvpXJzAf8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-3ZPpIYUnM8aGaYWTNpzGRA-1; Fri, 25 Sep 2020 18:22:20 -0400
X-MC-Unique: 3ZPpIYUnM8aGaYWTNpzGRA-1
Received: by mail-wr1-f70.google.com with SMTP id d13so1614958wrr.23
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WnXTkz+/ctmLQQwvaDR7Qd+4H4vqY3Yke9ZK1sUrI2Q=;
        b=rqCHf9MaXgveB8N9EDtZ5mVpacePOkyOH2YqJ0T6q3cDaTSGxBR1GmeSUB2pipEaZL
         /seOXojbumsbQzi/+ytdjnkjXW8kPVqkD4WVR7u3FxkwK3h87l9gHqCAP+4URvbvCScb
         1PXbGIrKGuwjMZlJGUWLK8T+XWjxoUcaWcPZMRs+mp6IT7kNDUQ65N9ZHeA/9uovpJWy
         NMaaZejeotEJi6A4tLKwyJrdGO+wxQfj54ozn4zCIheRPJ7XSSHHUA80T/aJFt5l45Jx
         pfA6NYPLtivFbEblvl2I5itUicHxrBDn9LytgXepho7aoE4OUjWVkLMzYvTXgi4BNcpJ
         czzg==
X-Gm-Message-State: AOAM5326V5o+yYOqdHGEYPujaWiJ1UaHS5eJwUGLoAjrPnu3Co31LA3e
        muKVbDkRdHoIHk9Q2Lm+HwW8D04RQCAbaLWXEXchXVpedCqtYrnPgNeieY2ZpQQ5a/CrTULneFy
        aiaFiIYSjJWnynRNM2TWTsKWJ
X-Received: by 2002:a05:6000:88:: with SMTP id m8mr3263944wrx.280.1601072539144;
        Fri, 25 Sep 2020 15:22:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyvAHL41aNceFHbsD7XNzOAM/bk8mimliUOQBhi9Xd2hh2XUKWNFEB2f/J487a4htihv6V+w==
X-Received: by 2002:a05:6000:88:: with SMTP id m8mr3263922wrx.280.1601072538929;
        Fri, 25 Sep 2020 15:22:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id c25sm405221wml.31.2020.09.25.15.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 15:22:18 -0700 (PDT)
Subject: Re: [PATCH v8 5/8] KVM: x86: SVM: Prevent MSR passthrough when MSR
 access is denied
To:     Alexander Graf <graf@amazon.com>, kvm list <kvm@vger.kernel.org>
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200925143422.21718-1-graf@amazon.com>
 <20200925143422.21718-6-graf@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f471cac2-89fd-2d61-04fa-2edf6ec438e5@redhat.com>
Date:   Sat, 26 Sep 2020 00:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925143422.21718-6-graf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 16:34, Alexander Graf wrote:
> We will introduce the concept of MSRs that may not be handled in kernel
> space soon. Some MSRs are directly passed through to the guest, effectively
> making them handled by KVM from user space's point of view.
> 
> This patch introduces all logic required to ensure that MSRs that
> user space wants trapped are not marked as direct access for guests.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> 
> ---
> 
> v7 -> v8:
> 
>   - s/KVM_MSR_ALLOW/KVM_MSR_FILTER/g
> ---

Ok, just some cosmetic fixes on top:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bb9f438e9e62..692110f2ac6f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -553,7 +553,7 @@ static int svm_cpu_init(int cpu)
 
 }
 
-static int direct_access_msr_idx(u32 msr)
+static int direct_access_msr_slot(u32 msr)
 {
 	u32 i;
 
@@ -561,33 +561,33 @@ static int direct_access_msr_idx(u32 msr)
 		if (direct_access_msrs[i].index == msr)
 			return i;
 
-	return -EINVAL;
+	return -ENOENT;
 }
 
 static void set_shadow_msr_intercept(struct kvm_vcpu *vcpu, u32 msr, int read,
 				     int write)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	int idx = direct_access_msr_idx(msr);
+	int slot = direct_access_msr_slot(msr);
 
-	if (idx == -EINVAL)
+	if (slot == -ENOENT)
 		return;
 
 	/* Set the shadow bitmaps to the desired intercept states */
 	if (read)
-		set_bit(idx, svm->shadow_msr_intercept.read);
+		set_bit(slot, svm->shadow_msr_intercept.read);
 	else
-		clear_bit(idx, svm->shadow_msr_intercept.read);
+		clear_bit(slot, svm->shadow_msr_intercept.read);
 
 	if (write)
-		set_bit(idx, svm->shadow_msr_intercept.write);
+		set_bit(slot, svm->shadow_msr_intercept.write);
 	else
-		clear_bit(idx, svm->shadow_msr_intercept.write);
+		clear_bit(slot, svm->shadow_msr_intercept.write);
 }
 
 static bool valid_msr_intercept(u32 index)
 {
-	return direct_access_msr_idx(index) != -EINVAL;
+	return direct_access_msr_slot(index) != -ENOENT;
 }
 
 static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
@@ -609,7 +609,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	return !!test_bit(bit_write,  &tmp);
 }
 
-static void set_msr_interception_nosync(struct kvm_vcpu *vcpu, u32 *msrpm,
+static void set_msr_interception_bitmap(struct kvm_vcpu *vcpu, u32 *msrpm,
 					u32 msr, int read, int write)
 {
 	u8 bit_read, bit_write;
@@ -646,7 +646,7 @@ static void set_msr_interception(struct kvm_vcpu *vcpu, u32 *msrpm, u32 msr,
 				 int read, int write)
 {
 	set_shadow_msr_intercept(vcpu, msr, read, write);
-	set_msr_interception_nosync(vcpu, msrpm, msr, read, write);
+	set_msr_interception_bitmap(vcpu, msrpm, msr, read, write);
 }
 
 static u32 *svm_vcpu_alloc_msrpm(void)
@@ -694,7 +694,7 @@ static void svm_msr_filter_changed(struct kvm_vcpu *vcpu)
 		u32 read = test_bit(i, svm->shadow_msr_intercept.read);
 		u32 write = test_bit(i, svm->shadow_msr_intercept.write);
 
-		set_msr_interception_nosync(vcpu, svm->msrpm, msr, read, write);
+		set_msr_interception_bitmap(vcpu, svm->msrpm, msr, read, write);
 	}
 }
 

