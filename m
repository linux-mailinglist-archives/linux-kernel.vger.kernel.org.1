Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A325C40D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgICPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 11:02:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbgICN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599141544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HtD2ycArY4CaDPGxp0AgCfZeRokiL+8HZRMctDc7COU=;
        b=Tf3HdTioHF35WoBl844tGSTAttZ4tkeNo+A6SE8rjwfes6nhbHyY2hMfX8dOcyu3HlRW/e
        FW0Hop8bKk8ib5UKpQc0XlKA69rm/uLXiwo8mYXSIBHM8nxB2ujuf+a9lPNnla6NTv38LQ
        b9zAgv8mJcT25tfY/V6HZdGCOGwe4hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-hE2tQMiQOVmhBt7wAYVWig-1; Thu, 03 Sep 2020 09:39:58 -0400
X-MC-Unique: hE2tQMiQOVmhBt7wAYVWig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6773A1019629;
        Thu,  3 Sep 2020 13:39:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.114])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C6AF76E01;
        Thu,  3 Sep 2020 13:39:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  3 Sep 2020 15:39:55 +0200 (CEST)
Date:   Thu, 3 Sep 2020 15:39:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -next] kdb: Use newer api for tasklist scanning
Message-ID: <20200903133951.GG4386@redhat.com>
References: <20200831193435.22141-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831193435.22141-1-dave@stgolabs.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31, Davidlohr Bueso wrote:
>
> This kills the custom kdb_do_each_thread/kdb_while_each_thread
> calls used in kdb to iterate through all tasks. It is obsolete
> and racy to use tsk->thread_group, although in this particular
> case there is no concurrency so it doesn't matter. Still, lets
> trivially replace it for the newer one, maintaining semantics,
> of course.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  kernel/debug/kdb/kdb_bt.c      | 4 ++--
>  kernel/debug/kdb/kdb_main.c    | 8 ++++----
>  kernel/debug/kdb/kdb_private.h | 4 ----
>  3 files changed, 6 insertions(+), 10 deletions(-)

Acked-by: Oleg Nesterov <oleg@redhat.com>

