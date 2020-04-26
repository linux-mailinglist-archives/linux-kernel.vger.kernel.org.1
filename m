Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA91B8A4F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 02:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDZAcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 20:32:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36577 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725962AbgDZAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 20:32:11 -0400
Received: (qmail 14241 invoked by uid 500); 25 Apr 2020 20:32:10 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Apr 2020 20:32:10 -0400
Date:   Sat, 25 Apr 2020 20:32:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     vladimir.stankovic@displaylink.com
cc:     gregkh@linuxfoundation.org, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <mausb-host-devel@displaylink.com>
Subject: Re: [PATCH v5 5/8] usb: mausb_host: Introduce PAL processing
In-Reply-To: <20200425091954.1610-6-vladimir.stankovic@displaylink.com>
Message-ID: <Pine.LNX.4.44L0.2004252027360.13475-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 vladimir.stankovic@displaylink.com wrote:

> Protocol adaptation layer (PAL) implementation has been added to
> introduce MA-USB structures and logic.
> 
> Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>

...

> +	/*
> +	 * Masking URB_SHORT_NOT_OK flag as SCSI driver is adding it where it
> +	 * should not, so it is breaking the USB drive on the linux
> +	 */
> +	urb->transfer_flags &= ~URB_SHORT_NOT_OK;

Removing the SHORT_NOT_OK flag is _not_ a valid thing to do.  It will 
cause drivers to malfunction.

Can you please explain this comment?

	What SCSI driver?

	When is the flag being added?

	How does it break USB drives?

	Why haven't you already reported this problem to the 
	appropriate maintainers?

Alan Stern

