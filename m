Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D1292A15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgJSPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729717AbgJSPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603120318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXlleUnBQnXgRgurIE/X/dP18+C+fiLS1/SOsHDJ8GA=;
        b=H4eC25y9E9I7dFEakKen3kpM6c9iNqV1bvNDoawcUEBOiFHdV4NkgXhanYuWkyrHEJYglX
        UvWl54JE6SwHMKSMEQBqJy5nDF+EgX6FIVwKpz2EzwCOyWGfh2KPBw4keEecVwPQgoLcu5
        gFKNw2AJmx+K6uL1RoHMUS2v48KOfsY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-ChDhxqS1O2OSRYGCDbJ0zw-1; Mon, 19 Oct 2020 11:11:56 -0400
X-MC-Unique: ChDhxqS1O2OSRYGCDbJ0zw-1
Received: by mail-wr1-f72.google.com with SMTP id 2so7551873wrd.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aXlleUnBQnXgRgurIE/X/dP18+C+fiLS1/SOsHDJ8GA=;
        b=fk8vA5P8Ngnum7d9uquPqKTpxjiporJlbPBLaJL0OGeiWEs2+XL+NGFee25rD8Njvl
         nlAFs/c3f++eRXpYJlmTNlLid7ecAUrXnlhUT0rfnkrJ/gadthZ/k9aP6wSsVEm+TFkH
         PIzSDJtX31q8ZykmrPtOt5g0H9EnypE1Yqp4zy71/tl0rRa5xBOWPLV0ZzLTcGMyaWvF
         sNM9FxkcT1yn+pc3HwzCFlawPEfTrq5FLp+CVwUyIHwF7g7oXW8WsAG/ek2TSbytC6v0
         gPxnRlsqtSx9w8U2GP4iYHFwn0KCUKMWznMR5yS+CgX8nnJZVf5+jmq9XVrjIBcORbHw
         kbqA==
X-Gm-Message-State: AOAM531nfM5BpAIOSy7SExy8mV3en5rfbgyitLWniZs+EQkXWMwnNvsG
        AK2iiYAiOBQvULWNADe0QaUMRjRW6cZ8P33Yo2fV+jpNCmjhecmJHD6Afe6ILS/zKXR95zOnJWX
        g1EUhljBcNFs/Y1eLUE0vkjry
X-Received: by 2002:a5d:4648:: with SMTP id j8mr1356810wrs.131.1603120315531;
        Mon, 19 Oct 2020 08:11:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFIREbO6DezALO0JWKlg4qRoGscw71tin3lv0IQ+vqnXpANv4T2rRXqGWJt7uALR0ANL13wg==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr1356789wrs.131.1603120315320;
        Mon, 19 Oct 2020 08:11:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g4sm374295wmh.13.2020.10.19.08.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 08:11:54 -0700 (PDT)
Subject: Re: [PATCH] Documentation: kvm: fix a typo
To:     Li Qiang <liq3ea@163.com>, corbet@lwn.net, lnowakow@eng.ucsd.edu,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liq3ea@gmail.com
References: <20201001095333.7611-1-liq3ea@163.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4339c95-8190-f477-381d-0617c74f9e9b@redhat.com>
Date:   Mon, 19 Oct 2020 17:11:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001095333.7611-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/20 11:53, Li Qiang wrote:
> Fixes: e287d6de62f74 ("Documentation: kvm: Convert cpuid.txt to .rst")
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  Documentation/virt/kvm/cpuid.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
> index a7dff9186bed..ff2b38d3e108 100644
> --- a/Documentation/virt/kvm/cpuid.rst
> +++ b/Documentation/virt/kvm/cpuid.rst
> @@ -62,7 +62,7 @@ KVM_FEATURE_PV_EOI                6           paravirtualized end of interrupt
>                                                handler can be enabled by
>                                                writing to msr 0x4b564d04
>  
> -KVM_FEATURE_PV_UNHAULT            7           guest checks this feature bit
> +KVM_FEATURE_PV_UNHALT             7           guest checks this feature bit
>                                                before enabling paravirtualized
>                                                spinlock support
>  
> 

Queued, thanks.

Paolo

