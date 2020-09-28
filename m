Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C9627B16F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1QJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI1QJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:09:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:09:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q13so9288585ejo.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Up1q7Lh5lzvjFc9/cxHyzghr4+aFRynRiUu3dMieLtc=;
        b=Uk8bicKc4zth43BPspUYEp5dLDqrP9I6O6GUTRzrQdgvFiowxRu+Qpum0iEH89lrzV
         ActGx9oUnCYKSYEjzDdx6Fyw7ldZw9CjocNllVmDeKAhd4jl9TCZevDPCbZ2KVG9LAfS
         +l//B7TziMzVX3fnYFKx4JcSUVtoF0aG8lxnf78lyBDDp0eXgP4zKY00gyVEWsm3TwNH
         xZUtRXPvC1TXOtn4imVjVYKAUMNC5WIjKha7GLRg65lPknrirrpy7CxHqMVC+N09b67m
         gxREQXfrzX1wk5/oL2SRozU4OquNrNYY76K4OUPqs0kMeI92VH0Qe8PKJwuFtReA/WPP
         xBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Up1q7Lh5lzvjFc9/cxHyzghr4+aFRynRiUu3dMieLtc=;
        b=r+wCE/Bq98qq/3/JqUq/vpHwVeq4a6IH65PZ/WZev9645m3ZffJajHDKj2XaJladZM
         WT+NXpuqaupYrETIpowtyIVfCvFTWPdbTb3H+Em9h0cbXnNVzsDCGe2/Gl1xKaOyZ+60
         F+1MrlTjMqGXBDKEc8IhOhAPd+sKqJRgL1y6Bd6U2BHkDQS+iDQ/Bl2/VQtQXy0p8ObM
         fOr64J1/kD8t4Hi5BOudCcqrsDqf1n4OT3mqXC74YEpmxQnsEp6oHoVrl+CfZ547uxS8
         y3lGIsAAcQl21yy68IR4/yYZT52aqY9SZCq5Xp4BOimdgBgHyubSq81kf4c1+aRIRo7A
         oNpw==
X-Gm-Message-State: AOAM5311QfPDdzHWPPSMSwLUIj8G+T4nS6exXv/ULDLZngN8LyXNoDop
        QqM9aNC9+6qb4ucOxYP4UHGWLRAtCBX9FAvZP6HTRw==
X-Google-Smtp-Source: ABdhPJw69H527++mfTxIHdHujjdJNWdrx/lYVxW964jL5Na5DK0aiFgGyAWcvOPGRwcalQ0XRDMpA6pl0uffYHr5eMo=
X-Received: by 2002:a17:906:2655:: with SMTP id i21mr2279494ejc.511.1601309376000;
 Mon, 28 Sep 2020 09:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200925143422.21718-1-graf@amazon.com> <20200925143422.21718-8-graf@amazon.com>
In-Reply-To: <20200925143422.21718-8-graf@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Mon, 28 Sep 2020 09:09:24 -0700
Message-ID: <CAAAPnDGt8nk+wPyr-j+j713atv+xXoO0BjpMSFB+2NgWHPv6PQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] KVM: x86: Introduce MSR filtering
To:     Alexander Graf <graf@amazon.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 7:35 AM Alexander Graf <graf@amazon.com> wrote:
>
> It's not desireable to have all MSRs always handled by KVM kernel space. Some
> MSRs would be useful to handle in user space to either emulate behavior (like
> uCode updates) or differentiate whether they are valid based on the CPU model.
>
> To allow user space to specify which MSRs it wants to see handled by KVM,
> this patch introduces a new ioctl to push filter rules with bitmaps into
> KVM. Based on these bitmaps, KVM can then decide whether to reject MSR access.
> With the addition of KVM_CAP_X86_USER_SPACE_MSR it can also deflect the
> denied MSR events to user space to operate on.
>
> If no filter is populated, MSR handling stays identical to before.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>

Reviewed-by: Aaron Lewis <aaronlewis@google.com>

>
> ---
>
> v2 -> v3:
>
>   - document flags for KVM_X86_ADD_MSR_ALLOWLIST
>   - generalize exit path, always unlock when returning
>   - s/KVM_CAP_ADD_MSR_ALLOWLIST/KVM_CAP_X86_MSR_ALLOWLIST/g
>   - Add KVM_X86_CLEAR_MSR_ALLOWLIST
>
> v3 -> v4:
>   - lock allow check and clearing
>   - free bitmaps on clear
>
