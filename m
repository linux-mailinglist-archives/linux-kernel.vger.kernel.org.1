Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F25627502C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgIWFGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:06:44 -0400
Received: from verein.lst.de ([213.95.11.211]:47166 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgIWFGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:06:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B53767373; Wed, 23 Sep 2020 07:06:41 +0200 (CEST)
Date:   Wed, 23 Sep 2020 07:06:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200923050641.GA14878@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com> <20200922135956.GA23437@lst.de> <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com> <20200922164154.GA1894@lst.de> <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 04:34:45PM -0400, Tong Zhang wrote:
> Hi Christoph,
> I modified the patch a bit and now it works.

So you're still hitting the WARN_ON_ONCE?  I think we need to fix that
as well, but all the ideas I have will turn into a bigger project,
so I think I'll submit this one to Jens, and then do things
incrementally.

Can you share your reproducer?
