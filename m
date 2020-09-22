Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7718D273CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIVH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:57:58 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:64767 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIVH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600761478; x=1632297478;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7q6qp4RZnrsNyoZoAdh8OrF1mLo5G8q76u+bCW+2zd8=;
  b=tDQsShnHLX7noUytVA0bqZMTO0O6luAol10p+szS8kX+4m3i9csoB/u9
   aAyAYzteJzlXMbBsuTKGD5o4+q6MUH9keQXIVWMp1s3A080Jp5hOZEuxZ
   0eQqFpZgDjuG592M7wRX2gdB+lNUCjCjelXa/E/KPzZu2Xz+z7Qvr5gSt
   I=;
X-IronPort-AV: E=Sophos;i="5.77,289,1596499200"; 
   d="scan'208";a="78173396"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Sep 2020 07:57:55 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id E9A50A0611;
        Tue, 22 Sep 2020 07:57:53 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.244) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 07:57:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent grants
Date:   Tue, 22 Sep 2020 09:57:32 +0200
Message-ID: <20200922075732.23767-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200922073202.GH19254@Air-de-Roger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.244]
X-ClientProxiedBy: EX13D44UWC003.ant.amazon.com (10.43.162.138) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 09:32:02 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Tue, Sep 22, 2020 at 09:01:25AM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Persistent grants feature provides high scalability.  On some small
> > systems, however, it could incur data copy overhead[1] and thus it is
> > required to be disabled.  But, there is no option to disable it.  For
> > the reason, this commit adds a module parameter for disabling of the
> > feature.
> 
> Have you considered adding a similar option for blkfront?

I will add yet another option for blkfront in the next spin.

> 
> > 
> > [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> > 
> > Signed-off-by: Anthony Liguori <aliguori@amazon.com>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  .../ABI/testing/sysfs-driver-xen-blkback        |  8 ++++++++
> >  drivers/block/xen-blkback/xenbus.c              | 17 ++++++++++++++---
> >  2 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > index ecb7942ff146..0c42285c75ee 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > @@ -35,3 +35,11 @@ Description:
> >                  controls the duration in milliseconds that blkback will not
> >                  cache any page not backed by a grant mapping.
> >                  The default is 10ms.
> > +
> > +What:           /sys/module/xen_blkback/parameters/feature_persistent
> > +Date:           September 2020
> > +KernelVersion:  5.10
> > +Contact:        SeongJae Park <sjpark@amazon.de>
> > +Description:
> > +                Whether to enable the persistent grants feature or not.
> > +                The default is 1 (enable).
> 
> I would add that this option only takes effect on newly created
> backends, existing backends when the option is set will continue to
> use persistent grants.
> 
> For already running backends you could drain the buffer of persistent
> grants and flip the option, but that's more complex and not required.

You're right, I will add the description.

> 
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > index b9aa5d1ac10b..9c03d70469f4 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -879,6 +879,12 @@ static void reclaim_memory(struct xenbus_device *dev)
> >  
> >  /* ** Connection ** */
> >  
> > +/* Enable the persistent grants feature. */
> > +static unsigned int feature_persistent = 1;
> > +module_param_named(feature_persistent, feature_persistent, int, 0644);
> > +MODULE_PARM_DESC(feature_persistent,
> > +		"Enables the persistent grants feature");
> > +
> >  /*
> >   * Write the physical details regarding the block device to the store, and
> >   * switch to Connected state.
> > @@ -906,7 +912,8 @@ static void connect(struct backend_info *be)
> >  
> >  	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
> >  
> > -	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
> > +	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
> > +			feature_persistent ? 1 : 0);
> 
> You can avoid writing the feature altogether if it's not enabled,
> there's no need to set feature-persistent = 0.

Agreed.  I will do so in the next spin.


Thanks,
SeongJae Park
