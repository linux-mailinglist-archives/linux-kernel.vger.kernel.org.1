Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC51C247C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 12:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEBK1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 06:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgEBK1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 06:27:32 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B542137B;
        Sat,  2 May 2020 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588415251;
        bh=meuNEm4QtlNCEOLrnXFslBa0+yQ+8Q4cBxs2ezZnL/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JkKzpdbeJDz1UlMXttpOk48NjTdtFgiaaUwJF8eteIL3RbCgmdqnTj5jOQ4nCIfAD
         4ujWBrU0pGb7Ds3rBuG+KhBpoB5cGg2dPpiibtxp0uyx2562z5xjOGVn7vnSxoPZeZ
         U+qk34pgdmDZyZFjiWV3fyb5SezTxhpY0j2BrsLs=
Date:   Sat, 2 May 2020 12:27:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 14/14] docs: staging: use small font for literal
 includes
Message-ID: <20200502122728.36eb231b@coco.lan>
In-Reply-To: <3aac8d7e3f11d7df5b8155c93beee447cf8f064b.camel@perches.com>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
        <3aac8d7e3f11d7df5b8155c93beee447cf8f064b.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 01 May 2020 17:10:00 -0700
Joe Perches <joe@perches.com> escreveu:

> On Fri, 2020-05-01 at 17:37 +0200, Mauro Carvalho Chehab wrote:
> > The normal font is too big to display 80 columns, causing extra
> > breaks to be added at weird places.
> > 
> > change to the footnotesize, as this would fit a little bit
> > better.  
> []
> > diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst  
> []
> > @@ -19,17 +19,41 @@ Unsorted Documentation
> >  Atomic Types
> >  ============
> >  
> > +.. raw:: latex
> > +
> > +    \footnotesize  
> 
> Please don't make the markup too invasive.

With the current status, this is unavoidable.

The only way to avoid those would be to convert the document itself
to ReST, but the document writer was not convinced yet to even minimal
ReST markups on 3 files.

The problem with a text file is that the lines produced at the PDF output 
with a mono-spaced font, on LaTeX have lot less than 80 colums. So, 
some markups should tell Sphinx to use a reduced font for those includes.

However, there's no "fontsize" directive (nor any other directive that 
would allow adjusting font parameters on an included file) on Sphinx. 
So, we need to use the above.

Thanks,
Mauro
