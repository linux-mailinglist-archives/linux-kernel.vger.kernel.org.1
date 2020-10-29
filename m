Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC27429E745
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgJ2J2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ2J2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:28:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZKZzkQOgnXxn+1sJFhuXZYJZjKMoRtNvNL96QGAp7Mg=; b=tCLyknDxJNUYy53fju6cNuRzZ5
        H7oktm/D6Xzg1GXL5RHz68QTF8KVAJs5tKxETDkoya9fZH8GBlEfzkpI040hL8PYQlJhzbD3q9qUT
        538Akd5WosG+0D4NCEtqe/Hcfo6pg+oOX+ZIWuBF/hqkhPP9UpuGHyBZqTGvrCE4Anu9BSi6ChA8o
        n4uN4HSdOO+WmzJyw7g6wRfRpXNrymlIvzPTsPwhfri9Q5yr58qzXxmEKDF9o6sSowL3aPb5EtwOM
        VeZp/+0f3jNiDgEQVGyiSDORvnK5VZMSTzNZprd+9kPv0fTYgKSu6ape188kvxHzCDAtT0mytexlJ
        cRbA4dLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY4Dm-0000CB-DU; Thu, 29 Oct 2020 09:27:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2271F300446;
        Thu, 29 Oct 2020 10:27:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02E632C6E59C4; Thu, 29 Oct 2020 10:27:47 +0100 (CET)
Date:   Thu, 29 Oct 2020 10:27:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH RFC v2 2/4] x86/bus_lock: Handle warn and fatal in #DB
 for bus lock
Message-ID: <20201029092747.GI2628@hirez.programming.kicks-ass.net>
References: <20201028202804.3562179-1-fenghua.yu@intel.com>
 <20201028202804.3562179-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028202804.3562179-3-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 08:28:02PM +0000, Fenghua Yu wrote:
> diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
> index d95d080b30e3..61078319fc6c 100644
> --- a/arch/x86/include/uapi/asm/debugreg.h
> +++ b/arch/x86/include/uapi/asm/debugreg.h
> @@ -16,7 +16,7 @@
>     are either reserved or not of interest to us. */
>  
>  /* Define reserved bits in DR6 which are always set to 1 */
> -#define DR6_RESERVED	(0xFFFF0FF0)
> +#define DR6_RESERVED	(0xFFFF07F0)

NAK

