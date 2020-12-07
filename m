Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA32D1344
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgLGOML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgLGOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:12:09 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3EC0613D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:11:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so12902295wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIglN2ENPr7zZxCKU9K9FdFhtb6JGzaE8AjsYQ4PtZ4=;
        b=Xhc60KBVbnArBSefinJI+TleN6X7aSEsNC0tQlYENBG2ZPPq9HpuIQyl0v3s77lz4d
         NaMMqkGUk2Y6w0tvbOkQAG1I6KgVd7yT8Wffq4xZm8NRs0HSBoivHZie/1RGmt2n3epv
         FWlxQlQGrjPu/b46XKseWpoWCCzY5a8gSoyHbAKyk7rvq6JkalR11VCCD+mz9yo/uYLt
         /GNmeSpjO/bd11ul7t0LgHnVA+wEfaLMtlihFIarwy5Cyr5nU64+sqY0OE8VOWKzZlX0
         3JRdkzVznY/XSjGX9AlOwFk42GHr6PPa4BxCms3CvL/Valg4Rg86Mypisvmqg2JBHR3o
         XV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kIglN2ENPr7zZxCKU9K9FdFhtb6JGzaE8AjsYQ4PtZ4=;
        b=kkN4c9vNTEZpgESP4gF9LjLpGK84vNruGNYZYXLNVQI36Q9Rsd71kXnxDcEeDicZEt
         A61Cwt1eu76b17DCyywaPiy9yympb8tAyQ6FKvoanN1uqXtjw6siZEVzt/fX9VlGvF+t
         AsIXg7yfPCHTRRe+dGfCPo7f18kPbw9RwIbB9zXtiSWpjYRb5VWZW0FQF5p3i5INueL2
         pucIgTzmvQkB/k96Tg6R4rdjt+KylFbwyQUZDBGH5FoFNOkPoDdUjiZW9eRA93tI0noJ
         bhpbqCs+qu2D4IPikW7R6RuCi3k172njIJ78Eikjf7h5m2RXyhAgq/Vx9AQjs6Jttt+j
         VYdQ==
X-Gm-Message-State: AOAM530lPvRVsAMlaZsVqH8yZbbSNJHHyhjdTd8dl85XhMAofYNEB3fF
        yeA1+hcraheFyEUCoP7D53ctkA==
X-Google-Smtp-Source: ABdhPJwy02g4n9Bw93wn8robHfmfXCvn8HmKD427RxXtDweC+OQzf6Bi6J3mgHqERGzkgRm3qn05dQ==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr17832777wrs.398.1607350287293;
        Mon, 07 Dec 2020 06:11:27 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id z2sm3072994wml.23.2020.12.07.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 06:11:26 -0800 (PST)
Date:   Mon, 7 Dec 2020 14:11:20 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <X844CBNCTL4XT3iq@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <20201207134052.GA4563@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207134052.GA4563@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 Dec 2020 at 13:40:52 (+0000), Will Deacon wrote:
> Why not use the RESERVEDMEM_OF_DECLARE() interface for the hypervisor
> memory? That way, the hypervisor memory can either be statically partitioned
> as a carveout or allocated dynamically for us -- we wouldn't need to care.

Yup, I did consider that, but the actual amount of memory we need to
reserve for the hypervisor depends on things such as the size of struct
hyp_page, which depends on the kernel you're running (that is, it might
change over time). So, that really felt like something the kernel should
be doing, to keep the DT backward compatible, ... Or did you have
something more elaborate in mind?

Thanks,
Quentin
