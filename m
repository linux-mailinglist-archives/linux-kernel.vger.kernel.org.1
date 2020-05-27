Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40571E37A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgE0FGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 01:06:04 -0400
Received: from verein.lst.de ([213.95.11.211]:48189 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgE0FGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:06:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1A4368B02; Wed, 27 May 2020 07:06:00 +0200 (CEST)
Date:   Wed, 27 May 2020 07:05:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527050559.GA16317@lst.de>
References: <20200527004955.19463-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527004955.19463-1-dongli.zhang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you add a Fixes tag so that this gets queued up for -stable properly?

