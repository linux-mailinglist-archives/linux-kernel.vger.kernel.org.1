Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F922E24D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 07:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgLXGk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 01:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXGk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 01:40:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B/IQ3X2M01QsNOxiIDL+MVpeOjEZ7iQ32/mv634iU5s=; b=PBG31iHytKn/dtcZ01sTlXO/pL
        I1VBxfHk7Rk3gYwhUliPsOPl9xW5/+vzHCWcm8zQ277kToCSlhhdSjQSpJ/INnfTR19JpwQLuVck+
        tza4V74f1QxXhoGxc3c6fjxRP1ybMyi/HAHNofjyHibnkdivrKwRN1XSXiAffUFGiQeKh0rKQ2Mqj
        CrdCyUwLV3vMtZWwt0hl3L3CeomdbfwqMXCHibYATBMEhbtIoDnA1EyzL1AMNKdWnihx3aT2IaP5f
        6G1BCiLMD1qe6zaDJCqFwZFfVSwhIjPKiWPc53MBVm+mZesJjcwRXyHQSiSYyY9FrjXYqE91XFZwV
        vDAGvjAA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksKHi-0000mS-5t; Thu, 24 Dec 2020 06:39:38 +0000
Date:   Thu, 24 Dec 2020 06:39:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        lkp@intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        kernel-team@android.com
Subject: Re: [PATCH] clocksource: clint: Avoid remove __iomem in
 get_cycles_hi()
Message-ID: <20201224063938.GA2758@infradead.org>
References: <20201223082330.GA24581@infradead.org>
 <mhng-b2cf0325-66e1-4e3c-bfbb-b393963fbb3f@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-b2cf0325-66e1-4e3c-bfbb-b393963fbb3f@palmerdabbelt-glaptop>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 06:59:34PM -0800, Palmer Dabbelt wrote:
> Aren't we OK with lines longer than 80 characters now?  Or was that some other
> project?  checkpatch doesn't complain, which I guess is why I didn't notice, so
> hopefully that means I'm not crazy (though I guess the commit message and title
> don't provide the best argument there... ;)).

They are allowed as an exception, not the norm.  Take a look at the
coding style document.  And checkpath has for a while not been doing the
right thing unfortunately.
