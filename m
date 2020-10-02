Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35E5280D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgJBGW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBGWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:22:25 -0400
Received: from coco.lan (ip5f5ad59f.dynamic.kabel-deutschland.de [95.90.213.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FCC206DD;
        Fri,  2 Oct 2020 06:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601619745;
        bh=Fm3wF63UnVpjp+czzLRNKA2N8EiUUiZinULEHueyAbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DG1CqBpfSykW1DDZaTaf0cKsorDz5skja30jv0E1nZUMfUiJi8GUg3Wh3JCgX3fc0
         7fFCVjYNm5DGwpDf0sZQhXEJBqTZNZAv+5cauqqpLqqFZPnSoc3YcWre82wM+wFUVw
         HdAukYgzZE9eVgVArq0H8FwVQ+TLkrdYR/9Zbac0=
Date:   Fri, 2 Oct 2020 08:22:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/52] scripts: kernel-doc: make it more compatible
 with Sphinx 3.x
Message-ID: <20201002082221.1df7d39b@coco.lan>
In-Reply-To: <20201001154100.2f7e89b8@lwn.net>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
        <c7b04d8f20f44d4d2eb797d8694bd7546f95ac05.1601467849.git.mchehab+huawei@kernel.org>
        <20201001154100.2f7e89b8@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 1 Oct 2020 15:41:00 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 30 Sep 2020 15:24:27 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > With Sphinx 3.x, the ".. c:type:" tag was changed to accept either:
> > 
> > 	.. c:type:: typedef-like declaration
> > 	.. c:type:: name
> > 
> > Using it for other types (including functions) don't work anymore.
> > 
> > So, there are newer tags for macro, enum, struct, union, and others,
> > which doesn't exist on older versions.
> > 
> > Add a check for the Sphinx version and change the produced tags
> > accordingly.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/kernel-doc | 71 ++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 65 insertions(+), 6 deletions(-)  
> 
> So this seems generally good, but I do wonder if we shouldn't just pass
> the sphinx version into kernel-doc as a parameter?  We're already doing a
> version check in the makefile, we should be able to capture the result and
> pass it in, maybe?  

My plan is to work later on a patch adding support for it ;)

Yet, there's something to consider: troubleshooting.

I mean, if a warning is produced during "make htmldocs", as part
of troubleshooting, people do:

	./scripts/kernel-doc <some file>

It sounds more natural that, by default, it will output the same
output as the one generated via "make htmldocs".

So, the version detection code there sounds the right way for
doing it.

Yet, as you pointed, as kerneldoc.py knows the Sphinx version,
it should be easy for it to pass an argument and avoid version
detection, by calling kernel-doc as:

	./scripts/kernel-doc --sphinx3 <somefile>

or

	./scripts/kernel-doc --sphinx-version 3 <somefile>

(not sure yet about how to name such arguments ;-) )

That might give some performance gain.

Btw, with regards to performance, I have a few other ideas that
might help how to improve kernel-doc (yet to be verified).

At least for now, I opted to keep it more straight without
adding more complexity. My plan is to work on those
things after the merge window.

Thanks,
Mauro
