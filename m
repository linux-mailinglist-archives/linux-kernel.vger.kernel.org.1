Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087C52D1D61
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 23:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgLGWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 17:33:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49088 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgLGWds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:33:48 -0500
Received: from zn.tnic (p200300ec2f0a3800f6520bb83eb81f06.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3800:f652:bb8:3eb8:1f06])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E73401EC0391;
        Mon,  7 Dec 2020 23:33:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607380387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QS7Xejh7Vaqx8FcuZLbicDhbx/3kJCtRN7fq17mk+3Y=;
        b=F0JH38xYZz9/1hpB7ZM603llmBV53eBbd1xiJXWFPSAXoD5nS1n2M4bMnCPOVndnbDG820
        I4TecqnmX2S1GXKXg6X+N96GYugcJNcl25qjrol9d7KeTd1/7CEJxKOfQyQ/FbP0M6wzLE
        bO9TiG8CduVlGlf1z43noJfpucCm4sc=
Date:   Mon, 7 Dec 2020 23:33:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "rientjes@google.com" <rientjes@google.com>
Subject: Re: [PATCH v7] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201207223307.GK20489@zn.tnic>
References: <20201203032559.3388-1-Ashish.Kalra@amd.com>
 <20201207121007.GD20489@zn.tnic>
 <20201207220624.GB6855@ashkalra_ubuntu_server>
 <20201207221433.GI20489@zn.tnic>
 <60FF61F4-9A7D-4467-A148-2956903C74AA@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60FF61F4-9A7D-4467-A148-2956903C74AA@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 10:20:20PM +0000, Kalra, Ashish wrote:
> It is more of an approximation of the earlier static adjustment which
> was 128M for <1G guests, 256M for 1G-4G guests and 512M for >4G
> guests.

Makes sense and it is better than nothing. Please put that explanation
over the 6% define.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
