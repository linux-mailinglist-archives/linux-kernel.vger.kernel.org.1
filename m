Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712BC2E6C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgL1Xzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgL1Xzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:55:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B960C061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:54:50 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 11so7103135pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDv04UcJXsRXAAb0BfpkpsXloYCUI9DJy9xrXGs5QQM=;
        b=rgFY1m+/I9TgOjygQc4ha2TMqD/pP3XpA3G7ozM621zTgnuLzPcCiYZ/9OMACx1lyW
         UveinnYhBpRFTA/9pAQ7d40htGoeRfR0DvekxWlkgGnwd/Vh/OM2PpN1205f2ImGQMEI
         02SUMQwXTxyUi2rcBY/UpvZ6Xjvl2qsmfcEcrjTYI7hVGuhEL36lx7aAKWefN9wGB8gK
         hA6ZHLwwumoWiQbQ9lEIw3WFyRVcix2XwO5z0j32cdZS++6cP8e+o9LzjhsACFLYnUig
         G+HTKme4yTAzAGyjLlvahv9zqJjhX8ocEx9nr6TuFppLG2NDoT/bK2Sc0a+zUFcqoFxe
         5u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDv04UcJXsRXAAb0BfpkpsXloYCUI9DJy9xrXGs5QQM=;
        b=f+PEfg6dwtgfN9gJm9byKI6ITug/Lp4TepyF7cq6BO/7txa8zlLSySkNsRfMC+TyYK
         ZE3DbAq3vLK9yfd0f3Bt98eOY7yAw0zfM1OyQsCFizRw/aO6Ax7OdU2XopmZXiZ1JO3n
         JtWWsF+jatK52aH+xDqA7uUwbdI6ew9o2iFIDwXuw6V2PviqAAqk8IDuaSobfAAPeZw9
         pgZcIoSe4VjFslMfswtox9TARqh6jqkV/TupDE9/nvucaW8RTNu2/pgB6xH32bkxZ1FF
         qdXQqaN/m53TO6V8jp5FCJrOjWzbtLO6u1LY9iUqZy574Li95bUk1RqTZXcqF/eviLyo
         Oo8Q==
X-Gm-Message-State: AOAM530nSBCuAVig41ejHfvBUlXQqFkWCSwfQPabnlraHliWDi6l3TS3
        +81Zn2bHsUkANGS7t5boaYS/nw==
X-Google-Smtp-Source: ABdhPJyyRAr3zrs08czIJ+HKYlNPj0xru7yWQ0bN5m9zJOEMLLWNvO9ObZi71MHus+HLcxOFzA+7qg==
X-Received: by 2002:aa7:8297:0:b029:1a9:9d0a:c407 with SMTP id s23-20020aa782970000b02901a99d0ac407mr42397687pfm.76.1609199689678;
        Mon, 28 Dec 2020 15:54:49 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id q23sm38439853pfg.18.2020.12.28.15.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 15:54:49 -0800 (PST)
Date:   Mon, 28 Dec 2020 15:54:42 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Subject: Re: [PATCH v3] KVM/x86: Move definition of __ex to x86.h
Message-ID: <X+pwQrLgVcMg0x3M@google.com>
References: <20201221194800.46962-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221194800.46962-1-ubizjak@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020, Uros Bizjak wrote:
> Merge __kvm_handle_fault_on_reboot with its sole user
> and move the definition of __ex to a common include to be
> shared between VMX and SVM.
> 
> v2: Rebase to the latest kvm/queue.
> 
> v3: Incorporate changes from review comments.

The v2, v3, ... vN patch history should go below the '---' so that it doesn't
need to be manually stripped when applying.

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> ---

vN stuff down here

>  arch/x86/include/asm/kvm_host.h | 25 -------------------------
>  arch/x86/kvm/svm/sev.c          |  2 --
>  arch/x86/kvm/svm/svm.c          |  2 --
>  arch/x86/kvm/vmx/vmx.c          |  4 +---
>  arch/x86/kvm/vmx/vmx_ops.h      |  4 +---
>  arch/x86/kvm/x86.h              | 24 ++++++++++++++++++++++++
>  6 files changed, 26 insertions(+), 35 deletions(-)

Reviewed-by: Sean Christopherson <seanjc@google.com>
