Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31D726A41C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIOLZ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 07:25:56 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:59090 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgIOLYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:24:25 -0400
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 6D5F830002FC;
        Tue, 15 Sep 2020 13:24:17 +0200 (CEST)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id CE8B440006CE; Tue, 15 Sep 2020 13:24:17 +0200 (CEST)
Message-ID: <d02d57308d9e8febd569c3fd3757dbcc87b1c4a1.camel@klomp.org>
Subject: Re: Static call dependency on libelf version?
From:   Mark Wielaard <mark@klomp.org>
To:     peterz@infradead.org, Hugh Dickins <hughd@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date:   Tue, 15 Sep 2020 13:24:17 +0200
In-Reply-To: <20200915093016.GV1362448@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
         <20200915093016.GV1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on gnu.wildebeest.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Peter,

On Tue, 2020-09-15 at 11:30 +0200, peterz@infradead.org wrote:
> On Tue, Sep 15, 2020 at 12:50:54AM -0700, Hugh Dickins wrote:
> > CONFIG_HAVE_STATIC_CALL=y
> > CONFIG_HAVE_STATIC_CALL_INLINE=y
> > stand out as new in the .config for 5.9-rc5-mm1, and references
> > to objtool in static_call.h and static_call_types.h took me to
> > tools/objtool/Makefile, with its use of libelf.
> > 
> > I've copied over files of the newer libelf (0.168) to the failing
> > machines, which are now building the 5.9-rc5-mm1 vmlinux correctly.
> > 
> > It looks as if CONFIG_HAVE_STATIC_CALL=y depends on a newer libelf
> > than I had before (0.155), and should either insist on a minimum
> > version, or else be adjusted to work with older versions.
> 
> Hurmph, I have no idea how this happened; clearly none of my machines
> have this older libelf :/ (the machines I use most seem to be on
> 0.180).
> 
> I'm also not sure what static_call is doing different from say orc
> data generation. Both create and fill sections in similar ways.
> 
> Mark, do you have any idea?

0.155 is more than 8 years old. Given that 0.168 (4 years old) works
fine and this might be an interaction with objtool, which if I remember
correctly uses ELF_C_RDWR to manipulate an ELF file in place, I suspect
it might be:

commit 88ad5ddb71bd1fa8ed043a840157ebf23c0057b3
Author: Mark Wielaard <mjw@redhat.com>
Date:   Tue Nov 5 16:27:32 2013 +0100

    libelf: Write all section headers if elf flags contains ELF_F_DIRTY.
    
    When ehdr e_shoff changes, elf flags is set dirty. This indicates that
    the section header moved because sections were added/removed or changed
    in size.
    
    Reported-by: Jiri Slaby <jslaby@suse.cz>
    Signed-off-by: Mark Wielaard <mjw@redhat.com>

Which is described as elfutils-0.157-15-g88ad5ddb so was in elfutils
0.158, but not before. At least the issue seems to mimics the bug
report a little:
https://sourceware.org/legacy-ml/elfutils-devel/imported/msg03724.html

But all this is for ancient versions of elfutils libelf. So it is hard
to say and my memory might be failing. If someone can confirm 0.158
(which is 6 years old) works fine I would pick that as minimum version,
otherwise simply go with 0.168 which is 4 years old and should be on
most systems by now.

Cheers,

Mark
