Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432911B886F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 20:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgDYSMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 14:12:44 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50711 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726061AbgDYSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 14:12:44 -0400
Received: (qmail 29597 invoked by uid 500); 25 Apr 2020 14:12:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2020 14:12:42 -0400
Date:   Sat, 25 Apr 2020 14:12:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Oliver Neukum <oneukum@suse.com>
cc:     Pete Zaitcev <zaitcev@redhat.com>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+be5b5f86a162a6c281e6@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in usblp_bulk_read
In-Reply-To: <1587835881.19130.3.camel@suse.com>
Message-ID: <Pine.LNX.4.44L0.2004251410050.29378-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020, Oliver Neukum wrote:

> Am Donnerstag, den 23.04.2020, 12:29 -0400 schrieb Alan Stern:
> > On Thu, 23 Apr 2020, Oliver Neukum wrote:
> 
> > The only suspicious thing I see is that usblp_resume() calls 
> > handle_bidir() without first acquiring any mutex.  But resume shouldn't 
> > race with disconnect.
> 
> Right.
> 
> > The only other place where read URBs get submitted is under
> > usblp_read(), which does acquire the mutex
> 
> Right.
> 
> >  and checks for disconnection
> > while holding it.
> 
> Where? It should, but I do not see where it does so.

usblp_read() calls usblp_rwait_and_lock(), which calls usblp_rtest(), 
which returns -ENODEV if usblp->present is clear.

Alan Stern

