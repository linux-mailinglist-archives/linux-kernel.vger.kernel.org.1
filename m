Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434F91F1729
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 13:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgFHLBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 07:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgFHLBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:01:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF082076A;
        Mon,  8 Jun 2020 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591614098;
        bh=x49fyr0xuV1XEupCgRZKXrj5qYCz0FvfqLfcYZx0Mwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1erz/OSTvA+nNa+hbzuS12qIiYPDOK/A7oX19gP0yaHEuSzY4YNDA58qfi9cxY67L
         td1KwKMqD9dQCq0hqorYhfjSgvoqswcApfuvbhjXIKA+Zb3ywA6XYtLAfup/xd+D+C
         6w5WDm1Z8sOlFpFuTSXxBN1R/eR8qj8131HhLEGc=
Date:   Mon, 8 Jun 2020 13:01:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>,
        Qiang Zhang <Qiang.Zhang@windriver.com>
Cc:     linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Kyungtae Kim <kt0755@gmail.com>
Subject: Re: usb: gadget: function: printer: Fix use-after-free in
 __lock_acquire()
Message-ID: <20200608110132.GA296162@kroah.com>
References: <5207d179-0a7d-b5ff-af34-102fb21028b5@web.de>
 <DM5PR11MB205835FB50BA296232BC3163FF850@DM5PR11MB2058.namprd11.prod.outlook.com>
 <ae59cac9-d770-36bd-ccb2-e5e442bd5e0a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae59cac9-d770-36bd-ccb2-e5e442bd5e0a@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 12:55:13PM +0200, Markus Elfring wrote:
> > I don't need to add Fix tag to view the code.
> 
> I have got understanding difficulties for this kind of feedback.
> How much do you care for corresponding patch review concerns?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=af7b4801030c07637840191c69eb666917e4135d#n183

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless review
comment to a patch submission on a Linux kernel developer mailing list.
I strongly suggest that you not do this anymore.  Please do not bother
developers who are actively working to produce patches and features with
comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not needed
to follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and inability
to adapt to feedback.  Please feel free to also ignore emails from them.

thanks,

greg k-h's patch email bot
