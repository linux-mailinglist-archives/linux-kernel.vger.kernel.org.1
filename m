Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515192D6BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbgLJX3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbgLJX3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:29:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3FC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:28:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 11so5677618pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CSt2FPKXtDQTYvs/cAS/t9n4d8NBaXGUQAaM+p/qblA=;
        b=rbTnfKoJCPQv5YrR8jiywKYAw6yNxzB5OGt54Suax/v3IwCjdbe2y9TeXPoDqQFjEI
         RrApWRXo3poxoacnjx30GrodOOetTNe9j0GfqfLceY3SRCOjIO7ZXeIzujWHtcjWrqgH
         IoSs4e0U8DDoqFoeDeT9XszgsQUyiLWFcYJqzdUOfPifGawBI4JX5raHrt1mwmQJVJJJ
         YM9LkcEGmlb8nSFyh3MMxqiqheWtT3szjtL2BezfUKXZvS52VIpeWlGeY/D69fLibcov
         IH2tWxPpnHUYIgW/mlJulN6jkb6XF6BhZkK67CbWJOBQVRMB2nBWtHiuxcThmK94VOL1
         Cdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=CSt2FPKXtDQTYvs/cAS/t9n4d8NBaXGUQAaM+p/qblA=;
        b=rIBzEJvoiRH+eQAE1Qx63fm2SYOVPhrIjuO12ALg1GsjIHiTiX2shKc+B2ZaKDyaeb
         Rl5FhSJXXCJeeZacnc3Ex7dwdUX5wbTw37epQSly7GZs4knC5Vcm9jhHeOZmDBAdFgAN
         5aKxldoo/HkPrxfkbBbN7fNn5JtSIpMeW9Yao1rNiNFWfck9CTwm28SOYl946HiKf3xw
         /1pzh3Y6A33irk2q5hh8mrNQXwwstVW02Q2sxY9DIUG75hYPbP2HtZgyOiETizziNwzr
         fmrCTuLPgpVTxO/OcZygzSAVwRG845lJRC1tYnb9YDG8GvHJ/EXMbDG2ATyTi/ETCrk8
         tiYw==
X-Gm-Message-State: AOAM5338wtBXz/qqYrpTdbtjLeOOTMgnUyXAMrvHwbZAfEvdzf9BwN63
        HAx9I07V5e2pBjaGaTuYGxDB2A==
X-Google-Smtp-Source: ABdhPJwFmOysqtEYH7lJTFtlxPjQzlHC4tPd1ANetiUdf4c0a/EEDaOb7x6HYq2n3bdzbGfoUg5P4A==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr9917082pjq.21.1607642922731;
        Thu, 10 Dec 2020 15:28:42 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e31sm7308677pgb.16.2020.12.10.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 15:28:41 -0800 (PST)
Date:   Thu, 10 Dec 2020 15:28:41 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
cc:     Ard Biesheuvel <ardb@kernel.org>, kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] KVM/SVM: add support for SEV attestation command
In-Reply-To: <78e18a3d-900b-fac5-19ca-c2defeb8d73a@amd.com>
Message-ID: <e47f69b2-d4ea-1db0-aa13-729baba45b46@google.com>
References: <20201204212847.13256-1-brijesh.singh@amd.com> <CAMj1kXFkyJwZ4BGSU-4UB5VR1etJ6atb7YpWMTzzBuu9FQKagA@mail.gmail.com> <78e18a3d-900b-fac5-19ca-c2defeb8d73a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020, Brijesh Singh wrote:

> Noted, I will send v2 with these fixed.
> 

And with those changes:

Acked-by: David Rientjes <rientjes@google.com>

Thanks Brijesh!
