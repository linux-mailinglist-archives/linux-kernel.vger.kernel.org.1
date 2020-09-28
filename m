Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE6127B176
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgI1QLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1QK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:10:59 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAAAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:10:58 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so1981134edt.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSbjOkpOXa/SRNzUYaJC32SvSqb9G8e3qi87JReDiYc=;
        b=i+be8AIJwl8mLk0ZeQtg25l5e4K8bjRLO7Y4bvHYxsM9jdWRhhYd13bbuqqd1qDtml
         4W3i+ijZaC6+QmQodqW6d+u59gvdOcXbfmJ9Upfk+e513jAIkpNNjZNbtFcptfEvjnDw
         LA4rBujnIZKjFNT8Jb/WGEwcv7iZ6yMdAw4outujy6PxTJWYcTpTcl+j0ZdvOsKVSuxy
         UPHsQmTPtiHzvRq11ffEgYMwlA38C0+8iuTJgTILdeslE8Hp3GEfsm8u8lvZnw91s1qv
         uW7rN17+dob3i9cuZsXm8i1ZfoSh9AmSQIBgD3w5yaUG0UuO9doJ5UnWLBaa9hGvGyHt
         uPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSbjOkpOXa/SRNzUYaJC32SvSqb9G8e3qi87JReDiYc=;
        b=TR7LFc0ELv2zW50WqQo8/NPPoooxEXCtocWjvqMRUWLCY3vitzk1cCUhK8mP3234Nb
         R+1ezLf6EvF+QTC5/dAvJZOiZ8fIpKSXq3m1d7C/h+bjJ0Wq7CK8uX6E9qmS8P1o7PgW
         URR2YA7NP3gXsPE8yFBBZzWnfrQSEF0dpdQ7DeUzKmex0idfBAapPovZxj/3L36lsEEq
         RAKpbW3lhPlPskIR4E1KllgBLC61PcOHspOKMAAPBWCx7nv0siIgHS/csisuin926s1e
         fG6NS2O+Gj3o3qYsJAoD7RYo/Z2h8C4eANd18EIpXKcDaJaEYgjNko8XoTUxddJN91Y4
         yZBQ==
X-Gm-Message-State: AOAM533+Eb8CIxArS0jJxYMD3H+OdnIfwrjVTsDCMwq5MkBiLNQcqvqH
        YRuh5eWk0Dr5Hvy8JjolOxURsFj9gRfZSmTmZhiZMg==
X-Google-Smtp-Source: ABdhPJwYItVzot76ygzrdbjuR8fOpjHu0HmDjOzOQdO0BgKrxV0xWHbZ927LIgqGhMMC16072uc89SppgiT8bNfs5K8=
X-Received: by 2002:a50:e78f:: with SMTP id b15mr2661553edn.104.1601309456646;
 Mon, 28 Sep 2020 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200925143422.21718-1-graf@amazon.com> <20200925143422.21718-9-graf@amazon.com>
In-Reply-To: <20200925143422.21718-9-graf@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Mon, 28 Sep 2020 09:10:45 -0700
Message-ID: <CAAAPnDFwABBaviHFCspa7222=thJStAPK6tL8jd_2CnMsH--2A@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] KVM: selftests: Add test for user space MSR handling
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

On Fri, Sep 25, 2020 at 7:36 AM Alexander Graf <graf@amazon.com> wrote:
>
> Now that we have the ability to handle MSRs from user space and also to
> select which ones we do want to prevent in-kernel KVM code from handling,
> let's add a selftest to show case and verify the API.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>

Reviewed-by: Aaron Lewis <aaronlewis@google.com>

>
> ---
>
> v2 -> v3:
>
>   - s/KVM_CAP_ADD_MSR_ALLOWLIST/KVM_CAP_X86_MSR_ALLOWLIST/g
>   - Add test to clear whitelist
>   - Adjust to reply-less API
>   - Fix asserts
>   - Actually trap on MSR_IA32_POWER_CTL writes
>
> v5 -> v6:
>
>   - Adapt to new ioctl API
>   - Check for passthrough MSRs
>   - Check for filter exit reason
>   - Add .gitignore
>
