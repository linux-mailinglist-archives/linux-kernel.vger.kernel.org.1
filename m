Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A0A27738F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIXOGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgIXOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600956398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WITCXHzAwksVt5Yjl1chINGWSfzTuBNvZDW5n9bgc5c=;
        b=Skrv+yZPW82Zveep9ux8HnGK7GUSpixnCoOR0ObFnaz4nKUB3GdnBOK7lxyOhpOeK7eEH7
        5TPUZRSTaT+4m0C4AqlzxH/NzHPLFSNMplyzYP9R+Zc6PGhNdc4cNjXH3KXq8mwDZ1Ccjk
        BXBB/ZfWPN8fjKT2h9vG0uR/CfjnfZw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-tnJbfysZME65YafQ83qRiQ-1; Thu, 24 Sep 2020 10:06:37 -0400
X-MC-Unique: tnJbfysZME65YafQ83qRiQ-1
Received: by mail-wm1-f70.google.com with SMTP id t8so905487wmj.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 07:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WITCXHzAwksVt5Yjl1chINGWSfzTuBNvZDW5n9bgc5c=;
        b=AwwKzAhhdZgMHrRs/SXPKdG/S9wZpSBR81RDOrx1yBrojHrRrQ4KU7Bi/r9N8Vxbk/
         RARCz4OXeK8oEYrcFB7kCLnlM2Iq0IdG4kIQXtqGJWJKujsdrWvkJ5j6bJ1Z7rWm+MYv
         kmFn36VYwebynqaT2DaM9j5aelvq/muWa9xTKf33FyVd+jDp19/vPqc/nr8pftLQF9ja
         HUPDffQPPgwL3zXSdat2BixHUzOFs2H0uVx/AfYJTcj+yUfYgFEf+eXdA7n07jjBGUIw
         Za714UwtEbbg9gG/4A2xsYOLo20TEndryrf4WM/jnezqR1TvQsSg1guNEasSpGPDyI/U
         7pRA==
X-Gm-Message-State: AOAM531u2Xn6g6s++vkJQ8r59TQcPRTX769ql+j2Q+p6VyE44BietVcO
        Ti0/ro6R8awIJG8mhwmdWQun/4KHdwAkRPjVGy7nMqBPt62Z4kErCp9OIZRzm3jiwp4ZVszwXoe
        n/SSicVnwQn/dwVq8qHpUfRcI
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr5248545wrp.161.1600956394237;
        Thu, 24 Sep 2020 07:06:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeFLtutxlfK0jUKd+nIPQGS+H9/NyYapLhwS0/o3lRPWfvF4hf0K/D4Lm+zt0QfImtD4gXLw==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr5248511wrp.161.1600956394020;
        Thu, 24 Sep 2020 07:06:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d80e:a78:c27b:93ed? ([2001:b07:6468:f312:d80e:a78:c27b:93ed])
        by smtp.gmail.com with ESMTPSA id a10sm3586835wmb.23.2020.09.24.07.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 07:06:32 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Add a dedicated INVD intercept routine
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <16f36f9a51608758211c54564cd17c8b909372f1.1600892859.git.thomas.lendacky@amd.com>
 <87zh5fcm4f.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26425c1b-a56d-bb52-109a-ab92eeb2c084@redhat.com>
Date:   Thu, 24 Sep 2020 16:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh5fcm4f.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/20 15:58, Vitaly Kuznetsov wrote:
> does it sill make sense to intercept INVD when we just skip it? Would it
> rather make sense to disable INVD intercept for SEV guests completely?

If we don't intercept the processor would really invalidate the cache,
that is certainly not what we want.

Paolo

