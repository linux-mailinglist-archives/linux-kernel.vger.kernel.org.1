Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4062CF43E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgLDSmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDSmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:42:09 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66DC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:41:28 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id c7so6860793edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpe0QzFR+pipwwlQ6a2MzDyp0bYD7DIdzQkuuRLNsTo=;
        b=N1pWv4MVTu8h54c3GOs5Ue8aeY0is8BFjfmOMVaj0XxCqhP/03svogCo1dlFWT63Eh
         A/rDBsUlceBfglZkzb0UDw3oaUnu8NMJ0KwRzihvA93AMxzYDYmejDM5IozeJKtEvICW
         4AS2VR4VaWa5kMmpNSJgBndJQDyANHJuQFll+uqcq+nHn9V0tG6dhm8BGNofHDaz4kUC
         7hPXvKaCtfvVorLMoY/CUnGi97CynEeSKpQDbux6DxSCoN2hA1MLAv56Pkx4rcmFkunL
         qKzjKZemdJ4CeXh2fseFX/E4pvjtaRkM28xypluQoaDZhzEZRObj0nun1tT2Mr8m+r+7
         uxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpe0QzFR+pipwwlQ6a2MzDyp0bYD7DIdzQkuuRLNsTo=;
        b=lqWx8QcrVRVG2mwjRrNvsfBofFbWBPDlTWo6PqpMCc/tLen7/NtuBMTpEdNH1e56Ok
         PFEww9RRJnPARGpHUpcMb3j1ItcQkGwzjm4XXUYdq1XlH9AMoshvuncPuNGZkTE6Olr4
         xRxsePsMzAs13d5KQ3d2BAiw94t+vRtIz0PnWIJ0rz1L8wP8IKrCOCK2BA7Rlr5nSr9C
         9MUPPBrZLc7O04LmbmBsRE7cWYiNWXN5XXToP+B8PnpQpPc00dOQA+Ge/+OlhaHlV0Al
         CkFEaHbKcfF7+1eWFc6HW12UTNR9i/gk4DXrYrXQOjOkgcN6p81L1JSfu9N/Y8p7GqBj
         fkHQ==
X-Gm-Message-State: AOAM532hOxhpOEc1P8xKCpz+4QfhxwWQ2925jcThcsijCJwbEqBEea0O
        GcqazFZudt2HI5344h9Fah/CIkvQeYhndpk2oDNdSw==
X-Google-Smtp-Source: ABdhPJz+JmjtP/rNpS01qPn31jBKjhcmz0scPpZbGA0wOOkM/QXJpxUIqwxfVRzPugL1FZDgtzhWYyvOBl24MWLcZ0M=
X-Received: by 2002:a50:f089:: with SMTP id v9mr9080510edl.353.1607107287403;
 Fri, 04 Dec 2020 10:41:27 -0800 (PST)
MIME-Version: 1.0
References: <X8pocPZzn6C5rtSC@google.com> <20201204180645.1228-1-Ashish.Kalra@amd.com>
In-Reply-To: <20201204180645.1228-1-Ashish.Kalra@amd.com>
From:   Sean Christopherson <seanjc@google.com>
Date:   Fri, 4 Dec 2020 10:41:15 -0800
Message-ID: <CAMS+r+XBhFHnXrepzMq+hkaP3yHOUELjyc65JQipKCN+7zubVw@mail.gmail.com>
Subject: Re: [PATCH v8 13/18] KVM: x86: Introduce new KVM_FEATURE_SEV_LIVE_MIGRATION
 feature & Custom MSR.
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Tom Lendacky <Thomas.Lendacky@amd.com>, bp@suse.de,
        Brijesh Singh <brijesh.singh@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        venu.busireddy@oracle.com, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 10:07 AM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> Yes i will post a fresh version of the live migration patches.
>
> Also, can you please check your email settings, we are only able to see your response on the
> mailing list but we are not getting your direct responses.

Hrm, as in you don't get the email?

Is this email any different?  Sending via gmail instead of mutt...
