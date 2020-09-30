Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB06527F0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgI3RiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:38:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgI3RiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:38:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601487484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbVSMX0ofjyA4TlGb7f37SdNgbEI+lBF5+h+rIMhjwE=;
        b=EF7PRwT7R1cApRXYfRs0HRMlDbMlYLX1qbGJPGC3eWgQy56GHLC60OqhG6o6DklKSP9XV+
        jQQ/K/G8Y7nsZVNja0oQuE2wDCLXGLI6WIplKonXrdejq6Wu8uevqd+B8RdFLEYUXZ9qHT
        H0AHjlrbBNQx+EUwX6NvqqadL5jhFMA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-wBzMgYSbNhCTV3v_HxKGlg-1; Wed, 30 Sep 2020 13:38:01 -0400
X-MC-Unique: wBzMgYSbNhCTV3v_HxKGlg-1
Received: by mail-wm1-f71.google.com with SMTP id 73so106217wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbVSMX0ofjyA4TlGb7f37SdNgbEI+lBF5+h+rIMhjwE=;
        b=Wx6DRxV1+MCi1aTyBBXRhn3ZnkfrAu9BQrcOAIyS2Tf/0Mt7uzna0x/dTGxxoXsH0i
         r+0GUWV9pRAIPlfOQBPkj9VFKyjUUD7XXyu5WPoNIZdqe3upHAxRq2X8/PPFo86QR/b+
         VcWxUE1FxIk3DV5FG7utcO4L0mAQ+fPoXlW7YEu/N9XCY7DfO2qdxxM7vDhhUIPcFRt6
         iMIKIkL470ro8kG6ebyAuzw+oJhxRf8pFSZnlqhnsOFCF/XsyjPNbUI3ZP7uyUtSyacZ
         uxKxAeInk9Dw3A6zEQy8yspaMr4U1g9UGqvhHFovDh3/1/ijbWJ70dmSFCjlxyRr6KX6
         cWfQ==
X-Gm-Message-State: AOAM532DI0WLqSIheAdNKZ/A9snABuR4/jaXLFDQswgHEQmlFd8ok/8z
        jdf5KahCEhuLu3+F0DrEfkveKNTpliT7IoAwlGQAdiqi6OHB2pj8s3L6l+vr4u6M5H0jT01Uifa
        85ucJhh6eE642thwe2A5p7D+n
X-Received: by 2002:a7b:c307:: with SMTP id k7mr4415213wmj.31.1601487480427;
        Wed, 30 Sep 2020 10:38:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp1wDZFnmFzUCxHS34y6dw6TXiGHDizdhqmNG6eghuz6QpGoY9QXzZ0SsDF1zWzIGheprEfg==
X-Received: by 2002:a7b:c307:: with SMTP id k7mr4415181wmj.31.1601487480144;
        Wed, 30 Sep 2020 10:38:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4? ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
        by smtp.gmail.com with ESMTPSA id k6sm3757940wmi.1.2020.09.30.10.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 10:37:59 -0700 (PDT)
Subject: Re: [PATCH 10/22] kvm: mmu: Add TDP MMU PF handler
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-11-bgardon@google.com>
 <20200930163740.GD32672@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b123d506-fa33-db3f-1166-4b0ec1d6dc1e@redhat.com>
Date:   Wed, 30 Sep 2020 19:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930163740.GD32672@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/20 18:37, Sean Christopherson wrote:
>> +	ret = page_fault_handle_target_level(vcpu, write, map_writable,
>> +					     as_id, &iter, pfn, prefault);
>> +
>> +	/* If emulating, flush this vcpu's TLB. */
> Why?  It's obvious _what_ the code is doing, the comment should explain _why_.
> 
>> +	if (ret == RET_PF_EMULATE)
>> +		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>> +
>> +	return ret;
>> +}

In particular it seems to be only needed in this case...

+	/*
+	 * If the page fault was caused by a write but the page is write
+	 * protected, emulation is needed. If the emulation was skipped,
+	 * the vCPU would have the same fault again.
+	 */
+	if ((make_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) && write)
+		ret = RET_PF_EMULATE;
+

... corresponding to this code in mmu.c

        if (set_spte_ret & SET_SPTE_WRITE_PROTECTED_PT) {
                if (write_fault)
                        ret = RET_PF_EMULATE;
                kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
        }

So it should indeed be better to make the code in
page_fault_handle_target_level look the same as mmu/mmu.c.

Paolo

