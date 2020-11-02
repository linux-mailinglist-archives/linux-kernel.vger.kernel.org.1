Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5EA2A3631
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgKBV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgKBV7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:59:18 -0500
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6569B22275;
        Mon,  2 Nov 2020 21:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604354358;
        bh=bOR9hiYB71zRAyVredEaMhzu2b0d0er6S0XMtO6f2ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=18MNxXC9GRc3UCxLUU36N4ftpwrAX/HCCBgpeRK+3FslqLgS2TZAPkXE2fw0HC+m1
         XLpyyTae3gj6WeQ7fLRy6+OnTmqji40sHSg8qjRp8XWtHuWUbOMsKBJwfvEZS1yE0f
         hUB5p/7V3Dw3g3RkvKHQgKWEVPJvWbAzS5NS1XeE=
Date:   Mon, 2 Nov 2020 22:59:11 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10-rc2 (docs build)
Message-ID: <20201102225911.0db4667f@coco.lan>
In-Reply-To: <fccc0ef0-e96a-0e0d-69d9-f72f6a31a201@infradead.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
        <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
        <20201102085841.5490f6da@coco.lan>
        <20201102093305.34ba4ff5@coco.lan>
        <d9b5a400-0dbb-3be8-66f2-f629ffe4a6b8@infradead.org>
        <20201102175922.4ed74e7a@coco.lan>
        <4a538b19-2bfd-5c7c-047c-7ed4292b89c8@infradead.org>
        <20201102213532.4d0706c4@coco.lan>
        <fccc0ef0-e96a-0e0d-69d9-f72f6a31a201@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Nov 2020 12:41:53 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 11/2/20 12:35 PM, Mauro Carvalho Chehab wrote:
> > Em Mon, 2 Nov 2020 11:23:25 -0800
> > Randy Dunlap <rdunlap@infradead.org> escreveu:
> >   
> >> On 11/2/20 8:59 AM, Mauro Carvalho Chehab wrote:  
> >>> Em Mon, 2 Nov 2020 08:02:34 -0800
> >>> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >>>     
> >>>> On 11/2/20 12:33 AM, Mauro Carvalho Chehab wrote:    
> >>>>> Em Mon, 2 Nov 2020 08:58:41 +0100
> >>>>> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> >>>>>       
> >>>>>> Hi Randy,
> >>>>>>
> >>>>>> Em Sun, 1 Nov 2020 16:01:54 -0800
> >>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >>>>>>      
> >>>>>>> Something broke the docs build (SEVERE):
> >>>>>>>
> >>>>>>>
> >>>>>>> Sphinx parallel build error:
> >>>>>>> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
> >>>>>>>
> >>>>>>> Attributes Common for All RapidIO Devices
> >>>>>>> -----------------------------------------
> >>>>>>>
> >>>>>>>      
> >>>>>>
> >>>>>> On what tree did you notice this? Linux-next or upstream?      
> >>>>
> >>>> See $Subject:  5.10-rc2
> >>>>
> >>>>    
> >>>>> Also: on what Sphinx version are you getting it? I'm not
> >>>>> able to reproduce the issue here, neither with Sphinx 2.4.4
> >>>>> nor with Sphinx 3.2.1.      
> >>>>
> >>>> That could be one source of the problem:  ;)
> >>>>
> >>>> from my docs build:
> >>>>
> >>>> Sphinx version: 1.7.6
> >>>> Warning: It is recommended at least Sphinx version 1.7.9.
> >>>>          If you want pdf, you need at least 2.4.4.    
> >>>
> >>> Could be... From 1.7.6 to 1.7.9, there were bug fixes ;-)
> >>>
> >>> Also, on Sphinx, they stop maintaining old versions once newer
> >>> stable ones are launched. So, any bug on 1.7.x (up to 3.2.x) will
> >>> remain unfixed[1].
> >>>
> >>> In any case, could you please check if this patch solves the
> >>> issue?
> >>>
> >>> 	https://lore.kernel.org/lkml/6c62ef5c01d39dee8d891f8390c816d2a889670a.1604312590.git.mchehab+huawei@kernel.org/    
> >>
> >> Nope, sorry, with that patch applied to v5.10-rc2, I get:
> >>
> >> reading sources... [ 93%] userspace-api/media/v4l/pixfmt-y8i .. userspace-api/media/v4l/vidioc-querybuf
> >> reading sources... [ 96%] userspace-api/media/v4l/vidioc-querycap .. vm/transhuge
> >> reading sources... [100%] vm/unevictable-lru .. xtensa/mmu
> >>
> >> waiting for workers...
> >>
> >> {hangs; enter ^C}
> >>
> >> Sphinx parallel build error:
> >> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-class-led-trigger-pattern.orig:16: (SEVERE/4) Unexpected section title.  
> > 
> > Hmm...
> > 	sysfs-class-led-trigger-pattern.orig
> > 
> > That doesn't sound right! It seems you have a backup of an old file
> > there ;-)  
> 
> Ha! I didn't even notice that.  :(
> 
> Anyway, it's not illegal to have such files, so Documentation builds
> should ignore them (IMO).

I agree that it should ignore, but unfortunately Sphinx works with
directories and it tries to use all files there that matches the 
expected extension, and not only the ones that are inside the index 
files.

So, if you want to keep a backup of an older version, I
suggest to rename the file extension.

> > -
> > 
> > In order to double-check, I tested it here with:
> > 
> > 	$ /usr/bin/python3 -m venv sphinx_1.7.6
> > 	$ pip install docutils sphinx_rtd_theme Sphinx==1.7.6
> > 	$ pip install docutils==0.15 sphinx_rtd_theme Sphinx==1.7.6
> > 
> > 
> > And then built the docs with:
> > 
> > 	$ time make O="sphinx1.7" SPHINXOPTS="-w new_warnings --no-color" cleandocs htmldocs
> > 
> > Everything build fine (except for a huge amount of warnings that seem
> > to indicate some bug at the cross-reference logic with 1.7.6).  
> 
> OK, I'll wait to see how things are in -rc2 or so.
> 
> thanks.

Ok.

Thanks,
Mauro
