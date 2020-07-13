Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EFF21B2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGJJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:47:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38988 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbgGJJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594374469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQvdU3iRt56w7HpkGVuSwd8XeVDq7ZK+VynoX1ee5lc=;
        b=Irx4KP3Ww0ay4Lft3Wgabh3WwkWlF9sl+vQu+qV7QzVfQd2prcuikFNKNb+ynxYRi5CjSs
        RTtHvMTUdAukrx4RVYwqbz5Rcm/eSRBwh76uk93H8VZrNNctbLrLCthJ2P3Xf/vUO0Ct7Q
        f8pEe37pzT0JwOp0+ImIxfvONkX7cfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-aWm8zGwqNZ-WDNJn0Vw6SA-1; Fri, 10 Jul 2020 05:47:47 -0400
X-MC-Unique: aWm8zGwqNZ-WDNJn0Vw6SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C69800FF1;
        Fri, 10 Jul 2020 09:47:46 +0000 (UTC)
Received: from T590 (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F49B6FEF4;
        Fri, 10 Jul 2020 09:47:39 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:47:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Remove unnecessary validation before calling
 blk_mq_sched_completed_request()
Message-ID: <20200710094735.GB3417252@T590>
References: <969d0e9f637b2a0dbfb3d284abfbed6fc7665ea4.1593846855.git.baolin.wang7@gmail.com>
 <20200710082304.GB29262@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710082304.GB29262@VM20190228-100.tbsite.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:23:04PM +0800, Baolin Wang wrote:
> Hi,
> 
> On Sat, Jul 04, 2020 at 03:28:21PM +0800, Baolin Wang wrote:
> > We've already validated the 'q->elevator' before calling ->ops.completed_request()
> > in blk_mq_sched_completed_request(), thus no need to validate rq->internal_tag again,
> > and remove it.
> 
> A gentle ping?

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

