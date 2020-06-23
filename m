Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22990205730
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbgFWQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:27:56 -0400
Received: from verein.lst.de ([213.95.11.211]:39847 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgFWQ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:27:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 078AE68AEF; Tue, 23 Jun 2020 18:27:52 +0200 (CEST)
Date:   Tue, 23 Jun 2020 18:27:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported
 macro
Message-ID: <20200623162751.GA4846@lst.de>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com> <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> Introduce a new capability macro to indicate if the controller
> supports the memory buffer or not, instead of reading the
> NVME_REG_CMBSZ register.

This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
a backwards incompatible change, as the CMB addressing scheme can lead
to data corruption.  The CMBS was added as part of the horribe hack
that also involves the CBA field, which we'll need to see before
using it to work around the addressing issue.  At the same time we
should also continue supporting the legacy pre-1.4 CMB with a warning
(and may reject it if we know we run in a VM).
