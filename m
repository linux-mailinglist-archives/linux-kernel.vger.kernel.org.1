Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B092DF14E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgLSTey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 14:34:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbgLSTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 14:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608406408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6z0RbAiLK9GTR+9ggjBwb/1gZHkBY9XWAFgiHpI1ZyE=;
        b=Q5F6XX8pspZFXiWIBHBd3jPYKCtwpJatxicI7Ld37xREc9GGoSq524lkhAJyF3aGvRDRGk
        EroVGStknnlC41YYPFLUUTNA296TM0OrQJap3xtTbwgBPVoiLX1DC/GHNc+SFUEMECm5KS
        rWYvCjvEoo6kJp+wd22mQ1sq6ZacdX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-bsrU9ddYNdOjEM0LL4A0Tg-1; Sat, 19 Dec 2020 14:33:26 -0500
X-MC-Unique: bsrU9ddYNdOjEM0LL4A0Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1EA9800D53;
        Sat, 19 Dec 2020 19:33:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.46])
        by smtp.corp.redhat.com (Postfix) with SMTP id B921E10016FF;
        Sat, 19 Dec 2020 19:33:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 19 Dec 2020 20:33:24 +0100 (CET)
Date:   Sat, 19 Dec 2020 20:33:14 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Pedro Alves <palves@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its
 pid unexpectedly
Message-ID: <20201219193313.GB9539@redhat.com>
References: <20201217142931.GA8865@redhat.com>
 <875z50roia.fsf@x220.int.ebiederm.org>
 <fc796624-2660-8c2b-0956-2c9ba8281952@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc796624-2660-8c2b-0956-2c9ba8281952@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19, Pedro Alves wrote:
>
> BTW, the problem was discovered by Simon Marchi when he tried to write
> a GDB testcase for a multi-threaded exec scenario:

OOPS! Sorry Simon, yes I forgot to add reported-by. Andrew, or Eric, if
you take this patch, could you also add

	Reported-by: Simon Marchi <simon.marchi@efficios.com>

> I've went through GDB's code looking for potential issues with the change and whether
> it would affect GDBs already in the wild.  Tricky corner cases abound, but I think
> we're good.  Feel free to add my ack:
>
> Acked-by: Pedro Alves <palves@redhat.com>

Thanks!

Oleg.

