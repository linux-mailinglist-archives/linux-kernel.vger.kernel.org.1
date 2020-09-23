Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F2275E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWRLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWRLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:11:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCBC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:11:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so410879ota.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeiiwT7dy9vr47NT7pjgw3junlFoaewgeW3zaJFROxc=;
        b=MOOek79ve9vzTaguN5u3sFjj6RpzMp50NMX7QWqg0Lk4d8RcOjM6RaMKlzDHuRABH3
         MUhXP6bhNQdR92GEz3GpiYSEqov/Oqio2do2XMDvZRGxhYAa1hxaeYCLpiVjyYEmWXr4
         nUEfZZbtO9aA3xwO8E7fqw5wQ4cXpt9PZQaUiYobNhx+8FuVSzeAAJ1O9QyI8fXYrXRE
         IkpSnZSR0CMZecb4RxN7bQxlwWTMFIxBX6g3gJiXZCw3hiSJE+gM1fIVWRCEuLCZf6jI
         FgEiq9pBdMyYG2I8qeh0hP3XwWPgeodZWALYweUhN61lWPNDpk2sHb3pxxqmfGYfJ6qF
         vEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeiiwT7dy9vr47NT7pjgw3junlFoaewgeW3zaJFROxc=;
        b=hTsKuApk+d8yndd+p5qh2UpIGtlWkMJNiGO+6atqDae390YwBAlhZV8gt37W9WIr7P
         gU2TKQCL/6IzU16TT/Pw5mwoiN3BlFRaEY12mwfSVWi8RnoslEVL5xweOGvl1Za5zmCT
         X1t+zQpsikziRKTGziswp4IWB1lY+0gynpzBSLJ0AgKpw+/XUpe8imhwlZeshg6L9X3o
         RwHiCQjyekuil/Eux3TL0rnjcyrfN2tv3xq9TVzSdbi9zeSxa4kl3BZuPugayqzHjGeW
         LY1zQ96jshJyhuONHJUERmXGL8cvOV5C6J0Am1dkk71HHHyBmgg/HgXo6PIGN/cZTq4t
         yyeg==
X-Gm-Message-State: AOAM531Qct8aiJf6hEfo41ZuYflYCIi9/qR0AcUatJb9LcBcXJcZoJfK
        eNqE7yyWzMfi57TBXdNbj9ReCmcnX+t8dwlbZyJiQw==
X-Google-Smtp-Source: ABdhPJx5OR2uQx762PlhO9GISWKgmk9r5adzY/TBnwRBxompVlbmsXEaVkIVD5Jof3LIYLoh6MZ1+WHFU0pzsbOmBcU=
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr435591ota.241.1600881068463;
 Wed, 23 Sep 2020 10:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200923165048.20486-1-sean.j.christopherson@intel.com> <20200923165048.20486-4-sean.j.christopherson@intel.com>
In-Reply-To: <20200923165048.20486-4-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 23 Sep 2020 10:10:57 -0700
Message-ID: <CALMp9eR78C_3eYshQmHLJ8_RZuaP0MXCkYCNdVbxNfSW=ZN08g@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: VMX: Rename RDTSCP secondary exec control name
 to insert "ENABLE"
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 9:51 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Rename SECONDARY_EXEC_RDTSCP to SECONDARY_EXEC_ENABLE_RDTSCP in
> preparation for consolidating the logic for adjusting secondary exec
> controls based on the guest CPUID model.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
