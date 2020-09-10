Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F7265419
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 23:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgIJVuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 17:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbgIJMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:23 -0400
Received: from coco.lan (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A851208FE;
        Thu, 10 Sep 2020 12:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741497;
        bh=kPOBDw/9ka9jRxKxmeiFvPl/dcpSjIPubIYDikC/5SA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sKBop0vFfTGsz708b68LvN9bv279DcFtKkIHL69Eo2ibgfYu7D8L3ziVZrlv9POrB
         +IQwaPAQSNKbEGUneqT4OxF/fMPkifErOwx4x9H9htNjz4aSLe5ZQ9GbDd6VPw/3c7
         eGhUrxpd1lhiQdnJdE7PL/E0TBd6HmJfJvAZUfYY=
Date:   Thu, 10 Sep 2020 14:38:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/14] XArray: docs: add missing kernel-doc parameters
 for xas_split_alloc()
Message-ID: <20200910143812.4316722a@coco.lan>
In-Reply-To: <20200910111322.GQ6583@casper.infradead.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
        <17aed0aeb9dad9ad3a1ca97da11bec16a6283f3c.1599732764.git.mchehab+huawei@kernel.org>
        <20200910111322.GQ6583@casper.infradead.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 10 Sep 2020 12:13:22 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Thu, Sep 10, 2020 at 12:23:56PM +0200, Mauro Carvalho Chehab wrote:
> >  /**
> > - * Allocate memory for splitting an entry of @order size into the order
> > - * stored in the @xas.
> > + * xas_split_alloc() - Allocate memory for splitting an entry of
> > + *		       @order size into the order stored in the @xas.
> > + *
> > + * @xas: is the 'xarray operation state'.  It may be either a pointer to
> > + * an xa_state, or an xa_state stored on the stack.  This is an unfortunate
> > + * ambiguity.
> > + * @entry: refers to something stored in a slot in the xarray
> > + * @order: size of each entry
> > + * @gfp: GFP allocation flags
> >   */  
> 
> No.  I'll do this properly. 

Thanks! Yeah, you should be able to document it better than me, as I'm
not familiar with XArray subsystem ;-)

> Sorry for forgetting to document the arguments.

No problem. I know it was hard to identify such warnings in the past,
as we used to have hundreds of warnings. Btw, while writing this
series that finally gets rid of them, I even identified one such
warning on media that slept though my review ;-)

Thanks,
Mauro
