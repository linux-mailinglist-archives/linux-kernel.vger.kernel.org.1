Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5439275B79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIWPTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgIWPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600874392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VP/uPxlVn+VO8OSs/cXXYD6CRLQQniKKhgRTFTtzIRU=;
        b=M+OmTQ0jCuGVjTUAXx2Tn0oAXoNEeuHUi87msS1s75acSwtd0PgkS9Y99XXtbps6uRnGyl
        OQSKZhFTHI/dTvHYsdqavag74Lm6igWo3vmwW/ryOvXX7RZ8yDRvOah1oc9IEYN+o01Nl1
        kzbnYG5VnrraThBMAUfk2zfgIHh0hnk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-1xsYwNAbPrS5sBBfeI8p9w-1; Wed, 23 Sep 2020 11:19:50 -0400
X-MC-Unique: 1xsYwNAbPrS5sBBfeI8p9w-1
Received: by mail-wr1-f70.google.com with SMTP id l9so8916037wrq.20
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VP/uPxlVn+VO8OSs/cXXYD6CRLQQniKKhgRTFTtzIRU=;
        b=q+nt+LgFOZHDPef0pEbgTB5RecAL9PNr6OFBu6C5OlFPTStTKs1ZX8iKfV4TOEiiGp
         VQGhTnRAVJtMgyqCB/C1aw51AenmflGwSsvZTHzuPPupQoGRW44NJYeCqS3HmbqsDRei
         7H2BHdVyQNMUphK6J5T3NFuLUk6MdQQ1PeELdX8QKFIp4K8YBryd0A5/2Qrw9WIX91Pj
         VNscigeZHOGjbZzOWBHSsxCY9/ssOBCFGRGqNjls+tLNbLpPNnf+Y+YlLlbtLZ+zYx5c
         WbFHTQKzIqY+KaV7t2QJ0zUeEA3F3QCKEoXIEPUoy5qkLRYyNYfrwqSBRG6i+jmQ0B45
         MLrQ==
X-Gm-Message-State: AOAM531Z52rFGGp28Q0GPLQ8j7i3I6fKMiamun9uo0RpQytj6GOhpLrc
        oySh034m9sH3lk7tG1TKyFCPGkmqK7a8nrzM6/syod3hhGW4VG0hX1vG4asxPcu9tAlxwAwQwLT
        7N4eD3QzrquZlrovEbgLyHgYO
X-Received: by 2002:a05:600c:22d2:: with SMTP id 18mr25121wmg.145.1600874389035;
        Wed, 23 Sep 2020 08:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbgMoWwfq+neyAnsK0EaJ4ibs2pkKiG4LrxWCZ5IbM3u5TcuDmjgY1SOIQ3UTsK1K+EpMxkg==
X-Received: by 2002:a05:600c:22d2:: with SMTP id 18mr25098wmg.145.1600874388795;
        Wed, 23 Sep 2020 08:19:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id c4sm120226wme.27.2020.09.23.08.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 08:19:48 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Jim Mattson <jmattson@google.com>
Cc:     Mohammed Gamal <mgamal@redhat.com>, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com
References: <20200903141122.72908-1-mgamal@redhat.com>
 <8c7ce8ff-a212-a974-3829-c45eb5335651@redhat.com>
 <CALMp9eTHbhwfdq4Be=XcUG9z82KK8AapQeVmsdH=mGdQ_Yt2ug@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79277092-a5b8-ebb0-8a9f-e41d094ed05b@redhat.com>
Date:   Wed, 23 Sep 2020 17:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eTHbhwfdq4Be=XcUG9z82KK8AapQeVmsdH=mGdQ_Yt2ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 16:32, Jim Mattson wrote:
> You don’t buy my argument that this should be per-VM, then? I’d bet that
> we have very close to 0 customers who care about emulating the reserved
> bits properly for 46-but wide VMs, but there may be someone out there
> using shadow paging in a nested kvm. 
> 

I do buy it but I prefer not to have a released version of Linux where
this is enabled by default.  I procrastinated hoping to cobble something
together but I didn't have time.

Paolo

