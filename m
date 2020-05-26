Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7251B4C09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 19:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgDVRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 13:44:36 -0400
Received: from verein.lst.de ([213.95.11.211]:53946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgDVRof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:44:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 028E568C4E; Wed, 22 Apr 2020 19:44:32 +0200 (CEST)
Date:   Wed, 22 Apr 2020 19:44:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v2 5/5] loop: Add LOOP_SET_FD_AND_STATUS ioctl
Message-ID: <20200422174431.GE30852@lst.de>
References: <20200422100636.46357-1-maco@android.com> <20200422100636.46357-6-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422100636.46357-6-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	case LOOP_SET_FD: {
> +		/* legacy case - pass in a zeroed out loop_info64, which
> +		 * corresponds with the default parameters we'd have used
> +		 * otherwise.
> +		 */

Nitpick: kernel coding style always has the /* on a line of its own.
Also please capitalize the first word in a multi-line comment.

> +		struct loop_info64 info;
> +
> +		memset(&info, 0, sizeof(info));
> +		return loop_set_fd_and_status(lo, mode, bdev, arg, &info);
> +	}
> +	case LOOP_SET_FD_AND_STATUS: {
> +		struct loop_fd_and_status fds;
> +
> +		if (copy_from_user(&fds, argp, sizeof(fds)))
> +			return -EFAULT;
> +
> +		return loop_set_fd_and_status(lo, mode, bdev, fds.fd,
> +					      &fds.info);

What about actually passing the whole loop_fd_and_status structure?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
