Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65071E4DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgE0S6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 14:58:25 -0400
Received: from verein.lst.de ([213.95.11.211]:52007 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgE0S6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:58:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0885868B05; Wed, 27 May 2020 20:33:14 +0200 (CEST)
Date:   Wed, 27 May 2020 20:33:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        ming.lei@redhat.com
Subject: Re: [PATCH v2 1/1] nvme-pci: avoid race between
 nvme_reap_pending_cqes() and nvme_poll()
Message-ID: <20200527183313.GA7331@lst.de>
References: <20200527161352.21227-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527161352.21227-1-dongli.zhang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.7.
