Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8FB2CA95A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbgLARPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgLARPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606842868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYhw/vZvk8MrQ/Lit7Nmq+GciopS/YLhUVtcN0QEwlo=;
        b=V8QtFnyj3KfR94hvAq/lOA8iaxi/f31+FpD4ygzEMwpN53REO39rJddLZS2/wOMZK/bePe
        ZSCFUfClkcl/L/T87HfiCCaoJJWmcOPJkSYWBqYqejtbTGa0B9UZj/BSDCMX5O3J9S5ZRD
        EEueWmCBOSNiIMu7LgEmZduLWiO6bBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-idkHgwGTPw6nOt4-Uxp9Uw-1; Tue, 01 Dec 2020 12:14:24 -0500
X-MC-Unique: idkHgwGTPw6nOt4-Uxp9Uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DE31805BED;
        Tue,  1 Dec 2020 17:14:23 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AC1019C44;
        Tue,  1 Dec 2020 17:14:21 +0000 (UTC)
Date:   Tue, 1 Dec 2020 18:14:20 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201201171420.GN1900232@localhost>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201161224.GF5487@ziepe.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:12:24PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 01, 2020 at 03:38:35PM +0100, Miroslav Lichvar wrote:
> > +	unsigned long time_set_nsec_fuzz;
> > +	static unsigned int attempt;
> 
> Adding a static value instide a static inline should not be done

Well, grepping through the other header files in include/linux, this
would not be the first case.

> I'm not sure using a static like this is the best idea anyhow, if you
> want something like this it should be per-rtc, not global

If there are multiple RTCs, are they all updated in this 11-minute
sync?

> Did you look at why time has become so in-accurate in your system? 5
> jiffies is usually a pretty long time?

I found no good explanation. It seems to depend on what system is
doing, if it's idle, etc. I suspect it's a property of the workqueues
that they cannot generally guarantee the jobs to run exactly on time.
I tried switching to the non-power-efficient and high priority
workqueues and it didn't seem to make a big difference.

-- 
Miroslav Lichvar

