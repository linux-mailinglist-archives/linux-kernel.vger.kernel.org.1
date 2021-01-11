Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED52F17E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbhAKOQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:16:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbhAKOQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:16:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF863224B1;
        Mon, 11 Jan 2021 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610374546;
        bh=3Ov5RV+7mpbSexLhdHd9S7MWOq/xuUQhaxOiewij4YY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1oyExNZYO1jczgNzJtB+me9sRmt+UXENWflKrQIgKh9hrlpGNyB/GQUnuk5Gy8r3
         hwNoaGGrLuCLR5Ys2MxE29iQNxUst+vTbbc3cY8DlJ9WlGUB6U/Z1c5bemcwDmpTO/
         GkaXVnfr+spMkM/TZ6a/evSHB1xXd16l0OBPqWRk=
Date:   Mon, 11 Jan 2021 15:16:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Message-ID: <X/xd2QQryUdiN9gv@kroah.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
 <X/xItnTyAa7OwSEI@kroah.com>
 <4D53036F-FB61-4730-87D9-4EB6B350B17F@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4D53036F-FB61-4730-87D9-4EB6B350B17F@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:05:56PM +0000, Jorgen Hansen wrote:
> On 11 Jan 2021, at 13:46, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Mon, Jan 11, 2021 at 04:18:53AM -0800, Jorgen Hansen wrote:
> >> When create the VMCI queue pair tracking data structures on the host
> >> side, the IOCTL for creating the VMCI queue pair didn't validate
> >> the queue pair size parameters. This change adds checks for this.
> >> 
> >> This avoids a memory allocation issue in qp_host_alloc_queue, as
> >> reported by nslusarek@gmx.net. The check in qp_host_alloc_queue
> >> has also been updated to enforce the maximum queue pair size
> >> as defined by VMCI_MAX_GUEST_QP_MEMORY.
> >> 
> >> The fix has been verified using sample code supplied by
> >> nslusarek@gmx.net.
> >> 
> >> Reported-by: nslusarek@gmx.net
> >> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> >> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> >> ---
> >> drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++----
> >> include/linux/vmw_vmci_defs.h           |  4 ++--
> >> 2 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - You sent multiple patches, yet no indication of which ones should be
> >  applied in which order.  Greg could just guess, but if you are
> >  receiving this email, he guessed wrong and the patches didn't apply.
> >  Please read the section entitled "The canonical patch format" in the
> >  kernel file, Documentation/SubmittingPatches for a description of how
> >  to do this so that Greg has a chance to apply these correctly.
> > 
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> > 
> > thanks,
> > 
> > greg k-h's patch email bot
> 
> Hi,
> 
> The patches are independent and should be able to apply in any order;
> I didn’t see any problems when applying them in different orders locally.
> 
> I’m hesitant to provide the patches as a series of patches, since one of
> them:
>  VMCI: Use set_page_dirty_lock() when unregistering guest memory
> is marked as fixing an original checkin, and should be considered for
> backporting, whereas the others are either not important to backport
> or rely on other recent changes. However, if formatting them as a
> series of misc fixes is preferred, I’ll do that.

If one patch is wanting to be merged now, for 5.11-final, great, don't
send it in a middle of series of other patches that are not, how am I
supposed to know any of this?

Please send them in the proper order, and as individual series for
different releases, if relevant, again, otherwise how am I supposed to
know what to do with them?

thanks,

greg k-h
