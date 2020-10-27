Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B281329A751
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895349AbgJ0JHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:07:49 -0400
Received: from verein.lst.de ([213.95.11.211]:37999 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895342AbgJ0JHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:07:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F359A68AFE; Tue, 27 Oct 2020 10:07:46 +0100 (CET)
Date:   Tue, 27 Oct 2020 10:07:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        lengchao@huawei.com
Subject: Re: [PATCH v3] nvme-rdma: handle nvme completion data length
Message-ID: <20201027090746.GC26785@lst.de>
References: <20201025115124.1430678-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025115124.1430678-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.10.
