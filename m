Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC41F3CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgFINoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 09:44:55 -0400
Received: from verein.lst.de ([213.95.11.211]:42520 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFINoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:44:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1915C68B02; Tue,  9 Jun 2020 15:44:53 +0200 (CEST)
Date:   Tue, 9 Jun 2020 15:44:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: constify static struct blk_mq_ops
Message-ID: <20200609134452.GB10030@lst.de>
References: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528222507.390172-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.8.
