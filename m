Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188C92587A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 07:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIAFrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 01:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAFrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:47:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795B12087D;
        Tue,  1 Sep 2020 05:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598939219;
        bh=QaG3/rBMRYAANZWx2ugTj+2VOdfslHDof0tq4Vo/tko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N/zAUdQTxbnNoXgZ/dUG6rsk/Kx2NIpkT1XXRlRPugC/qgPv9Kgnfpa6fJMFpPsgF
         RnSrUTcm1JPEKWzsTVbOVbI5T2IkcoHIPJ7wjdeulkGUoTfT1+euiZHy5us/e6Fp+T
         bxLZruhXf4FGw33CkIw0xS6RqyL13TGH/t/AW7rI=
Date:   Tue, 1 Sep 2020 14:46:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] Documentation: tracing: Add %return suffix
 description
Message-Id: <20200901144656.35ced5c71cc07b45fe2d1da9@kernel.org>
In-Reply-To: <20200901072745.9ca00fc7efeabe9f0cf479e6@kernel.org>
References: <159887792384.1330989.5993224243767476896.stgit@devnote2>
        <159887797048.1330989.6092698289026009625.stgit@devnote2>
        <210c7494-da9e-5314-c648-917493081c32@infradead.org>
        <20200901072745.9ca00fc7efeabe9f0cf479e6@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 07:27:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 31 Aug 2020 11:50:20 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 8/31/20 5:46 AM, Masami Hiramatsu wrote:
> > > Add a description of the %return suffix option for kprobe tracer.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  Documentation/trace/kprobetrace.rst |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > > index c1709165c553..d29d1f9e6721 100644
> > > --- a/Documentation/trace/kprobetrace.rst
> > > +++ b/Documentation/trace/kprobetrace.rst
> > 
> > Check spacing:
> > 
> > > @@ -37,6 +38,7 @@ Synopsis of kprobe_events
> > >  		  based on SYM+offs or MEMADDR.
> > >   MOD		: Module name which has given SYM.
> > >   SYM[+offs]	: Symbol+offset where the probe is inserted.
> > > + SYM%return     : Return address of the symbol
> > >   MEMADDR	: Address where the probe is inserted.
> > >   MAXACTIVE	: Maximum number of instances of the specified function that
> > >  		  can be probed simultaneously, or 0 for the default value
> > 
> > If I remove the '+', the ':' lines up but the SYM does not line up.
> > Am I missing something?
> > 
> > @@ -37,6 +38,7 @@ Synopsis of kprobe_events
> >  		  based on SYM+offs or MEMADDR.
> >   MOD		: Module name which has given SYM.
> >   SYM[+offs]	: Symbol+offset where the probe is inserted.
> >  SYM%return     : Return address of the symbol
> >   MEMADDR	: Address where the probe is inserted.
> >   MAXACTIVE	: Maximum number of instances of the specified function that
> >  		  can be probed simultaneously, or 0 for the default value
> > 
> 

Shouldn't we use the horizontal tab in .rst ? It seems other lines
use a tab to indent, but this line doesn't (VIM converted the tab to spaces.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
