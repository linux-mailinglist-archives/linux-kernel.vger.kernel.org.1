Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13182A081F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgJ3Ojo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgJ3Ojn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:39:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BAAC0613CF;
        Fri, 30 Oct 2020 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/nuHOYGzfdSAxG5g3XnaFq7PaodpHm2ctY0x0q4Q3jE=; b=LWE3y7rRfF9Ta8lyu4v8Uz1Mj4
        4Zr3VB2IFdAlpLSmIkkuCpNhrTt4ew2Irzas0nMtK3qQgCIIFJQZP/Np9qt0MFFGqUE2VHV9wMCJI
        44IbPDGbsAadlu0w421qlDB/5dEaja94mzcpRfeKjazUq7kMDQstW5y9isdYG9GfqEVk18YJAxEcZ
        9uU9L1LBS45FH35mzVCis8Zr2scX9zvWEzEuiC1j1fsTu53/cm9lRKDSiZiv7Kmzt2kUbkioH8Yp9
        SL31I+fVVXXyGlVrrJLnl2PY0Y0odAcEhBweZQckD62XuIcDrd9liaC7UHi+hIMFc4K4kJ2jrMJDF
        KuIBvFUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYVZ3-0008Ba-Je; Fri, 30 Oct 2020 14:39:37 +0000
Date:   Fri, 30 Oct 2020 14:39:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@protonmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: Python 2.7 support and automarkup.py - Was: Re: [PATCH v2 1/5]
 docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <20201030143937.GK27442@casper.infradead.org>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
 <20201013231218.2750109-2-nfraprado@protonmail.com>
 <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
 <20201030151026.3afd7997@coco.lan>
 <20201030081440.47a74dad@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030081440.47a74dad@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:14:40AM -0600, Jonathan Corbet wrote:
> On Fri, 30 Oct 2020 15:10:26 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > I see a few alternatives:
> > 
> > 1) fix automarkup.py for it to work again with python 2.7;
> > 
> > 2) conf.py could gain some logic to disable automarkup with
> >    Python < 3;
> > 
> > 3) scripts/sphinx-pre-install already detects Python version. 
> >    It should likely be easy to ask the user to use python 3.x,
> >    if an older version is detected.
> > 
> > Doing (1) or (2) will require an additional step when we raise
> > the bar for Python version.
> 
> We haven't dropped support for Python 2 yet, so this constitutes a
> regression.  My own approach would be something like this at the top of
> automarkup.py:
> 
> 	if python2:
> 	    ascii = 0
> 	else:
> 	    ascii = re.ASCII
> 
> ...then s/re.ASCII/ascii/ throughout.  I can probably put together
> something later this morning.

Could we have a warning somewhere that python 2.7 is going to produce
inferior docs?

Alternatively, https://docs.python.org/2/library/re.html suggests
using "The third-party regex module".
