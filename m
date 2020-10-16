Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4125229098C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410745AbgJPQSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410727AbgJPQSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602865125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eD8jVuSLB7bhS1tzZOiVsps5uH3EKR905X+lDjVw/1E=;
        b=Fpg+xh/bADci/JlEqVAd/SlHQ9f+Wx08L5DPeupm8eT3qX+aObHzsKsPIds9QdyEM8u9j3
        rGyKZrqTtAv/w8vQU3U2mgzCCF8zC1V4wVRH7VApZQUAzjgLePrEu+0ttre8eHQKa9anxM
        uPbOqdKukCug1adDYDv9t0TRZHKO+SI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-PXrggrblPguhFIQjf0iGKQ-1; Fri, 16 Oct 2020 12:18:43 -0400
X-MC-Unique: PXrggrblPguhFIQjf0iGKQ-1
Received: by mail-wr1-f72.google.com with SMTP id 31so1699439wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 09:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eD8jVuSLB7bhS1tzZOiVsps5uH3EKR905X+lDjVw/1E=;
        b=qYmZz0ZHAyl6S6/2G8fh1uhMdVYZNQute2uxUD1Vt7ohgwYIo531hqUT1hG61mJsSG
         sbZ//taww2raglOUks5jnrLiIkIvE5QjJzY8yRuMQzO/KSzaomBHmC4XAUXGGBxSePDV
         DcE2g/r7oBj5mOhzvGWaxH9gyYjNOwJrYtZrsETDHQ7GQf6vW1ebW6unIr1FWimLmawB
         Ngnllm68NS/NDt/VVuOXtIDZUwVPrcNoz9nXKC24kM9l6kWEpgsaf77JFhR/SY0eFlv+
         Q+76mk9EFmdEGIYbC9txnywyTsmShObSNT96NuYvgOWtWlX/yNBpH9xAmOepCD9Iz20g
         imXQ==
X-Gm-Message-State: AOAM530fDoPWw6d48D7GVrlaq41E2huslv1wIALeevgUmrtbyDCZ6j+R
        PNg/ewTUMJORTGaiEmPSWLoxbo99I8Lcjz06RJRyY5oVYRfa5habTpJnf6iTI2kqVJoeiIgBJ9b
        G/EN+hHwu/1IFd0zqLTcrFvF+
X-Received: by 2002:a5d:468f:: with SMTP id u15mr4893721wrq.154.1602865122090;
        Fri, 16 Oct 2020 09:18:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNE1a3lrNF/pwxGalrsxHiv258wT6XJyjXt4igENgxUD08IKd03Tf7FldvIb1/Ed3K1y5Qrw==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr4893690wrq.154.1602865121811;
        Fri, 16 Oct 2020 09:18:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3? ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
        by smtp.gmail.com with ESMTPSA id l26sm3250779wmi.39.2020.10.16.09.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 09:18:41 -0700 (PDT)
Subject: Re: [PATCH v2 17/20] kvm: x86/mmu: Support write protection for
 nesting in tdp MMU
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
 <20201014182700.2888246-18-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5b511f2-1224-c4b3-539a-0c34dca34c51@redhat.com>
Date:   Fri, 16 Oct 2020 18:18:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014182700.2888246-18-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/20 20:26, Ben Gardon wrote:
> +		spte_set = write_protect_gfn(kvm, root, gfn) || spte_set;

Remaining instance of ||.

