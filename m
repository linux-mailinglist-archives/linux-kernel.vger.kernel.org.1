Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC352927A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgJSMu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbgJSMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603111855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKbXwf4+mcbeKehYI1z20l9UIe1TokmoIfEoo7RIUYo=;
        b=eCx5r2hVLHhwoJp5hAO6LszTN9K4w1Q6eND8ZoVnUWjXWh5EV70BgzIXV1bgMhuW61IkmC
        eWl8JuwJaJQGlXZF1oOwq62NX0KoKoKhwGWswBklCdu5eCYWWbjK8UVq+ax83nPF4j5ymM
        5IFr0y4RAc4R0dmvUC4taVBW6M6dpcg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-8nTN0VYfM8-fjCQ61xj-dg-1; Mon, 19 Oct 2020 08:50:53 -0400
X-MC-Unique: 8nTN0VYfM8-fjCQ61xj-dg-1
Received: by mail-wr1-f70.google.com with SMTP id p6so7323123wrm.23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 05:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VKbXwf4+mcbeKehYI1z20l9UIe1TokmoIfEoo7RIUYo=;
        b=MtTIn2Ita+u94WTd36CJjqIVPox3WVzuIUeSkOZCFTPVhO9HDO0eBCkPBfbLMR2ajI
         3cW9l/zghd4LLlh1AyxGDeUhM553lvMi6oO7rjusYe5MEQclx/OVfnCaqemgV+W096IM
         oDHtiY9DJZk7te+cD+Iz3XZZ7/VcGiPdpMF5oao5dKz/Z0GneAJVJLyLxA8F1k44CbC6
         gOfiWwMlayo8mqzQbObgkq7JcoANfvJSsEwIFfoE2IYMyn/6QZe0Dg0W5LXWp2naQzRo
         bNhDTnvu/3k6uSrBT9iVBFYzWn4AGrXFM1mhlqnP+am8tG/nRPX+5GMju1TCcHtrSYO1
         e+Iw==
X-Gm-Message-State: AOAM531DUTQY+bncatEgcHCvPiTU4Ay77b5JSxMhY6SGmyV3uc3TRwlC
        Px0g4ZRYwMW9IeE5DPc0s4Pej2EOqTtavh5LQ/VappOB2t6YZiMtoNrrekk9XtHmCF3+7rhkkI6
        1Kk6Fix/zirGvZ7RgWOQt3ED5
X-Received: by 2002:a7b:c418:: with SMTP id k24mr18278497wmi.118.1603111851931;
        Mon, 19 Oct 2020 05:50:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7IguPe7eZw+dfDTAsx9GR0C6WN6hqOxMvMsojTsn/pWrzXldNJif3UL4sbamz6brVCIw++Q==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr18278482wmi.118.1603111851728;
        Mon, 19 Oct 2020 05:50:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l26sm15944178wmi.39.2020.10.19.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 05:50:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     pbonzini@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        Haiwei Li <lihaiwei@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KVM: Check the allocation of pv cpu mask
In-Reply-To: <0330c9df-7ede-815b-0e6e-10fb883eda35@gmail.com>
References: <20201017175436.17116-1-lihaiwei.kernel@gmail.com> <87r1pu4fxv.fsf@vitty.brq.redhat.com> <0330c9df-7ede-815b-0e6e-10fb883eda35@gmail.com>
Date:   Mon, 19 Oct 2020 14:50:49 +0200
Message-ID: <87imb64bx2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

> And 'pv_ops.mmu.tlb_remove_table = tlb_remove_table' should not 
> be set either.

AFAIU by looking at the commit which added it (48a8b97cfd80 "x86/mm:
Only use tlb_remove_table() for paravirt") it sholdn't hurt much. We
could've avoided the assignment but it happens much earlier, in
kvm_guest_init() and there's no good way to un-patch pvops back.

-- 
Vitaly

