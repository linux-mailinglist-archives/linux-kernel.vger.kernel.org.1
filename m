Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B77216154
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgGFWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 18:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgGFWKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:10:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB9B206E9;
        Mon,  6 Jul 2020 22:10:54 +0000 (UTC)
Date:   Mon, 6 Jul 2020 18:10:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, torvalds@linux-foundation.org
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <20200706181052.174c290a@oasis.local.home>
In-Reply-To: <1cceba0f-c8ad-260d-9a09-5417bee32d50@gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <1cceba0f-c8ad-260d-9a09-5417bee32d50@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 00:31:49 +0300
Pavel Begunkov <asml.silence@gmail.com> wrote:
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 2657a55c6f12..4b15ab671089 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
> >  problem, which is called the function-growth-hormone-imbalance syndrome.
> >  See chapter 6 (Functions).
> >  
> > +For symbol names, avoid introducing new usage of the words 'slave' and
> > +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> > +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> > +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> > +'denylist'.  
> 
> "Subordinate" means that they are unequal, and inequality is a big issue. This

And if two objects are unequal, then that seems to be an appropriate
term. We are not concerned about the inequality of devices.

-- Steve
