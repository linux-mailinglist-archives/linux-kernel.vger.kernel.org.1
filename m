Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB22CC05D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgLBPJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbgLBPJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606921655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5xJvg4nvjjgZQmxkhKVMRdu9M0gEjHhA3AT4X447g0=;
        b=VlC36XSJDtxp0jocD8K842LI4G9nV+T073oMBm25Kjs98iAuGGm7UIbAF2LN5GZKPbpy5X
        ljBFTrxxS+ZwqmjEqm3ImPZ+koqGpTAIQP8is4+6hy8LULSch3Wc1qWQ5yqkaid1BpEF9+
        RJ+6iJfvvpSy4K+QTvGPmf/6GU/Gk34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Bmuk68WSPjizgwxYJ3FhNg-1; Wed, 02 Dec 2020 10:07:29 -0500
X-MC-Unique: Bmuk68WSPjizgwxYJ3FhNg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 565048558E7;
        Wed,  2 Dec 2020 15:07:28 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AFCC5D705;
        Wed,  2 Dec 2020 15:07:27 +0000 (UTC)
Date:   Wed, 2 Dec 2020 16:07:25 +0100
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] rtc: adapt allowed RTC update error
Message-ID: <20201202150725.GA2231584@localhost>
References: <20201201143835.2054508-1-mlichvar@redhat.com>
 <20201201161224.GF5487@ziepe.ca>
 <20201201171420.GN1900232@localhost>
 <20201201173540.GH5487@ziepe.ca>
 <87mtywe2zu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtywe2zu.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 02:44:53PM +0100, Thomas Gleixner wrote:
> Something like the completely untested below should make this reliable
> and only needs to retry when the work is running late (busy machine),
> but the wakeup will be on time or at max 1 jiffie off when high
> resolution timers are not available or disabled.

It seems to work nicely. In my test most of the updates succeeded on
the first attempt hitting the right tick, the rest succeeding on the
second attempt. Only when the clock was set to run 10% faster, it
needed few more attempts to converge to the target time.

Thanks,

-- 
Miroslav Lichvar

