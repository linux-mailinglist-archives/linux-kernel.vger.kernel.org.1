Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE7275E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIWR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726751AbgIWR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600882063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ma/IyYqWd34oHOgskwlzrFRY7gOhK4MLYjQUwqMt/1Q=;
        b=Ho/+dWmsXEuc3ObPIIdanfrrvmdnCnFf6uGjQ07aPuTE6Qm+O2F0/1Ed4pvGqPd17PlAUB
        vfuMZar0sD6pTC/rtGHItdbeJWaip7kuh6piyTCxVK9ZGxvVZADd9MAcdFfwGXPMRmPfIq
        JdJirH/qi2WUNqhcMBpviKDS0SzqFvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-EjrH_UNrMT2vyHnn7juJQg-1; Wed, 23 Sep 2020 13:27:41 -0400
X-MC-Unique: EjrH_UNrMT2vyHnn7juJQg-1
Received: by mail-wr1-f72.google.com with SMTP id b7so116699wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ma/IyYqWd34oHOgskwlzrFRY7gOhK4MLYjQUwqMt/1Q=;
        b=ZrfyptlnHSlv7KKbV/RmrFc7DepJZUbb4q5+/HxB0NVIg1UAwf96eHrzBvoM5ww0I3
         ngPe4gzIbjXsYG6e80vreCLTUlVJ19HJbgUO106HC5EUc+99CMZN06SFP/ne/Kf5i1qp
         CuQtKOcN0efzqa5qZLLBDb6qC59BUm0y82o5mfAuaw00G3ZLzbCrK51Rh/o7iUs9+kFE
         ftmnChNQ5cftt/FxP/XO3sC5VmgA55iYRg3TXGN0L7+XnjrEnC3dD22tXvabVozsb3dJ
         dYkXu7nYw99YoWGNLWwif+KPHpSR9Ba9UBalDorXq//h65us2KRo/GXMfki5YbjuxSMh
         +BCQ==
X-Gm-Message-State: AOAM532dasPiwFUweuiBv4PhDnBAoomFWbiY+3rFszECiPxsPKGmaheX
        2pOO6xrjTHVKtJXJll6UM6o5L1jCaSmbqijiysDJsr8rY4zsmIP6L/8OzuwVARi8penVjQhybIj
        qLdHCyDnJaFOunos4XqysVpKd
X-Received: by 2002:adf:f58b:: with SMTP id f11mr757861wro.250.1600882059642;
        Wed, 23 Sep 2020 10:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsdKtajaFmi/b3j9rqMRBSAB1kFNumm9ZLFFSjFBEHO1MxeWAxTEGwTkb33g3um/6zhxK81w==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr757833wro.250.1600882059442;
        Wed, 23 Sep 2020 10:27:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id t124sm539908wmg.31.2020.09.23.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 10:27:38 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Mark SEV launch secret pages as dirty.
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Cfir Cohen <cfir@google.com>,
        "kvm @ vger . kernel . org" <kvm@vger.kernel.org>,
        Lendacky Thomas <thomas.lendacky@amd.com>,
        Singh Brijesh <brijesh.singh@amd.com>,
        Grimm Jon <Jon.Grimm@amd.com>,
        David Rientjes <rientjes@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200807012303.3769170-1-cfir@google.com>
 <20200919045505.GC21189@sjchrist-ice>
 <5ac77c46-88b4-df45-4f02-72adfb096262@redhat.com>
 <20200923170444.GA20076@linux.intel.com>
 <548b7b73-7a13-8267-414e-2b9e1569c7f7@redhat.com>
 <20200923172646.GB32044@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ccf42d8-2803-c1db-73f0-884d1ea27282@redhat.com>
Date:   Wed, 23 Sep 2020 19:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923172646.GB32044@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 19:26, Sean Christopherson wrote:
> 	/*
> 	 * Flush before LAUNCH_UPDATE encrypts pages in place, in case the cache
> 	 * contains the data that was written unencrypted.
>  	 */
>  	sev_clflush_pages(inpages, npages);
> 
> there's nothing in the comment or code that even suggests sev_clflush_pages() is
> conditional, i.e. no reason for the reader to peek at the implemenation.
> 
> What about:
> 
> 	/*
> 	 * Flush (on non-coherent CPUs) before LAUNCH_UPDATE encrypts pages in
> 	 * place, the cache may contain data that was written unencrypted.
> 	 */

Sounds good.

Paolo

