Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB452281129
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbgJBLZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 07:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgJBLZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 07:25:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66850206DC;
        Fri,  2 Oct 2020 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601637907;
        bh=GdW7nIffpaI3CS7jtRMkfkeh+9fDoZ9uqoJtsNYHSdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qlH+EWoLrOC6rokmhaDB3LuZf05FihFdWLXAYRe0M06o+L9xzi7Z1XPllOg6bfM/l
         mKtmOAO0cf7d9/JkZ/n3zAPrdjlm1i9VhAXWiKN9MyHTVSrEeS+Zy31aZl6TS/BdH2
         WUQas3SgTkwiYjvmrrVtujhjdDCzKlAQOZhubfKo=
Date:   Fri, 2 Oct 2020 13:25:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
Message-ID: <20201002112506.GA3273699@kroah.com>
References: <cover.1600285923.git.joe@perches.com>
 <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
 <20200930115740.GA1611809@kroah.com>
 <1a9cac491e1813b94cde3bed67d642f52cd81e7d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a9cac491e1813b94cde3bed67d642f52cd81e7d.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 06:58:53AM -0700, Joe Perches wrote:
> On Wed, 2020-09-30 at 13:57 +0200, Greg Kroah-Hartman wrote:
> > Kees, and Rafael, I don't know if you saw this proposal from Joe for
> > sysfs files, questions below:
> 
> https://lore.kernel.org/linux-pm/5d606519698ce4c8f1203a2b35797d8254c6050a.1600285923.git.joe@perches.com/T/
> 
> > So I guess I'm asking for another developer to at least agree that this
> > feels like the right way forward here.  I don't want to start down this
> > path, only to roll them all back as it feels like pointless churn.
> 
> https://lore.kernel.org/lkml/c256eba42a564c01a8e470320475d46f@AcuMS.aculab.com/T/#mb40d265bc1dabb8bb64b0dfa29dd8eda44be056e
> 
> 
> 
> 

All now queued up, thanks!

greg k-h
