Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23370292CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgJSRfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgJSRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603128953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/RufWKnLZUskTlxf1MZpvMgrqUwpnS/7Ou19TQ6qNrc=;
        b=Cm+rYkH0hcRUzMrzyl+1sKfhFmvhOAZM1KF6DXXXeFsnhqlgj1rnGHkVLFfhwczWbw/FsF
        pNOBSKbaqSAxD2T3e+zckQMT7Iss+79H4mbgYtReGyEVP+nwxJwSd0X+c7xbuCbOF6L3hd
        LZgSM6UzRT8QbudsvtncognpO/Ydu+s=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-vaFIPHY_P4iPFjK83gmjXg-1; Mon, 19 Oct 2020 13:35:50 -0400
X-MC-Unique: vaFIPHY_P4iPFjK83gmjXg-1
Received: by mail-il1-f199.google.com with SMTP id p17so688337ilb.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RufWKnLZUskTlxf1MZpvMgrqUwpnS/7Ou19TQ6qNrc=;
        b=LOrK8VXVBwfjVHIEnSaC6jvuvxmbGbJRl1n7C7WKq/Y8yoU4OANrK8j3jJHYZ6iXsK
         ZhJbe8x2V6Bk4Y96FkpW86DBcEQvOJxLqSLnqxkc8EDNXsn3/Nb9/zs9jUUmQSxZE02Q
         /Jh+3CIM9qwUed1q3lw6x1lg8DFjfB9BGrDWiI6EsmjnpnweTlrqPRjrz19+6aEUmx9X
         WMLqUMymKEYRArIaR6SWSHTHgLw9Anjd+t2mK+sZfYHrFYA6AYRC1Q2Cp8/7n98faebQ
         nB8Wkf4CF3eZ8D25JjBlhsc6w53HRR7E8xiP9GtF1XxOu2pTN4TknYcA9zz9zy+dOEqx
         MHjA==
X-Gm-Message-State: AOAM53149wvJeoWDDe6ZeRoOkSLCXQ8hnfNSAD/ssalczD/BR4OeHURr
        X+ZEYQR2WEv0hjRQ0gbDSajHe5G9MHxl03RNHFD/1lLn6j++Cxtttr3iiP761frhQ8A/Plplrgz
        s8YhrbCQV5VsmwjLelQfBMz2X
X-Received: by 2002:a6b:cd83:: with SMTP id d125mr449086iog.174.1603128950133;
        Mon, 19 Oct 2020 10:35:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+bURNpXTe1n9PgAEbCYBrgDNhf0ddoGYqPH6Xk8CtU5WYkmvye0WwXAuZZUa7bdlmNtav0g==
X-Received: by 2002:a6b:cd83:: with SMTP id d125mr449059iog.174.1603128949880;
        Mon, 19 Oct 2020 10:35:49 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id g185sm367924ilh.35.2020.10.19.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:35:49 -0700 (PDT)
Date:   Mon, 19 Oct 2020 13:35:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Alexander Graf <graf@amazon.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH] KVM: VMX: Forbid userspace MSR filters for x2APIC
Message-ID: <20201019173547.GB3203@xz-x1>
References: <20201019170519.1855564-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019170519.1855564-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 01:05:19PM -0400, Paolo Bonzini wrote:
> Allowing userspace to intercept reads to x2APIC MSRs when APICV is
> fully enabled for the guest simply can't work.   But more in general,
> if the LAPIC is in-kernel, allowing accessed by userspace would be very
> confusing.  If userspace wants to intercept x2APIC MSRs, then it should
> first disable in-kernel APIC.
> 
> We could in principle allow userspace to intercept reads and writes to TPR,
> and writes to EOI and SELF_IPI, but while that could be made it work, it
> would still be silly.
> 
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Aaron Lewis <aaronlewis@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

