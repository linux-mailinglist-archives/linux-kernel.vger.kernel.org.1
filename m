Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DAE274358
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIVNja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:39:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22091 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbgIVNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600781968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOI1WpHi1dirYs0ZwrGaNH1l5VP48PNKICMJarwnWG8=;
        b=jMeW1lYM6fDWVElXkxXcFNRNf9BrpWCfPi0H4HdhyxLU5H430OQA6iZU1XRBW0lK2F+B9p
        BC2nMwwh0o8ZaBAQtEL2uSJtItf6ZBJSoTLhO/OS/zoAqWw0t+rXg/+WjOKo3Bcffe5jUY
        Q0ZtZfMZDBaWkz3/k+ldDi5JnZR7yYc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-yh7H-RFdOnC105-dgOyRiw-1; Tue, 22 Sep 2020 09:39:25 -0400
X-MC-Unique: yh7H-RFdOnC105-dgOyRiw-1
Received: by mail-wr1-f72.google.com with SMTP id d9so7426689wrv.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOI1WpHi1dirYs0ZwrGaNH1l5VP48PNKICMJarwnWG8=;
        b=qAPhXhJnUbKtjlVdfshfkxWMTA9WhyBd6f0D4UO1LQdGmee7f85PwSf80Uzyzf6xhc
         HQTxt3kEc35dtm39/C83ypnH2JrwyciHhOLwnPapJeZbkO/DEYAY1Uvh4ezGdSrWyKeM
         hHDNA8OS51dUN4aN98XegypquNaeu+rKEGx0ayXgUHv3ncqm0lBvf6wE5d2mpGrYD0+E
         gPJ8FojrImb5puMrRuMFT82XFm8fh6/8E/ZnYAsKMHq97aq+6XPWxyjB1c2FyaDKkhDj
         8SnzcQkr4MYsafjjiMq9hu5UuQPDf3DANh6Dy1FJL3tXQcwVKwePEMGnTzf4eydPD9NQ
         ybHA==
X-Gm-Message-State: AOAM533S83Mu0GFkZ25tCk5bSNZAMCmW8DhgPCgBlnAiZYyzXZGNWhHj
        5J/SYbtp9T8HIYoG40YsmNeZlVHe9OQzNoP2FtSMMYEY4aOWRrAMi1pLU3rfvstksJ2Q8slqw1h
        zQbIm+HGpffahXOwq8e2PgpLf
X-Received: by 2002:adf:f042:: with SMTP id t2mr5210214wro.385.1600781963808;
        Tue, 22 Sep 2020 06:39:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr0vCFA8qgUEqKKr5lLX6Qwfl1aK55d38FwPyZh9anbVWG3qPboRxwPNc0l5Hj4TOj9QOH1w==
X-Received: by 2002:adf:f042:: with SMTP id t2mr5210193wro.385.1600781963572;
        Tue, 22 Sep 2020 06:39:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id h1sm25477745wrx.33.2020.09.22.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:39:22 -0700 (PDT)
Subject: Re: [PATCH v6 04/12] KVM: SVM: Modify intercept_exceptions to generic
 intercepts
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>, vkuznets@redhat.com,
        jmattson@google.com, wanpengli@tencent.com, kvm@vger.kernel.org,
        joro@8bytes.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de
References: <159985237526.11252.1516487214307300610.stgit@bmoger-ubuntu>
 <159985250037.11252.1361972528657052410.stgit@bmoger-ubuntu>
 <1654dd89-2f15-62b6-d3a7-53f3ec422dd0@redhat.com>
 <20200914150627.GB6855@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e74fd79c-c3d0-5f9d-c01d-5d6f2c660927@redhat.com>
Date:   Tue, 22 Sep 2020 15:39:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914150627.GB6855@sjchrist-ice>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 17:06, Sean Christopherson wrote:
>> I think these should take a vector instead, and add 64 in the functions.
> 
> And "s/int bit/u32 vector" + BUILD_BUG_ON(vector > 32)?

Not sure if we can assume it to be constant, but WARN_ON_ONCE is good
enough as far as performance is concerned.  The same int->u32 +
WARN_ON_ONCE should be done in patch 1.

Thanks for the review!

Paolo

