Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708C32935F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405329AbgJTHmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:42:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731568AbgJTHmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:42:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603179726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IyHsTupE9fuRCreVd/5Khl5usGRzJYicWfZVGY98Tjk=;
        b=o88PlNkVACqAvIX4H5PqG/DTmKfZqGqoXRwIJizXfHw8wI1qJGLezu0+0hNa0tQV/TiFBj
        HLI9fye+zlRG5VDv7wrokipiFK/zb4Gf3j7Caf4jKrTMzfYglJaGtXwsYizmkOd091BNaY
        u3UbVvQuDv0THJu8SzSxBe8n/rYNTtU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F0A6AE09;
        Tue, 20 Oct 2020 07:42:06 +0000 (UTC)
Message-ID: <09636f3b8dbd3838ba7a568f611a0323e85c4404.camel@suse.com>
Subject: Re: [PATCH] usb: cdc-acm: fix cooldown mechanism
From:   Oliver Neukum <oneukum@suse.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Pascal Vizeli <pascal.vizeli@nabucasa.com>
Date:   Tue, 20 Oct 2020 09:41:34 +0200
In-Reply-To: <20201019170702.150534-1-jbrunet@baylibre.com>
References: <20201019170702.150534-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 19.10.2020, 19:07 +0200 schrieb Jerome Brunet:
> Commit a4e7279cd1d1 ("cdc-acm: introduce a cool down") is causing
> regression if there is some USB error, such as -EPROTO.
> 
> This has been reported on some samples of the Odroid-N2 using the Combee II
> Zibgee USB dongle.
> 
> > struct acm *acm = container_of(work, struct acm, work)
> 
> is incorrect in case of a delayed work and causes warnings, usually from
> the workqueue:
> 
> > WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:1474 __queue_work+0x480/0x528.
> 
> When this happens, USB eventually stops working completely after a while.
> Also the ACM_ERROR_DELAY bit is never set, so the cooldown mechanism
> previously introduced cannot be triggered and acm_submit_read_urb() is
> never called.
> 
> This changes makes the cdc-acm driver use a single delayed work, fixing the
> pointer arithmetic in acm_softint() and set the ACM_ERROR_DELAY when the
> cooldown mechanism appear to be needed.
> 
> Fixes: a4e7279cd1d1 ("cdc-acm: introduce a cool down")
> Reported-by: Pascal Vizeli <pascal.vizeli@nabucasa.com>
> Cc: Oliver Neukum <oneukum@suse.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

