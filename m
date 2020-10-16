Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97A7290802
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409819AbgJPPNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2409810AbgJPPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602861184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXuQ2J5tyK0euDvqdN4vvQ3etzq51rcwkx2yRUeKdfE=;
        b=Yw/Dk1wl8tqb38UmdzADbELqP78xNqsuZD189hGLumBq1w5sTWFDy0EqtanTF7I2unLjsy
        AArm+zTKSd+t1lfBO0v2IhZ7O67t5/03NA0PIv7cOo2CgQyYEzTAZu7RmG1CCi0ObhC3id
        ogrRjSD0K3Hvuo6BYwLWtdzTYV8ltp0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-HIlKdawJO7iCNG9ewcABMQ-1; Fri, 16 Oct 2020 11:13:02 -0400
X-MC-Unique: HIlKdawJO7iCNG9ewcABMQ-1
Received: by mail-wr1-f72.google.com with SMTP id n14so1629468wrp.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 08:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XXuQ2J5tyK0euDvqdN4vvQ3etzq51rcwkx2yRUeKdfE=;
        b=ZZvj1+O9iPR0TwhYqUWdXztHi65bpptOzK6C+6ismRRopJAEhNFTS6RJ92c5zRbb5P
         IDG/34TvXyfxpDgDOsn63IRNMo5TRVEQOd7Ri2MVSMjYDvdqCmfS3NFGXzjFzGUjAJCo
         bS2cxa3FuC30QTclSMGo2Wq/fS7K9dgAHfIjQm/eGh/EO5/2pVSCQFSuhTugSVAQovbC
         efMmA7TtieOPrBAnMvCM2WmfGtRUt6ix+o08Io9Cxqs0cAL8p5Q4tr+4UwWxG/6jgR+m
         lE/nQDwYHcm9S+8khr6qcg/CXcbY6F3Hl5xsb05nmShV0I/UbEehjfitg1duX/VtWUwC
         6ZWg==
X-Gm-Message-State: AOAM532yW+1jm9NFe/4m5UN7RE261bxJyl5oVs1TTEVGZJBfxOlBnlH3
        wjNuGJgyniOtxtFQwOvhG7wLG072WCaOy0LPBlShe17DfIlbyKpMxPRkJ6tl61doFGHGegiGjgp
        0xzaG/bb9By94ll/SDrcNESMT
X-Received: by 2002:adf:ed49:: with SMTP id u9mr4323868wro.88.1602861181081;
        Fri, 16 Oct 2020 08:13:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySiuEdF8Qgm9VbY+OyiIzzdTIfV0LWVLIJOarxUrK2xeA3m2l9uScuqOFd58pz1L8EVtBfpA==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr4323838wro.88.1602861180879;
        Fri, 16 Oct 2020 08:13:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3? ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
        by smtp.gmail.com with ESMTPSA id t12sm3971534wrm.25.2020.10.16.08.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 08:12:59 -0700 (PDT)
Subject: Re: [PATCH v2 10/20] kvm: x86/mmu: Add TDP MMU PF handler
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
References: <20201014182700.2888246-1-bgardon@google.com>
 <20201014182700.2888246-11-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d74ab511-586b-4704-dbb1-811343a05092@redhat.com>
Date:   Fri, 16 Oct 2020 17:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014182700.2888246-11-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/20 20:26, Ben Gardon wrote:
> +	if (is_tdp_mmu_root(vcpu->kvm, vcpu->arch.mmu->root_hpa))
> +		r = kvm_tdp_mmu_map(vcpu, gpa, error_code, map_writable,
> +				    max_level, pfn, prefault, is_tdp);
> +	else
> +		r = __direct_map(vcpu, gpa, error_code, map_writable, max_level,
> +				 pfn, prefault, is_tdp);

I like the rename, but I guess is_tdp is clearly enough superfluous.

Paolo

