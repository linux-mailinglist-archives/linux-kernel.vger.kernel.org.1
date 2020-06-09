Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBE31F3D63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFINzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 09:55:10 -0400
Received: from verein.lst.de ([213.95.11.211]:42576 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbgFINzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:55:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29DEA68B02; Tue,  9 Jun 2020 15:55:06 +0200 (CEST)
Date:   Tue, 9 Jun 2020 15:55:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        kbusch@kernel.org, axboe@fb.com
Subject: Re: [PATCH 0/2] nvme: simple cleanup
Message-ID: <20200609135506.GB10669@lst.de>
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608162002.17017-1-dongli.zhang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.9.
