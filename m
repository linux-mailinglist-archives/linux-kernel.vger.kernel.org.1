Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950392795D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgIZBJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51633 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIZBJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:09:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601082560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhIG5lIeSniauUXqSeFzOVd/HOplR5lP9oJTjmYBwr4=;
        b=bjCkUS6uzeBjJO6K608YdfNwzZQdkYZNySCfjVieEYnJazlXsqWnL2z7W/luUeT3Qp+bMC
        +FK+Jkx73vLFhDwBDzo1c/Ti4CQk4AXtXMZYMglrXdfbjgUVPjjugEthrmCCiDrSXhIEjJ
        slhrYnH0+9NLkCuugk70leP4u+VpKpk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-LDnZj4BXMJGA5FfbetSJ0Q-1; Fri, 25 Sep 2020 21:09:19 -0400
X-MC-Unique: LDnZj4BXMJGA5FfbetSJ0Q-1
Received: by mail-wm1-f69.google.com with SMTP id b20so272939wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhIG5lIeSniauUXqSeFzOVd/HOplR5lP9oJTjmYBwr4=;
        b=N9BaK/iPR0zbBz4v2eOlFa2/rQRlpob8gTzutSlxZzaWF6u0uh8Dh4EXQj/UCigOIc
         +AFcNdu63xaXZylESXu4IIdFSo8LmlF8SBkoooncc80pjyQBhiLDIu2vmSzd9nLsoQd9
         /LGnhr8rU6CsLfG4CGftvhdUOLnnXqENKgKGhLNEPXriUAFVV54KdsJDluhnHjUKA0ti
         nM60DSqEZIp9UEemX/7yZR7yaxjoZAeLaHw35tIK9DK/Drs1HovW4eo6a9MwsFrifuFo
         DSZi+Mj2N0/+UntE+x7E1lI7VkNyfLhBLsCjk+wBgPyVHsiQAHUZrVJsLhxcnZKmzOiM
         77dQ==
X-Gm-Message-State: AOAM531Wk6zeOZQrTaRX9HkyNXyKYHYA5voBIYjKdbfiiJS/Z3djxE9r
        PRAPJbolkzhHzOCo1+qYNClA/I8YMwQFlrarsyqA8RgM+2F31oKwmynDEsbkI+8VStAcxlwh+f2
        bczSnOL3tk5j/NAhvXA3eRtE8
X-Received: by 2002:a1c:31c6:: with SMTP id x189mr247361wmx.83.1601082557852;
        Fri, 25 Sep 2020 18:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzLUyQP75wWdVj638jZZOHVrM+HQw/Dru+TIGIm46WWePJ54+CuKgTNe0RK+yLBktmQDLL8Q==
X-Received: by 2002:a1c:31c6:: with SMTP id x189mr247346wmx.83.1601082557623;
        Fri, 25 Sep 2020 18:09:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id n14sm732281wmi.33.2020.09.25.18.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 18:09:17 -0700 (PDT)
Subject: Re: [PATCH 18/22] kvm: mmu: Support disabling dirty logging for the
 tdp MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-19-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44822999-f5dc-6116-db12-a41f5bd80dd8@redhat.com>
Date:   Sat, 26 Sep 2020 03:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-19-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> +	for_each_tdp_pte_root(iter, root, start, end) {
> +		if (!is_shadow_present_pte(iter.old_spte) ||
> +		    is_last_spte(iter.old_spte, iter.level))
> +			continue;
> +

I'm starting to wonder if another iterator like
for_each_tdp_leaf_pte_root would be clearer, since this idiom repeats
itself quite often.  The tdp_iter_next_leaf function would be easily
implemented as

	while (likely(iter->valid) &&
	       (!is_shadow_present_pte(iter.old_spte) ||
		is_last_spte(iter.old_spte, iter.level))
		tdp_iter_next(iter);

Paolo

