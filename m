Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A400286645
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgJGRx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbgJGRx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602093235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wkv1LonlQeT5UBNJLTQ7QmWoIbUunt1WKxKHWvxBZHU=;
        b=Bdv0e3jhzUtMsHOVpDmbOu3XJfWG8rguRz23TgI0Xpxv3qeLF7l+gLojo+FvqXLqLOL2sV
        9hEq5+GFWZAb+zfq9wcPEtMGtGuBS3nXn4ZsxDqXui+odsF+WV2Lrp9V3K0y/KJU5wgMc0
        muAOfiK3u88VI2qpsju0TnWCnzxVass=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ld5NXYNaOrKJTVrHjl44Jg-1; Wed, 07 Oct 2020 13:53:53 -0400
X-MC-Unique: ld5NXYNaOrKJTVrHjl44Jg-1
Received: by mail-wm1-f70.google.com with SMTP id u207so1154563wmu.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wkv1LonlQeT5UBNJLTQ7QmWoIbUunt1WKxKHWvxBZHU=;
        b=rFJ1JU2NvzqblpiaoMZT+hMU1xko3i6qbW9j7o/d+A+QwtPOgYrKFURwetRHHx86bl
         kiHDn5NBF33ma7vxXXZPGzM/+D/zvuaTh1WUAnvznJDrVI4svaIGnYMhXT3sXoA3IX3q
         tkNwz2Ndbn2fZs8NBqEUPDpeW2onqEbMrHIcdzSSNNJNTVyaYmfRf1prVtagCsuhzcW3
         +mwf9QFEzwm6l8dUGoMw+3p4UNYI1M+O7RsSIY+AQXzNUhUpT1wtoJqRVureWj882FP+
         vl+lwTWh5S+QZaGUp7OcJ7WLGB6x9p1oqX8WTSCnCbY+TjSfIl3WlwEJ76cFwWsGON/7
         uI0w==
X-Gm-Message-State: AOAM531uAmkRzzKRq4mGZUf+l70voPSAVeSZRJbDvB/ha1qBTFebZH4B
        pXbSgjuFnzjEx8mwh5k4Z6MH1A1Y0NSOYZ4XfbaeCMXGv3kuR5n8KWtVv64cd+RiAFX+E+Xyh9J
        0p/sGQdtjfBsFD8n9mO2xNFEm
X-Received: by 2002:a1c:bb84:: with SMTP id l126mr4806486wmf.159.1602093231887;
        Wed, 07 Oct 2020 10:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx66R/eljpuRHcwEkISzskFEnh6eFZvXspkuojvwqTEM48rNfW48Y3jx1D6geUNIh8ejoUSpQ==
X-Received: by 2002:a1c:bb84:: with SMTP id l126mr4806458wmf.159.1602093231631;
        Wed, 07 Oct 2020 10:53:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff? ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
        by smtp.gmail.com with ESMTPSA id u81sm3439550wmg.43.2020.10.07.10.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 10:53:50 -0700 (PDT)
Subject: Re: [PATCH 18/22] kvm: mmu: Support disabling dirty logging for the
 tdp MMU
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-19-bgardon@google.com>
 <44822999-f5dc-6116-db12-a41f5bd80dd8@redhat.com>
 <CANgfPd_dQ19sZz2wzSfz7-RzdbQrfP6cYJLpSYbyNyQW6Uf09Q@mail.gmail.com>
 <5dc72eec-a4bd-f31a-f439-cdf8c5b48c05@redhat.com>
 <CANgfPd8Nzi2Cb3cvh5nFoaXTPbfm7Y77e4iM6-zOp5Qa3wNJBw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0dd49e95-181f-e6eb-5e3f-ed32d20c2196@redhat.com>
Date:   Wed, 7 Oct 2020 19:53:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd8Nzi2Cb3cvh5nFoaXTPbfm7Y77e4iM6-zOp5Qa3wNJBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/20 19:28, Ben Gardon wrote:
>> No, that would be just another way to write the same thing.  That said,
>> making the iteration API more complicated also has disadvantages because
>> if get a Cartesian explosion of changes.
> I wouldn't be too worried about that. The only things I ever found
> worth making an iterator case for were:
> Every SPTE
> Every present SPTE
> Every present leaf SPTE

* (vcpu, root) * (all levels, large only)

We only need a small subset of these, but the naming would be more
complex at least.

Paolo

