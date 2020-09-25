Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18065278ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgIYQkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbgIYQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:40:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3012C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:40:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so2856653otb.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adS2w4MfZVtQ+JdOzVjFl88CdbAyPhM8+osYUFtdj/U=;
        b=m5NtFveSMLhfuRJGGdkLfEMup8cEopZ/jbnqb7UUZO0HMgcTV545eLiYK19f2Rtic9
         XnixmPOvGbambOL+DhjMVQ9mGnjHwL1P63lW23ZeaEO5CtuX7BJVAuDISt87ZaFzaqji
         +TQjVytRPzlc/f3cs+CnYLbe28QaWc/I3Y0KTEmvF+sQfXu+M9+G5B4+IG9tJkm66rVa
         LssiqNZHVitPn5b4xTv8RcqNDD6hXDLkYK1+zwQcydYyoFgi6iBfLBm8BNH2WMTlsoAi
         tCmQl5+2u9BjRUgBdaRT/uOKAwywJ/Qoc9DxSCWSzydl0lJh1NbwKzGeQbxoDOP7vrQP
         gOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adS2w4MfZVtQ+JdOzVjFl88CdbAyPhM8+osYUFtdj/U=;
        b=LguhcrptugL2yfjY1sHuRkVxbhYMcESV7sUDTLNJkNNAqXUp6iehaTFuhO6wq9sqzb
         yNb2tK0VXF3wOXPpbSxljBx8I+1rH8wy4Oc2wRvQERM2RRDsW72QlkNzUB589LekzZOJ
         EC24qHBy84VtsmQF4Wy2M116LLPJN42aNsCj/JPm7d4gKMTUTNbmF06JLPYnJzyLQBq7
         FRj4Y5SEP+JHmVc2q5Wno+mrsa6Z4U43HPz6BkcISy5aVBifYjbzwkeOWli3UvhOj8kJ
         GE/sb52F6KpYrcjJ82dFPz2uLUc/D/kVVPb0pTmSyh5cs0Uj+F+8yWctqMU6b+8pYu1n
         OrnQ==
X-Gm-Message-State: AOAM532gBVixJs26dmqG2+UDu1NbEkTzIJsPBRr8w1y6/R/LDM3Um2VZ
        4SUF6JAXVQkzARpLS+m0fULOfWvfZ6cHYSq2dse+6Q==
X-Google-Smtp-Source: ABdhPJy/QdDf8ZZphXLshFnr46sMAVEmrQ6ga42OUf0dnO02EpnX+XXwrzbC1TlH5wbcBksxHK3/H9KCAGjVDCAkWbM=
X-Received: by 2002:a05:6830:164e:: with SMTP id h14mr894858otr.56.1601052020022;
 Fri, 25 Sep 2020 09:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200925143422.21718-1-graf@amazon.com> <20200925143422.21718-2-graf@amazon.com>
In-Reply-To: <20200925143422.21718-2-graf@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 25 Sep 2020 09:40:08 -0700
Message-ID: <CALMp9eSDH1F70i=-3wrC55ipz91qygrsPtw7RL4iCi09A-Da6A@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] KVM: x86: Return -ENOENT on unimplemented MSRs
To:     Alexander Graf <graf@amazon.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 7:34 AM Alexander Graf <graf@amazon.com> wrote:
>
> When we find an MSR that we can not handle, bubble up that error code as
> MSR error return code. Follow up patches will use that to expose the fact
> that an MSR is not handled by KVM to user space.
>
> Suggested-by: Aaron Lewis <aaronlewis@google.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
