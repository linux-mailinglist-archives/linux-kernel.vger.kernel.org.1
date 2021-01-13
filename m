Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3962C2F50F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbhAMRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbhAMRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:18:10 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DB2C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:17:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so1905099pgj.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3STmS+zatbijavWt2TOuzoxTb1FHjkZNwlSMF11jw0=;
        b=qGncu76OHOBf70DtOp94s5WPBtUSZQAg9+TESOqjGujjFleamyY7hjpE4ZxMc8dpmu
         qPPOlr9HEDxXMAWavY5ppT70MRbTVUHv/Te2aS1zBCqVHsQ/GD5hrLLnYv2vNbYKvwPN
         aDIBZNwv9K8iHbf456M0lrc7C6vMHpjaBY80TSBYK97jXyuZ5cdgo+zBbPRIhgywlF69
         bbLfS2CLHSJU6ujTMmp7A/L9uiEQmkqyq7tS64XVX5olYQUoQfafMMWdSgtyxw5QPx6q
         slrDtXpbIOOIltYbkZC/TyVX8TNeC9YDg0A1574F1afRqi7BCmdWQh1ijQg/aeV7dXoU
         Byug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3STmS+zatbijavWt2TOuzoxTb1FHjkZNwlSMF11jw0=;
        b=pyaVsDpKVXnnp277vaOh76qwx5B+jU5V/5dHFNOOY5sZiCJ5ZksQu0hzytmQhrkNpJ
         pv8zWXl83DsdZeQj/H3Eb1NCLO7KS1ape/b1PySANCD0DaUdaDWA4mSKWeSaSeSfJ3ML
         dOlic22TrbVUL8PL2lsGNsoIcNklMEnpsFxp5xD9R8vUcHFyJR5s1oFPL2UvjmNreFom
         MuOh5L+XARhW4Vad8B9PfL/pjStUS7J4l36pHMHhcQJGEkot/72wJdTu1O4eSAi94uV6
         IIQ2G2R1k/a5pVSIlD6zDCivzNaj5sL6DIsIO9Z1dD5LLyaRuJVADr9SSWTDY4ziCxlS
         yogg==
X-Gm-Message-State: AOAM531VidZ7eMt3Y0ne5vBV+7djpwZs35S0eOY9TN2UZPqdPnoc8rLI
        A3zXQowYMnw/X2Veo4Bjk9PT8A==
X-Google-Smtp-Source: ABdhPJzQAr5AwCj9j/9lCm0gPeLTxznNLGrNOq388mriy/cQdG48dqpJ/7jgEBs02tqYbK/EN/1gow==
X-Received: by 2002:a63:e151:: with SMTP id h17mr2963978pgk.120.1610558249502;
        Wed, 13 Jan 2021 09:17:29 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id d20sm40837423pjz.3.2021.01.13.09.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:17:28 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:17:22 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        peterz@infradead.org, aarcange@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: introduce definitions to support static
 calls for kvm_x86_ops
Message-ID: <X/8rIgrMkb61/la9@google.com>
References: <cover.1610379877.git.jbaron@akamai.com>
 <ce483ce4a1920a3c1c4e5deea11648d75f2a7b80.1610379877.git.jbaron@akamai.com>
 <ee071807-5ce5-60c1-c5df-b0b3e068b2ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee071807-5ce5-60c1-c5df-b0b3e068b2ba@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021, Paolo Bonzini wrote:
> If you need to choose between DECLARE_STATIC_CALL_NULL and
> DECLARE_STATIC_CALL, you can have kvm-x86-ops.h use one of two macros
> KVM_X86_OP_NULL and KVM_X86_OP.
> 
> #define KVM_X86_OP(func) \
> 	DECLARE_STATIC_CALL(kvm_x86_##func,	\
> 			    *(((struct kvm_x86_ops *)0)->func));
> 
> #define KVM_X86_OP_NULL(func) \
> 	DECLARE_STATIC_CALL_NULL(kvm_x86_##func,	\

Gah, DECLARE_STATIC_CALL_NULL doesn't exist, though it's referenced in a comment.
I assume these should be s/DECLARE/DEFINE?  I haven't fully grokked the static
call code yet...

> 			    *(((struct kvm_x86_ops *)0)->func));
> 
> #include <asm/kvm-x86-ops.h>
> 
> ...
> 
> #define KVM_X86_OP(func) \
>   static_call_update(kvm_x86_##func, kvm_x86_ops.func)
> #define KVM_X86_OP_NULL(func) \
>   static_call_update(kvm_x86_##func, kvm_x86_ops.func)
> #include <asm/kvm-x86-ops.h>
> 
> In that case vmx.c and svm.c could define KVM_X86_OP_NULL to an empty string
> and list the optional callbacks manually.
> 
> Paolo
> 
