Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4902E93CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhADK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:58:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34790 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbhADK6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:58:39 -0500
Received: from zn.tnic (p200300ec2f086c001ffa80bfe662d8cb.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6c00:1ffa:80bf:e662:d8cb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A88571EC0266;
        Mon,  4 Jan 2021 11:57:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609757878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E5GizZkZaUZ0FWl5frthsoGdmpOhLMxMLt6FD0R1SWg=;
        b=r4NZohJmXs/qYbsHhlJFQ7ktoN+PmtbjkZ76Zj7sjkq6LzyLpsU/0C58patf0orbnMuhWJ
        x0LUx8Bwag8gNVSbpQ2pqwCpcW9knTj6tRNFuqIXOqOnKkKS2tM4o2LK/qJIeNONmHQKwc
        xWKS0/07f3cd+eytRN3YdUVFmbBpeq0=
Date:   Mon, 4 Jan 2021 11:58:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 5.11-rc1 TTM list corruption
Message-ID: <20210104105802.GD32151@zn.tnic>
References: <20201231104020.GA4504@zn.tnic>
 <e3bfa0a4-5d0a-bd68-6cc8-73db1d29f22c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3bfa0a4-5d0a-bd68-6cc8-73db1d29f22c@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 01, 2021 at 03:34:28PM +0100, Christian König wrote:
> Going to double check the code, but can you reproduce this issue
> reliable?

Lemme find a test box which can trigger it too - the splat happened
on my workstation and I'd like to avoid debugging there for obvious
reasons.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
