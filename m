Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94F2C0DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgKWOkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgKWOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:40:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33696C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:40:00 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so18089728wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IA/qfqyOklQJ79pqoG5f5P3U9Ipwq6yHC17vWE58tNA=;
        b=dDlg28P+Jh4WcUUlhAaq1JtPUuluHcfx65ApOfbVNU1dBa9Ao9nNN3oqUjtpo4n2RL
         bs55n7JhmPAMJu5SsUcgF5jAQujYSTMh3gIGsli/knyqFXfi7M7MHR6GJcRTuLW1hAKj
         oDL+sXKgB4ohn7ghXtJVILlso5bwoVTIprgaJOATeg0t+sdmnK259j0WIEcZaUoGG5zI
         nGNhrjlStyWjlCeEriRzGA6e4f5MMBCusLNYE6yOnGB6KBQe2TBnq8tpOpBVz7OwN/0P
         Xo/FufSf0lPAAyfrQoasy/ymA8ZPqtqL8xuT/eBCyPxzhzqP0QRTuj3y7WyhXwzCkLGN
         5XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IA/qfqyOklQJ79pqoG5f5P3U9Ipwq6yHC17vWE58tNA=;
        b=Zotoj9Olfk/RpcJBphReSDhFpTPn4DOvvaO6PV1fdJuy1juOuN2m0cmHO4UVIGD8ID
         aIt3fILh250OnDJXWB1WZ5xQqJGlikocGAoyNMuc7YJdOnlx2auNazCB8pDY+UVXrB3h
         wCZVAn7wKDztDOLpx3XJTFpcOLzJ1nxlMTPbGCE+Cn2t0yRRdeid4zMfO/CgeIzCm/l5
         MA3AHap7qhZXbCitohw5balB8vZjsRnzuM90zrv98T/Jh4rZbMyNblmUA+80PCPXB7Z4
         1hhWVC96uYNF65/k83AifAN6E2F4D7jFlgZ5BjIwCa9F8MQjCIaNpJ4QN6nVRef6dCVl
         +k5w==
X-Gm-Message-State: AOAM530bguWYYbtPMqva73y2LTC2PgPdJ37pYiiyewdBX6LVVeS9sB6N
        EtHA5ZQWN9cof47LOWZ1yQTfWQ==
X-Google-Smtp-Source: ABdhPJzKkhqMWPHaBtD6XLWKHtSpwRHpjKsbcwlUiF4pqtF3mjusg9s7MoY8/c/6bW3rqWv2KFWqkg==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr23864861wmi.70.1606142398827;
        Mon, 23 Nov 2020 06:39:58 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id f17sm17235287wmh.10.2020.11.23.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:39:58 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:39:54 +0000
From:   Quentin Perret <qperret@google.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Subject: Re: [RFC PATCH 13/27] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <20201123143954.GA578849@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-14-qperret@google.com>
 <20201123132223.oohevce4izuoaqi3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123132223.oohevce4izuoaqi3@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 Nov 2020 at 13:22:23 (+0000), David Brazdil wrote:
> Could you help my understand why we need this?
> * Why do we need PI routines in the first place? Would my series that fixes
>   relocations in hyp code remove the need?
> * You added these aliases for the string routines because you were worried
>   somebody would change the implementation in arch/arm64/lib, right? But this
>   cache flush function is defined in hyp/nvhe. So why do we need to point to
>   the PI alias if we control the implementation?

Right, in the specific case of the __flush_dcache_area() function none
of the PI stuff is really needed I think. I did it this way to keep
things as consistent as possible with the host-side implementation, but
that is not required.

I understand this can cause confusion, so yes, I'll simplify this for
v2.

Cheers,
Quentin
