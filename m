Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26554277608
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgIXP55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:57:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35518 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgIXP5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:57:54 -0400
Received: from zn.tnic (p200300ec2f0c950086c1a307bd73ace8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:86c1:a307:bd73:ace8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DB981EC046C;
        Thu, 24 Sep 2020 17:57:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600963073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QS0UPPpukaaGR044ycG31aWsVOTNPV8uZL7cGVPnRe4=;
        b=ISfWmNxW/nJHGp7rto/mTXqWmBoBIflNMYyGpWY2oVQEvGtRirWm1iNB8JhRAPfHCYUl9v
        I2vHMOj3cB6u8Jw9CzewJmYMhUjL/Z6lBhF34eng4JHaxwMNt7i7q7+9S3a3RfsbrsYrsD
        /47mwP0SyEfZi/4TxX80YnlNWwPbhBI=
Date:   Thu, 24 Sep 2020 17:57:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jethro Beekman <jethro@fortanix.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 17/24] x86/sgx: ptrace() support for the SGX driver
Message-ID: <20200924155751.GJ5030@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-18-jarkko.sakkinen@linux.intel.com>
 <20200922154424.GL22660@zn.tnic>
 <20200923132037.GA5160@linux.intel.com>
 <20200923161733.GP28545@zn.tnic>
 <20200924115119.GD56811@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200924115119.GD56811@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 02:51:28PM +0300, Jarkko Sakkinen wrote:
> On Wed, Sep 23, 2020 at 06:17:33PM +0200, Borislav Petkov wrote:
> > > Add 'access' implementation to vm_ops with the help of these functions.
> > 
> > "Add an ->access virtual MM function for accessing the enclave's memory... "
> 
> Thank you. I wrote the last paragraph like this:
> 
> "Add an '->access' virtual function for accessing the enclave's memory
> to vm_ops by using these functions. This allows to use ptrace() with

"to vm_ops" must come after "function".

But lemme ask what is "vm_ops"?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
