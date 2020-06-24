Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8537206D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389472AbgFXGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 02:53:02 -0400
Received: from verein.lst.de ([213.95.11.211]:43030 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388972AbgFXGxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:53:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACFC668B05; Wed, 24 Jun 2020 08:52:58 +0200 (CEST)
Date:   Wed, 24 Jun 2020 08:52:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme: Add Arbitration Burst support
Message-ID: <20200624065258.GA18130@lst.de>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com> <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:49:57PM +0800, Baolin Wang wrote:
> >From the NVMe spec, "In order to make efficient use of the non-volatile
> memory, it is often advantageous to execute multiple commands from a
> Submission Queue in parallel. For Submission Queues that are using
> weighted round robin with urgent priority class or round robin
> arbitration, host software may configure an Arbitration Burst setting".
> Thus add Arbitration Burst setting support.

What is the value add of doing this in the kernel?  Wouldn't a nvme-cli
subcommand to just set the arbitration burst to the recommended value,
either as a saved or current value be both more useful and also cause
less kernel bloat?
