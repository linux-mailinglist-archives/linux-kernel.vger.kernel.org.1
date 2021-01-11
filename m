Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C272F2479
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404401AbhALAYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390873AbhAKXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:01:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BCAC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:01:15 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q4so318696plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOPKNqy/+sbhY4IEndRdEvmmTtUbPEVweZlVM1PfEvA=;
        b=u44tO9OPlRjZKL3SImVA+n+tnToeXY8svGWzY7PZRxycFVDlgThBGHfjLOEGNnmbKk
         755WLEqRgzjpX6amRZYWGK+0KW+G2NuKzN0x+z8nwI+wJSs2sUHkOaPk+5j+S43ZbH4S
         jO12rEV09tg44ckeIv/BCZlhlg/41ujryuV40F5vYIciL22M6Xqq3vOYZ3SG3Pe4qUJA
         3w1pFpKebNtQt3sua/ByHE6jRMybltvhJsptyZ9Ku/aRQ6aOAXxZ6E4l0XF+8FF1DT5V
         MlOo24QPNzNYoKaF1VVIvORd3ZYcHJ0g18wZu7S4rBZaWSIaajHeBAVGJ5MZg30ceJcG
         uHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOPKNqy/+sbhY4IEndRdEvmmTtUbPEVweZlVM1PfEvA=;
        b=uK4Q5j2x/9U7vSF70hEQyYhyh2Q/aEBvknq3A4Udqt1hALdlsOmWV2nNrDGz2vho9x
         uIHQQTnUzT+jLBG85zPHR782DmBbg20JU5J0z95A9Dsd+EzjenkdOffC49Thhxneuky2
         d+vaU2HKZXuVj5nRbNCzynBBZt5mcgF/aXH18uOlEw1LxxhhHjPhXlapsQzc1nycOnOt
         NoSOMA+ylO5EoezAo14y5YA9cYRbhSDC8IASsYmNJ1PHmWWlqwUUkzfaVVJ2a6X4ro+N
         IPmxpLk/39TteyGLX+f2dQs5hKw+jo36BYxhdxmD+WlVw3cGsYzrWwBDXIDo53tMf+4i
         Y3SQ==
X-Gm-Message-State: AOAM5314lX97TRl3O2PF/ONMLj2ZgiJqPs1ur8nDO9hG1UKeCeaPIrM7
        5beIs9Yi3T1ebieIQKjlyjrAyeSZ0wG9uQ==
X-Google-Smtp-Source: ABdhPJydGNoJGAYJDTyPYiciKOeziGNqWQ8xAXi3qDj10yzGvHULOj/oIrYKIDIkcVFI4Ri7PR5gYQ==
X-Received: by 2002:a17:90b:e96:: with SMTP id fv22mr1198135pjb.92.1610406074679;
        Mon, 11 Jan 2021 15:01:14 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id a29sm689291pfr.73.2021.01.11.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 15:01:13 -0800 (PST)
Date:   Mon, 11 Jan 2021 15:01:06 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     syzbot <syzbot+e87846c48bf72bc85311@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in kvm_vcpu_after_set_cpuid
Message-ID: <X/zYsnfXpd6DT34D@google.com>
References: <000000000000d5173d05b7097755@google.com>
 <CALMp9eSKrn0zcmSuOE6GFi400PMgK+yeypS7+prtwBckgdW0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eSKrn0zcmSuOE6GFi400PMgK+yeypS7+prtwBckgdW0vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021, Jim Mattson wrote:
> It looks like userspace can possibly induce this by providing guest
> CPUID information with a "physical address width" of 64 in leaf
> 0x80000008.

It was actually the opposite, where userspace provides '0' and caused '63 - 0 + 1'
to overflow.  KVM controls the upper bound, and rsvd_bits() explicitly handles
'end < start', so an absurdly large maxpa is handled correctly.

Aleady fixed by Paolo in commit 2f80d502d627 ("KVM: x86: fix shift out of bounds
reported by UBSAN").

> Perhaps cpuid_query_maxphyaddr() should just look at the low 5 bits of
> CPUID.80000008H:EAX? Better would be to return an error for
> out-of-range values, but I understand that the kvm community's stance
> is that, in general, guest CPUID information should not be validated
> by kvm.

And rob Paolo of his crazy^Wbrilliant bit math shenanigans? :-D
