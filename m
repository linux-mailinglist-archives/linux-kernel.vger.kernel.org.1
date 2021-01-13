Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C42F4BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhAMM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:58:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbhAMM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610542645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lgVRo6CQ9NzWlGI1TykX+pxELJPZRPvZtRz/475DZc=;
        b=OSmSg5lgR+tinFh5kFR7XJo3TGfreRBMGMftAlplKsfA4u9vQXjDL47gPj/pZA+SaqW0u5
        06YZjkoA5ty75SZztuPdDli1ls1izkLSPpMzq/WmMdahaZsTEoS/k65RNPvZT5OYcOPwe5
        eJWGjk25/JFS7uEKrg2Y3oAcW08iBf4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-wONHlRJyPKW2zeAsRnEuxw-1; Wed, 13 Jan 2021 07:54:56 -0500
X-MC-Unique: wONHlRJyPKW2zeAsRnEuxw-1
Received: by mail-ej1-f69.google.com with SMTP id j14so688485eja.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0lgVRo6CQ9NzWlGI1TykX+pxELJPZRPvZtRz/475DZc=;
        b=oPPyjOyWrN8edD9mdiZfezUqpCHv6R0796vB/AXnsBv4XowZfnMQdaZxejk9lvNDIp
         NAWZ2qgBtq+ExbPRAkcRYQQh/DTMBGduPblSdwsbDb4W4U36ZxlWYMGSdXv95hGfg7tq
         Kg1G6IGLaEKqwbZHpwlb7MnV1NiNv+XJwetkx67NKvJD8qfl+knQ0hvidjB32zqnJlPY
         ytiYHut9Mu4T0avjjmTsaMQVzYrCRRZZlPoJk67DwP6YasstXdY7CCHF0Td1UQTSP7sv
         kufuGAtrjYX7kYM0myfDlghJOi+w9x/qvzHfNy5h+YyDml94z/zU+Xq4ahsJUG3TdS9g
         y10Q==
X-Gm-Message-State: AOAM531VsPxL8Ag+GqGQbNlIZAdT05VFchO084RfH7/xDDqDCBOwnifW
        QjOzfAkgOU4bgMLP7mc4Mln8L3zIQUvBRocCqof5oFU4HPPMlJVI80NxdmVx/xA17gldM0fqYWT
        VItE5py+f7YfC04X5WZh0ONn+
X-Received: by 2002:a17:906:8051:: with SMTP id x17mr1399612ejw.430.1610542495000;
        Wed, 13 Jan 2021 04:54:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBAbgplulFKo9eP75wGHcb584+trku5uwL0gCASCjo/ZigzcaALTL85slMCjEGciyLubpwAA==
X-Received: by 2002:a17:906:8051:: with SMTP id x17mr1399592ejw.430.1610542494870;
        Wed, 13 Jan 2021 04:54:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k16sm677031ejd.78.2021.01.13.04.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 04:54:53 -0800 (PST)
Subject: Re: [PATCH 1/2] Enumerate AVX Vector Neural Network instructions
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, tony.luck@intel.com, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, kyung.min.park@intel.com, x86@kernel.org
References: <20210105004909.42000-1-yang.zhong@intel.com>
 <20210105004909.42000-2-yang.zhong@intel.com>
 <8fa46290-28d8-5f61-1ce4-8e83bf911106@redhat.com>
 <20210105121456.GE28649@zn.tnic> <20210112021321.GA9922@yangzhon-Virtual>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be47fd98-9d76-a35f-3ee2-7de2144dbdd6@redhat.com>
Date:   Wed, 13 Jan 2021 13:54:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112021321.GA9922@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Boris, is it possible to have a topic branch for this patch?
>>
>> Just take it through your tree pls.
>>
>> Acked-by: Borislav Petkov <bp@suse.de>
>>
>    
>    Paolo, Boris has acked this kernel patch, and if i need send new patchset to add this
>    acked-by info ? or kvm tree will directly pull this patchset? thanks.

I'll take care of it shortly.

Paolo

