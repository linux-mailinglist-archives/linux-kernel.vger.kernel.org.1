Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4922821F6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 09:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgJCHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 03:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCHY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 03:24:28 -0400
Received: from coco.lan (ip5f5ad5cf.dynamic.kabel-deutschland.de [95.90.213.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C35206CA;
        Sat,  3 Oct 2020 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601709868;
        bh=NZ6KVXDvtsl0xw2xgZYRbiM9tDJ/L3boO8rrLkSjWe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IEqDXOwJ+I6IXij6hwslUvG/tGtVkX4GcY5G8+t06cjNqxm6QX5cR67c8GZNXybqQ
         gwZKUyccW8KDnma5ikhbqFED3iwZP7r8Ydsrvfg2qttHz/BbhPGB4PkveUB2VukePy
         pExBX17D9eqHopITcfUL4Lo/XIkpI3N8iVsi6Tmg=
Date:   Sat, 3 Oct 2020 09:24:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] scripts: kernel-doc: add support for typedef enum
Message-ID: <20201003092423.58e25910@coco.lan>
In-Reply-To: <20201002120728.GH4067422@lunn.ch>
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
        <f381c13667d8794a941457f5ef771fe34788e831.1601616399.git.mchehab+huawei@kernel.org>
        <20201002120728.GH4067422@lunn.ch>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Em Fri, 2 Oct 2020 14:07:28 +0200
Andrew Lunn <andrew@lunn.ch> escreveu:

> On Fri, Oct 02, 2020 at 07:49:49AM +0200, Mauro Carvalho Chehab wrote:
> > The PHY kernel-doc markup has gained support for documenting
> > a typedef enum.
> > 
> > However, right now the parser was not prepared for it.  
> 
> Hi Mauro
> 
> Thanks for this. I'm using Sphinx 3.2.1, since that is what my Debian
> box has. So it can be hard to see the new warnings amongst the old.

Yeah, there were simply too much warnings with docs, and 3.2.1 is
even worse.

Things will improve a lot after merging my set of patches fixing
the issues for it. Yet, there are some warnings that can't currently
be fixed on Sphinx 3.2 (~10 warnings). Fixing those will require
some internal changes in Sphinx itself.

So, except if you need Sphinx 3 for some reason, I would suggest you
to uninstall it, and then use venv with Sphinx 2.4.4. The Kernel build
system should be able to provide you the commands for installing it,
once you remove the one from your PATH.

> Will this patch get merged via Jonathan Corbet's tree?

Yes, that's the plan.

Thanks,
Mauro
