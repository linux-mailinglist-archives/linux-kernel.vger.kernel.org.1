Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E84B26B457
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgIOXWE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 19:22:04 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:35494 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgIOOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:38:06 -0400
Received: from tarox.wildebeest.org (tarox.wildebeest.org [172.31.17.39])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id EFF85300BC89;
        Tue, 15 Sep 2020 16:38:02 +0200 (CEST)
Received: by tarox.wildebeest.org (Postfix, from userid 1000)
        id C2D9F40006CE; Tue, 15 Sep 2020 16:38:02 +0200 (CEST)
Message-ID: <38388294c6ad7bf4abdb1b9a0bac9af5224c8fa6.camel@klomp.org>
Subject: Re: Static call dependency on libelf version?
From:   Mark Wielaard <mark@klomp.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     peterz@infradead.org, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Tue, 15 Sep 2020 16:38:02 +0200
In-Reply-To: <20200915141701.j5fnir63trpwqbfp@treble>
References: <alpine.LSU.2.11.2009142337530.1550@eggly.anvils>
         <20200915093016.GV1362448@hirez.programming.kicks-ass.net>
         <d02d57308d9e8febd569c3fd3757dbcc87b1c4a1.camel@klomp.org>
         <20200915141701.j5fnir63trpwqbfp@treble>
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

Hi Josh,

On Tue, 2020-09-15 at 09:17 -0500, Josh Poimboeuf wrote:
> On Tue, Sep 15, 2020 at 01:24:17PM +0200, Mark Wielaard wrote:
> > But all this is for ancient versions of elfutils libelf. So it is hard
> > to say and my memory might be failing. If someone can confirm 0.158
> > (which is 6 years old) works fine I would pick that as minimum version,
> > otherwise simply go with 0.168 which is 4 years old and should be on
> > most systems by now.
> 
> I just discovered elf_version(), I assume that would allow us to check
> and enforce the libelf version?

No, sorry. That is for the ELF file format version, which is and has
always been  version 1 (and I suspect it will be for the next 20
years).

There is /usr/include/elfutils/version.h which provides a
_ELFUTILS_PREREQ(major, minor) macro if you need something during
compile time.

Note that in theory libelf is a generic library (there are variants for
Solaris and BSD with which we try to be [source] compatible), but the
only actively maintained version is the elfutils one.

Cheers,

Mark
