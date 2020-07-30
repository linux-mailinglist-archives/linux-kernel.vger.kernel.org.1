Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD2232C03
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgG3GoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 02:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgG3GoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:44:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3918206D7;
        Thu, 30 Jul 2020 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596091446;
        bh=MVEIO7FfojzQztFXL9hSu5cyY0RA3fORSt6UPu4rm/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1FiKYPaH2+h9zer3nVVTKIHkZyRLDJ55pAj6CjKudvNPdyLel5Bga4zkaFViIkaD
         tYYTFcNOoljvUQlJxHVm1X0htfpq+0F2sYd4y2wQuzzEZ7NmX78+j0PY7thuwNc5Yv
         LLSCs2cm9lxqKt0VhIjQzYkCNLfqLoKhgpZuVuXE=
Date:   Thu, 30 Jul 2020 08:43:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Migrate workqueue to RT priority
 for processing events
Message-ID: <20200730064356.GA3910237@kroah.com>
References: <20200730022457.3021112-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730022457.3021112-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 07:24:57PM -0700, Badhri Jagan Sridharan wrote:
> "tReceiverResponse 15 ms Section 6.6.2
> The receiver of a Message requiring a response Shall respond
> within tReceiverResponse in order to ensure that the
> sender’s SenderResponseTimer does not expire."
> 
> When the cpu complex is busy running other lower priority
> work items, TCPM's work queue sometimes does not get scheduled
> on time to meet the above requirement from the spec.
> Moving to kthread_work apis to run with real time priority.
> Just lower than the default threaded irq priority,
> MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).
> 
> Further, as observed in 1ff688209e2e, moving to hrtimers to
> overcome scheduling latency while scheduling the delayed work.
> 
> TCPM has three work streams:
> 1. tcpm_state_machine
> 2. vdm_state_machine
> 3. event_work
> 
> tcpm_state_machine and vdm_state_machine both schedule work in
> future i.e. delayed. Hence each of them have a corresponding
> hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.
> 
> When work is queued right away kthread_queue_work is used.
> Else, the relevant timer is programmed and made to queue
> the kthread_work upon timer expiry.
> 
> kthread_create_worker only creates one kthread worker thread,
> hence single threadedness of workqueue is retained.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes since v1:(Guenter's suggestions)
> - Remove redundant call to hrtimer_cancel while calling
>   hrtimer_start.
> 
> Changes since v2:(Greg KH's suggestions)
> - Rebase usb-next TOT.
>   633198cd2945b7 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workqueue to RT priority for processing events
>   fa56dd9152ef95 (origin/usb-next) Merge tag 'usb-serial-5.9-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
>   25252919a1050e xhci: dbgtty: Make some functions static
>   b0e02550346e67 xhci: dbc: Make function xhci_dbc_ring_alloc() static
>   ca6377900974c3 Revert "usb: dwc2: override PHY input signals with usb role switch support"
>   09df709cb5aeb2 Revert "usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs"
>   17a82716587e9d USB: iowarrior: fix up report size handling for some devices
>   e98ba8cc3f8a89 Merge tag 'usb-for-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
>   c97793089b11f7 Merge 5.8-rc7 into usb-next
>   92ed301919932f (tag: v5.8-rc7, origin/usb-linus, origin/main) Linux 5.8-rc7
> 

Hm, still does not apply.  I think it has something to do with other
patches that landed before yours, can you rebase again?

thanks,

greg k-h
