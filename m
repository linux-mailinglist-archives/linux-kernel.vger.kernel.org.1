Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C32054FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbgFWOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 10:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732738AbgFWOkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:40:16 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE362053B;
        Tue, 23 Jun 2020 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592923216;
        bh=2gzWQlrlUbt8yYSj3sO6iIOtsSAOWbEMJh9zFKnUe2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOJxyweiOt7o/Z2CRcui4ao8o1ebr70thXezTE5YZXPjHqEztwWy49qsTzyrhoG+B
         YkAp6n7KmAJDAEKAdAPxGcN+xCraiaZ4KPRSR1oxLFclIX87YCfokQEO2Thhdfr4G1
         mtl5M8jX9U99IMl3/tsVByW80AomcjrO2Essh3Ss=
Date:   Tue, 23 Jun 2020 07:40:14 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:24:32PM +0800, Baolin Wang wrote:
> From the NVMe spec, "In order to make efficient use of the non-volatile
> memory, it is often advantageous to execute multiple commands from a
> Submission Queue in parallel. For Submission Queues that are using
> weighted round robin with urgent priority class or round robin
> arbitration, host software may configure an Arbitration Burst setting".
> Thus add Arbitration Burst setting support.

But if the user changed it to something else that better matches how
they want to use queues, the driver is just going to undo that setting
on the next reset.
