Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10D22432FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 05:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHMDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 23:55:41 -0400
Received: from ale.deltatee.com ([204.191.154.188]:41344 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHMDzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mut7N42mh5vYAnOGpRQfTephvtNDrJcec2/m7aRKhb0=; b=K8LgK7r8nixrKQsEJO7cKuUmi5
        85iU3LQed/6W8Jblqn1daLqQqiDKsepKA3iAsMumiAH5v3UVTRsBX7m/OVFVuyQUjHQqoffztqlzi
        +fpod/sxu2YxplgTD8K+g8EoMTXg9P6KbMdiOQ7CJCQtGxZknapgf4wYecK3B/OwVUPWMaCw4l08t
        WHUMrEtC3cKJTfUoVRXkKAfahj5gLCam/zHPgRNkhVZjpo2jbEdc4ybItCYYjdtIE2roKouxoeniX
        nKN2zs13wqbYsFeT5RGPM1FXmhK5+xn26xzBzXOEq+jGpqgL/kOdOXfn04ckjXOHoop/+yihs0ETg
        Pfcs7CVw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k64L1-0002aC-AP; Wed, 12 Aug 2020 21:55:36 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20200812232444.18310-1-logang@deltatee.com>
 <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <829bed01-44c9-cac7-eb1b-9d1ccca7fd47@deltatee.com>
Date:   Wed, 12 Aug 2020 21:55:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813003200.GA1640756@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, keith.busch@wdc.com, sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2] nvme: Use spin_lock_irq() when taking the ctrl->lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-08-12 6:32 p.m., Keith Busch wrote:
> There's an unrelated whitespace change in nvme_init_identify().
> Otherwise, looks fine.

Oops, sorry. can this be fixed up when it's merged?

Logan
