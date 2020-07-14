Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8F21EF14
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGNLTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 07:19:50 -0400
Received: from verein.lst.de ([213.95.11.211]:53949 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgGNLRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:17:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6BE1368CFE; Tue, 14 Jul 2020 13:17:46 +0200 (CEST)
Date:   Tue, 14 Jul 2020 13:17:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Message-ID: <20200714111746.GA17883@lst.de>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 02:25:21PM +0800, Baolin Wang wrote:
> We've already validated the 'kato' in nvme_start_keep_alive(), thus no
> need to validate it again in nvme_start_ctrl(). Remove it.

Thanks,

applied to nvme-5.9.
