Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBA627BF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgI2ISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:18:16 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:58812
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbgI2ISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:18:16 -0400
X-IronPort-AV: E=Sophos;i="5.77,317,1596492000"; 
   d="scan'208";a="360311607"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 10:18:14 +0200
Date:   Tue, 29 Sep 2020 10:18:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] scripts/most_common_subject_prefix.pl: Find the most
 common commit subject prefix
In-Reply-To: <c04c10773d5fd12fac67d0dc9ebab46d41962376.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009291012560.2808@hadrien>
References: <e949cb8f12caec813c22dc3791a92e9f87670a5b.1601356990.git.joe@perches.com>  <alpine.DEB.2.22.394.2009290941260.2808@hadrien> <c04c10773d5fd12fac67d0dc9ebab46d41962376.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Sep 2020, Joe Perches wrote:

> On Tue, 2020-09-29 at 09:45 +0200, Julia Lawall wrote:
> > On Mon, 28 Sep 2020, Joe Perches wrote:
> > < This will emit a single line that is the most commonly used commit
> > > subject prefix up to and including the last colon of the commit subject
> > > for commits that _only_ include the specific file and not any other file.
> >
> > For the comma->semicolon patches, I noticed the need for a number of
> > suject lines of the form:
> >
> > hwrng: xxx - patch description
> >
> > So maybe other delimiters have to be taken into account.
>
> Maybe. Can you provide a few more examples?

Looking through git log --oneline, nothing else is jumping out.  Another
issue is colons in the message text.  I think that I check that the only
spaces have the form ": " to avoid this problem, but I do see:

88db0aa24216 all arch: remove system call sys_sysctl
92e4edba6e2 perf ftrace: Make option description initials all capital letters
(most of the perf patches seem to be like this one)

Here is another with -

27aced19e098 Input: exc3000 - add reset gpio support

Reverts seem to typically have Revert followed by the original subject
line in quotes.

julia
