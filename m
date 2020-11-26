Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DE52C5411
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbgKZMj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbgKZMj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:39:57 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD08120B80;
        Thu, 26 Nov 2020 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606394396;
        bh=0PzfkZxzSz+Tr8N1gBaxXQkoZUtHrQ9csBuPBbYPTMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y5A/LGkrfnZKFDpKgXSPqk7fRrJNKGQgpwBKEfTzb/8Ru2bQXrx10CwlGf9iz4Q+6
         w2UI0ltU2L4zUnfF8CXwLqI1P7Q4aNVFbnDtp1ifatY5xrIrheDhnTXfaJtzvLILT6
         JLHiS9HDoSorgvEu3wtuAL9nqt4Kna7c1wohS6/Y=
Date:   Thu, 26 Nov 2020 13:41:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Disregard vbus off while in
 PR_SWAP_SNK_SRC_SOURCE_ON
Message-ID: <X7+iY9RSpD3wSHjr@kroah.com>
References: <20201125020703.1604979-1-badhri@google.com>
 <20201126120120.GM1008337@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126120120.GM1008337@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:01:20PM +0200, Heikki Krogerus wrote:
> On Tue, Nov 24, 2020 at 06:07:03PM -0800, Badhri Jagan Sridharan wrote:
> > During PR_SWAP sequence, when TCPM is waiting in PR_SWAP_SNK_SRC_SOURCE_ON
> > for the vbus source to ramp up, TCPM would prematurely exit
> > PR_SWAP_SNK_SRC_SOURCE_ON and transition to SNK_UNATTACHED state when a
> > vbus off notification is received. This should not be the case as vbus
> > can still be off while in PR_SWAP_SNK_SRC_SOURCE_ON and the vbus source
> > has PD_T_NEWSRC to ramp up.
> > 
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> 
> FWIW:
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks, i've added this, and your other ack, to the commits in my tree.

greg k-h
