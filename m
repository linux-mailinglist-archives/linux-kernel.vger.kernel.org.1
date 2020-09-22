Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BDA27441E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVOYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIVOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:24:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E609C0613CF;
        Tue, 22 Sep 2020 07:24:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bfb00bac1eb742b9d4935.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:bac1:eb74:2b9d:4935])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B217A1EC02E6;
        Tue, 22 Sep 2020 16:24:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600784658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b9ig+ASowjbt+g3pR0np+7iMxB15EFcK7NyuXShobS4=;
        b=WY1KrOzh7W306okwBE+M/OOizUawZqkQjJqwdw4AQL2SSroW3eZYNXNCLyhVMQRPkbai/V
        /slaQzT2ouhMBeVzLNFattqRo3ECXnphiXFTqWlDYUYgrnFcHXeiIVkmdSU4dz7ifvQLSa
        KAeNEAjmM89MsrSSFKSRmySfcdMekoI=
Date:   Tue, 22 Sep 2020 16:24:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jethro Beekman <jethro@fortanix.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Seth Moore <sethmo@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v38 16/24] x86/sgx: Add a page reclaimer
Message-ID: <20200922142413.GH22660@zn.tnic>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
 <20200915112842.897265-17-jarkko.sakkinen@linux.intel.com>
 <20200922104538.GE22660@zn.tnic>
 <20200922140314.GA164527@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922140314.GA164527@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:03:23PM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 22, 2020 at 12:45:38PM +0200, Borislav Petkov wrote:
> > > + * %SGX_ENCL_PAGE_VA_OFFSET_MASK:	Holds the offset in the Version Array
> > > + *					(VA) page for a swapped page.
> > >   * %SGX_ENCL_PAGE_ADDR_MASK:		Holds the virtual address of the page.
> > >   *
> > >   * The page address for SECS is zero and is used by the subsystem to recognize
> > 
> > ...
> 
> So what's wrong over here?

Nothing - that's just an ellipsis: https://en.wikipedia.org/wiki/Ellipsis

I do that because otherwise you'd have to scroll through pages of quoted
mail for no good reason and that ain't friendly at all. And I notice
people not trimming their replies and not quoting only the text they
reply to. They should not wonder if their emails remain unread.

Thx for the rest.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
