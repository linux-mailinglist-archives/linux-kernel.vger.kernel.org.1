Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91B1253924
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHZUhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 16:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZUht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:37:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6241C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:37:48 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n23so2614807otq.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ybWHrSMyDBrSdF5ECn3A4pj2aU4lAfHVUX9+2rwitU=;
        b=rPD/a9E6McwFRtU8JnYRGPiEXxyoUkU5X7thpuUru3IhxHyl/gXb4XWycdFgHi8mZ/
         IycTdhhBNnYcC4JIpn2FBab2HPWOrZA4HHvUGIh/KBvjrf3fLXkzmbnc+sALXrvr17VW
         NVM8x+ehJTH892ezv583w5OrPMzphz8XhW41oZPuDe2QC1Wt/xhudRxEU/uFs0MLOpPy
         1fPz57yTaS1qCFbuHRmK9l1ErYwscS7dgrn16LbM9NMs6SfeDc+yBidJ+W+YCPI0/8wf
         pyKAL34TDorvF+3Idaad3a7HxQa3l76+I4XwYwfK6QttsBV+I28sBO6xt40In1KXdboc
         927Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ybWHrSMyDBrSdF5ECn3A4pj2aU4lAfHVUX9+2rwitU=;
        b=GBOuG6b36nqW7NXHHD2mp0FcOJPVjWBurv92m6LJfCYSMyILWzUO7dRQGRKbxoLCYG
         FCBvHHeWpCa9pi/Mx5/He0qBo9HCssYQhtmD75zJSyhjZqjvk/J6C5UUQ79EItp+r5o/
         ZwWJAkSBVPYKvNiojPIdn4sHZsBHKvzTj0179YpjimhH+wj+mgGNMXz2v25swvcFVWOt
         517J7k3b+PdENgj09oaROMG834Aq/+buK2Zc02UH2zJeJTixm2BUZWmRKkLKKgCb5QzX
         FtUiJ3/+mHnERBBWUv3ghu3Z5aoFHeZI27yAohdoYab7M8wvdzbfE+sQlXGqAZavZxLC
         KnqA==
X-Gm-Message-State: AOAM532N0KehLcQTmuGDledjneKi3fu5BLCqCaXZgaqzvjpCfsQcjkpC
        IOJBxklry/czJ0zK37NuDEmr6RundBUsILzHamdm1w==
X-Google-Smtp-Source: ABdhPJxRAGKt3qz4Jm62WwzP/4jDfgRPDaUUEg4FpEBTM3Ti7SEKs6bIqi+bxY7lQte+tHM/uD8AwcCSWWcNfkoh1GA=
X-Received: by 2002:a9d:51c7:: with SMTP id d7mr8696668oth.56.1598474267398;
 Wed, 26 Aug 2020 13:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <159846887637.18873.14677728679411578606.stgit@bmoger-ubuntu> <159846923148.18873.3524447445230117185.stgit@bmoger-ubuntu>
In-Reply-To: <159846923148.18873.3524447445230117185.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 26 Aug 2020 13:37:36 -0700
Message-ID: <CALMp9eTGo91f=ZZ_tPp2C9GC8BN5g72YwWLX1+5p-MDL3nj4=Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] KVM: SVM: Introduce vmcb_(set_intercept/clr_intercept/_is_intercept)
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:13 PM Babu Moger <babu.moger@amd.com> wrote:
>
> This is in preparation for the future intercept vector additions.
>
> Add new functions vmcb_set_intercept, vmcb_clr_intercept and vmcb_is_intercept
> using kernel APIs __set_bit, __clear_bit and test_bit espectively.
Nit: "respectively"
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
