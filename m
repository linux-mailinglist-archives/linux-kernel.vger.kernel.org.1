Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAA62865BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgJGRS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgJGRSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602091104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/v7nvWSVPw21rmS+GFFSvbPZ5gWBbt3l5XRpI+aI+Hg=;
        b=PEigp3Gd8KJNA2OO5W4pNZjRv+SRPUa8WxVNa7D5z8nmuBq2Q6dn22suLzl9QQThytthcn
        lGB2FTvq8aWiHzOhNg3Djy8lA+Arlfm0c8qcoquEfsxg+E8hMqDsVBPRlMFXOEsZFnwPKa
        vzmeA5CvVdVJsbeeGLys9ZUwavF+Unw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-QyQGe5ptN26bnab1lJopCw-1; Wed, 07 Oct 2020 13:18:22 -0400
X-MC-Unique: QyQGe5ptN26bnab1lJopCw-1
Received: by mail-wm1-f70.google.com with SMTP id z7so1174865wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/v7nvWSVPw21rmS+GFFSvbPZ5gWBbt3l5XRpI+aI+Hg=;
        b=rIWktVbC4TTOlqc1o86GndsfEevH5lSpFOLy9/GC+/w79Tk7cWQif6Nm4IYcxaGB3D
         1AdnTmb9bsOyr72/DmQiAqN5xogCMz887+52+WKi9ry7axdvpbPA9QmKweG/zBB0m4HV
         FpLy/E9xnTOsaWPSe//EZny7fWHy4cD9JgtOC1IdMY7h7tRr4h4z7EP0BgbvxdND9OFs
         plECWoKyf42pE63c6J4lfK/+t5Fcqkx97hXL1LCJXPLJGfzPhr2ldQbq59tfWkI/R9Z3
         NU3o8NfxapwAMLLG8FxMJvyTWhkVYvKfc0cfXoS6IFOFkx5/b5iLz2FiqpFsfwLwxAFk
         hBRQ==
X-Gm-Message-State: AOAM532q53Vle66XS1K0udzFioyF4EizxLuXfmWEMuJICQMcip/qjQcC
        lmIWyUi5c1RRWToARGulNBxkQoHP0TN1OT4+eNS38aDwAKPUkJPAPlTsnC2pZb6snZYBCuUhV1e
        XS4r+RmgrRsWMrFGuYffxoWLw
X-Received: by 2002:a1c:7302:: with SMTP id d2mr4631652wmb.133.1602091101035;
        Wed, 07 Oct 2020 10:18:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKPP74qZQsmdxyvkGEn9VUtPzb5ZTroAyk+Nnw3EhYDtq8OtPP0lUjG9SJzJF7Ewpy5P4qlA==
X-Received: by 2002:a1c:7302:: with SMTP id d2mr4631622wmb.133.1602091100710;
        Wed, 07 Oct 2020 10:18:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff? ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
        by smtp.gmail.com with ESMTPSA id f12sm3396397wmf.26.2020.10.07.10.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 10:18:19 -0700 (PDT)
Subject: Re: [PATCH 15/22] kvm: mmu: Support changed pte notifier in tdp MMU
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
 <20200925212302.3979661-16-bgardon@google.com>
 <622ffc59-d914-c718-3f2f-952f714ac63c@redhat.com>
 <CANgfPd_8SpHkCd=NyBKtRFWKkczx4SMxPLRon-kx9Oc6P7b=Ew@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7636707a-b622-90a3-e641-18662938f6dd@redhat.com>
Date:   Wed, 7 Oct 2020 19:18:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd_8SpHkCd=NyBKtRFWKkczx4SMxPLRon-kx9Oc6P7b=Ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/20 18:53, Ben Gardon wrote:
>> in addition to the previously-mentioned cleanup of always calling
>> handle_changed_spte instead of special-casing calls to two of the
>> three functions.  It would be a nice place to add the
>> trace_kvm_mmu_set_spte tracepoint, too.
> I'm not sure we can avoid special casing calls to the access tracking
> and dirty logging handler functions. At least in the past that's
> created bugs with things being marked dirty or accessed when they
> shouldn't be. I'll revisit those assumptions. It would certainly be
> nice to get rid of that complexity.
> 
> I agree that putting the SPTE assignment and handler functions in a
> helper function would clean up the code. I'll do that.

Well that's not easy if you have to think of which functions have to be
called.

I'll take a closer look at the access tracking and dirty logging cases
to try and understand what those bugs can be.  Apart from that I have my
suggested changes and I can probably finish testing them and send them
out tomorrow.

Paolo

> I got some
> feedback on the RFC I sent last year which led me to open-code a lot
> more, but I think this is still a good cleanup.

