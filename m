Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE12A3534
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBUfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgKBUfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:35:38 -0500
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD470206F8;
        Mon,  2 Nov 2020 20:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604349337;
        bh=J330c+FvCffBp5mpDv8bkxNW8hfiLems/15HYpWHgLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ao8x+kjUska8BpmJwSRfX2Rmg4e7i6JJxkgha3/L+y/t3SYcRasO3cG4lWuiTVk/d
         GpW5A0EKRM7rF0CtJ7xx09LHeuYzPFF5xfJBy5e59aJHpDM++4PENAZtwRxXEiPKP9
         MBt9Lnr2ABT2fGdwYRLQfwFLdD+RzYWO0GKgis8Y=
Date:   Mon, 2 Nov 2020 21:35:32 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10-rc2 (docs build)
Message-ID: <20201102213532.4d0706c4@coco.lan>
In-Reply-To: <4a538b19-2bfd-5c7c-047c-7ed4292b89c8@infradead.org>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
        <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
        <20201102085841.5490f6da@coco.lan>
        <20201102093305.34ba4ff5@coco.lan>
        <d9b5a400-0dbb-3be8-66f2-f629ffe4a6b8@infradead.org>
        <20201102175922.4ed74e7a@coco.lan>
        <4a538b19-2bfd-5c7c-047c-7ed4292b89c8@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Nov 2020 11:23:25 -0800
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 11/2/20 8:59 AM, Mauro Carvalho Chehab wrote:
> > Em Mon, 2 Nov 2020 08:02:34 -0800
> > Randy Dunlap <rdunlap@infradead.org> escreveu:
> >   
> >> On 11/2/20 12:33 AM, Mauro Carvalho Chehab wrote:  
> >>> Em Mon, 2 Nov 2020 08:58:41 +0100
> >>> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> >>>     
> >>>> Hi Randy,
> >>>>
> >>>> Em Sun, 1 Nov 2020 16:01:54 -0800
> >>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >>>>    
> >>>>> Something broke the docs build (SEVERE):
> >>>>>
> >>>>>
> >>>>> Sphinx parallel build error:
> >>>>> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
> >>>>>
> >>>>> Attributes Common for All RapidIO Devices
> >>>>> -----------------------------------------
> >>>>>
> >>>>>    
> >>>>
> >>>> On what tree did you notice this? Linux-next or upstream?    
> >>
> >> See $Subject:  5.10-rc2
> >>
> >>  
> >>> Also: on what Sphinx version are you getting it? I'm not
> >>> able to reproduce the issue here, neither with Sphinx 2.4.4
> >>> nor with Sphinx 3.2.1.    
> >>
> >> That could be one source of the problem:  ;)
> >>
> >> from my docs build:
> >>
> >> Sphinx version: 1.7.6
> >> Warning: It is recommended at least Sphinx version 1.7.9.
> >>          If you want pdf, you need at least 2.4.4.  
> > 
> > Could be... From 1.7.6 to 1.7.9, there were bug fixes ;-)
> > 
> > Also, on Sphinx, they stop maintaining old versions once newer
> > stable ones are launched. So, any bug on 1.7.x (up to 3.2.x) will
> > remain unfixed[1].
> > 
> > In any case, could you please check if this patch solves the
> > issue?
> > 
> > 	https://lore.kernel.org/lkml/6c62ef5c01d39dee8d891f8390c816d2a889670a.1604312590.git.mchehab+huawei@kernel.org/  
> 
> Nope, sorry, with that patch applied to v5.10-rc2, I get:
> 
> reading sources... [ 93%] userspace-api/media/v4l/pixfmt-y8i .. userspace-api/media/v4l/vidioc-querybuf
> reading sources... [ 96%] userspace-api/media/v4l/vidioc-querycap .. vm/transhuge
> reading sources... [100%] vm/unevictable-lru .. xtensa/mmu
> 
> waiting for workers...
> 
> {hangs; enter ^C}
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-class-led-trigger-pattern.orig:16: (SEVERE/4) Unexpected section title.

Hmm...
	sysfs-class-led-trigger-pattern.orig

That doesn't sound right! It seems you have a backup of an old file
there ;-)

-

In order to double-check, I tested it here with:

	$ /usr/bin/python3 -m venv sphinx_1.7.6
	$ pip install docutils sphinx_rtd_theme Sphinx==1.7.6
	$ pip install docutils==0.15 sphinx_rtd_theme Sphinx==1.7.6


And then built the docs with:

	$ time make O="sphinx1.7" SPHINXOPTS="-w new_warnings --no-color" cleandocs htmldocs

Everything build fine (except for a huge amount of warnings that seem
to indicate some bug at the cross-reference logic with 1.7.6).

<snip>
make[1]: Entering directory '/devel/v4l/docs/sphinx1.7'
rm -f   /devel/v4l/docs/sphinx1.7/Documentation/output/audio.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/ca.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/dmx.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/frontend.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/net.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/video.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/videodev2.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/media.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/cec.h.rst /devel/v4l/docs/sphinx1.7/Documentation/output/lirc.h.rst 2>/dev/null
Detected OS: Ubuntu 20.04.1 LTS.
Sphinx version: 1.7.6

Warning: It is recommended at least Sphinx version 1.7.9.
         If you want pdf, you need at least 2.4.4.
Note: It is recommended at least Sphinx version 2.4.4 if you need PDF support.
To upgrade Sphinx, use:

	/devel/v4l/docs/sphinx_1.7.6/bin/python3 -m venv sphinx_2.4.4
	. sphinx_2.4.4/bin/activate
	pip install -r ../Documentation/sphinx/requirements.txt

If you want to exit the virtualenv, you can use:
	deactivate

All optional dependencies are met.
Needed package dependencies are met.
  SPHINX  htmldocs --> file:///devel/v4l/docs/sphinx1.7/Documentation/output
  PARSE   include/uapi/linux/dvb/audio.h
  PARSE   include/uapi/linux/dvb/ca.h
  PARSE   include/uapi/linux/dvb/dmx.h
  PARSE   include/uapi/linux/dvb/frontend.h
  PARSE   include/uapi/linux/dvb/net.h
  PARSE   include/uapi/linux/dvb/video.h
  PARSE   include/uapi/linux/videodev2.h
  PARSE   include/uapi/linux/media.h
  PARSE   include/uapi/linux/lirc.h
  PARSE   include/uapi/linux/cec.h
Running Sphinx v1.7.6
...
copying static files... done
copying extra files... done
dumping search index in English (code: en) ... done
dumping object inventory... done
build succeeded, 767 warnings.

The HTML pages are in Documentation/output.
make[1]: Leaving directory '/devel/v4l/docs/sphinx1.7'

real	2m31.798s
user	9m39.494s
sys	0m38.300s
</snip>

The only output difference is the huge amount of warnings (767 warnings
with this version, against 24 when built with 2.4.4).

Thanks,
Mauro
