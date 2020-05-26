Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66471BA6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgD0Oxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 10:53:40 -0400
Received: from verein.lst.de ([213.95.11.211]:48733 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgD0Oxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:53:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 593EA68C7B; Mon, 27 Apr 2020 16:53:38 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:53:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 2/9] loop: Factor out setting loop device size
Message-ID: <20200427145338.GB5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-3-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-3-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:42:15AM +0200, Martijn Coenen wrote:
> This code is used repeatedly.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
