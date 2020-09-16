Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F826C92E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgIPTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgIPRrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:47:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E8C014DBC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:35:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so6909190wrl.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y0GHMsQrfoNkF8hoL5Nxc0+CH+Sz1FlZ4J0DpK8dO70=;
        b=OpOeI24LEAE+oDQATH8MdVWdt4mZNQ4qh1Hc0omlnt7RwHiPRKvJrLL01717FgPnnb
         1t+n+B6+mnQxwsOhc5OfAHt9THe5P9ok+08CnWZwgPJLemA4xraL3S0LRRaUFrd0nuU7
         yRKZjwxGHu2Xcb4i1Mdyqj+a2bvB9eJzXsEOa3kbquHPZTCRLg6PiXODmEUA6N/ezqtH
         WrdIqnvo6yMjPIgfbcKtYQzcIktY+hY7v3S3aaNBZGh1xFeC7rDf3IQUoCoKX+3JD4qH
         ShFWfgA8F0+G1Or4c6EbK0e67x7FvsJI33FROdF/TI1M6+2DETeMlQ74rxZgNY5SadWE
         gcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y0GHMsQrfoNkF8hoL5Nxc0+CH+Sz1FlZ4J0DpK8dO70=;
        b=p9bt5Id/zkZqZ5GLsVLUIkTLlfEmnc7WHDWbOC42HccFVWWujaBIS14l4KmdeoSo6n
         pk+qzwcGXi21BnR4wcmYfuNZjldzLAMPgIqAXSPdA4i1lL6AcepA8fMDuDWjBJ1Jy7+u
         xnKE5Ib31Oac6O6KqGOQNM1J9wI99X9gBcB4tSE9uYAEmfkyVK3cAZDKwr69mq+kOo29
         KTMQ5G2VC1MoL8C68djbT4Q23GuUO7wS9uG+WnV8jZmEm4Ex9FsvRS922le1qvJko9OZ
         q/IftDDQkJgIA3qz4//KY7lvfO+oylLzTexpHQKAmjMyYG7yVbCsTR+uNPf6XVNudBZ0
         DGNw==
X-Gm-Message-State: AOAM531BrSJmxejQW0s5pKRWKZxyINJErgfiJcuy4lhGWBehPZ+X5qOK
        /3vTKT6uAJHVpwiN+eL1KV5pZA==
X-Google-Smtp-Source: ABdhPJxj1njKOkMy/uGBtiswR54WhjIWwVc4v6yTTlieFUIM6NmtAP4wvPkgHYBaLSDHrvMxwMPqPg==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr4416951wrs.395.1600263306480;
        Wed, 16 Sep 2020 06:35:06 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id v9sm37780715wrv.35.2020.09.16.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:35:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:35:04 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Andrew Scull <ascull@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 10/10] kvm: arm64: Remove unnecessary hyp mappings
Message-ID: <20200916133504.7v5j7y5ccajw2a7s@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200903091712.46456-11-dbrazdil@google.com>
 <20200910140738.GE93664@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140738.GE93664@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	for_each_possible_cpu(cpu)
> > +		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
> > +			per_cpu(arm64_ssbd_callback_required, cpu);
> 
> Careful with breaking allocations across lines, that seems to be taboo
> in this subsystem.

Happy to put the `ptr` var back. Sorry *embarrassed emoji*.

Thanks for reviewing,
David
