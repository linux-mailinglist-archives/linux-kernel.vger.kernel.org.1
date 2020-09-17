Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDD26D6E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgIQIjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:39:43 -0400
Received: from verein.lst.de ([213.95.11.211]:55343 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgIQIjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:39:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF02968BEB; Thu, 17 Sep 2020 10:30:15 +0200 (CEST)
Date:   Thu, 17 Sep 2020 10:30:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix doulbe irq free
Message-ID: <20200917083015.GB4595@lst.de>
References: <20200916153700.5572-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916153700.5572-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:37:00AM -0400, Tong Zhang wrote:
> the irq might already been released before reset work can run

If it is we have a problem with the state machine, as we shouldn't
have two resets running at the same time.  Can you share your reproducer?

