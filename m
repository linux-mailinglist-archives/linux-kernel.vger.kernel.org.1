Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F462B5438
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgKPWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgKPWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:20:48 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1097C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:20:46 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m143so20511568oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUgq39nfUV6cfcgfxfVRyyih0cIl6dnKtUhLRhxAR+8=;
        b=U/k3Myy9d4B9JeG1yp4ijBWOlH6ytTjS1YEOx4zdkJtETmgqKqNIPx6ZqFcFFJ9jRd
         c2L2mWUlTCFFepINyZ3ucBt3IZfTzyglFc3WgRNKApnVhzFLZKtRfctObxioosHL8q2u
         ImWhWOXgEwyzpS4tUSftvGsokGC+f8veDL7AER9uzzvJ5g8Q79eLC3PaSw9Lwf4jofmM
         TehjzoFP4TkqZE/fhHjOt+jXUTRHr61oSn5PZjvBsqo4DkHp/uDr8nHBk007+jCz72MO
         nArnZRh6/SG8S2cyBcrHH4pkmB0wW17tQB2Wmer/vmbL6tV0VXBb/mQJEqcM0txm1ipb
         FoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUgq39nfUV6cfcgfxfVRyyih0cIl6dnKtUhLRhxAR+8=;
        b=eWbmqU6Jtib9PokazwSg0Pd+jFfsKLUpYQSLpTZ5Z0PDzzPwGsm6liqBmY2tKFSnY0
         YE/L/VWvAywiq6pnx3KBeoM3OhLNOQvQF4IbCk1Rs0mG1IbjniepfsinSdirP/PC9jTI
         v0OoGhCDMBGHdJyd3/V8dVDlns11jmv/pV85n564+uKv8yjJh4kA0wPkgxD43qxwF9aw
         zUXYpVyuXh+04QVa0LjaDHkjCZihhipluAczHERB2+t+5UmXShAoZoM/3Qi1YIM/4EWh
         ZFpMOLW8zaDgshI7DFzXggLafJzFCWtMynI6I+u5wZfBsmg9hgjw71mQYzqg8WUx+Xe0
         C5/w==
X-Gm-Message-State: AOAM5319XNamSp9FGuzLkxyVogLSDZHq5k4iULUlCrR+SJHJbmnMimdT
        OiiE/hKwMjF/Ms1ELVEESLVQaaPfW63KB9pZoNKSTg==
X-Google-Smtp-Source: ABdhPJyUjM+zLt2B3OGBnxsT7ATpDYYTApVyf7TUQUwSWiRBMbbX4VyNvQFc3N2VqTVdbNJhynBKyBHhukmOezD6aQ0=
X-Received: by 2002:aca:4fc7:: with SMTP id d190mr579597oib.13.1605565245760;
 Mon, 16 Nov 2020 14:20:45 -0800 (PST)
MIME-Version: 1.0
References: <20201116181126.2008838-1-pbonzini@redhat.com>
In-Reply-To: <20201116181126.2008838-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 16 Nov 2020 14:20:34 -0800
Message-ID: <CALMp9eTT64a7A+A+KLz04q9T0_GQ7EaytUZ6f+fkRRdfaQTnzQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: check CR4 changes against vcpu->arch
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:11 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Similarly to what vmx/vmx.c does, use vcpu->arch.cr4 to check if CR4
> bits PGE, PKE and OSXSAVE have changed.  When switching between VMCB01
> and VMCB02, CPUID has to be adjusted every time if CR4.PKE or CR4.OSXSAVE
> change; without this patch, instead, CR4 would be checked against the
> previous value for L2 on vmentry, and against the previous value for
> L1 on vmexit, and CPUID would not be updated.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
