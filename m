Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBF1D9E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 19:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgESRsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 13:48:18 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:35950 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbgESRsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:48:18 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 May 2020 10:48:15 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 912B1B2906;
        Tue, 19 May 2020 13:48:17 -0400 (EDT)
Date:   Tue, 19 May 2020 10:48:17 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200519174817.GR9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <20200515205610.fmdimt7wbafypuqc@treble>
 <20200518195045.GQ9040@rlwimi.vmware.com>
 <20200518222754.cp7vh2qp76khfy4r@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200518222754.cp7vh2qp76khfy4r@treble>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 05:27:54PM -0500, Josh Poimboeuf wrote:
> On Mon, May 18, 2020 at 12:50:45PM -0700, Matt Helsley wrote:
> > > Why were these moved to arch.h?  They're not necessarily arch-specific,
> > > but rather "check"-specific, so I think they still belong in check.h, if
> > > possible.
> > 
> > Ah, found it. They are arch specific due to struct orc_entry, which is
> > presently not defined for any archs besides x86.
> > 
> > Prior to the patch (-> means "includes"):
> > 	check.h -> asm/orc_types.h (defines struct orc_entry)
> > 	orc_gen.c -> check,h
> > 
> > After patch:
> > 	check.c -> asm/orc_types.h
> > 	orc_gen.c -> asm/orc_types.h
> > 	orc_gen.c -> check.h
> > 	orc_gen.c -> arch.h
> > 	{ now weak.c } -> check.h
> > 
> > So this prevents the headers, which help us keep the weak definitions
> > consistent with the strong definitions, from breaking compiles on archs
> > that lack struct orc_entry.
> > 
> > I'm not sure what the best way to remove this dependency is without
> > a nasty void * for the orc entry, or some #ifdef games related to
> > checking for cpp defines from asm/orc_types.h. This approach neatly
> > avoids conditional preprocessor games and type casting though I do
> > agree it's surprising.
> > 
> > Do you have any advice here?
> 
> Would it work if we just move the check() and orc_dump() prototypes to
> objtool.h?  Then weak.c can just include objtool.h.  And check.h and
> orc.h would only need to be included for arches which implement them.

OK, I tested that and it works well. In fact it simplifies the includes
a bit so I think it might be the right move.

Cheers,
	-Matt Helsley
