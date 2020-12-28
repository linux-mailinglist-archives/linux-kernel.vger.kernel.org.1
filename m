Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921252E6C84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgL1X3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 18:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgL1X3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 18:29:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764D8C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:28:39 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e2so8195180pgi.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 15:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHXv2Jc7uDRYfCGmkxwRFDrFxzJk/xjA57oTL7WqPAk=;
        b=IG4n+U0iEnyjsOCZ36oBibFHyoOloR7t5DabLazjPAe2lmK9D0UpcdC1dKKsDHKU92
         +cNGcUFXNXP9hkO3LbUWCr4BRQi8Whnn0wu2z0IWJBCvbK2HBZGFiD4+Zxu0/hukuw4o
         lk5/1GiSFtPGVEp627njimpcVjMqmpIG/+hZ/x7/ZGthyf687XFMXEzCjJ1BNbefxYu1
         Ckfm4sTb/14a3XTyZzu4k0DcHLu3bTxHYOdScTu399djk0ZSL++S4f0s0e8oFurmTvbQ
         2KnzVqjqU5gz8irc4zLW+QTUznTF3rr51hGWnCeJsWt/b+EdNpgkby/LqoXldqBS97Se
         5wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHXv2Jc7uDRYfCGmkxwRFDrFxzJk/xjA57oTL7WqPAk=;
        b=uYjAMX7DWavcZzgUO9mMA2BFr9Y0KAI7X2cShJjpAq/XalM+NCjg+ag/7DzmZf0p+d
         +wPrrjQZSoiAUzhoxAfCdnZBqcQN1FTXPFKfgIYV8hlICzcmJjYLRsJmfzdPhap+kCTc
         nQREJ9Arq9BM8glupIi9VNYV2GIZs6vYmvdL7kl+fpmakGwO8UiNzhOlPNy6XYLxHDQn
         pSdKGAaDYTtXUP1oAMghJ7yD1P/+Brhh7H/jjWp7r0H8GGHI7WdPqoq/dCN0820NT4RR
         dlSKNFCP9HmiLXZ1qUgzRzoxO3FiBHV8j91U5RNRLCPR7SakwpDuKiM2+p7xnPOPDRoC
         esAQ==
X-Gm-Message-State: AOAM530+pos5FWcgtCHhHvU+fLdjSwNWXRfWTIvtQmjRXKPl/WlQ7MAZ
        hJVPub7hN9jiYNOMeE4xPfA7jg==
X-Google-Smtp-Source: ABdhPJweRY8jL3It79h5jMNDyIgtwp8n/71UFFCLfDWomYceM6Sn3/Me6p1fMh1We7VQeu4ROtUHLA==
X-Received: by 2002:a63:44d:: with SMTP id 74mr45370796pge.170.1609198118926;
        Mon, 28 Dec 2020 15:28:38 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id c199sm38708633pfb.108.2020.12.28.15.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 15:28:38 -0800 (PST)
Date:   Mon, 28 Dec 2020 15:28:31 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Zhimin Feng <fengzhimin@bytedance.com>
Cc:     zhouyibo@bytedance.com, zhanghaozhong@bytedance.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC: timer passthrough 0/9] Support timer passthrough for VM
Message-ID: <X+pqH77bs9nyhK8w@google.com>
References: <20201228091559.25745-1-fengzhimin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228091559.25745-1-fengzhimin@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020, Zhimin Feng wrote:
> The main motivation for this patch is to improve the performance of VM.

Do you have numbers that show when this improves performance, and by how much?

This adds hundreds of cycles of overhead (VMWRITEs, WRMSRs, RDMSRs, etc...) to
_every_ VM-Exit roundtrip, and the timer IRQ still incurs a VM-Exit.  It's not
obvious that this is a net win, and it adds a fair amount of complexity and
subtlety, e.g. there are multiple corner cases this gets wrong.  I suspect
you'll have a tough time getting this reviewed, let alone merged, without hard
numbers to justify the complexity and review effort.
