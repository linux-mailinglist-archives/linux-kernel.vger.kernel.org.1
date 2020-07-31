Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52F2349CD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbgGaRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 13:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgGaRBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:01:52 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F2F22083B;
        Fri, 31 Jul 2020 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596214911;
        bh=bSAymtNHCBDr8Kx95kjWuEFdlUC8QYDCH5apu40tVUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNF3PNHrT80TOZ5SOJ/cHUlaTcFc7jFFalO1uXzLK34V8wRAC2tAzGh0tp9D+8s5n
         uNbE/7wgOZs8dgXGe2OpJ7P53nqFJztGrIWbigNKIEtqb2DABcfwaPf6BKqXI2Z2v6
         sL9ODyPW2NCtmbzEjkYcZEZrVvp/+yorikBLE6bI=
Date:   Fri, 31 Jul 2020 12:07:55 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vim: linux-kernel: Increase columns highlighting to 100+
Message-ID: <20200731170755.GB1726@embeddedor>
References: <20200731163301.GA8004@embeddedor>
 <4e30e2df7bec0fedf1a29f7825fbb4c12593eac9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e30e2df7bec0fedf1a29f7825fbb4c12593eac9.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 09:35:42AM -0700, Joe Perches wrote:
> On Fri, 2020-07-31 at 11:33 -0500, Gustavo A. R. Silva wrote:
> > Increase columns highlighting to 100+ once the 80-column warning has
> > been deprecated in the Linux kernel[1].
> > 
> > [1] commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  plugin/linuxsty.vim | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
> > index 6f7e331..c42ce72 100644
> > --- a/plugin/linuxsty.vim
> > +++ b/plugin/linuxsty.vim
> > @@ -62,7 +62,7 @@ function s:LinuxFormatting()
> >      setlocal tabstop=8
> >      setlocal shiftwidth=8
> >      setlocal softtabstop=8
> > -    setlocal textwidth=80
> > +    setlocal textwidth=100
> 
> This is not a good change.
> 80 columns is still _preferred_.
> 

Now that you mention that, I have mixed feelings about this.
Let's see if we can get more opinions...

--
Gustavo

> 
> >      setlocal noexpandtab
> >  
> >      setlocal cindent
> > @@ -80,7 +80,7 @@ function s:LinuxHighlighting()
> >      highlight default link LinuxError ErrorMsg
> >  
> >      syn match LinuxError / \+\ze\t/     " spaces before tab
> > -    syn match LinuxError /\%>80v[^()\{\}\[\]<>]\+/ " virtual column 81 and more
> > +    syn match LinuxError /\%>100v[^()\{\}\[\]<>]\+/ " virtual column 101 and more
> >  
> >      " Highlight trailing whitespace, unless we're in insert mode and the
> >      " cursor's placed right after the whitespace. This prevents us from having
> 
