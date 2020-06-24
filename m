Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76AC207965
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 18:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404959AbgFXQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 12:44:45 -0400
Received: from verein.lst.de ([213.95.11.211]:45167 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391226AbgFXQoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:44:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 729D968B02; Wed, 24 Jun 2020 18:44:41 +0200 (CEST)
Date:   Wed, 24 Jun 2020 18:44:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed
 fields in initializers
Message-ID: <20200624164441.GA24816@lst.de>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618200235.1104587-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks good to me, but I'd rather wait a few releases to
avoid too mush backporting pain.
