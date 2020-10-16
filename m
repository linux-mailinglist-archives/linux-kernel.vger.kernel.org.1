Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D05E2906C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408495AbgJPOEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:04:12 -0400
Received: from verein.lst.de ([213.95.11.211]:35860 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408450AbgJPOEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:04:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E091B67357; Fri, 16 Oct 2020 16:04:08 +0200 (CEST)
Date:   Fri, 16 Oct 2020 16:04:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: Disable Write Zeroes on Sandisk Skyhawk
Message-ID: <20201016140408.GA5165@lst.de>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com> <20201013083445.12317-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013083445.12317-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.10.
