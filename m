Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB6297B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759814AbgJXGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 02:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759806AbgJXGph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 02:45:37 -0400
Received: from coco.lan (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F7120735;
        Sat, 24 Oct 2020 06:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603521937;
        bh=66+o0TQRHydjos+x14DK62znQJEeGHX+weWJ+zho+Ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rzvtFu2UpaKmSNmH/HBfXF84KkKhm1o5JNxMUqVO/SDnZniUzg5sPgopSsG4jYCqK
         JhZZhFhnhBt9zeaYyyrFPSFvHchIGQo5Eh96+L3hUYUh/FJP94wPVbvOHvAeWb+IMN
         SJwoQn5Mt3tjJSoRCwA39RnOX7YjdfKZrhqWmoHA=
Date:   Sat, 24 Oct 2020 08:45:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        Corey Minyard <cminyard@mvista.com>,
        Harald Seiler <hws@denx.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Walle <michael@walle.cc>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-api: remove a duplicated index entry
Message-ID: <20201024084531.33fc1b75@coco.lan>
In-Reply-To: <20201021151344.4f471fbc@lwn.net>
References: <623fb26a8409a7b002e45bdbb6f517ac08fd508a.1602753121.git.mchehab+huawei@kernel.org>
        <20201021151344.4f471fbc@lwn.net>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 21 Oct 2020 15:13:44 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Thu, 15 Oct 2020 11:12:06 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The ipmb file was added twice at index.rst. That
> > sounds to be because the same patch was applied twice,
> > via different git trees:
> > 
> > 	commit f6ae22d64433fd8e08654adad7966299da931bb9
> > 	Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > 	Commit: Jonathan Corbet <corbet@lwn.net>
> > 
> > 	    docs: ipmb: place it at driver-api and convert to ReST
> > 
> > 	commit ac499fba98c3c65078fd84fa0a62cd6f6d5837ed
> > 	Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > 	Commit: Corey Minyard <cminyard@mvista.com>
> > 
> > 	    docs: ipmb: place it at driver-api and convert to ReST
> > 
> > With Sphinx 4.0.0 development tree, a new warning is produced
> > due to that:
> > 
> > 	.../Documentation/driver-api/index.rst:14: WARNING: duplicated entry found in toctree: driver-api/ipmb
> > 
> > The fix is trivial: just drop the duplicated line.
> > 
> > Fixes: f6ae22d64433 ("docs: ipmb: place it at driver-api and convert to ReST")
> > Fixes: ac499fba98c3 ("docs: ipmb: place it at driver-api and convert to ReST")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Interesting...I wonder how applying the patch twice could lead to the line
> being inserted in two completely different locations like that?  Anyway,
> I've applied this one, hopefully nobody else will do the same :)

Probably this was due to some manual conflict resolution when applying
one of the versions of it ;-)

No big harm, and with newer Sphinx versions, we should be able 
to detect similar cases in the future.

Thanks,
Mauro
