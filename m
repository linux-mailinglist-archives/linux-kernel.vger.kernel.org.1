Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6853E1E37D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgE0FTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgE0FTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:19:06 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BE0207E8;
        Wed, 27 May 2020 05:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590556745;
        bh=+Gu7Ms819qce1QK403qJCBSwes3RbCCCLDAY5Pq8X2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7384c9qF9IFuyKS/iMi2tBagpNmaWjiDU1TY32lRPvM1CulVTZoqeY7zkRwEHesc
         V44k6+Kvdw252EsRRXIt8MolSdYOGEg1KwjNWHuOQsIX9optA3gYpuMWEfj3p+bB30
         aWKSYEGPAaVIA3MCWu73f6clJVTow1ynWJ9lRVD8=
Date:   Wed, 27 May 2020 14:18:56 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        axboe@fb.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527051856.GB24949@redsun51.ssa.fujisawa.hgst.com>
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
 <20200527050559.GA16317@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527050559.GA16317@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: fa46c6fb5d61 ("nvme/pci: move cqe check after device shutdown")
