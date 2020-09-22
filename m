Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78705274443
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgIVO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:29:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34438 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgIVO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:29:12 -0400
Received: from zn.tnic (p200300ec2f0bfb00bac1eb742b9d4935.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:bac1:eb74:2b9d:4935])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C119B1EC026F;
        Tue, 22 Sep 2020 16:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600784949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSY0WOXNPS5GPOxVHadfRHRYP5iRKwJ9qWaJGJKxqUk=;
        b=kZWaaEJNrxtCIy+H/n+xRU//G+mgUnzalDkxCw92V4kADWYChmegvG5CdgUIagXMo9OH+u
        BOu9gc/NIMBOI8y9KNR6KUlRRgee6Ihwtx/DypzJ4wR1B3SNgENfkvJpXAWxOePF4xmAvf
        ZhQqmSiAhoIhxg1Ol+4c119f3wsNvIo=
Date:   Tue, 22 Sep 2020 16:29:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 14/24] x86/sgx: Add SGX_IOC_ENCLAVE_INIT
Message-ID: <20200922142909.GI22660@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-15-jarkko.sakkinen@linux.intel.com>
 <20200921173514.GI5901@zn.tnic>
 <20200921181021.GA24481@linux.intel.com>
 <20200921182753.GK5901@zn.tnic>
 <20200921191658.GA24823@linux.intel.com>
 <20200922082918.GC22660@zn.tnic>
 <a6f4d3e5-c128-fcd7-a1ca-5515a6c4c09a@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6f4d3e5-c128-fcd7-a1ca-5515a6c4c09a@fortanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 02:56:19PM +0200, Jethro Beekman wrote:
> I don't see why you'd need to retry indefinitely. Yes the MSRs may not
> match the cached value for “reasons”, but if after you've written
> them once it still doesn't work, clearly either 1) an “unhelpful”
> VMM is actively messing with the MSRs which I'd say is at best a VMM
> bug or 2) there was an EPC reset and your enclave is now invalid
> anyway, so no need to EINIT.

/me likes that even more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
