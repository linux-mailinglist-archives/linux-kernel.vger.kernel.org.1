Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE642F2E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbhALLx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbhALLx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:53:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA04623104;
        Tue, 12 Jan 2021 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610452367;
        bh=OcFaWpuTodeRxcFu2GL87awHeAEwzBs2cjEtv5TrCFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2OeiarAprAPllUQOSeJA9dGvko+wUDr2wDM9EaL4Q5zeax4RxWS9lht6dSUxkGsY
         V7o1TYhe38682Te7SEWtXukbZX2yHX82e+HAEhCaohb6nwonXOfeOiXeZGoGZalp0b
         1ILshKksWTSiWLDx6noLu+3ZHF4RZQ5zi/y+X2Vs=
Date:   Tue, 12 Jan 2021 12:53:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        hdegoede@redhat.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] AMS, Collision Avoidance, and Protocol Error
Message-ID: <X/2N1LAgNRCSkWrw@kroah.com>
References: <20210105163927.1376770-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105163927.1376770-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 12:39:24AM +0800, Kyle Tso wrote:
> This series include previous patch "[v4] AMS and Collision Avoidance"
> https://lore.kernel.org/r/20201217030632.903718-1-kyletso@google.com
> and two more patches "Protocol Error handling" and "Respond Wait if...".
> 
> The patch "AMS and Collision Avoidance" in [v5] is the same as the one
> in [v4] (only rebased to ToT).
> 
> The patch "Protocol Error handling" is based on PD3 6.8.1 to fix the
> wrong handling.
> 
> The patch "Respond Wait if..." is to fix a conflict when 
> DR/PR/VCONN_SWAP occurs just after the state machine enters Ready State.
> 
> Kyle Tso (3):
>   usb: typec: tcpm: AMS and Collision Avoidance
>   usb: typec: tcpm: Protocol Error handling
>   usb: typec: tcpm: Respond Wait if VDM state machine is running
> 
>  drivers/usb/typec/tcpm/tcpm.c | 925 +++++++++++++++++++++++++++++-----
>  include/linux/usb/pd.h        |   2 +
>  include/linux/usb/tcpm.h      |   4 +
>  3 files changed, 792 insertions(+), 139 deletions(-)

Heikki, any thoughts about this series?

thanks,

greg k-h
