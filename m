Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5023287601
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgJHO2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729992AbgJHO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602167280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2DqGTurTSdnreVGrCWwogl9N4t6aIEaM1wwUSTbToDg=;
        b=PHrFZ+yZvvMI8zaKA2gkVFFSAVtdWpW28ZZ/6yV3iRJONS1GASb9DYDQcu2qs/l+eO39H8
        bMsrblokS+Q6uQYdwa0cAlZJAvyVy3h8NzubA61UUcDSpIO5bJbxVDYNRIY+chepAgxhcF
        dvygy8LXJFs9inWQICItNRtK8qs2+bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-WtrUfIQSO--Kp-9O1ho9Pg-1; Thu, 08 Oct 2020 10:27:56 -0400
X-MC-Unique: WtrUfIQSO--Kp-9O1ho9Pg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89413191E2AF;
        Thu,  8 Oct 2020 14:27:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.132])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1A42B6EF63;
        Thu,  8 Oct 2020 14:27:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  8 Oct 2020 16:27:55 +0200 (CEST)
Date:   Thu, 8 Oct 2020 16:27:53 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH 4/6] kernel: add support for TIF_NOTIFY_SIGNAL
Message-ID: <20201008142752.GI9995@redhat.com>
References: <20201005150438.6628-1-axboe@kernel.dk>
 <20201005150438.6628-5-axboe@kernel.dk>
 <20201008135325.GG9995@redhat.com>
 <b691ff60-8847-e48f-956b-41f8f5c1275b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b691ff60-8847-e48f-956b-41f8f5c1275b@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08, Jens Axboe wrote:
>
> On 10/8/20 7:53 AM, Oleg Nesterov wrote:
> >> --- a/kernel/entry/kvm.c
> >> +++ b/kernel/entry/kvm.c
> >> @@ -8,6 +8,9 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
> >>  	do {
> >>  		int ret;
> >>
> >> +		if (ti_work & _TIF_NOTIFY_SIGNAL)
> >> +			tracehook_notify_signal();
> >
> > Can't really comment this change, but to me it would be more safe to
> > simply return -EINTR.
> >
> > Or perhaps even better, treat _TIF_NOTIFY_SIGNAL and _TIF_SIGPENDING
> > equally:
> >
> > 	-	if (ti_work & _TIF_SIGPENDING) {
> > 	+	if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
> > 			kvm_handle_signal_exit(vcpu);
> > 			return -EINTR;
>
> Not sure I follow your logic here. Why treat it any different than
> NOTIFY_RESUME from this perspective?

Ah, good point, I din't notice that xfer_to_guest_mode_work() handles
TIF_NOTIFY_RESUME.

Thanks, then I think this change is fine.

Oleg.

