Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB65B25396A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 22:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHZUzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 16:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:55:21 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:55:21 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h9so751654ooo.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+vjVAuISvnpGVRIwJiakR4nTwDap3MbktaNw6PO2bU=;
        b=mxPAPsoSvS+iXuLSu39XURXtyzceIfXa6bQoRMDO8sKWgaeiOVOSPIzRZogQ79Bmjq
         5GJDaV9RQ0UwB7sAjcx4nNDMj5rs7hoNY/LbPufGnv8YaL+1S1pFYjSYR6Yvhvz941lZ
         Vh/GOFmstnxJnCh89bN+/FClaZFKQh0kB/y3/j3skxgvJlGCTAJWaoiHr4uhuZz2brLw
         wl6RpSH/Nlg0pFEtBo0BkleEdGbYkFxRL7/FG9V6Bkjsb21pvofcAN9kuHHe2evBPcxm
         QZb2fiPqXtfmbmDBuNpPK4BOESOoNuX8AyM/D33vIXIrhS7+feVAd7WCJvG3JMY/K5oF
         L9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+vjVAuISvnpGVRIwJiakR4nTwDap3MbktaNw6PO2bU=;
        b=m+6Pa0ZyaE1zsQ+0kBmiQz4ub7bveel4dH3xABNHgzdoEAVcjI1lsk0fD5iVswhOwt
         6z2YDvknRH8paK5B9a0eveu73JHsReorFsP8kSTpj1oSwz1n69cnKm7ZQTFUlPHfzmsp
         6cJqxPm3KYZHd6wPWTLezRpgru2XxVIN3iT5FGwDW5Dlg+T4CbRzC/ddq6bf5Ql5Syjg
         wvtHWjOUYualYu00wYTF8fQZM/exsOlHKfqirMQ1tEa8ORih8cGzgH6jJhJNg94BjgND
         QL5MpGhoxCBRid9vJFKPL2qY435F9HkdtpCQuDoKzPEELlD8YRa34pYuzXR4cOrzDyZ2
         7ONA==
X-Gm-Message-State: AOAM532hvQBq4GiDeUnG/dFeve223FZRuNkdsTp/4jocAe3hF2tjEhvR
        UrZwg7AA18qmZZg5KHnjpuGniufEO+tL2nf/GAX7gQ==
X-Google-Smtp-Source: ABdhPJz+8zGaxkZfSHOp4BWSIIplcgRi0L3opVhlk/A6WMyFoB8df8iUjVmpO+4hjMTU5MC+PWgpI+T2uKlCk5gWgqs=
X-Received: by 2002:a4a:87c8:: with SMTP id c8mr11875970ooi.81.1598475320301;
 Wed, 26 Aug 2020 13:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <159846887637.18873.14677728679411578606.stgit@bmoger-ubuntu> <159846925426.18873.12673817778834207178.stgit@bmoger-ubuntu>
In-Reply-To: <159846925426.18873.12673817778834207178.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 26 Aug 2020 13:55:09 -0700
Message-ID: <CALMp9eSHVS+HmbYUMdRgt9gPQaWUGBHt_owDenPOz4+KiDti5Q@mail.gmail.com>
Subject: Re: [PATCH v5 04/12] KVM: SVM: Modify intercept_exceptions to generic intercepts
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

On Wed, Aug 26, 2020 at 12:14 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Modify intercept_exceptions to generic intercepts in vmcb_control_area. Use
> the generic vmcb_set_intercept, vmcb_clr_intercept and vmcb_is_intercept to
> set/clear/test the intercept_exceptions bits.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---

> @@ -835,7 +832,7 @@ static bool nested_exit_on_exception(struct vcpu_svm *svm)
>  {
>         unsigned int nr = svm->vcpu.arch.exception.nr;
>
> -       return (svm->nested.ctl.intercept_exceptions & (1 << nr));
> +       return (svm->nested.ctl.intercepts[EXCEPTION_VECTOR] & (1 << nr));
Nit: BIT(nr) rather than (1 << nr).
