Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB352FF81F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAUWlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAUWk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:40:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B410C061756
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:40:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b8so2108720plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZM0IqfylJQO8fpBkI77F1H1VKg6hQFLtrN7oyrrKYhM=;
        b=brYcVyxMXMhRtAQg4ywy6K+79u14opqTKuDEHgYANxh/TTAWAlvwzSflTL6QXquP2c
         kTFcYFzLXkLTfin10lkDaT9NffnfcYLGHTpEXSbdbhh9821bdTyp/tJzJv3+JUbWQtiC
         nVXFvytHBFqfc6DcJ6SW2Z0b9vBYlthVLo2NKlwhKVYkes1NOeBuDpFkugJ5NtjtTpFp
         eT6AST3K8DdHsOjvNA/1wnsf0cPbMVkM35Xp92N3jvFzRGxf4212xhmYPrI4qg1q1Mc+
         xaaekxOIrbLNXUiYgvc8I5EXWEDCJTZO3vcvVz3obKst+dCxoaRLQltTKJ+3pHxTXI53
         uJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZM0IqfylJQO8fpBkI77F1H1VKg6hQFLtrN7oyrrKYhM=;
        b=EYg+oCnAzj3dfODnO2b1EE7T5uqLiricGN+I3iJZWk/ilv8z5htpkAZjH1Zn/I9PeS
         1qLra7+Nw5UyOgxOxujHwbIf6BZKXybhF1I/D2AQurL3FDHmYGd1JP/1C/JaA4anDml3
         JZLcYInn0tckWYBE8/RBv2rIvBheAs7F8LueJdiS/4dNhLGm7KYLawFG4Ldv8867XnyR
         gpUOeG63hGoQDWWe0dV8NFCyaD30f1vvUbCExPL/zHeIlRhVNTL8Av+86On0CwcsgXvl
         /XZ1mxf/lIjN0GH44lCXJB5vfIP5fmGMmvNDaAW2dmUmeqAsLf5aLbPcMcA1uxRddc1R
         QjEQ==
X-Gm-Message-State: AOAM5307XN4kD6Km9xbnyJRPzGiM1oFa6DjUzixj4rz3JVGKTVkPFcjr
        uUSyBgOaGjxcEfsrtNFZz5CqrA==
X-Google-Smtp-Source: ABdhPJydkXtTMozhDBPCHpRtvPfWauKZlpKXCN2rkk13/rERJFSNQ7GCWR+2mOdv4w4m/QVIM9UJww==
X-Received: by 2002:a17:90b:11cb:: with SMTP id gv11mr1898532pjb.4.1611268818901;
        Thu, 21 Jan 2021 14:40:18 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id k9sm6858083pjj.8.2021.01.21.14.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:40:18 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:40:11 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Wei Huang <whuang2@amd.com>, Wei Huang <wei.huang2@amd.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
Subject: Re: [PATCH v2 2/4] KVM: SVM: Add emulation support for #GP triggered
 by SVM instructions
Message-ID: <YAoCy5C0Zj97iSjN@google.com>
References: <20210121065508.1169585-1-wei.huang2@amd.com>
 <20210121065508.1169585-3-wei.huang2@amd.com>
 <cc55536e913e79d7ca99cbeb853586ca5187c5a9.camel@redhat.com>
 <c77f4f42-657a-6643-8432-a07ccf3b221e@amd.com>
 <cd4e3b9a5d5e4b47fa78bfb0ce447e856b18f8c8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd4e3b9a5d5e4b47fa78bfb0ce447e856b18f8c8.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021, Maxim Levitsky wrote:
> BTW, on unrelated note, currently the smap test is broken in kvm-unit tests.
> I bisected it to commit 322cdd6405250a2a3e48db199f97a45ef519e226
> 
> It seems that the following hack (I have no idea why it works,
> since I haven't dug deep into the area 'fixes', the smap test for me)
> 
> -#define USER_BASE      (1 << 24)
> +#define USER_BASE      (1 << 25)

https://lkml.kernel.org/r/20210121111808.619347-2-imbrenda@linux.ibm.com
