Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62DA2A9EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgKFVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFVNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61484C0613CF;
        Fri,  6 Nov 2020 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mzSnlUk01ZdJAA6PiH8BmokyA/8f90mFrb1du4sTZ5E=; b=odyo1Y2Fudsb5/Su7KcrdNzmEk
        4KEeLptcEsg9V9nPHb/ky9xaG/5BF1NiRK/fTVTALmZqLzhEmZHQCKm5BDrLkCehJANa0BitF6/os
        +DEbRDXERyV8AnkloG9dFjYXZqMyw/Bu+S+xD9audQ7L0WB9JdaLW36HPrAd4DrWJ2rEXkQzz5YWx
        XotwK+wFuUqKAAE05l4TEe2IrlpAP0dvsB8TmcJnAMDLHukM1L2a/fUtU2vwElE9ldXPdgsFVTgPx
        tbdFmR+U0ra1X6ikgSTGIkUbt5dDkdxc1EKmYQC0ME/hUuCOMwrWHO0OW1cpAUwJ3s5qjCTKAgSUo
        k4S0QFqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb92l-0002d4-AD; Fri, 06 Nov 2020 21:13:11 +0000
Date:   Fri, 6 Nov 2020 21:13:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v40 10/24] mm: Add 'mprotect' hook to struct
 vm_operations_struct
Message-ID: <20201106211311.GT17076@casper.infradead.org>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
 <20201104145430.300542-11-jarkko.sakkinen@linux.intel.com>
 <20201106174359.GA24109@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106174359.GA24109@wind.enjellic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:43:59AM -0600, Dr. Greg wrote:
> The 900 pound primate in the room, that no one is acknowledging, is
> that this technology was designed to not allow the operating system to
> have any control over what it is doing.  In the mindset of kernel
> developers, the operating system is the absolute authority on
> security, so we find ourselves in a situation where the kernel needs
> to try and work around this fact so any solutions will be imperfect at
> best.
> 
> As I've noted before, this is actually a primary objective of enclave
> authors, since one of the desires for 'Confidential Computing' is to
> hide things like proprietary algorithms from the platform owners.  I
> think the driver needs to acknowledge this fact and equip platform
> owners with the simplest and most effective security solutions that
> are available.

Or we need to not merge "technology" that subverts the owner of
the hardware.  Remember: root kit authors are inventive buggers.

