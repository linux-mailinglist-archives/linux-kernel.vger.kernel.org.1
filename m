Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563281C7272
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgEFOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 10:08:50 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35679 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725915AbgEFOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:08:50 -0400
Received: (qmail 14706 invoked by uid 500); 6 May 2020 10:08:49 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 May 2020 10:08:49 -0400
Date:   Wed, 6 May 2020 10:08:49 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <zaitcev@redhat.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
In-Reply-To: <1588756482.13662.20.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.2005061008030.13334-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020, Oliver Neukum wrote:

> Am Donnerstag, den 30.04.2020, 11:11 -0400 schrieb Alan Stern:
> 
> > KASAN is documented.  The difficulty is that this race is obviously 
> > hard to trigger, and without the ability to reproduce it we can't run 
> > diagnostics to find the underlying cause.
> > 
> > We can't even ask syzbot to try running tests for us; without a valid 
> > reproducer it won't agree to rerun the original test program.
> 
> 
> Very well. We are not going to find it without exceptional luck. Yet
> there may be a real issue, too. We simply do not know. How about the
> attached patch?

It's okay with me (apart from the typo in the patch description: "UB").

Alan Stern

