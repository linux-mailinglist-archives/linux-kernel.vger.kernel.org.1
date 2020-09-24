Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A539A277B35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgIXVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 17:48:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1080C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:48:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i17so588798oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xArRoyeelIzIpNPDluLH6f4v8ePnpcjzOS5A48X5f0w=;
        b=B1c1WtVgsgU+MU3gEbQZPChT6adeHIhecNeka1JLXaUzoq0BXKK6voV7J3yMjvDc3w
         W8FkWWtmm7ybExbABw2VDoq98F8IwlbYqi2NzPeII1Ze22GI73Y9s7ij2QiHzg0N/aJ1
         QY54dKwVGA3U7o6oEAtEnMwD8sI/tL67pyuD5uR7QV9o5ilXb7tkYGOSjY5g4DkyNpmT
         Sk4qtSIkJN9RL603u9flAL4etYSqafBnu8XJfpvDQzRo9E32QL3rCbl10zoBzYg2z4uo
         RQeqvkawuD4pN0PaDpCU0Y3HsW1xVlDL6aQmbIv+l00cTI1gwkLVa8hQZPR4CKfmqg2g
         spAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xArRoyeelIzIpNPDluLH6f4v8ePnpcjzOS5A48X5f0w=;
        b=A5ck/s3qUGWNLVsgSE7bHEV+Kh6lBkOKPTlxrN61HoGJKc02P8kAwXWDIBwWdsWpge
         Xi9ehAInqRrBYVTxiIO9OtMOcnd1cyz363ICq3ktLBQdnnFtzgYrr+rq6BjeiGTHUrIb
         P9pGm6E02A0M7ZDXLR5pMzgiqUz2UPFZ9ekTlKgVTn21JtndbRZ2ZFXexqloqrvMvkph
         qBbLQLMxjv1+QL5HcReSdLv4wbQLi7PLTQQnYgX9DgeBF3cLSXi0YK3qP8UqgpbVtccP
         /+5rkOa+fj2sUBbw/TsdVYydxGuh1VBaAN0JotW2nlVAPbdSiu6Zz92GD5EumedlZat4
         tOKQ==
X-Gm-Message-State: AOAM530MHYhA2Jvd8Q2wUcKqypz/LLQc1I9zJUvPn7bCjVH5pYbZ7phZ
        +vjAuUOSmzAPBKu9QSEX3MF5gfz20PYZOeJN/G+8XA==
X-Google-Smtp-Source: ABdhPJztT6apWUYRoRTm4fBFbAB4wIE8562b5j+yIz6Utz/Sx6C0LjkYbxRe+JXOxzPTM162lBmpFXrUPmbGHgDv55M=
X-Received: by 2002:aca:d9c2:: with SMTP id q185mr527387oig.28.1600984094899;
 Thu, 24 Sep 2020 14:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200923215352.17756-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200923215352.17756-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 24 Sep 2020 14:48:03 -0700
Message-ID: <CALMp9eQzZmV5k6qjHZgJYnKv3c7VPB7qEDJRLREW_NNUo=H1zA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Reset MMU context if guest toggles CR4.SMAP or CR4.PKE
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 2:54 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Reset the MMU context during kvm_set_cr4() if SMAP or PKE is toggled.
> Recent commits to (correctly) not reload PDPTRs when SMAP/PKE are
> toggled inadvertantly skipped the MMU context reset due to the mask
> of bits that triggers PDPTR loads also being used to trigger MMU context
> resets.
>
> Fixes: 427890aff855 ("kvm: x86: Toggling CR4.SMAP does not load PDPTEs in PAE mode")
> Fixes: cb957adb4ea4 ("kvm: x86: Toggling CR4.PKE does not load PDPTEs in PAE mode")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Peter Shier <pshier@google.com>
> Cc: Oliver Upton <oupton@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Thanks for the fix!

Reviewed-by: Jim Mattson <jmattson@google.com>
