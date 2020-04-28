Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E321BCF33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 23:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgD1Vzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1Vzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:55:36 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25CC03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:47:03 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so400495ilp.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76NwtcJFolRpkssepMqzzHW6HjfTr+1YoDKxexuV45Y=;
        b=MPCuda/sCllNWtDmaB2Z8BpFCPmPYapCKuY71j1CJ3zJn0c1Rh5QkHwgW2snCRZsgp
         HV3ItMCtbPp9p14VV+dchHw5H5QSxUNJwE7Ay+0fRQnxVytV3Tf3iYlUKDVhSIzdc4va
         /snaOKzBHe5dUgseXI6IqCnpJsPLz6pHO3JSuSX4QcLFVh9hdKUROM+2O/V5D934uP3Q
         rbd7adUyVoUJ2VaOqvxbiFbItcLHKxAUtiAbwP8yhyWXrYoC6UEzX5YUrnD1c4Jdd0KC
         FiNNuvnN0PSPR0pRrcjM+iOLTmEysfF21xRQbwcnvZkLW0ucwG8cTFH68TRnhzDOy/Qf
         gJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76NwtcJFolRpkssepMqzzHW6HjfTr+1YoDKxexuV45Y=;
        b=jda70hjDoz3ljNTrvmEAp8IVXtc1tgVvnw6g+JvUcvdnPq2t6id5f5/Uo1r5xSwHkB
         kspLwH2AIe2a7L8COfYpPM5tFPLAoQN58FKWTnUx0RokvvnUYhnsq2zaelFjMFIUCRu8
         GqdZuX8pb+PYppW1nKpQnY1viG92rR4j3CYkOdrkvmYgEguUsB8RlG/nOTlkh4XQ3/fV
         TFi0EALqHbNGXlTbmOEgt+OqmhmdLD1n+dqhOxPEetEQswwTvQvEoRqVFeiOxcph2rZK
         DV34H5r8kJwH/H7ESg9KKlonmbQUKKMGIhVssqn+1hRJLzwDDouNFUML0+XEjRYiZ/fE
         iX9Q==
X-Gm-Message-State: AGi0PuZfIhTabpjO1fml5+TniIcAe+0k+7KgKaXgsJT91fr0OrLUG0/l
        K1dwgpU44fCpuJ4NlxN1wFcfgjh1qFkZDLiTLwZ/6g==
X-Google-Smtp-Source: APiQypJBobtGHzmKTfOmqkB1rhDOoIuXbsBLejVtVlTBZageEuCay/mjHv6SX62C34lGE/3iCsJIY5BzlgGxahZuE1g=
X-Received: by 2002:a92:da4e:: with SMTP id p14mr28469010ilq.296.1588110422235;
 Tue, 28 Apr 2020 14:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-7-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-7-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 14:46:51 -0700
Message-ID: <CALMp9eTFm9T1b66Za2BXxUhZmNRaXNjid3RJ3YMLmg68imx6=Q@mail.gmail.com>
Subject: Re: [PATCH 06/13] KVM: nVMX: Report NMIs as allowed when in L2 and
 Exit-on-NMI is set
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Report NMIs as allowed when the vCPU is in L2 and L2 is being run with
> Exit-on-NMI enabled, as NMIs are always unblocked from L1's perspective
> in this case.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
