Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9825227F999
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgJAGlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAGlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:41:49 -0400
Received: from coco.lan (ip5f5ad5d2.dynamic.kabel-deutschland.de [95.90.213.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5CB20848;
        Thu,  1 Oct 2020 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601534508;
        bh=CESks9T8sCotDTGSbJvcIn+WtTDi56a2QYNDKjHeMCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cM0yXeUdvjTaUQJRCCsk5u057Onxypq4csFdLsYxUa4lWxUOc0uTvbIf/IJ5wYk/T
         pL+2UPtce29mTVaLYx7wllKWISx5EfQRFbcIKziXct94uL6DD6tJObucvAGHg27WcQ
         CGS6lXEgDCQ5uUErBBX5LdC6yn0MfYTmlyoBjgWg=
Date:   Thu, 1 Oct 2020 08:41:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 23/52] docs: trace-uses.rst: remove bogus c-domain
 tags
Message-ID: <20201001084143.7c6f7836@coco.lan>
In-Reply-To: <5e19b1d5-8015-c41d-788d-00b121599c6b@linux.vnet.ibm.com>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
        <f1d8fc4bb976f8c25c6fb444b0b675d9a849ba06.1601467849.git.mchehab+huawei@kernel.org>
        <5e19b1d5-8015-c41d-788d-00b121599c6b@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 1 Oct 2020 11:36:53 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> escreveu:

> On 30/09/20 6:54 pm, Mauro Carvalho Chehab wrote:
> > There are some c-domain tags that are wrong. While this won't
> > cause problems with Sphinx < 3.0, this cause troubles with
> > newer versions, as the C parser won't recognize the contents
> > of the tag, and will drop it from the output.
> > 
> > Let's just place them at literal blocks.
> >   
> 
> tired with Sphinx v3.2.1, invalid C declaration warnings are not
> seen with the patch.

Well, it would be possible to use :c:expr: with Sphinx 3.2.1,
in order for it to check for invalid C declarations.

Btw, this is one of the improvements over the last versions: the
rewritten C parser there is a lot more pedantic with regards to the
C syntax.

-

That's said, the backward-compatibility code I added at 
Documentation/sphinx/cdomain.py will convert this into a 
literal markup though, as there's no equivalent tag before 
Sphinx 3.x.

As there are still one upstream issue on Sphinx 3.x that requires a fix[1],
and we don't know yet the issues with :c:expr[2], at least for now, I would 
avoid adding :c:expr: markups.

[1] Right now, the C domain is not able to have two names
    for different types. So, it is not possible to have
    a struct "foo" and a function "foo".

    Due to that, while I was able to fix all warnings with
    Sphinx 2.x build, Sphinx 3.x will still have bogus
    warnings.

[2] One of the limitations of :c:expr: is with regards to function
    prototypes. You can't use it like: :c:expr:`int foo(void);`,
    as it will complain with the function return type.


> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Thanks!

Mauro
