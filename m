Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9A20AE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZI2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:28:47 -0400
Received: from verein.lst.de ([213.95.11.211]:50862 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFZI2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:28:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4C3F68B05; Fri, 26 Jun 2020 10:28:44 +0200 (CEST)
Date:   Fri, 26 Jun 2020 10:28:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme: Use USEC_PER_SEC instead of magic numbers
Message-ID: <20200626082844.GA24570@lst.de>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com> <440d84877c3bc0917790466ee85753919fb29cb5.1592980985.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440d84877c3bc0917790466ee85753919fb29cb5.1592980985.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.9.
