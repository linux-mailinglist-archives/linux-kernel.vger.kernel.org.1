Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF173272475
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIUNAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:00:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIUNAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600693231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QbMGdGSEKCbNHlcpDxVMYwiji/WZGhd6LjylQ8KNxmc=;
        b=sJvwDXIgsaDJzaZVFypt9dI5DemxxR8DfDfQbVsusSxH7ZeIoYef+pI9sdOk+8GsPMmzGp
        q96A35YZbN+aArJfcLCOvaa5/pWU62pl0j6emV1k15QvHTu+5SMNlp6LTuKbIDYyS84Jvc
        W3D7Ee3BbjEuuL7B26VWnNI+jc1qwQ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4564AD12;
        Mon, 21 Sep 2020 13:01:07 +0000 (UTC)
Message-ID: <1600693216.2424.92.camel@suse.com>
Subject: Re: [PATCH] usb: yurex: Rearrange code not to need GFP_ATOMIC
From:   Oliver Neukum <oneukum@suse.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        johan@kernel.org, gustavoars@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 21 Sep 2020 15:00:16 +0200
In-Reply-To: <20200921125237.GA24776@duo.ucw.cz>
References: <20200920084452.GA2257@amd> <1600691092.2424.85.camel@suse.com>
         <20200921125237.GA24776@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 21.09.2020, 14:52 +0200 schrieb Pavel Machek:
> Hi!

> > 
> > Task goes to TASK_INTERRUPTIBLE
> > 
> > >  	if (retval >= 0)
> > >  		timeout = schedule_timeout(YUREX_WRITE_TIMEOUT);
> > 
> > Task turns into Sleeping Beauty until timeout
> 
> Is there way to do the allocations for submit_urb before the

No. In theory you do not even know which HC will get the URB.
Preallocating resources is impossible. I do consider this a
design bug in the usbcore API.

> prepare_to_wait? GFP_ATOMIC would be nice to avoid... and doing
> GFP_ATOMIC from normal process context just because of task_state
> seems ... wrong.

Well, then you will need to change the rest of the logic
and use a struct completion. Give the age and practical
relevance of the driver I would recommend against making
such drastic changes and let it just be in its awkward
but correct state.

	Regards
		Oliver

