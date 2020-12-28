Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1739C2E3105
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 13:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgL0MAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 07:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29555 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgL0MAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 07:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609070355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B77ZH4RVvlN4DS2W5XduNFHLg2L16n9zgwjAwYXRZm4=;
        b=OUeXIOmn2hkD+lxr3Y/1Xu4t0K08etIn6aT3gK2HvFDokoBT0jMsjtKNayHkyTPFHZoqfi
        HBK1rGvxZ33j1NAk49+CPc5BeJeyN5sK8FqSZNy92zREq/vY3wP+icWlzX0xy7TUfkgLxg
        Ue08QfBsRn8+FpaRo6DdmCv71FpeCnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-4BplTBqwMaC9gom0zlk6Mg-1; Sun, 27 Dec 2020 06:59:13 -0500
X-MC-Unique: 4BplTBqwMaC9gom0zlk6Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD1EC180A08A;
        Sun, 27 Dec 2020 11:59:11 +0000 (UTC)
Received: from T590 (ovpn-12-134.pek2.redhat.com [10.72.12.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 123865D719;
        Sun, 27 Dec 2020 11:59:03 +0000 (UTC)
Date:   Sun, 27 Dec 2020 19:58:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 1/3] blk-mq: allow hardware queue to get more tag while
 sharing a tag set
Message-ID: <20201227115859.GA3282759@T590>
References: <20201226102808.2534966-1-yukuai3@huawei.com>
 <20201226102808.2534966-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226102808.2534966-2-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu Kuai,

On Sat, Dec 26, 2020 at 06:28:06PM +0800, Yu Kuai wrote:
> When sharing a tag set, if most disks are issuing small amount of IO, and
> only a few is issuing a large amount of IO. Current approach is to limit
> the max amount of tags a disk can get equally to the average of total
> tags. Thus the few heavy load disk can't get enough tags while many tags
> are still free in the tag set.

Yeah, current approach just allocates same share for each active queue
which is evaluated in each timeout period.

That said you are trying to improve the following case:
- heavy IO on one or several disks, and the average share for these
  disks become bottleneck of IO performance
- small amount IO on other disks attached to the same host, and all IOs are
submitted to disk in <30 second period.

Just wondering if you may share the workload you are trying to optimize,
or it is just one improvement in theory? And what is the disk(hdd, ssd
or nvme) and host? And how many disks in your setting? And how deep the tagset
depth is?


Thanks, 
Ming

