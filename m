Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01D29C99D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460398AbgJ0UFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1830753AbgJ0UEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:04:43 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965AF2222C;
        Tue, 27 Oct 2020 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603829082;
        bh=f+2hjx0YuqPqtRa+YtUvmPaLqiGcwczmgW7+ZwGJdrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NU0KV8zW5ixCAu+sNYnAH6LjIGq57HEQiDTruW66p/XuJi+agDC0uCFDvRfJGKuwm
         xBuME07GZ1sMYD+XuQolKP8fi43DApYhwyL1CkpUO4+qEn/BfIRoJwr6NgLf7A1/ox
         DQ345kGma6N7sYoDvZ7S2Ja1xdpf6xh/XgY7UWag=
Date:   Tue, 27 Oct 2020 13:04:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 1/4] block: keyslot-manager: Introduce passthrough
 keyslot manager
Message-ID: <20201027200441.GA2416412@gmail.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015214632.41951-2-satyat@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:46:29PM +0000, Satya Tangirala wrote:
> +/**
> + * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
> + * @ksm: The keyslot manager to init
> + *
> + * Initialize a passthrough keyslot manager.
> + * Called by e.g. storage drivers to set up a keyslot manager in their
> + * request_queue, when the storage driver wants to manage its keys by itself.
> + * This is useful for inline encryption hardware that doesn't have the concept
> + * of keyslots, and for layered devices.
> + *
> + * See blk_ksm_init() for more details about the parameters.
> + */
> +void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm)
> +{
> +	memset(ksm, 0, sizeof(*ksm));
> +	init_rwsem(&ksm->lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_ksm_init_passthrough);

The last paragraph of the comment ("See blk_ksm_init() for more details about
the parameters.") isn't useful and should be removed.

Otherwise this patch looks fine.  You can add:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
