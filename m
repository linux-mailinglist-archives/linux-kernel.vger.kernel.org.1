Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5612744CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIVO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbgIVO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600786601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fQZ3CsVAakZ0XBmAEYMPM13fOqKXxB3YkpyUsuX4ts=;
        b=OkzWxXJBoHyTpaMHl8av9r8I0F5tL/IB4YxMOKNrwQfzCzkzM1MQ+vao74nVcN1AHdubaa
        G/2zMdgGdazF5cRmXLZfIxffNkeyRVp0VocRPVwaZiqP/jNSxH/vBHZ3MAnb7fCQW6QzXZ
        qHemEN9Rcp1KHldR0O+MsPTbCy74nm8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-2JV-2NlnNumDT25NLd-EJg-1; Tue, 22 Sep 2020 10:56:39 -0400
X-MC-Unique: 2JV-2NlnNumDT25NLd-EJg-1
Received: by mail-wm1-f69.google.com with SMTP id c200so1007596wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7fQZ3CsVAakZ0XBmAEYMPM13fOqKXxB3YkpyUsuX4ts=;
        b=C5bxWvbMScOyPkSVBq+Ojb6vBAfc1etFd+Pa4oz8pzx4jL0jvL72lUHjHGfMMgdpse
         6/2CBimAZ9XFsSJ7DSGQb+F0AFZ+2O/P/l1UjbqQjV/5DaFIsFI9f8kCDszt6WobofOI
         wnGZwjfiOyskq8cufRLw8P/Q4zEk1Z4QfUMF/Vf0aX99/MpQDIbqhDKywdhoZQymceSh
         im3s2qTlfMAUf+X0987FZO878a2x4ywGrBvG0et3FGLNl66T3pqqiHyheVIO+9esGzAP
         hqF2Tke2RG3TqNBHESCbLPzgKMM448LMLHjpY9FfN2ciHs8GdtHo25wFPcRaS1HJ92iL
         vecg==
X-Gm-Message-State: AOAM531F1jwnBSt22Sb0sNfasbh80FKjQGk4Rx1xDFeiXhKzUJ3ldGXa
        XXZaYECcNloXUN7M/dmpvXbD4FSpmt1syJLyDLZh2dwzPN+XjVu3sXRpJmQfrqwaDNLbMCTosoN
        VCYpvh/L9OZ5S2V/WPNrnLmc7
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr5749646wrm.216.1600786598706;
        Tue, 22 Sep 2020 07:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycHG/qyFPrbTWyMA6o+icN09XP4SKvKb2PRcjckpm9cJP8do2/gpvlR9PXbycQsdrOnpPkpg==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr5749626wrm.216.1600786598464;
        Tue, 22 Sep 2020 07:56:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6? ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
        by smtp.gmail.com with ESMTPSA id k4sm27735243wrx.51.2020.09.22.07.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 07:56:37 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Analyze is_guest_mode() in svm_vcpu_run()
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1600066548-4343-1-git-send-email-wanpengli@tencent.com>
 <b39b1599-9e1e-8ef6-1b97-a4910d9c3784@oracle.com>
 <91baab6a-3007-655a-5c59-6425473d2e33@redhat.com>
 <CAB5KdOaV81ro=F8BiuFfR_OWrY1+AJ4QngSOXOZt7vH_bXPR5A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66a1479f-9603-5045-c307-804db1a62845@redhat.com>
Date:   Tue, 22 Sep 2020 16:56:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAB5KdOaV81ro=F8BiuFfR_OWrY1+AJ4QngSOXOZt7vH_bXPR5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/20 16:54, Haiwei Li wrote:
>> EXIT_FASTPATH_REENTER_GUEST handling up to vcpu_enter_guest)...
> Hi, Paolo
> 
> I have sent a patch to do this,
> 
> https://lore.kernel.org/kvm/20200915113033.61817-1-lihaiwei.kernel@gmail.com/

Cool, thanks.  I think I'll just squash it in Wanpeng's if you don't mind.

Paolo

