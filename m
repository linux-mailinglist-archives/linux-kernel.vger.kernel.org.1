Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F191C83AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 09:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 03:44:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbgEGHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588837484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6uswedAMjpbqecNSfTjRCenxs9Rh0/ygb45+I7a8eQ=;
        b=Sp2AEr/7zkMDFJ98VyFjiU1eZanHM3ofW2zfYraxP2by+mOqPLYnqeJv+JcLNC7Sltkrqs
        GFnJYrDci+R4J+woT5Jen5/i0E1QQSu41/iP11Mg8D3C7rJlZj9I3N4La3cfjF+1G52z+e
        98EUVBOk7NBK0jqM6prKrVGOy9Rz7v0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-9dXyWPYcOxCf54YDKpZcrw-1; Thu, 07 May 2020 03:44:40 -0400
X-MC-Unique: 9dXyWPYcOxCf54YDKpZcrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D017C1895A2A;
        Thu,  7 May 2020 07:44:38 +0000 (UTC)
Received: from T590 (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60B945D9C5;
        Thu,  7 May 2020 07:44:27 +0000 (UTC)
Date:   Thu, 7 May 2020 15:44:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev) v3 (resend)
Message-ID: <20200507074423.GA1285373@T590>
References: <20200504124801.2832087-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504124801.2832087-1-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 02:47:52PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> can you pick up this series?
> 
> the first three patches are my take on the proposal from Yufen Yu
> to fix the use after free of the device name of the bdi device.
> 
> The rest is vaguely related cleanups.
> 
> Changes since v2:
>  - switch vboxsf to a shorter bdi name
> 
> Changes since v1:
>  - use a static dev_name buffer inside struct backing_dev_info
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

