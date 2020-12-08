Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B22D36F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgLHXeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:34:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbgLHXeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:34:02 -0500
Received: from zn.tnic (p200300ec2f0f08002eb81e5fb58e3a10.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:800:2eb8:1e5f:b58e:3a10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 95A421EC0541;
        Wed,  9 Dec 2020 00:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607470401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5ZNUMfRTS3iWTt1V1kV+gFvars2JRmFiQ9QSJSav1tk=;
        b=odEY2ikG3P7AiODunofgZ+MPbpDEQasOPwsTp3EQ13PrPWiwAV8ZV+m4AvDcFHEZxi/KSq
        pNrxKT8N5RwO8MJlQQHOuTSqywg38Qnu463dtTIvBnSAFMcchVvdKm4SRrTI4OHqtQQOj1
        PeR2/TdBF4hVq+wPIz7QzkTFU2ObPMg=
Date:   Wed, 9 Dec 2020 00:33:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201208233322.GI27920@zn.tnic>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201208222220.GA27599@char.us.oracle.com>
 <20201208230119.GG27920@zn.tnic>
 <6443B6DC-2C54-48E4-8207-3F2D88B82AC0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6443B6DC-2C54-48E4-8207-3F2D88B82AC0@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 06:27:39PM -0500, Konrad Rzeszutek Wilk wrote:
> That said if you have the time to take a peek at the x86 bits - that
> would be awesome!

Sure, tomorrow.

Good night. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
