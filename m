Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD862D4ABE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 20:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbgLITow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 14:44:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387936AbgLITos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 14:44:48 -0500
Received: from zn.tnic (p200300ec2f0f480094b14cbb76d70e52.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4800:94b1:4cbb:76d7:e52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B24C41EC0554;
        Wed,  9 Dec 2020 20:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607543043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=clZvtADPHLsnbhIEOKq+ZZYNEVnzxTgG9yjyoKhNTw0=;
        b=kzI0F107nxnZfGWBmCmsUwN9Slp0hL2W3106LtLwPhG6sfJ7Q+aSz+T5RF66GWL8EU2zy0
        N7pWEw46bLEwl7UMJvRApAfnRJP2l+kiW4R1/f6hS1DwG6KA+9q68TXiN5sujZUo6Fc9Zk
        zmHQmfIINJ9Wk62Aj5nfpEVhs3dTo70=
Date:   Wed, 9 Dec 2020 20:43:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jon.Grimm@amd.com,
        rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201209194358.GA20638@zn.tnic>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201209110115.GA18203@zn.tnic>
 <20201209122907.GA6258@ashkalra_ubuntu_server>
 <20201209125442.GC18203@zn.tnic>
 <20201209131946.GA6495@ashkalra_ubuntu_server>
 <20201209175105.GD18203@zn.tnic>
 <20201209193416.GA6807@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209193416.GA6807@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:34:16PM +0000, Ashish Kalra wrote:
> This should work, but i am concerned about making IO_TLB_DEFAULT_SIZE
> (which is pretty much private to generic swiotlb code) to be visible
> externally, i don't know if there are any concerns with that ?

Meh, it's just a define and it is not a secret that swiotlb size by
default is 64M.

Btw, pls trim your reply by removing quoted text you're not responding
to.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
