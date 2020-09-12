Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4809267831
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 08:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgILGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 02:20:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30327 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbgILGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 02:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599891620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wtddZ/g5BzSG6r0hO9D5GNe6gRNbI691h+YLFCj4YNs=;
        b=GKHJMYtFFhAldoL9QfLC8fWgUvVuq8kB/+2vP0ADLPfHTUoFm66QZbw6evH3ro6ycHdAmO
        7FH099TNrf1ymQGv1eJiTmViKrs6VfuLGcY3hr+129HS5FDynSCh+j3FUzlezu33U7Tx9J
        bXy+omDO9FkT4AUW49oRRXGsr+fjfdg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-BjTVc6VzO6WtkDVuS--_Lw-1; Sat, 12 Sep 2020 02:20:17 -0400
X-MC-Unique: BjTVc6VzO6WtkDVuS--_Lw-1
Received: by mail-wm1-f72.google.com with SMTP id m125so1678218wmm.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 23:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wtddZ/g5BzSG6r0hO9D5GNe6gRNbI691h+YLFCj4YNs=;
        b=thM7A87gnQD+hL9LZJkasgYdYzpS5OH6p6vWxh66lYk6dws1tjdjr+nqfP+IVTcYfH
         GFAzsIbqeePvX7R4+MzXKnxM0W0AWiRmKSqeUVQdWFkqotM5i7u6Jbqh33wTXlkZIL92
         l8DQxTMlW745HHsRXuJ2r49lSVHFmqBXCB/Ait/fKoAsXOz16molstWn9wbRq3K1VX1S
         H+zDWBLnrF6TdM9xgkqfcuocpAegqaZ1Yq5WETZNxkMrdoPNDzQz+/lBdV7zeEw/dfZs
         cR3bAdxIJE4s7URprT/QMhXaBQXdK1nQuTCYM3oNo6Pkb12ntZmm9kZvcHf9SqPf7xYE
         SC6w==
X-Gm-Message-State: AOAM531GM8OgSqmCQKEYcUxzu2/hsCxsSJmH7pKnzDdcAjbpTXND8lYG
        oKPaCvX3x4Nw7qc/ROWDpkjQuMin5ysKFxlhSHRXzBQmW/bvgwVOWxOP1V4DLuZptU7bRvNRK9n
        B+ECFbqPumWl6D5s00fEWBX8G
X-Received: by 2002:a1c:e3c3:: with SMTP id a186mr525471wmh.189.1599891616755;
        Fri, 11 Sep 2020 23:20:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3J9onSbFlnBmb71KhpXE0SnDHzaeYgliqwQ1/UJzyJ+sCi/4G2rJz2kHw7uY91FM3JgxYsw==
X-Received: by 2002:a1c:e3c3:: with SMTP id a186mr525461wmh.189.1599891616575;
        Fri, 11 Sep 2020 23:20:16 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id u66sm8430591wmg.44.2020.09.11.23.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 23:20:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] KVM: SVM: Move svm_complete_interrupts() into
 svm_vcpu_run()
To:     Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Paul K ." <kronenpj@kronenpj.dyndns.org>
References: <1599620119-12971-1-git-send-email-wanpengli@tencent.com>
 <87eenbmjo4.fsf@vitty.brq.redhat.com>
 <CANRm+CxR=U1jYMsqGEUOJ+G6ekUs3igZxzNzrepHp17QYrcEnw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9ae6d3d-e616-58c5-5db5-149fb702631f@redhat.com>
Date:   Sat, 12 Sep 2020 08:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CxR=U1jYMsqGEUOJ+G6ekUs3igZxzNzrepHp17QYrcEnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/20 10:47, Wanpeng Li wrote:
>> One more thing:
>>
>> VMX version does
>>
>>         vmx_complete_interrupts(vmx);
>>         if (is_guest_mode(vcpu))
>>                 return EXIT_FASTPATH_NONE;
>>
>> and on SVM we analyze is_guest_mode() inside
>> svm_exit_handlers_fastpath() - should we also change that for
>> conformity?
> 
> Agreed, will do in v2.

Please just send an incremental patch.  Thanks!

Paolo

