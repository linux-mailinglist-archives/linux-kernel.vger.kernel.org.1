Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305D31BAAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD0RGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 13:06:17 -0400
Received: from verein.lst.de ([213.95.11.211]:50039 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0RGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:06:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C935B68C7B; Mon, 27 Apr 2020 19:06:13 +0200 (CEST)
Date:   Mon, 27 Apr 2020 19:06:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 0/9] Add a new LOOP_SET_FD_AND_STATUS ioctl
Message-ID: <20200427170613.GA13686@lst.de>
References: <20200427074222.65369-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-1-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've just been looking over the loop driver for other reasons,
and noticed that setting the block size still isn't possible
with LOOP_SET_FD_AND_STATUS as far as I can tell.  Might that
be worth it?  Also maybe an explicit direct I/O flag, and maybe
enough padding with a future proof flags bitmap that we can easily
extend it for new features if they pop up?
