Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD341C270B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgEBQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 12:42:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728312AbgEBQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 12:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588437728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OidOSfoLTFcT8l45mrEaIKuRu8kYn+JXy7OweRfj4xs=;
        b=W3u4kTy0QYTTrAFEbj4B6PBUaIE+rSsFU14yKNMOtI2y9OdzYo3XY30sArWU1r+z5IDrKz
        uuHLIuc9JBnO9E99SSO3883WF/cKVLCnJyV+EfdIAAkKX/lZl5fo47cm3tCFhxffL+w94R
        7fZ66zn3wAIPVwXeGl3SXLiPeRyAJQ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-WwsBEZy2MgytEWw85uPyPA-1; Sat, 02 May 2020 12:42:06 -0400
X-MC-Unique: WwsBEZy2MgytEWw85uPyPA-1
Received: by mail-wm1-f71.google.com with SMTP id d134so6033997wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 09:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OidOSfoLTFcT8l45mrEaIKuRu8kYn+JXy7OweRfj4xs=;
        b=D21ImpoelEs2w6REWVU9W+JICrroafVULoF33yF2mvuUU820rXURYJvLUS0WHZnZKH
         1IOX3qzm4bUcc2eXnLdSb8NswHLE/G6K48uDxVe4Z4Yx5AAk8ZcGZJraACBYatcnDDl3
         0UD2ZPXYALhx6N7kXMqSsg5p4im70S7tZzzCs3tEzTYJ5IrCdRUuORQRi4oLbq8pvjSB
         G9Y9eXFku04/HoMsIg9+cC+/Xlk3Tkfc0Qcat6e9mqjg9i7BQxQJNPTBXAgj03GFLNkU
         EQt+pnTXqOA0NtLFfZHeh2LmQnPpVlZJon7lfBtpse+Q8CZ/SrzDs1m/U2w6nxN9wrSY
         5UmA==
X-Gm-Message-State: AGi0PuZsyxW9Z0MlNkyJ1wPVZsxTCAYKmWn3im5iNcGJ0dqA7IlnsaIR
        4XWPo8h1wws5zNoaxR3bEngXqmgGLoGbHtRqwitZqFVuc12QFnoX5/QheuB52pFnsO9pSKjW9Ah
        xKyhWRUDZ9jq35ACPCoGv7K5S
X-Received: by 2002:adf:ce02:: with SMTP id p2mr9893077wrn.173.1588437724966;
        Sat, 02 May 2020 09:42:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUKirEiYTqHQbj1N49RThKk1BCWQb1DCNrF6PMtg9FJiFwHPqNHMIAZlRE7BsQ8uI/4Gwzgw==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr9893066wrn.173.1588437724734;
        Sat, 02 May 2020 09:42:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1000:6128:564:d837? ([2001:b07:6468:f312:1000:6128:564:d837])
        by smtp.gmail.com with ESMTPSA id d7sm9923543wrn.78.2020.05.02.09.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 09:42:04 -0700 (PDT)
Subject: Re: AVIC related warning in enable_irq_window
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org
References: <9ce7bb5c4fb8bcc4ac21103f7534a6edfcbe195d.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <758b27a8-74c0-087d-d90b-d95faee2f561@redhat.com>
Date:   Sat, 2 May 2020 18:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9ce7bb5c4fb8bcc4ac21103f7534a6edfcbe195d.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/20 15:58, Maxim Levitsky wrote:
> The AVIC is disabled by svm_toggle_avic_for_irq_window, which calls
> kvm_request_apicv_update, which broadcasts the KVM_REQ_APICV_UPDATE vcpu request,
> however it doesn't broadcast it to CPU on which now we are running, which seems OK,
> because the code that handles that broadcast runs on each VCPU entry, thus
> when this CPU will enter guest mode it will notice and disable the AVIC.
> 
> However later in svm_enable_vintr, there is test 'WARN_ON(kvm_vcpu_apicv_active(&svm->vcpu));'
> which is still true on current CPU because of the above.

Good point!  We can just remove the WARN_ON I think.  Can you send a patch?

svm_set_vintr also has a rather silly

static void svm_set_vintr(struct vcpu_svm *svm)
{
       set_intercept(svm, INTERCEPT_VINTR);
       if (is_intercept(svm, INTERCEPT_VINTR))
               svm_enable_vintr(svm);
}

so I'm thinking of just inlining svm_enable_vintr and renaming
svm_{set,clear}_vintr to svm_{enable,disable}_vintr_window.  Would you
like to send two patches for this, the first to remove the WARN_ON and
the second to do the cleanup?

Thanks,

Paolo

> The code containing this warning was added in commit
> 
> 64b5bd27042639dfcc1534f01771b7b871a02ffe
> KVM: nSVM: ignore L1 interrupt window while running L2 with V_INTR_MASKING=1

