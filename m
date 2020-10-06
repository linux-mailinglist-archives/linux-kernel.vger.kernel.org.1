Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F01284793
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgJFHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbgJFHlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601970079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFC0ISn2+rWqsHgSwE4sZ0+UQ3DhHxUZGAadpsJBkLw=;
        b=SnA6ci52OjArJTJSaAYCMYdXCqHtfbII7sEGje6ijOxmHEXl9GDSnOpEEbM1vR9B4E9+SV
        Iz1xWnvs10YKOTqB6E5GS6ria/6iLRrpTEnyeqQi/4KlDCvxnk4JnMHpw2hj9coboAbYdQ
        p/bfj68fCfXELer50PplT41HRIxJjbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-JKwoqOqxNom9jlTPhAa4hQ-1; Tue, 06 Oct 2020 03:41:15 -0400
X-MC-Unique: JKwoqOqxNom9jlTPhAa4hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3AE1868411;
        Tue,  6 Oct 2020 07:41:13 +0000 (UTC)
Received: from T590 (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4C5755767;
        Tue,  6 Oct 2020 07:41:04 +0000 (UTC)
Date:   Tue, 6 Oct 2020 15:41:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V7 0/2] percpu_ref & block: reduce memory footprint of
 percpu_ref in fast path
Message-ID: <20201006074100.GA26059@T590>
References: <20201001154842.26896-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001154842.26896-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:48:40PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st patch removes memory footprint of percpu_ref in fast path
> from 7 words to 2 words, since it is often used in fast path and
> embedded in user struct.
> 
> The 2nd patch moves .q_usage_counter to 1st cacheline of
> 'request_queue'.
> 
> Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
> per core) machine, dual socket/numa.
> 
> V7:
> 	- add comments about reason for struct split

Hello Jens

Can you consider to merge the patchset in block tree if you are fine?


Thanks,
Ming

