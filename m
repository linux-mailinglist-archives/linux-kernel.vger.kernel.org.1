Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141E32A2629
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgKBIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:33:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgKBIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:33:10 -0500
Received: from coco.lan (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF0520756;
        Mon,  2 Nov 2020 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604305990;
        bh=4qISsedp366oWJviFziBEbxc4aj/ikqli0Ar2HNCIbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xJhz+6iZhPnKQyq4tN4G7ZrWW4JaElYm4aBVsXuk7Qvyhqxd9dYHfI9W/gnuyFy/+
         0QPYOAelb7s8BaQVkmImc39baO+uQXEga50YLScgiYVseyQ38btHNyz3PdWxQkV74o
         D62FAYL1D923bn9MfBsanzyfwdkuxZNYKF6tQ+18=
Date:   Mon, 2 Nov 2020 09:33:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10-rc2 (docs build)
Message-ID: <20201102093305.34ba4ff5@coco.lan>
In-Reply-To: <20201102085841.5490f6da@coco.lan>
References: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
        <ff1301ed-6040-3aac-c057-7f37184604d3@infradead.org>
        <20201102085841.5490f6da@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Nov 2020 08:58:41 +0100
Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> Hi Randy,
> 
> Em Sun, 1 Nov 2020 16:01:54 -0800
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
> > Something broke the docs build (SEVERE):
> > 
> > 
> > Sphinx parallel build error:
> > docutils.utils.SystemMessage: /home/rdunlap/lnx/lnx-510-rc2/Documentation/ABI/testing/sysfs-bus-rapidio:2: (SEVERE/4) Title level inconsistent:
> > 
> > Attributes Common for All RapidIO Devices
> > -----------------------------------------
> > 
> > 
> 
> On what tree did you notice this? Linux-next or upstream?

Also: on what Sphinx version are you getting it? I'm not
able to reproduce the issue here, neither with Sphinx 2.4.4
nor with Sphinx 3.2.1.

(building against next-20201102 and against 5.10-rc2)

Thanks,
Mauro
