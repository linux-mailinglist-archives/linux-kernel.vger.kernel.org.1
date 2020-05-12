Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C924B1D0259
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 00:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgELWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 18:31:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgELWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589322672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YD4eV5Zg/zcvyFEl47MW+GCWx9tAYaUwV9UBJhWyuxU=;
        b=SQw4qi4QPfzCYHw5aKVFwZKT6HxL7CTyL/RWEmtHD9DNBqt2Rbb5KCaL1F1f3a63OUsLw+
        XT6ZEpXrl5jbBYE7dOa/8tmezEdUkr33fUUlN8pq/HQzBjE56b2jOFbnCRWb04Img6y/8r
        Kor3Y4LsqE/uIRc3lBbPsNPQ4PIMMr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-6JPl9u_LNFOfLYPirTHD0A-1; Tue, 12 May 2020 18:31:00 -0400
X-MC-Unique: 6JPl9u_LNFOfLYPirTHD0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ABF4EC1A1;
        Tue, 12 May 2020 22:30:59 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C195410001B3;
        Tue, 12 May 2020 22:30:56 +0000 (UTC)
Date:   Wed, 13 May 2020 00:31:03 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uapi, posix-timers: provide clockid-related macros
 and functions to UAPI
Message-ID: <20200512223103.GC1016@asgard.redhat.com>
References: <20190923130531.GA27774@asgard.redhat.com>
 <87y2pxvsbr.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pxvsbr.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 10:58:16PM +0300, Sergey Organov wrote:
> Eugene Syromiatnikov <esyr@redhat.com> writes:
> 
> > As of now, there is no interface exposed for converting pid/fd into
> > clockid and vice versa; linuxptp, for example, has been carrying these
> > definitions in missing.h header for quite some time[1].
> >
> > [1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h
> >
> > Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> > ---
> > Changes since v1[1]:
> >  * Actually tried to build with the patch and fixed the build error
> >    reported by kbuild test robot[2].
> >
> > [1] https://lkml.org/lkml/2019/9/20/698
> > [2] https://lkml.org/lkml/2019/9/22/13
> > ---
> >  include/linux/posix-timers.h | 47 +------------------------------------------
> >  include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+), 46 deletions(-)
> 
> Was this patch applied, rejected, lost?
> 
> I can't find it in the current master.

IIRC, it was ignored.

