Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F76227D80A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgI2U1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgI2U1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:27:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:27:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ead004f62ea03a39a83a7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:4f62:ea03:a39a:83a7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 125EF1EC047E;
        Tue, 29 Sep 2020 22:27:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601411220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CjmvGfS48ESBGtW8w0gZRQtSZ5i61WRGavmSChoRrBg=;
        b=GK5gwfr+F8ZCncvPht5h4nHQ7wTxIjkp4Rf9ijxT0UFRxxzHiVpQvYhxXnZS3+PAUhIkRr
        xYfdwK7p/1Wb/Cq4sqof8n46vrUQkXGW/FOrmjzrJ1uOzqqLi1H/n2V05XBQijxyI8LnL/
        i7YucoywA1pbhfb3A/jZyvT7EkjQMgk=
Date:   Tue, 29 Sep 2020 22:26:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>, shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 02/17] x86/acrn: Introduce acrn_{setup,
 remove}_intr_handler()
Message-ID: <20200929202604.GP21110@zn.tnic>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-3-shuo.a.liu@intel.com>
 <20200929175947.GL21110@zn.tnic>
 <873630jqiy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <873630jqiy.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:07:17PM +0200, Thomas Gleixner wrote:
> That does not prevent that either and notifiers suck.

Bah, atomic notifiers run functions which cannot block, not what is
needed here, right.

> The pointer is fine and if something removes the handler before all of
> the muck is shutdown then the author can keep the pieces and mop up
> the remains.

Uhu, so what makes sure that the module is not removed while an IRQ is
happening?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
