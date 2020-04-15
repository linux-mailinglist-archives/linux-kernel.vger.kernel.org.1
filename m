Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042641AA1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 14:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370214AbgDOMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 08:46:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2898221AbgDOMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586954724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAlovoyi5PA4D+Fqa/NczMkBNI951G2MPlQuUiIGWTU=;
        b=iTQK33bOwKHjhGxmseMuDbPSs5ONbXFcjBg+f7pZKQAJX6aoxdMttontRZGwxBfx16+oQA
        GI1dx3/gZJtu7AIM2plz/GTclGGsVhLIhPQj2Nk0ZBq+9ZGlzd+a5inewd/YxWaZz4m/dH
        bZIvH63Ab4fqhBkon7AJZoleTKh1kF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-7SS2cWc1PNGLpYIaLuR6Zw-1; Wed, 15 Apr 2020 08:45:19 -0400
X-MC-Unique: 7SS2cWc1PNGLpYIaLuR6Zw-1
Received: by mail-wr1-f69.google.com with SMTP id y1so10505671wrp.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAlovoyi5PA4D+Fqa/NczMkBNI951G2MPlQuUiIGWTU=;
        b=jVoarvwWkQREDoIupg3AY8XldLMYi6WCb9MGPL8zjvciNclpncuLpe03Y8nzcNCD+f
         ysFM9XJ/ilDpfr909w2iI+RZ0srYjalk6GFXl5pBKEZnVbyliPAcvhAnGnbN3KXqGFQh
         tSzyHAwRl1JDIIXt31awZG3geYOYZMrtgIo0SXa6dMl+5woumXfxBh5l0fP02bl5ImHu
         sfl69vgPRkCpmxkMjE5mtzM1yc+flhLc4nUXvKp04Q8Fdtk3DxCOnojbSQklVMTMM4rQ
         5Y+eydLecs/qRE/+s/VnvNdIqdjUZxR5tzfjoN0/fXktOA49Uvd8pHNNKkLQC9XT8Jvx
         olWg==
X-Gm-Message-State: AGi0PubB1RLKIpye8PuYHXDHi/kcLdvrhNEkj+bCh/FvlYHs7cVaxNgK
        5/Nt5VLUHx0ZrxH+3XFBY9yjfq1gQp4u1HIXnptNFsn3GGi8Zo007miMBzur5iWQm6wXKVI9qBI
        rmiBShZjAddHgdwcwEQfLTPz5
X-Received: by 2002:adf:e942:: with SMTP id m2mr28849934wrn.364.1586954717747;
        Wed, 15 Apr 2020 05:45:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJKPyYvpGgkRePJv+9rAQwzxja3UlK/XUhK4cNv9GoxnsNJrHaNpgzSFb37TbJIKtZpEkFYyQ==
X-Received: by 2002:adf:e942:: with SMTP id m2mr28849913wrn.364.1586954717511;
        Wed, 15 Apr 2020 05:45:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id g186sm23460498wme.7.2020.04.15.05.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 05:45:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: SVM: Implement check_nested_events for NMI
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Cathy Avery <cavery@redhat.com>
Cc:     wei.huang2@amd.com, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200414201107.22952-1-cavery@redhat.com>
 <87zhbdw02i.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e4bfa85-559e-79b0-268f-1a3024559b34@redhat.com>
Date:   Wed, 15 Apr 2020 14:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zhbdw02i.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 11:49, Vitaly Kuznetsov wrote:
> Not directly related to this series but I just noticed that we have the
> following comment in inject_pending_event():
> 
> 	/* try to inject new event if pending */
> 	if (vcpu->arch.exception.pending) {
>                 ...
> 		if (vcpu->arch.exception.nr == DB_VECTOR) {
> 			/*
> 			 * This code assumes that nSVM doesn't use
> 			 * check_nested_events(). If it does, the
> 			 * DR6/DR7 changes should happen before L1
> 			 * gets a #VMEXIT for an intercepted #DB in
> 			 * L2.  (Under VMX, on the other hand, the
> 			 * DR6/DR7 changes should not happen in the
> 			 * event of a VM-exit to L1 for an intercepted
> 			 * #DB in L2.)
> 			 */
> 			kvm_deliver_exception_payload(vcpu);
> 			if (vcpu->arch.dr7 & DR7_GD) {
> 				vcpu->arch.dr7 &= ~DR7_GD;
> 				kvm_update_dr7(vcpu);
> 			}
> 		}
> 
> 		kvm_x86_ops.queue_exception(vcpu);
> 	}
> 
> As we already implement check_nested_events() on SVM, do we need to do
> anything here? CC: Jim who added the guardian (f10c729ff9652).

It's (still) okay because we don't use check_nested_events() for exceptions.

Regarding this series, I think we should implement the NMI injection
test for VMX and see if it requires the same change as patch 2.

Paolo

