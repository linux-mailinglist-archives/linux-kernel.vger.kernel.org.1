Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC02FA834
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407441AbhARSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:01:45 -0500
Received: from verein.lst.de ([213.95.11.211]:49047 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407410AbhARSAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:00:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADBAC6736F; Mon, 18 Jan 2021 18:59:56 +0100 (CET)
Date:   Mon, 18 Jan 2021 18:59:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Klaus Jensen <its@irrelevant.dk>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2] nvme: allow use of cmb on v1.4 controllers
Message-ID: <20210118175956.GD9901@lst.de>
References: <20210115063046.274495-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115063046.274495-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.11 with a little tweak to remove the cmbmsc local
variable and a comment explaining what is going on.
