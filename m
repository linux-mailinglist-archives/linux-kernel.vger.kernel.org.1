Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F14F293666
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbgJTIHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733119AbgJTIHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603181251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9X9z7bcSkIflMn/EuSDjY+5PXLgWKnYQvzQsm5FKNI4=;
        b=eoCQF8gBqv8v44m8rjosk01hvvqUVYUotZO2ZUPaGuxnXqC/rdOdljjf5vzDcEuzJ0LTbm
        O8sPSHHOzAu2MFsTcgSHsYlu3AYaZxnEQUU1gsk9h2ko4JF2G9FGEuFC/RZ7/NPnUzNvfn
        zvBQL9Y1J3FILNrHpQJHM7xZ7C0I+D4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-HLrKi0ljNPu8-QPI12VGUA-1; Tue, 20 Oct 2020 04:07:28 -0400
X-MC-Unique: HLrKi0ljNPu8-QPI12VGUA-1
Received: by mail-wr1-f69.google.com with SMTP id q15so481716wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9X9z7bcSkIflMn/EuSDjY+5PXLgWKnYQvzQsm5FKNI4=;
        b=qFqiy+f0nTXZDG9LHDM2i9/pVUoCwKvgKlETN1KUDB6yl8eLUHLiQklAMQ56JauSMj
         O+m/FGS3mQEKf/S8f9hH3d+KjrmlOnkoyiVFOafEuooy0KLHWCGuuN6glY906pwyMQ/t
         79Nna2DE9nsIHt0EowBEHhyx5c8b0kCnmEPbt3IZneKlL6l94sDyQQutlxKS1IR+IPx6
         zVYV6OowtOi3epe4v9O0AZFi+Vd3e8W6DfEnkVKcvLilC2GhZOyf5ByrDgZRYPVt1WNp
         V9yAQNYGjEKRAhO6P46iKUajCXA0ZJ1UKPpcBdgSx1JfoFYa37qE8BGIgPNMlPH4rQ4E
         u/gQ==
X-Gm-Message-State: AOAM532D15JEFUEHjTv2623IDUm80+/ZvSMaUDFRZxv656N28ukgXxjb
        u7eGrFvk/VJD67VM0nDwgkrCryKwIZlCwvhF6iFAZfIBvWgSF5spbbccMVbLxTb28itZ5puIxav
        cgHopdKRGAA+/9OfgQpUOU5K+
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr1970786wru.161.1603181247379;
        Tue, 20 Oct 2020 01:07:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNRdNCmWfia+V+FyupuFLmwfwLBKlDsbsy04oihernE2WtCItAguN6D52h+xDVSr+M69is3Q==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr1970760wru.161.1603181247137;
        Tue, 20 Oct 2020 01:07:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d3sm1944911wrb.66.2020.10.20.01.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 01:07:26 -0700 (PDT)
Subject: Re: [PATCH v2 00/20] Introduce the TDP MMU
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
References: <20201014182700.2888246-1-bgardon@google.com>
 <f19b7f9c-ff73-c2d2-19f9-173dc8a673c3@redhat.com>
 <CANgfPd9CpYt9bVNXWbB+2VTrndfLBezqPauDo2-n8UdKDsrzpA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b07db4bf-860c-57cb-6a1d-b5a151c28c9b@redhat.com>
Date:   Tue, 20 Oct 2020 10:07:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd9CpYt9bVNXWbB+2VTrndfLBezqPauDo2-n8UdKDsrzpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/20 20:15, Ben Gardon wrote:
> When getting the dirty log, we
> follow the following steps:
> 1. Atomically get and clear an unsigned long of the dirty bitmap
> 2. For each GFN in the range of pages covered by the unsigned long mask:
>     3. Clear the dirty or writable bit on the SPTE
> 4. Copy the mask of dirty pages to be returned to userspace
> 
> If we mark the page as dirty in the dirty bitmap in step 3, we'll
> report the page as dirty twice - once in this dirty log call, and
> again in the next one. This can lead to unexpected behavior:
> 1. Pause all vCPUs
> 2. Get the dirty log <--- Returns all pages dirtied before the vCPUs were paused
> 3. Get the dirty log again <--- Unexpectedly returns a non-zero number
> of dirty pages even though no pages were actually dirtied

Got it, that might also fail the dirty_log_test.  Thanks!

Paolo

