Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84B527D551
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgI2SBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:01:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33676 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI2SBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:01:31 -0400
Received: from zn.tnic (p200300ec2f0ead009e71cc6c0304d124.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:ad00:9e71:cc6c:304:d124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 063E31EC037C;
        Tue, 29 Sep 2020 20:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601402490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wdBdZsIvOLM9wv6F7s7HGPPTACViaL/H1ZxNp7CAFFQ=;
        b=MKpoxAqzPu3T7uN/7poJ3hu0Bm8+yyS3OVI4QH6zyDq8DG3zc8+Y0jHZLeoagM49hZyXYO
        4eYyuThlNjTx9yz9Juc3CP1u0eOJxNf9ikKcdYkBBURKKLN0/dKqIw09/EPeR/ZH/GGFXo
        osnyNI/FP649fkM+BWjIkF+F1U7TbNw=
Date:   Tue, 29 Sep 2020 20:01:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20200929175947.GL21110@zn.tnic>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-3-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922114311.38804-3-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:42:56PM +0800, shuo.a.liu@intel.com wrote:
> +void acrn_setup_intr_handler(void (*handler)(void))
> +{
> +	acrn_intr_handler = handler;
> +}
> +EXPORT_SYMBOL_GPL(acrn_setup_intr_handler);
> +
> +void acrn_remove_intr_handler(void)
> +{
> +	acrn_intr_handler = NULL;
> +}
> +EXPORT_SYMBOL_GPL(acrn_remove_intr_handler);

I don't like this one bit.

Also, what stops the module from doing acrn_remove_intr_handler()
while it gets a HYPERVISOR_CALLBACK_VECTOR interrupt and the handler
disappearing from under it?

IOW, this should be an atomic notifier instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
