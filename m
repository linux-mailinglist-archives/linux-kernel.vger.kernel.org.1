Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC72E76BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 08:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgL3HD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 02:03:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgL3HD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 02:03:29 -0500
Received: from zn.tnic (p200300ec2f0ae90058345bc89b9c20d2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e900:5834:5bc8:9b9c:20d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E357E1EC04F0;
        Wed, 30 Dec 2020 08:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609311768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IVIq9v7uhd13qBpMQD16SmyiUO8UUvqpILGYkZ47HJo=;
        b=jq3k8zvDtJx6/tM/0+ZBgmlGDufmiW5hdO4HCuUJymq1D4Rabnx9CJMwz/OkGeCrPTJqqq
        dQVpIuosWm5FRr4E5snOgvGaJsrqLzdIgV0akYeADZppnBBQczJSwEZ8awF8gGCFXStV3q
        UiRy1KBwaTCCRMS6Imljj6Doo4kzQFw=
Date:   Wed, 30 Dec 2020 08:02:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, zhongjiang@huawei.com,
        joe@perches.com, konrad.wilk@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, iommu@lists.linux-foundation.org,
        dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org
Subject: Re: [PATCH] x86/iommu: Fix two minimal issues in
 check_iommu_entries()
Message-ID: <20201230070244.GA22022@zn.tnic>
References: <20201223062412.343-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223062412.343-1-zhenzhong.duan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 02:24:12PM +0800, Zhenzhong Duan wrote:
> check_iommu_entries() checks for cyclic dependency in iommu entries
> and fixes the cyclic dependency by setting x->depend to NULL. But
> this repairing isn't correct if q is in front of p, there will be
> "EXECUTION ORDER INVALID!" report following. Fix it by NULLing
> whichever in the front.

When does "q is in front of p" happen? How does it happen?

> The second issue is about the report of exectuion order reverse,
> the order is reversed incorrectly in the report, fix it.

I have no clue what that means.

Plese structure your commit message something like this:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
