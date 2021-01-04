Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2302E9C1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhADRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:36:50 -0500
Received: from verein.lst.de ([213.95.11.211]:58601 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbhADRgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:36:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2E6867373; Mon,  4 Jan 2021 18:36:07 +0100 (CET)
Date:   Mon, 4 Jan 2021 18:36:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     lalithambika.krishnakumar@intel.com
Cc:     kbusch@kernel.org, hch@lst.de, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH] nvme: avoid possible double fetch in handling CQE
Message-ID: <20210104173607.GA30626@lst.de>
References: <20201223220900.11234-1-lalithambika.krishnakumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223220900.11234-1-lalithambika.krishnakumar@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.11.
