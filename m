Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E112ED620
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbhAGRz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728262AbhAGRz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610042041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6GQmzJAdTbPNgN/TmIYptrmtmdvKcTL/LS3Q66JubM=;
        b=dt07wlikwzGF23HlS6detPW3oGBilTfrsWUKFt08IR9TMbWtJ82aCPdAn14mmtEChveZDr
        1dkcwNUXDFe4rWYjyiHPk2/pw7YAzyLKesj/LTkSC6XPDN3oJy/YLK7jnw8PM0YpgKZe3v
        fxLukp52mfQX+vJPqCEYcNc2BXcyAqQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-1vzQfuCkN0aPvtCDF-5Y7A-1; Thu, 07 Jan 2021 12:54:00 -0500
X-MC-Unique: 1vzQfuCkN0aPvtCDF-5Y7A-1
Received: by mail-ed1-f69.google.com with SMTP id u17so3613050edi.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6GQmzJAdTbPNgN/TmIYptrmtmdvKcTL/LS3Q66JubM=;
        b=FYYgRRK3PPIubvOWePiBtJ6EgmGdRxnhyMOBDTTHyVKiMiPPjpC9V0v+U9M9+RaFbU
         v72pr77oGMGfj4A4qkAy2Pp0+M1ns5FH51khaDlpJqTnKTaca9FVrsFGSP3NhXMTbjgB
         mIQ9QONaHVgH2KxqeH57pxbklSGokD6lc24v1cvU2lGLYkIzWO9hGLoOco4xBvRJ+XY3
         vGkqJNsLYHFN1QOIFWVNB6iKiIbB+elrMZyX0O00Wu+dh/ZDMBjd+bsxR+QGBpYkWlMW
         mGWjXNisU8NLl6UT4eU2wK81JAUkw1KFBkBurXY6xxpZEtAjP6KhEJ5Tg8ryxvpabZ1Z
         MZNg==
X-Gm-Message-State: AOAM5313GvufA/+H0YNsbZxr89NujWIXPoblAS/7LguDxM6/k/L8okjM
        cMLuqEsLi/V/nrbKL+t6NTUMdWsgM6pIW+oYSqUDBel2ZJlutXdHXlhAKoSL+94O2Kpg2cCt0b4
        +BZLLPCUtTx3EhqEfoMua7Fq1
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr3052499ejc.529.1610042039043;
        Thu, 07 Jan 2021 09:53:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUmwEXqBL7daFEotytllonxdak4JkeaZiDz9BhtX0hPPREL2/RRc65HY2CrqgZeN6FTCLGzw==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr3052492ejc.529.1610042038914;
        Thu, 07 Jan 2021 09:53:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id dd18sm2694365ejb.53.2021.01.07.09.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:53:58 -0800 (PST)
Subject: Re: [PATCH v3 1/2] KVM: x86/mmu: Ensure TDP MMU roots are freed after
 yield
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Peter Shier <pshier@google.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Leo Hou <leohou1402@gmail.com>
References: <20210107001935.3732070-1-bgardon@google.com>
 <X/dHpSoi5AkPIrfc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a1a9346c-e403-618a-91e8-02ce4b7105c8@redhat.com>
Date:   Thu, 7 Jan 2021 18:53:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X/dHpSoi5AkPIrfc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/21 18:40, Sean Christopherson wrote:
> /*
>   * The yield_safe() variant of the TDP root iterator gets and puts references to
>   * the roots it iterates over.  This makes it safe to release the MMU lock and
>   * yield within the loop, but the caller MUST NOT exit the loop early.
>   */
> 

Nicer, thanks!

Paolo

