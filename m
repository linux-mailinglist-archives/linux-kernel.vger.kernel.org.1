Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA58226069
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGTNE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:04:58 -0400
Received: from verein.lst.de ([213.95.11.211]:46827 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgGTNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:04:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9224168BFE; Mon, 20 Jul 2020 15:04:56 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:04:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] uuid: Remove unused uuid_le_to_bin() definition
Message-ID: <20200720130456.GA715@lst.de>
References: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075355.55936-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:53:55AM +0300, Andy Shevchenko wrote:
> There is no more user, so remove it.

Thanks,

applied to the uuid tree.
