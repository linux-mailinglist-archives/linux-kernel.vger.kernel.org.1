Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323842FBC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbhASQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731977AbhASQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:24:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:23:29 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lw17so1645334pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0aw/dETMyxgWmjUTx9neVtUqH4K4+9hFjmLcYtwpTlI=;
        b=r6uBjXQvcvyRmHqbrxzkyljpZ0UV1wRqHtetO09wL9bUkHwsRpMBrvAJBuhjn3bMN3
         CK704Gq4qEDSkx6qEHFLql2vJa4yCo+BJnB1icdl1vvHD4nKZIczcF+KXMUCMMBHlbPh
         +Ibs0/U9p3sB4dD0k788fjTw1qEQCmlUUAg4RBmyPNP06E1bwlyDy8QJ4TwwB6vLDFnF
         cDQDTHiRz25/UYFM5Y8WrrXoiQhTfjI0oAu1Yw+mzMWKiAJRfkcAq4GjSuTlAMKjSm0S
         Nf1mkIyQGjx7Cu4cAqNMXITF42n2vJyNbnA3gqCA2VxwP8aswR47e/f/RW7gTVDJq1qr
         GCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aw/dETMyxgWmjUTx9neVtUqH4K4+9hFjmLcYtwpTlI=;
        b=G9LfWohpzUQBY7AcBhit5Eu03t3LZci+Pe7xWVWc6NGC+YwMR3GoSeh4LRhw2wSLSK
         xgB2RK/BV4vjo8ZdMAQSv9VRROQ3txcgMBugMAMyCAJPiMgGJO4NUw0gdJzZAhsaypGt
         /k4rn+ODHPCV7gv4HZkJv2sh9jrdIOwi5D7hd25N50SEPz67k2HiXV+HO/ypS+jcHdya
         3ju6IdJzeOkSmNirDAwF07rAxVpjSE/6gaoyX8jZmF/CazntkUSwyh62OhDRbkELWuIJ
         oqHNrFLb9YHtp1PNQKR8XOTo0Q1246z7tkvKe9GqszrWDX4J9DgYtToBlDdTUdXp/9UD
         iouA==
X-Gm-Message-State: AOAM533M5OPQax+OO7/1IAoy1B0mCsBFihWH6ZAClpokBMD6YVdWQEz9
        yo+PYn4XFh6x9zhjop7gpjWtIQ==
X-Google-Smtp-Source: ABdhPJzkbBTMkzVaU2ainTlxiwnqT4XcchF3oQOixMC4RLrfx24qmbl9157+OmRmbNU6roe5reBn8w==
X-Received: by 2002:a17:90a:eacf:: with SMTP id ev15mr431309pjb.209.1611073408624;
        Tue, 19 Jan 2021 08:23:28 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id a188sm12854460pfb.108.2021.01.19.08.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:23:27 -0800 (PST)
Date:   Tue, 19 Jan 2021 08:23:20 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Add AMD_SEV_ES_GUEST Kconfig for including
 SEV-ES support
Message-ID: <YAcHeOyluQY9C6HK@google.com>
References: <20210116002517.548769-1-seanjc@google.com>
 <20210118202931.GI30090@zn.tnic>
 <5f7bbd70-35c3-24ca-7ec5-047c71b16b1f@redhat.com>
 <20210118204701.GJ30090@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118204701.GJ30090@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021, Borislav Petkov wrote:
> On Mon, Jan 18, 2021 at 09:32:07PM +0100, Paolo Bonzini wrote:
> > I think it makes sense because AMD_SEV_ES_GUEST's #VC handling is quite a
> > bit of code that you may not want or need.
> 
> Quite a bit of code which ends up practically enabled on the majority of
> distros.
> 
> And it ain't about savings of whopping KiBs. And yet another Kconfig symbol
> in our gazillion Kconfig symbols space means ugly ifdeffery and paying
> attention to randconfig builds.
> 
> For tailored configs you simply disable AMD_MEM_ENCRYPT on !AMD hw and
> all done.

It was the AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT dependency that tripped me up.  To
get KVM to enable SEV/SEV-ES by default, that needs to be enabled, which in turn
requires AMD_MEM_ENCRYPT=y.  I didn't realize that there isn't actually a
dependency on AMD_MEM_ENCRYPT=y

> So I don't see the point for this.

Agreed, I'll send a KVM patch to remove the AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
dependency.
