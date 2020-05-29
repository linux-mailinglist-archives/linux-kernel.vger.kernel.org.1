Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D158D1E78B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgE2Ir4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 04:47:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59371 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgE2Irz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590742074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMJc+r/r+0/7enCThmZTDSPXOVNgB1F7k3W87RQaDkY=;
        b=K/LNz0MDnv2wmjjkd/T3Huvvq09h7gJ9sHnbsYXdj3iMznOUeukGlRNs7VCkCamyvWczEU
        887ClHHusMY/GHq+ItjQ1Jkp6fI56nED77jCVT+jub9JrNg1npEyiQkUbgjAeeOEiKf+Ri
        fsrFQQdp4MO1//42dW7NT9d9S4MCJAY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-rd-rRCvENrurzEbxLM0ngg-1; Fri, 29 May 2020 04:47:52 -0400
X-MC-Unique: rd-rRCvENrurzEbxLM0ngg-1
Received: by mail-wr1-f71.google.com with SMTP id z10so775890wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dMJc+r/r+0/7enCThmZTDSPXOVNgB1F7k3W87RQaDkY=;
        b=rEYDBDL98kg6MgmXU3qUSzzDg93RrLSJvg5rVAg1f4QLe6BpdgppM60ALo7RiDTVgp
         3sNtVDt6sOeSIVZUt5s4lT6NAxlCK0i3BURohJBfjjZtJDpGj4LqaVzFGgsdvFd2yZ0o
         2obSRVFz9NqA0pvW2E1iGfVnOsOv3oOWiskrr4g8RdvNHwr0zwJSNWBKNot4O+/WdqWe
         2UQq83kwwP6jN1IKse4onQQDoPZZ3wKfZ8zU+rP4AsIUDEezXjnC/w3Wv4ipigOUSoTL
         pBwWL9RDz2tdeFm/Lka6k4bqt1ETuQt7dEKnaSywQ/91AutwBA7bNVuJIUrk7BpLlfPD
         sTOw==
X-Gm-Message-State: AOAM5310jpE4AsGpzvUfwZ/iHiJYL+zCyh/0g2V4WTaDNmFf8sJZn3Iy
        rylxpzSxSsWBhjgLL3BMLvJC/5xO9bqaTCNMZhk/YrKEUGeXNr0JLoRFissmCUS8ZNfxpAJjpTU
        aXI6D6soWkob7+6wcUjyYeIoO
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr7682066wrx.317.1590742071103;
        Fri, 29 May 2020 01:47:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtAKBA+DYtf8htNfnI9kbnY0IFz6CjGCCBOuaPsdJCF4MCwCL4AgBIy6MCwkP7CEX+VoOv8w==
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr7682050wrx.317.1590742070904;
        Fri, 29 May 2020 01:47:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b096:1b7:7695:e4f7? ([2001:b07:6468:f312:b096:1b7:7695:e4f7])
        by smtp.gmail.com with ESMTPSA id k21sm4729753wrd.24.2020.05.29.01.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 01:47:50 -0700 (PDT)
Subject: Re: [PATCH 05/28] KVM: nSVM: correctly inject INIT vmexits
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
 <20200526172308.111575-6-pbonzini@redhat.com>
 <a5331d80-b6ee-b111-c91b-a8723fd3da9b@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25c0ab83-f7d7-44f9-b00f-59ecee0256dc@redhat.com>
Date:   Fri, 29 May 2020 10:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a5331d80-b6ee-b111-c91b-a8723fd3da9b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 08:46, Krish Sadhukhan wrote:
>>
>> +static void nested_svm_init(struct vcpu_svm *svm)
> 
> Should this be named nested_svm_inject_init_vmexit in accordance with
> nested_svm_inject_exception_vmexit that you did in patch# 3 ?

There's also nested_svm_intr and nested_svm_nmi.  I'll rename all of
them, but it will be a follow up.

Paolo

