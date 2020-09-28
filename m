Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5327B27B15D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgI1QGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1QGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:06:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6399C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:06:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gr14so9349771ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o71LzbqX367JaJH9ttdwJUvGzrnJxktn3m8pbVRAwzw=;
        b=fvsDnXfKUBOAXccBDwFSPn5D6Csgk0G1mHyAUd74eUxAq5zR8163TbnodrFpDHFksK
         q2UiyDX8dhCNVWDabaAhGk6xzfG4SXk1cjcB+qzfJ7yDn1xhigkN52Szo+wj1QDppJZy
         SQIg1zSkc4EsBC+GeqRxR6kysSFmHW8aanRGoDDPzu+9MkTBuf1hXhNNXN+d3nIR/hOU
         1p+7sGA15/ttgAVlsAnYSh8fZUQuiNAtvq8tEXBc7wT+Dzt+eNRle4hU6ePzLCSiumPP
         94zV7qksW3cZEgcTnZWteH9J53JSPSP4z9MrIiYAh1NbGG9saHFBAmXyiozR7L2/MR6P
         ARaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o71LzbqX367JaJH9ttdwJUvGzrnJxktn3m8pbVRAwzw=;
        b=qGWcJXeHWMj9cr2XecBUdtvdVBIcYVPzteHsjS3EfdPsY1gH4GuQj9vuf8cO6IrZ5j
         A4wklaAjh0bivklmNIgvOaM8Xie0VItHAQgWt9HAkkLl7BPLucRaZFnBhxEY3RN5O4MV
         CsuV5g6nNywm6v/cJ9FQqaG90OeMM4RGp35vFZ4fizZNGrh5ih5CGZztLBvJdE1ZeqEw
         1GZqA140iJ0/t9r779mtUg3yILUewKLYYTvqaGQAVuwx5MUsd6E6UN1pysV01LABSVJw
         Oi+dzUh38/8bwuZE0BH6ltcSrg91DkFniMUDKTtM+cKfnixIn5tqAHnoUymzUhKfFtlQ
         qJcA==
X-Gm-Message-State: AOAM531KbkvfhtO7v2muqJdgsbpRlq4eAFQHaxdKBeADII0h9c0yfwp0
        USB3mgCwuWESmmezULP8AWEm5VVAbRVwUByfAB9/Cw==
X-Google-Smtp-Source: ABdhPJwqh8E0xHjHa+dXhoJEb6VW08INWmr1q9wGgTppwWtMYPE+FmoLDTQjTf5DzUZYK4TAiqHPx/WYKmjPD/totDw=
X-Received: by 2002:a17:906:3e08:: with SMTP id k8mr2297800eji.480.1601309169232;
 Mon, 28 Sep 2020 09:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200925143422.21718-1-graf@amazon.com> <20200925143422.21718-3-graf@amazon.com>
In-Reply-To: <20200925143422.21718-3-graf@amazon.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Mon, 28 Sep 2020 09:05:58 -0700
Message-ID: <CAAAPnDGVKDvVRdDK8yUzqXHzWzFK_9tnbwdmHkwbgcVb2wU5aA@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] KVM: x86: Deflect unknown MSR accesses to user space
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

>
> This patch adds a generic interface to handle WRMSR and RDMSR from user
> space. With this, any future MSR that is part of the latter categories can
> be handled in user space.
>
> Furthermore, it allows us to replace the existing "ignore_msrs" logic with
> something that applies per-VM rather than on the full system. That way you
> can run productive VMs in parallel to experimental ones where you don't care
> about proper MSR handling.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Aaron Lewis <aaronlewis@google.com>

>
> ---
>
> v1 -> v2:
