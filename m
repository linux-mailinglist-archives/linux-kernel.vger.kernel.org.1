Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303172953EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505860AbgJUVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:13:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:37646 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505852AbgJUVNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:13:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DFD392C8;
        Wed, 21 Oct 2020 21:13:47 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:13:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Message-ID: <20201021151344.4f471fbc@lwn.net>
In-Reply-To: <623fb26a8409a7b002e45bdbb6f517ac08fd508a.1602753121.git.mchehab+huawei@kernel.org>
References: <623fb26a8409a7b002e45bdbb6f517ac08fd508a.1602753121.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 11:12:06 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The ipmb file was added twice at index.rst. That
> sounds to be because the same patch was applied twice,
> via different git trees:
> 
> 	commit f6ae22d64433fd8e08654adad7966299da931bb9
> 	Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 	Commit: Jonathan Corbet <corbet@lwn.net>
> 
> 	    docs: ipmb: place it at driver-api and convert to ReST
> 
> 	commit ac499fba98c3c65078fd84fa0a62cd6f6d5837ed
> 	Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 	Commit: Corey Minyard <cminyard@mvista.com>
> 
> 	    docs: ipmb: place it at driver-api and convert to ReST
> 
> With Sphinx 4.0.0 development tree, a new warning is produced
> due to that:
> 
> 	.../Documentation/driver-api/index.rst:14: WARNING: duplicated entry found in toctree: driver-api/ipmb
> 
> The fix is trivial: just drop the duplicated line.
> 
> Fixes: f6ae22d64433 ("docs: ipmb: place it at driver-api and convert to ReST")
> Fixes: ac499fba98c3 ("docs: ipmb: place it at driver-api and convert to ReST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Interesting...I wonder how applying the patch twice could lead to the line
being inserted in two completely different locations like that?  Anyway,
I've applied this one, hopefully nobody else will do the same :)

Thanks,

jon
