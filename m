Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E92C8E40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgK3TkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgK3TkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:40:20 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:39:29 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id ms7so217089pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o6rtmKPTOe3MI6LpooTnqzq594FdWbZHfm2j9oryTcE=;
        b=pqHlgGMiEu/p0dKcFRIJepFYNmoKCvWk9svkXrglrSRAR/UqIpTJpbEu2FbJJOjZ2r
         EENBGawkuvGUryYSHiS3NgAA8t5nnDT8E9BGZHdynRvNH4Riz5OQgIXScY1ZvsJQAkQY
         G3Td1KM4MxUZtvJ6l8WRrlUG7+evwRBmuMquo8MThVsBAQDVmwOkiC7WjerKor54HV3h
         ykK3TFYa4ZPxx5E2nXwhnKsv1YWpx5AYiAcqBAC8ePhwAVbIOwnR7ScbQbCFi1HGtk96
         pVaJeguMZlwI/7EanFKZqmVl95AaH16KIm7TjlO0C0HKwgKwcqtnmxL7LQ54qhpZVVPR
         5GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6rtmKPTOe3MI6LpooTnqzq594FdWbZHfm2j9oryTcE=;
        b=rO9CIJ7lDmSXsqM1DxIlLcsj8gVda1Dbzhb5mwl1gcOvEvddaFAWnXoiKTXaKhsdX7
         BR18Xulh+obTvHMFYv7lkApwE01KbmQLJOjyXhce1SXgNEidnlYplNGnREPHN31of2CM
         DVB89LjkN0Z6QtD/wpkUer1gWLC8Z8M5GvDL3wjlTAnhCxU8K5v8xg3GfnNpZmgGQwMR
         2nGWMe6XvHCRb0FB8Le+o/K2nl/5kIeo8oFmw3iaFZwEL9ANP4kjEwTZ+WhMItKq7PFr
         HYUck6cox399wXseKTvaR8TOgFJMI56m+XlGrJSCtme45wmMIo1gwNjypM49wzQor+ZX
         drHA==
X-Gm-Message-State: AOAM532ax7baX63kyihmc2px02KRO5314+vazDXiP4kBwDTlZzos9I2+
        cWSy04ww9fpJgThUUDLCGJaU7g==
X-Google-Smtp-Source: ABdhPJyBPOj+BUOCDMsjX7h8TcafuKx02gSTxE7xTOAMupSoP4OnMeBtT6gqcJSdzXh51dADt+q6rw==
X-Received: by 2002:a17:90a:7022:: with SMTP id f31mr405610pjk.213.1606765169152;
        Mon, 30 Nov 2020 11:39:29 -0800 (PST)
Received: from google.com (242.67.247.35.bc.googleusercontent.com. [35.247.67.242])
        by smtp.gmail.com with ESMTPSA id z11sm17647793pfk.52.2020.11.30.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 11:39:28 -0800 (PST)
Date:   Mon, 30 Nov 2020 19:39:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [RFC PATCH 25/35] KVM: x86: Update __get_sregs() / __set_sregs()
 to support SEV-ES
Message-ID: <X8VKbLzEDc+W+jU/@google.com>
References: <cover.1600114548.git.thomas.lendacky@amd.com>
 <e08f56496a52a3a974310fbe05bb19100fd6c1d8.1600114548.git.thomas.lendacky@amd.com>
 <20200914213708.GC7192@sjchrist-ice>
 <7fa6b074-6a62-3f8e-f047-c63851ebf7c9@amd.com>
 <20200915163342.GC8420@sjchrist-ice>
 <6486b1f3-35e2-bcb0-9860-1df56017c85f@amd.com>
 <20200915224410.GI8420@sjchrist-ice>
 <3f5bd68d-7b2f-8b1f-49b9-0e59587513c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5bd68d-7b2f-8b1f-49b9-0e59587513c8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020, Paolo Bonzini wrote:
> On 16/09/20 00:44, Sean Christopherson wrote:
> > > KVM doesn't have control of them. They are part of the guest's encrypted
> > > state and that is what the guest uses. KVM can't alter the value that the
> > > guest is using for them once the VMSA is encrypted. However, KVM makes
> > > some decisions based on the values it thinks it knows.  For example, early
> > > on I remember the async PF support failing because the CR0 that KVM
> > > thought the guest had didn't have the PE bit set, even though the guest
> > > was in protected mode. So KVM didn't include the error code in the
> > > exception it injected (is_protmode() was false) and things failed. Without
> > > syncing these values after live migration, things also fail (probably for
> > > the same reason). So the idea is to just keep KVM apprised of the values
> > > that the guest has.
> > 
> > Ah, gotcha.  Migrating tracked state through the VMSA would probably be ideal.
> > The semantics of __set_sregs() kinda setting state but not reaaaally setting
> > state would be weird.
> 
> How would that work with TDX?

Can you elaborate?  I.e. how would what work with TDX?
