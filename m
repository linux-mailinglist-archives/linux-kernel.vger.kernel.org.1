Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18BA1CF358
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 13:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgELLaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 07:30:35 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:51232 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:30:35 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 6A3A51A40053; Tue, 12 May 2020 04:30:35 -0700 (PDT)
Date:   Tue, 12 May 2020 04:30:35 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question regarding blocking set[ug]id on processes including via
 suid executables
Message-ID: <20200512113035.easefxliufsx54mk@shells.gnugeneration.com>
References: <20200512094524.662gnls64rwjhct2@shells.gnugeneration.com>
 <20200512104408.jq3umt5hlqfbuhex@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512104408.jq3umt5hlqfbuhex@shells.gnugeneration.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:44:08AM -0700, Vito Caputo wrote:
> On Tue, May 12, 2020 at 02:45:24AM -0700, Vito Caputo wrote:
> > Hello folks,
> > 
> > I'm curious if someone knows a way to do this using existing linux
> > interfaces.
> > 
> > I'd like to create a login lacking the ability to switch uid/gid.
> > 
> > Even if the process has access to suid executables like /bin/su, and
> > the user has the root password, I'd like the descendant processes of
> > their login to be simply incapable of changing uid/gid, even when it's
> > in the form of running a program w/suid bit set on an existing and
> > accessible executable in the filesystem.  No matter what, it just
> > can't happen.
> > 
> > Do we have any such thing today?  I'd really like to be able to set
> > this on a specific user and all logins of that user are simply stuck
> > on that uid no matter what.
> > 
> 
> 
> Basically what I'm looking for is a convention for login-time
> application of the PR_SET_NO_NEW_PRIVS prctl, do we have anything
> formalized in userspace for this?  We've got NoNewPrivileges in
> systemd but it's not really user-oriented AFAIK...
> 
> Maybe lkml isn't the right place to pose this question, any pointers
> appreciated though.
> 

For posterity and comment if interested, PAM seems like a reasonable
integration point for this but I don't see any existing support
currently:

https://github.com/linux-pam/linux-pam/issues/224

I'll quit talking to myself on lkml and head to sleep now :)

Regards,
Vito Caputo
