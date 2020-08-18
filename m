Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C588F247F10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHRHLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:11:45 -0400
Received: from verein.lst.de ([213.95.11.211]:60474 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgHRHLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:11:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 807DD68B02; Tue, 18 Aug 2020 09:11:41 +0200 (CEST)
Date:   Tue, 18 Aug 2020 09:11:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     kbusch@kernel.org, hch@lst.de, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Message-ID: <20200818071141.GA2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com> <20200818052936.10995-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818052936.10995-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.

No, it is not.
