Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5612F56F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbhANB4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbhAMXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:47:27 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4666C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:46:18 -0800 (PST)
Received: from jlbec by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzpq8-00A5k3-1M; Wed, 13 Jan 2021 23:46:12 +0000
Date:   Wed, 13 Jan 2021 15:46:08 -0800
From:   Joel Becker <jlbec@evilplan.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 3/4] configfs: implement committable items
Message-ID: <X/+GQIhGmyHlIe0+@google.com>
Mail-Followup-To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20201125152247.30809-1-brgl@bgdev.pl>
 <20201125152247.30809-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125152247.30809-4-brgl@bgdev.pl>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 04:22:46PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This implements configfs committable items. We mostly follow the
> documentation except that we extend config_group_ops with uncommit_item()
> callback for reverting the changes made by commit_item().

Woohoo!  A long time coming, but thank you for working on the
implementation!

> Each committable group has two sub-directories: pending and live. New
> items can only be created in pending/. Attributes can only be modified
> while the item is in pending/. Once it's ready to be committed, it must
> be moved over to live/ using the rename() system call. This is when the
> commit_item() function will be called.

The original API intended for live items to still be modifyable.  The
live/ path forbids mkdir()/rmdir(), but it allows store().  Otherwise,
items can't be adjusted at all while in use, which is severely limiting.
Obviously the store() handler must not allow transitions from
valid-value->invalid-value, but the handler would reject invalid values
anyway, wouldn't it?

> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> index 1f0270229d7b..a20e55fd05e8 100644
> --- a/fs/configfs/file.c
> +++ b/fs/configfs/file.c
> @@ -243,9 +243,17 @@ fill_write_buffer(struct configfs_buffer * buffer, const char __user * buf, size
>  static int
>  flush_write_buffer(struct file *file, struct configfs_buffer *buffer, size_t count)
>  {
> +	struct config_item *parent_item = buffer->item->ci_parent;
>  	struct configfs_fragment *frag = to_frag(file);
> +	struct configfs_dirent *sd;
>  	int res = -ENOENT;
>  
> +	if (parent_item && parent_item->ci_dentry) {
> +		sd = parent_item->ci_dentry->d_fsdata;
> +		if (sd->s_type & CONFIGFS_GROUP_LIVE)
> +			return -EPERM;
> +	}
> +
>  	down_read(&frag->frag_sem);
>  	if (!frag->frag_dead)
>  		res = buffer->attr->store(buffer->item, buffer->page, count);

Basically, I would just leave this hunk out.

Thanks,
Joel

-- 

"Now Someone's on the telephone, desperate in his pain.
 Someone's on the bathroom floor doing her cocaine.
 Someone's got his finger on the button in some room.
 No one can convince me we aren't gluttons for our doom."

			http://www.jlbec.org/
			jlbec@evilplan.org
