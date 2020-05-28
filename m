Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F431E670E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404863AbgE1QFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 12:05:08 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:17500 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404688AbgE1QFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:05:06 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 28 May 2020 09:05:02 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 0782FB1646;
        Thu, 28 May 2020 12:05:05 -0400 (EDT)
Date:   Thu, 28 May 2020 09:05:05 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 3/3] objtool: Add support for relocations without
 addends
Message-ID: <20200528160505.GX9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <933488b79c91ba040e68847fe53531fd97b18e07.1590597288.git.mhelsley@vmware.com>
 <20200528142414.rzk5mvz4nwhsjcwp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528142414.rzk5mvz4nwhsjcwp@treble>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:24:14AM -0500, Josh Poimboeuf wrote:
> On Wed, May 27, 2020 at 09:42:33AM -0700, Matt Helsley wrote:
> > @@ -525,16 +556,8 @@ static int read_relocs(struct elf *elf)
> >  				return -1;
> >  			}
> >  			memset(reloc, 0, sizeof(*reloc));
> > -
> > -			if (!gelf_getrela(sec->data, i, &reloc->rela)) {
> > -				WARN_ELF("gelf_getrela");
> > +			if (read_reloc(sec, i, reloc, &symndx))
> >  				return -1;
> > -			}
> 
> I try to avoid function pointers, them being slow and ugly and all.
> 
> Since it's just a single call site, I'd rather a direct call.  For
> example, call read_reloc(), which has an if-then to decide which
> subfunction to call.

OK, I'll take the function pointers out in favor of switches.

Cheers,
	-Matt Helsley
