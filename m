Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3092B218A48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgGHOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 10:38:22 -0400
Received: from casper.infradead.org ([90.155.50.34]:36230 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgGHOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c8LJS0PEirAv0LRNOM8mCHHxnhEu7nen7eJsU9tuuok=; b=TeN+LC551cDKhOWJDvk6jmN66n
        udCzXPPwxi33y2zhNgD687f3u2vtT7DSsXs3quGv8g0PzKnTChr6Z4GNtREaMTbPKuIDMCSrz3UnA
        QqhZyRPT13YpjqE0y2vDiGN2onKxt3FeEV6IMyIF74kQepBCHTeYKAClm7Fuev9lkGPYru2AClg4E
        pru0NnowEsbhbPObd022ZEh+8BBmHXRK3eCUy6shpUYxSVdV4POjEq6zgubO5YgE1w3KNnwrK+av3
        mP7/kJTpzrNDudmzYub4TPYWDDdAtCHijW77sZ6mGaFclgdA0UWQeXawoVgCot12qbBug0+VVvvrO
        MAYi4Ngg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtBC9-0008JO-LB; Wed, 08 Jul 2020 14:37:21 +0000
Date:   Wed, 8 Jul 2020 15:37:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jethro Beekman <jethro@fortanix.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v34 10/24] mm: Add vm_ops->mprotect()
Message-ID: <20200708143708.GR25523@casper.infradead.org>
References: <20200707030204.126021-1-jarkko.sakkinen@linux.intel.com>
 <20200707030204.126021-11-jarkko.sakkinen@linux.intel.com>
 <20200707031424.GD25523@casper.infradead.org>
 <20200707032254.GB5208@linux.intel.com>
 <20200707032408.GE25523@casper.infradead.org>
 <20200707040151.GA143804@linux.intel.com>
 <20200707041046.GI25523@casper.infradead.org>
 <20200708143320.GD538949@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708143320.GD538949@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:33:20PM +0300, Jarkko Sakkinen wrote:
> I get the point but I don't think that your proposal could work given
> that mprotect-callback takes neither 'prev' nor 'newflags' as its
> parameters. The current callback has no means to call mprotect_fixup()
> properly.
> 
> It would have to be extended
> 
> 	int (*mprotect)(struct vm_area_struct *vma,
> 			struct vm_area_struct **pprev, unsigned long start,
> 			unsigned long end, unsigned long prot,
> 			unsigned long newflags);
> 
> Is this what you want?

https://lore.kernel.org/linux-mm/20200625173050.GF7703@casper.infradead.org/
