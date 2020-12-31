Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD5A2E8197
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgLaSV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 13:21:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37464 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbgLaSV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 13:21:26 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BVIKXGn004833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Dec 2020 13:20:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AE6B515C3515; Thu, 31 Dec 2020 13:20:33 -0500 (EST)
Date:   Thu, 31 Dec 2020 13:20:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Robin Rowe <robin.rowe@cinepaint.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: C/C++ Code Reviewer Available
Message-ID: <X+4WcTkXEJFUvQzF@mit.edu>
References: <beeedada-d62f-6a94-32aa-c4c56cfbe0a0@cinepaint.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beeedada-d62f-6a94-32aa-c4c56cfbe0a0@cinepaint.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 11:45:58PM -0800, Robin Rowe wrote:
> "Linux kernel's Kroah-Hartman: We're not struggling to get new coders, it's
> code review that's the bottleneck", says article at The Register.
> 
> Ok, I've used C++ for 20 years, taught C/C++ at two universities, and
> developed real-time safety-critical systems. Need me? Contact me off-list.

Hi Robin,

It's great that you expressed an interest in contributing to the Linux
kernel!

How much experience do you have with Linux kernel coding?  Most code
reviewers specialize in a particular kernel subsystem, and often get
their start submitting patches as part of coming up to speed with that
particular subsystem so that a subsystem maintainer knows how much
they can trust a particular code review.

The real challenge is that we have plenty of people who are
enthusiastic about submitting whitespace patches and drive-by
checkpatch fixes, and/or submitting new drives or other features for
their particular employer, but we need to get them to graduate from
being entry-level coders, to being people who become senior developers
who can perform trusted code reviews --- and for their employers to
allow them to spend company time contributing back to the community.

Or for people who are willing to spend their own time on nights and
weekend doing this sort of code review work and/or bug fixes and/or
reviewing issues reported by fuzz testers or static code analyizers,
instead of just focusing on features that aren't part of drivers or
features that their companies need for their own short-term business
interest.  This does happen of course, for people who have become
super-passionate about contributing to the subsystem and the kernel
community at large, but there are many people who just submit device
drivers and/or specific kernel features because it's part of their 9-5
job.

This is most of what maintainers and other senior developers do; it's
the less glamorous "scut work" that fewer people are interested in ---
including implementing regression test frameworks, improving subsystem
documentation, investigating fuzz reports and hard-to-reproduce flaky
tests, helping to mentor and train newer engineers, and yes, code
review.  It's what's called servant-leadership.  :-)

Cheers,

				- Ted
