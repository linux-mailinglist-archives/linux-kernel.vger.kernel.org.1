Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE127959A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgIZAdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729792AbgIZAdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:33:10 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601080389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2svHRBQva/Nus5XSRtpGhL7T7fUDe0VOrf/F1WA0Tc=;
        b=WvHRZFzXxOtcyQl5iQyAufjbZYTXFZQTnGYSYn0Baw+dUFd67MG+F85ycQf1BEFUV2CyOA
        l6zUewQikZthrEQ64HxUMxI/1J0bQv7PzAV1cp+6wfvWs7SAYeKY286QzxDT7EA2Q9QcDH
        R+ZN9Z4vat9yH2aAIvXBlvGiElYTpms=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-So20wip7PO6xFv5NA2uDfg-1; Fri, 25 Sep 2020 20:33:07 -0400
X-MC-Unique: So20wip7PO6xFv5NA2uDfg-1
Received: by mail-wr1-f72.google.com with SMTP id j7so1733627wro.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2svHRBQva/Nus5XSRtpGhL7T7fUDe0VOrf/F1WA0Tc=;
        b=adyPujb1DMzt7xvfv64cBx3d6YFcaaO6V2UZMKnQH4Y5BGl84fLugMG6QJDbzXZx1H
         M7p1ehr+4wEQwHnC7dqbj2ZgkqwJoExjGUiwgWtgrmCWH49OI3gnXjGdJCUVCPKheKYn
         pITHH4KaXuIFPgDcoy0rezH+F7bk5ERb2RETrJmW1MdD1iuM5ZHxq8guZ3zYgITPesmE
         9Yu0E+cKCAGIFJCD64p6+N9fEVS2WGi0Qz9sG5YZ56/0H9W5YZZbVOIwy9PSOshbkXYN
         a5as0dxPWRuCFRiuOsNCmFXYHcJs6WDAWJf1PO4kcmeenMEz/oyNCPT8jKdI3F0Ta1H8
         2hCg==
X-Gm-Message-State: AOAM530HRiGVD+pDTkCyjlr2+EbneKBpl8uDqPl0csAv9hW1XHsTIc8j
        tz/SHB2ilfp3cv3ZMV74n3dhmnBw3035ksyd0QHkJAj3iSTThmW3CPE9mTzIplLa5x8BmDXVNH2
        UXt3KDVZYtbnCxrKyaYrU5LLR
X-Received: by 2002:adf:e407:: with SMTP id g7mr6953553wrm.349.1601080386249;
        Fri, 25 Sep 2020 17:33:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOErB8p/7YPgr4TtDRkw7ALR4XUUJKDTDtDNpkAbJTRk2g4+X6ESLcxvEwumiVX0L1vmkkDg==
X-Received: by 2002:adf:e407:: with SMTP id g7mr6953541wrm.349.1601080386081;
        Fri, 25 Sep 2020 17:33:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id h17sm4946584wro.27.2020.09.25.17.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:33:05 -0700 (PDT)
Subject: Re: [PATCH 15/22] kvm: mmu: Support changed pte notifier in tdp MMU
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
 <20200925212302.3979661-16-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc3a8cb7-ea8d-9c4d-6341-95522b184a16@redhat.com>
Date:   Sat, 26 Sep 2020 02:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-16-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> @@ -1708,6 +1695,21 @@ static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
>  	return kvm_zap_rmapp(kvm, rmap_head);
>  }
>  
> +u64 kvm_mmu_changed_pte_notifier_make_spte(u64 old_spte, kvm_pfn_t new_pfn)
> +{
> +	u64 new_spte;
> +
> +	new_spte = old_spte & ~PT64_BASE_ADDR_MASK;
> +	new_spte |= (u64)new_pfn << PAGE_SHIFT;
> +
> +	new_spte &= ~PT_WRITABLE_MASK;
> +	new_spte &= ~SPTE_HOST_WRITEABLE;
> +
> +	new_spte = mark_spte_for_access_track(new_spte);
> +
> +	return new_spte;
> +}
> +

And another. :)

