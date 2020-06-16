Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9681FBB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgFPQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgFPQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:24:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F808C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:24:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o5so22552628iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHU5NIj28mFBazu9jdqEVaKFMbdsjaboVO1Xjcptaqs=;
        b=Y1c6FPq275I90ZY+g0ftWg5KQkd1D+8GqwaUSjZUJoK0rstULwyRaN4x6eKhEmbJjf
         QPQe+soc9cGuoZCFIWUcuUjIKN0A6zZtGWoGt1IQBgjs6lqQVlD7uNzNgKkp7lsEMKoa
         PSkh4qlK00BTuN2ZPq3YCVyjo3tbhyKXLxc3R/UFheQFEEi1h3HD7MsA936xUCEyWU9G
         IZumGTqJ3lTToH6U4GoJv1Jh52/aet6V2cDzMIUdT3CgQvkp0fLLJNFNUjB61qpgY/oK
         Mfh5aUcbVRoZFWIndjuzoW2pK08ag7n6l7x/fICh+ZZV2ApZujcMyD0QG7IHCGnzZfdT
         MESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHU5NIj28mFBazu9jdqEVaKFMbdsjaboVO1Xjcptaqs=;
        b=idcAZmwjV1+x7Ije/7N1U7dd4u06DjtJuXAJdf255qV8tk1nP4D4QbeYaBMLfdw0VH
         GDTN7taKNnO7W+kqUvF7/gz3eK/crfdBorgHwzvzRHzVJJZajglS7LKzcSt+LzgdT3Pi
         MUFqYpCHPlcTvAqK63w7K2T8+DyW7fpMfOaTn3UzOLAXz4ftB6k0DExgwoE5L7zT7QcT
         wZhYqATxF7ReCp+Pw+tXAqZztgV4j8XKiNPzDK3jjaAeq3o7gD4uSrYZOEboLo8moTbO
         lxzFBMzreT5d2LEc9J2QRwImjXTskkrEz5jfVG4PqQarkCjDPwzcfoplV4K7OtIPBzV7
         wJBA==
X-Gm-Message-State: AOAM530J9vkuUjbhBLyWaVR2s7FHZA9f62lgVs4E3/KPgUL5CxVH6SIF
        XSxUIo2SoUs6eE9COZmDx17OoxewTS6FnLDEXxArbQ==
X-Google-Smtp-Source: ABdhPJz6daLARwINz1z8LOJd4TBWGCiIuoS7XuQTJSE+8zWd6pJytz4lbvrsJEBrFmTx9/LKJmuob4k32nzTsdscrnQ=
X-Received: by 2002:a02:3406:: with SMTP id x6mr26671587jae.24.1592324694558;
 Tue, 16 Jun 2020 09:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200616161427.375651-1-vkuznets@redhat.com>
In-Reply-To: <20200616161427.375651-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 16 Jun 2020 09:24:42 -0700
Message-ID: <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 9:14 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> state_test/smm_test selftests are failing on AMD with:
> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
>
> MSR_IA32_PERF_CAPABILITIES is an emulated MSR indeed but only on Intel,
> make svm_has_emulated_msr() skip it so it is not returned by
> KVM_GET_MSR_INDEX_LIST.

Do we need to support this MSR under SVM for cross-vendor migration?
Or, have we given up on that?
