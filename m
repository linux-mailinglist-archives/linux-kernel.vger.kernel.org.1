Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9E11CE119
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgEKRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:02:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730066AbgEKRCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589216564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHGPNIROFnT34Gvs2WU2Vk5cOji6+ep42HfonVjndto=;
        b=eaTfarSx4ZxOVpqi9tzB40YOU7+NFWrM9t6m96zihYCUSJv89f5GxZnl/dLu9YG9nl/YHF
        vuXPwOldqrdTzgB8y3y1TrEd7zLQUJyuaiFG8Otu0M5ALuELLRlWvKS1ytHGExvlJ/RK8h
        4TOtVAsWw1ZbvP7aQjEt5gTeTM81S84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-OommdsRmNVS5rn2GtVOEow-1; Mon, 11 May 2020 13:02:42 -0400
X-MC-Unique: OommdsRmNVS5rn2GtVOEow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2922D1899529;
        Mon, 11 May 2020 17:02:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09ADC5C254;
        Mon, 11 May 2020 17:02:36 +0000 (UTC)
Date:   Mon, 11 May 2020 13:02:35 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        song@kernel.org, breeves@redhat.com, mpatocka@redhat.com,
        khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v4 0/2] Historical Service Time Path Selector
Message-ID: <20200511170235.GA7719@redhat.com>
References: <20200511163910.3778467-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511163910.3778467-1-krisman@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11 2020 at 12:39pm -0400,
Gabriel Krisman Bertazi <krisman@collabora.com> wrote:

> Hi,
> 
> This fourth version of HST applies the suggestion from Mikulas Patocka
> to do the ktime_get_ns inside the mpath map_bio instead of generic
> device-mapper code. This means that struct dm_mpath_io gained another
> 64bit field.  For the request-based case, we continue to use the block
> layer start time information.
> 
> With this modification, I was able obtain similar performance on  BIO
> to request-based multipath with HST on the benchmarks shared in v1.
> 
> v3: https://www.redhat.com/archives/dm-devel/2020-April/msg00308.html
> v2: https://www.redhat.com/archives/dm-devel/2020-April/msg00270.html
> v1: https://www.redhat.com/archives/dm-devel/2020-April/msg00176.html

I already staged your v3 in linux-next.  Please provide an incremental
patch that layers on this git branch:

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.8

I was hopeful for a flag to be set (e.g. in 'struct path_selector') to
reflect whether the path selector expects highres start_time.  Makes
little sense to incur that extra cost of providing the time if the path
selector doesn't even use it.

Alternatively, could split out the setting of the time needed by .end_io
to a new path_selector_type method (e.g. .set_start_time).  And then
only use ktime_get_ns() for bio-based if .set_start_time is defined.
Would get a little fiddly needing to make sure a stale start_time isn't
used... also, makes more sense to conditionally call this
.set_start_time just after .start_io is.

Mike

