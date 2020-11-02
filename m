Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433EA2A30AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgKBQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbgKBQ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:59:28 -0500
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 810B620706;
        Mon,  2 Nov 2020 16:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604336367;
        bh=JHwXb5T7A00gJZ7SBAekh5mJiLVICSz1+RLws5QvUUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjyMj6SZtzVX5i2iMH6LcEn8dCPQWqN625l+IV2wxor+NGmcdYFnpBRBYDIZZNsAm
         MHx4/XGJ6i7c+sKWQNJmkMgiZqdd1HI5V5tKxJ0whYhZ5YW5fO/DZryb5CoNTztxbJ
         sphSwEQcvOdiuGeHqL8T72Rp1y5gzsHc9Ry7eJ+w=
Date:   Mon, 2 Nov 2020 17:59:22 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10-rc2 (docs build)
Message-ID: <20201102175922.4ed74e7a@coco.lan>
In-Reply-To: <d9b5a400-0dbb-3be8-66f2-f629ffe4a6b8@infradead.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
        <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
        <20201102085841.5490f6da@coco.lan>
        <20201102093305.34ba4ff5@coco.lan>
        <d9b5a400-0dbb-3be8-66f2-f629ffe4a6b8@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Nov 2020 08:02:34 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 11/2/20 12:33 AM, Mauro Carvalho Chehab wrote:
> > Em Mon, 2 Nov 2020 08:58:41 +0100
> > Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> >   
> >> Hi Randy,
> >>
> >> Em Sun, 1 Nov 2020 16:01:54 -0800
> >> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >>  
> >>> Something broke the docs build (SEVERE):
> >>>
> >>>
> >>> Sphinx parallel build error:
> >>> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
> >>>
> >>> Attributes Common for All RapidIO Devices
> >>> -----------------------------------------
> >>>
> >>>  
> >>
> >> On what tree did you notice this? Linux-next or upstream?  
> 
> See $Subject:  5.10-rc2
> 
> 
> > Also: on what Sphinx version are you getting it? I'm not
> > able to reproduce the issue here, neither with Sphinx 2.4.4
> > nor with Sphinx 3.2.1.  
> 
> That could be one source of the problem:  ;)
> 
> from my docs build:
> 
> Sphinx version: 1.7.6
> Warning: It is recommended at least Sphinx version 1.7.9.
>          If you want pdf, you need at least 2.4.4.

Could be... From 1.7.6 to 1.7.9, there were bug fixes ;-)

Also, on Sphinx, they stop maintaining old versions once newer
stable ones are launched. So, any bug on 1.7.x (up to 3.2.x) will
remain unfixed[1].

In any case, could you please check if this patch solves the
issue?

	https://lore.kernel.org/lkml/6c62ef5c01d39dee8d891f8390c816d2a889670a.1604312590.git.mchehab+huawei@kernel.org/
	

> Note: It is recommended at least Sphinx version 2.4.4 if you need PDF support.
> 
> 
> > (building against next-20201102 and against 5.10-rc2)  
> 
> 
> Someone might want to update Documentation/process/changes.rst:
> Sphinx\ [#f1]_	       1.3		sphinx-build --version
> 
> Documentation/doc-guide/sphinx.rst also says minimal version is 1.3
> but then goes on to discuss other versions. It's a bit of a mess.

I don't test versions below 2.4 for a while, but I believe that
version 1.3 is still the minimal one for the documentation to be
built (earlier versions don't support some keywords used on a few
documents - and the Sphinx extensions can also break). 

Anyway, Jon is planning to raise the minimal version on Kernel
5.11, dropping some logic inside Documentation/sphinx/*.py that
are there to preserve backward compatibility with Python2 and with
too old versions of the toolchain.

After such changes, we should update changes.rst and sphinx.rst.

-

[1] On a side note, according with:
    https://www.sphinx-doc.org/en/master/changes.html
    Sphinx v3.3.0 was released today. Didn't test building with it yet.


Thanks,
Mauro
