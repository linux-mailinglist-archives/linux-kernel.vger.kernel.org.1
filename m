Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64B02E0B29
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgLVNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:51:43 -0500
Received: from verein.lst.de ([213.95.11.211]:59129 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbgLVNvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:51:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 07C7967373; Tue, 22 Dec 2020 14:51:00 +0100 (CET)
Date:   Tue, 22 Dec 2020 14:50:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] nvmet: fix mismatched serial
Message-ID: <20201222135059.GA32569@lst.de>
References: <20201212075801.1393924-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212075801.1393924-1-pizhenwei@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 03:58:01PM +0800, zhenwei pi wrote:
> Target side uses 'bin2hex' to convert u64 serial number to a hex
> string, saving serial number as be64 to keep the right byte order.
> Also use format '%016llx' to show the full serial string to avoid
> to drop prefixed zero.
> 
> Test on x86 server, config '0123456789abcdef' to 'attr_serial' on
> target side, and run 'nvme id-ctrl /dev/nvme0' on initiator side,
> then we can get the same SN string.

We can't change this interface any more, as it can break tons of user
space.
