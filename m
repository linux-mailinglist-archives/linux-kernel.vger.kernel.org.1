Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57532C6774
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgK0OG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730811AbgK0OG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:06:26 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC30206D8;
        Fri, 27 Nov 2020 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606485985;
        bh=Ux3DKpJU3rq2gHaeVjqKyd+buN3/6fWlqg8gl1rTGbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnEGHsHMKhGWTNSzPVa/gnQ0jP+qhJG7l25qunzrTlI8sgpP4jq430hf0SISthJN+
         5G0f0kowzA4sH9foHoi9w5kw5dfn1RovdtU05UOP0uVeRuxBJBFYpuwYbxsx0YkHJh
         IrtVW/986CllWIZBsOfVT24yw9spcqhNXCRT+bpU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     balbi@kernel.org
Cc:     peter.chen@nxp.com, willmcvicker@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/5] USB: gadget: f_fs: remove likely/unlikely
Date:   Fri, 27 Nov 2020 15:05:59 +0100
Message-Id: <20201127140559.381351-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127140559.381351-1-gregkh@linuxfoundation.org>
References: <20201127140559.381351-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are used way too often in this file, in some ways that are actually
wrong.  Almost all of these are already known by the compiler and CPU so
just remove them all as none of these should be on any "hot paths" where
it actually matters.

Cc: Felipe Balbi <balbi@kernel.org>
Reported-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c | 179 ++++++++++++++---------------
 1 file changed, 89 insertions(+), 90 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index a34a7c96a1ab..9047b20b6715 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -296,11 +296,11 @@ static int __ffs_ep0_queue_wait(struct ffs_data *ffs, char *data, size_t len)
 	reinit_completion(&ffs->ep0req_completion);
 
 	ret = usb_ep_queue(ffs->gadget->ep0, req, GFP_ATOMIC);
-	if (unlikely(ret < 0))
+	if (ret < 0)
 		return ret;
 
 	ret = wait_for_completion_interruptible(&ffs->ep0req_completion);
-	if (unlikely(ret)) {
+	if (ret) {
 		usb_ep_dequeue(ffs->gadget->ep0, req);
 		return -EINTR;
 	}
@@ -337,7 +337,7 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 
 	/* Acquire mutex */
 	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
-	if (unlikely(ret < 0))
+	if (ret < 0)
 		return ret;
 
 	/* Check state */
@@ -345,7 +345,7 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 	case FFS_READ_DESCRIPTORS:
 	case FFS_READ_STRINGS:
 		/* Copy data */
-		if (unlikely(len < 16)) {
+		if (len < 16) {
 			ret = -EINVAL;
 			break;
 		}
@@ -360,7 +360,7 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 		if (ffs->state == FFS_READ_DESCRIPTORS) {
 			pr_info("read descriptors\n");
 			ret = __ffs_data_got_descs(ffs, data, len);
-			if (unlikely(ret < 0))
+			if (ret < 0)
 				break;
 
 			ffs->state = FFS_READ_STRINGS;
@@ -368,11 +368,11 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 		} else {
 			pr_info("read strings\n");
 			ret = __ffs_data_got_strings(ffs, data, len);
-			if (unlikely(ret < 0))
+			if (ret < 0)
 				break;
 
 			ret = ffs_epfiles_create(ffs);
-			if (unlikely(ret)) {
+			if (ret) {
 				ffs->state = FFS_CLOSING;
 				break;
 			}
@@ -381,7 +381,7 @@ static ssize_t ffs_ep0_write(struct file *file, const char __user *buf,
 			mutex_unlock(&ffs->mutex);
 
 			ret = ffs_ready(ffs);
-			if (unlikely(ret < 0)) {
+			if (ret < 0) {
 				ffs->state = FFS_CLOSING;
 				return ret;
 			}
@@ -495,7 +495,7 @@ static ssize_t __ffs_ep0_read_events(struct ffs_data *ffs, char __user *buf,
 	spin_unlock_irq(&ffs->ev.waitq.lock);
 	mutex_unlock(&ffs->mutex);
 
-	return unlikely(copy_to_user(buf, events, size)) ? -EFAULT : size;
+	return copy_to_user(buf, events, size) ? -EFAULT : size;
 }
 
 static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
@@ -514,7 +514,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 	/* Acquire mutex */
 	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
-	if (unlikely(ret < 0))
+	if (ret < 0)
 		return ret;
 
 	/* Check state */
@@ -536,7 +536,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 	case FFS_NO_SETUP:
 		n = len / sizeof(struct usb_functionfs_event);
-		if (unlikely(!n)) {
+		if (!n) {
 			ret = -EINVAL;
 			break;
 		}
@@ -567,9 +567,9 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 		spin_unlock_irq(&ffs->ev.waitq.lock);
 
-		if (likely(len)) {
+		if (len) {
 			data = kmalloc(len, GFP_KERNEL);
-			if (unlikely(!data)) {
+			if (!data) {
 				ret = -ENOMEM;
 				goto done_mutex;
 			}
@@ -586,7 +586,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 		/* unlocks spinlock */
 		ret = __ffs_ep0_queue_wait(ffs, data, len);
-		if (likely(ret > 0) && unlikely(copy_to_user(buf, data, len)))
+		if ((ret > 0) && (copy_to_user(buf, data, len)))
 			ret = -EFAULT;
 		goto done_mutex;
 
@@ -608,7 +608,7 @@ static int ffs_ep0_open(struct inode *inode, struct file *file)
 
 	ENTER();
 
-	if (unlikely(ffs->state == FFS_CLOSING))
+	if (ffs->state == FFS_CLOSING)
 		return -EBUSY;
 
 	file->private_data = ffs;
@@ -657,7 +657,7 @@ static __poll_t ffs_ep0_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &ffs->ev.waitq, wait);
 
 	ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
-	if (unlikely(ret < 0))
+	if (ret < 0)
 		return mask;
 
 	switch (ffs->state) {
@@ -706,7 +706,7 @@ static const struct file_operations ffs_ep0_operations = {
 static void ffs_epfile_io_complete(struct usb_ep *_ep, struct usb_request *req)
 {
 	ENTER();
-	if (likely(req->context)) {
+	if (req->context) {
 		struct ffs_ep *ep = _ep->driver_data;
 		ep->status = req->status ? req->status : req->actual;
 		complete(req->context);
@@ -716,10 +716,10 @@ static void ffs_epfile_io_complete(struct usb_ep *_ep, struct usb_request *req)
 static ssize_t ffs_copy_to_iter(void *data, int data_len, struct iov_iter *iter)
 {
 	ssize_t ret = copy_to_iter(data, data_len, iter);
-	if (likely(ret == data_len))
+	if (ret == data_len)
 		return ret;
 
-	if (unlikely(iov_iter_count(iter)))
+	if (iov_iter_count(iter))
 		return -EFAULT;
 
 	/*
@@ -885,7 +885,7 @@ static ssize_t __ffs_epfile_read_buffered(struct ffs_epfile *epfile,
 		return ret;
 	}
 
-	if (unlikely(iov_iter_count(iter))) {
+	if (iov_iter_count(iter)) {
 		ret = -EFAULT;
 	} else {
 		buf->length -= ret;
@@ -906,10 +906,10 @@ static ssize_t __ffs_epfile_read_data(struct ffs_epfile *epfile,
 	struct ffs_buffer *buf;
 
 	ssize_t ret = copy_to_iter(data, data_len, iter);
-	if (likely(data_len == ret))
+	if (data_len == ret)
 		return ret;
 
-	if (unlikely(iov_iter_count(iter)))
+	if (iov_iter_count(iter))
 		return -EFAULT;
 
 	/* See ffs_copy_to_iter for more context. */
@@ -930,7 +930,7 @@ static ssize_t __ffs_epfile_read_data(struct ffs_epfile *epfile,
 	 * in struct ffs_epfile for full read_buffer pointer synchronisation
 	 * story.
 	 */
-	if (unlikely(cmpxchg(&epfile->read_buffer, NULL, buf)))
+	if (cmpxchg(&epfile->read_buffer, NULL, buf))
 		kfree(buf);
 
 	return ret;
@@ -968,7 +968,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 
 	/* We will be using request and read_buffer */
 	ret = ffs_mutex_lock(&epfile->mutex, file->f_flags & O_NONBLOCK);
-	if (unlikely(ret))
+	if (ret)
 		goto error;
 
 	/* Allocate & copy */
@@ -1013,7 +1013,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		spin_unlock_irq(&epfile->ffs->eps_lock);
 
 		data = ffs_alloc_buffer(io_data, data_len);
-		if (unlikely(!data)) {
+		if (!data) {
 			ret = -ENOMEM;
 			goto error_mutex;
 		}
@@ -1033,7 +1033,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		ret = usb_ep_set_halt(ep->ep);
 		if (!ret)
 			ret = -EBADMSG;
-	} else if (unlikely(data_len == -EINVAL)) {
+	} else if (data_len == -EINVAL) {
 		/*
 		 * Sanity Check: even though data_len can't be used
 		 * uninitialized at the time I write this comment, some
@@ -1068,12 +1068,12 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		req->complete = ffs_epfile_io_complete;
 
 		ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
-		if (unlikely(ret < 0))
+		if (ret < 0)
 			goto error_lock;
 
 		spin_unlock_irq(&epfile->ffs->eps_lock);
 
-		if (unlikely(wait_for_completion_interruptible(&done))) {
+		if (wait_for_completion_interruptible(&done)) {
 			/*
 			 * To avoid race condition with ffs_epfile_io_complete,
 			 * dequeue the request first then check
@@ -1115,7 +1115,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
 		req->complete = ffs_epfile_async_io_complete;
 
 		ret = usb_ep_queue(ep->ep, req, GFP_ATOMIC);
-		if (unlikely(ret)) {
+		if (ret) {
 			io_data->req = NULL;
 			usb_ep_free_request(ep->ep, req);
 			goto error_lock;
@@ -1166,7 +1166,7 @@ static int ffs_aio_cancel(struct kiocb *kiocb)
 
 	spin_lock_irqsave(&epfile->ffs->eps_lock, flags);
 
-	if (likely(io_data && io_data->ep && io_data->req))
+	if (io_data && io_data->ep && io_data->req)
 		value = usb_ep_dequeue(io_data->ep, io_data->req);
 	else
 		value = -EINVAL;
@@ -1185,7 +1185,7 @@ static ssize_t ffs_epfile_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	if (!is_sync_kiocb(kiocb)) {
 		p = kzalloc(sizeof(io_data), GFP_KERNEL);
-		if (unlikely(!p))
+		if (!p)
 			return -ENOMEM;
 		p->aio = true;
 	} else {
@@ -1222,7 +1222,7 @@ static ssize_t ffs_epfile_read_iter(struct kiocb *kiocb, struct iov_iter *to)
 
 	if (!is_sync_kiocb(kiocb)) {
 		p = kzalloc(sizeof(io_data), GFP_KERNEL);
-		if (unlikely(!p))
+		if (!p)
 			return -ENOMEM;
 		p->aio = true;
 	} else {
@@ -1384,7 +1384,7 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 
 	inode = new_inode(sb);
 
-	if (likely(inode)) {
+	if (inode) {
 		struct timespec64 ts = current_time(inode);
 
 		inode->i_ino	 = get_next_ino();
@@ -1416,11 +1416,11 @@ static struct dentry *ffs_sb_create_file(struct super_block *sb,
 	ENTER();
 
 	dentry = d_alloc_name(sb->s_root, name);
-	if (unlikely(!dentry))
+	if (!dentry)
 		return NULL;
 
 	inode = ffs_sb_make_inode(sb, data, fops, NULL, &ffs->file_perms);
-	if (unlikely(!inode)) {
+	if (!inode) {
 		dput(dentry);
 		return NULL;
 	}
@@ -1467,12 +1467,11 @@ static int ffs_sb_fill(struct super_block *sb, struct fs_context *fc)
 				  &simple_dir_inode_operations,
 				  &data->perms);
 	sb->s_root = d_make_root(inode);
-	if (unlikely(!sb->s_root))
+	if (!sb->s_root)
 		return -ENOMEM;
 
 	/* EP0 file */
-	if (unlikely(!ffs_sb_create_file(sb, "ep0", ffs,
-					 &ffs_ep0_operations)))
+	if (!ffs_sb_create_file(sb, "ep0", ffs, &ffs_ep0_operations))
 		return -ENOMEM;
 
 	return 0;
@@ -1560,13 +1559,13 @@ static int ffs_fs_get_tree(struct fs_context *fc)
 		return invalf(fc, "No source specified");
 
 	ffs = ffs_data_new(fc->source);
-	if (unlikely(!ffs))
+	if (!ffs)
 		return -ENOMEM;
 	ffs->file_perms = ctx->perms;
 	ffs->no_disconnect = ctx->no_disconnect;
 
 	ffs->dev_name = kstrdup(fc->source, GFP_KERNEL);
-	if (unlikely(!ffs->dev_name)) {
+	if (!ffs->dev_name) {
 		ffs_data_put(ffs);
 		return -ENOMEM;
 	}
@@ -1652,7 +1651,7 @@ static int functionfs_init(void)
 	ENTER();
 
 	ret = register_filesystem(&ffs_fs_type);
-	if (likely(!ret))
+	if (!ret)
 		pr_info("file system registered\n");
 	else
 		pr_err("failed registering file system (%d)\n", ret);
@@ -1697,7 +1696,7 @@ static void ffs_data_put(struct ffs_data *ffs)
 {
 	ENTER();
 
-	if (unlikely(refcount_dec_and_test(&ffs->ref))) {
+	if (refcount_dec_and_test(&ffs->ref)) {
 		pr_info("%s(): freeing\n", __func__);
 		ffs_data_clear(ffs);
 		BUG_ON(waitqueue_active(&ffs->ev.waitq) ||
@@ -1739,7 +1738,7 @@ static void ffs_data_closed(struct ffs_data *ffs)
 static struct ffs_data *ffs_data_new(const char *dev_name)
 {
 	struct ffs_data *ffs = kzalloc(sizeof *ffs, GFP_KERNEL);
-	if (unlikely(!ffs))
+	if (!ffs)
 		return NULL;
 
 	ENTER();
@@ -1829,11 +1828,11 @@ static int functionfs_bind(struct ffs_data *ffs, struct usb_composite_dev *cdev)
 		return -EBADFD;
 
 	first_id = usb_string_ids_n(cdev, ffs->strings_count);
-	if (unlikely(first_id < 0))
+	if (first_id < 0)
 		return first_id;
 
 	ffs->ep0req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
-	if (unlikely(!ffs->ep0req))
+	if (!ffs->ep0req)
 		return -ENOMEM;
 	ffs->ep0req->complete = ffs_ep0_complete;
 	ffs->ep0req->context = ffs;
@@ -1889,7 +1888,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 		epfile->dentry = ffs_sb_create_file(ffs->sb, epfile->name,
 						 epfile,
 						 &ffs_epfile_operations);
-		if (unlikely(!epfile->dentry)) {
+		if (!epfile->dentry) {
 			ffs_epfiles_destroy(epfiles, i - 1);
 			return -ENOMEM;
 		}
@@ -1927,7 +1926,7 @@ static void ffs_func_eps_disable(struct ffs_function *func)
 	spin_lock_irqsave(&func->ffs->eps_lock, flags);
 	while (count--) {
 		/* pending requests get nuked */
-		if (likely(ep->ep))
+		if (ep->ep)
 			usb_ep_disable(ep->ep);
 		++ep;
 
@@ -1961,7 +1960,7 @@ static int ffs_func_eps_enable(struct ffs_function *func)
 		}
 
 		ret = usb_ep_enable(ep->ep);
-		if (likely(!ret)) {
+		if (!ret) {
 			epfile->ep = ep;
 			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
 			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
@@ -2034,12 +2033,12 @@ static int __must_check ffs_do_single_desc(char *data, unsigned len,
 #define __entity_check_ENDPOINT(val)   ((val) & USB_ENDPOINT_NUMBER_MASK)
 #define __entity(type, val) do {					\
 		pr_vdebug("entity " #type "(%02x)\n", (val));		\
-		if (unlikely(!__entity_check_ ##type(val))) {		\
+		if (!__entity_check_ ##type(val)) {			\
 			pr_vdebug("invalid entity's value\n");		\
 			return -EINVAL;					\
 		}							\
 		ret = entity(FFS_ ##type, &val, _ds, priv);		\
-		if (unlikely(ret < 0)) {				\
+		if (ret < 0) {						\
 			pr_debug("entity " #type "(%02x); ret = %d\n",	\
 				 (val), ret);				\
 			return ret;					\
@@ -2164,7 +2163,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 
 		/* Record "descriptor" entity */
 		ret = entity(FFS_DESCRIPTOR, (u8 *)num, (void *)data, priv);
-		if (unlikely(ret < 0)) {
+		if (ret < 0) {
 			pr_debug("entity DESCRIPTOR(%02lx); ret = %d\n",
 				 num, ret);
 			return ret;
@@ -2175,7 +2174,7 @@ static int __must_check ffs_do_descs(unsigned count, char *data, unsigned len,
 
 		ret = ffs_do_single_desc(data, len, entity, priv,
 			&current_class);
-		if (unlikely(ret < 0)) {
+		if (ret < 0) {
 			pr_debug("%s returns %d\n", __func__, ret);
 			return ret;
 		}
@@ -2281,7 +2280,7 @@ static int __must_check ffs_do_single_os_desc(char *data, unsigned len,
 	/* loop over all ext compat/ext prop descriptors */
 	while (feature_count--) {
 		ret = entity(type, h, data, len, priv);
-		if (unlikely(ret < 0)) {
+		if (ret < 0) {
 			pr_debug("bad OS descriptor, type: %d\n", type);
 			return ret;
 		}
@@ -2321,7 +2320,7 @@ static int __must_check ffs_do_os_descs(unsigned count,
 			return -EINVAL;
 
 		ret = __ffs_do_os_desc_header(&type, desc);
-		if (unlikely(ret < 0)) {
+		if (ret < 0) {
 			pr_debug("entity OS_DESCRIPTOR(%02lx); ret = %d\n",
 				 num, ret);
 			return ret;
@@ -2342,7 +2341,7 @@ static int __must_check ffs_do_os_descs(unsigned count,
 		 */
 		ret = ffs_do_single_os_desc(data, len, type,
 					    feature_count, entity, priv, desc);
-		if (unlikely(ret < 0)) {
+		if (ret < 0) {
 			pr_debug("%s returns %d\n", __func__, ret);
 			return ret;
 		}
@@ -2574,20 +2573,20 @@ static int __ffs_data_got_strings(struct ffs_data *ffs,
 
 	ENTER();
 
-	if (unlikely(len < 16 ||
-		     get_unaligned_le32(data) != FUNCTIONFS_STRINGS_MAGIC ||
-		     get_unaligned_le32(data + 4) != len))
+	if (len < 16 ||
+	    get_unaligned_le32(data) != FUNCTIONFS_STRINGS_MAGIC ||
+	    get_unaligned_le32(data + 4) != len)
 		goto error;
 	str_count  = get_unaligned_le32(data + 8);
 	lang_count = get_unaligned_le32(data + 12);
 
 	/* if one is zero the other must be zero */
-	if (unlikely(!str_count != !lang_count))
+	if (!str_count != !lang_count)
 		goto error;
 
 	/* Do we have at least as many strings as descriptors need? */
 	needed_count = ffs->strings_count;
-	if (unlikely(str_count < needed_count))
+	if (str_count < needed_count)
 		goto error;
 
 	/*
@@ -2611,7 +2610,7 @@ static int __ffs_data_got_strings(struct ffs_data *ffs,
 
 		char *vlabuf = kmalloc(vla_group_size(d), GFP_KERNEL);
 
-		if (unlikely(!vlabuf)) {
+		if (!vlabuf) {
 			kfree(_data);
 			return -ENOMEM;
 		}
@@ -2638,7 +2637,7 @@ static int __ffs_data_got_strings(struct ffs_data *ffs,
 	do { /* lang_count > 0 so we can use do-while */
 		unsigned needed = needed_count;
 
-		if (unlikely(len < 3))
+		if (len < 3)
 			goto error_free;
 		t->language = get_unaligned_le16(data);
 		t->strings  = s;
@@ -2651,7 +2650,7 @@ static int __ffs_data_got_strings(struct ffs_data *ffs,
 		do { /* str_count > 0 so we can use do-while */
 			size_t length = strnlen(data, len);
 
-			if (unlikely(length == len))
+			if (length == len)
 				goto error_free;
 
 			/*
@@ -2659,7 +2658,7 @@ static int __ffs_data_got_strings(struct ffs_data *ffs,
 			 * if that's the case we simply ignore the
 			 * rest
 			 */
-			if (likely(needed)) {
+			if (needed) {
 				/*
 				 * s->id will be set while adding
 				 * function to configuration so for
@@ -2681,7 +2680,7 @@ static int __ffs_data_got_strings(struct ffs_data *ffs,
 	} while (--lang_count);
 
 	/* Some garbage left? */
-	if (unlikely(len))
+	if (len)
 		goto error_free;
 
 	/* Done! */
@@ -2828,7 +2827,7 @@ static int __ffs_func_bind_do_descs(enum ffs_entity_type type, u8 *valuep,
 
 	ffs_ep = func->eps + idx;
 
-	if (unlikely(ffs_ep->descs[ep_desc_id])) {
+	if (ffs_ep->descs[ep_desc_id]) {
 		pr_err("two %sspeed descriptors for EP %d\n",
 			  speed_names[ep_desc_id],
 			  ds->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK);
@@ -2859,12 +2858,12 @@ static int __ffs_func_bind_do_descs(enum ffs_entity_type type, u8 *valuep,
 		wMaxPacketSize = ds->wMaxPacketSize;
 		pr_vdebug("autoconfig\n");
 		ep = usb_ep_autoconfig(func->gadget, ds);
-		if (unlikely(!ep))
+		if (!ep)
 			return -ENOTSUPP;
 		ep->driver_data = func->eps + idx;
 
 		req = usb_ep_alloc_request(ep, GFP_KERNEL);
-		if (unlikely(!req))
+		if (!req)
 			return -ENOMEM;
 
 		ffs_ep->ep  = ep;
@@ -2906,7 +2905,7 @@ static int __ffs_func_bind_do_nums(enum ffs_entity_type type, u8 *valuep,
 		idx = *valuep;
 		if (func->interfaces_nums[idx] < 0) {
 			int id = usb_interface_id(func->conf, &func->function);
-			if (unlikely(id < 0))
+			if (id < 0)
 				return id;
 			func->interfaces_nums[idx] = id;
 		}
@@ -2927,7 +2926,7 @@ static int __ffs_func_bind_do_nums(enum ffs_entity_type type, u8 *valuep,
 			return 0;
 
 		idx = (*valuep & USB_ENDPOINT_NUMBER_MASK) - 1;
-		if (unlikely(!func->eps[idx].ep))
+		if (!func->eps[idx].ep)
 			return -EINVAL;
 
 		{
@@ -3110,12 +3109,12 @@ static int _ffs_func_bind(struct usb_configuration *c,
 	ENTER();
 
 	/* Has descriptors only for speeds gadget does not support */
-	if (unlikely(!(full | high | super)))
+	if (!(full | high | super))
 		return -ENOTSUPP;
 
 	/* Allocate a single chunk, less management later on */
 	vlabuf = kzalloc(vla_group_size(d), GFP_KERNEL);
-	if (unlikely(!vlabuf))
+	if (!vlabuf)
 		return -ENOMEM;
 
 	ffs->ms_os_descs_ext_prop_avail = vla_ptr(vlabuf, d, ext_prop);
@@ -3144,13 +3143,13 @@ static int _ffs_func_bind(struct usb_configuration *c,
 	 * endpoints first, so that later we can rewrite the endpoint
 	 * numbers without worrying that it may be described later on.
 	 */
-	if (likely(full)) {
+	if (full) {
 		func->function.fs_descriptors = vla_ptr(vlabuf, d, fs_descs);
 		fs_len = ffs_do_descs(ffs->fs_descs_count,
 				      vla_ptr(vlabuf, d, raw_descs),
 				      d_raw_descs__sz,
 				      __ffs_func_bind_do_descs, func);
-		if (unlikely(fs_len < 0)) {
+		if (fs_len < 0) {
 			ret = fs_len;
 			goto error;
 		}
@@ -3158,13 +3157,13 @@ static int _ffs_func_bind(struct usb_configuration *c,
 		fs_len = 0;
 	}
 
-	if (likely(high)) {
+	if (high) {
 		func->function.hs_descriptors = vla_ptr(vlabuf, d, hs_descs);
 		hs_len = ffs_do_descs(ffs->hs_descs_count,
 				      vla_ptr(vlabuf, d, raw_descs) + fs_len,
 				      d_raw_descs__sz - fs_len,
 				      __ffs_func_bind_do_descs, func);
-		if (unlikely(hs_len < 0)) {
+		if (hs_len < 0) {
 			ret = hs_len;
 			goto error;
 		}
@@ -3172,13 +3171,13 @@ static int _ffs_func_bind(struct usb_configuration *c,
 		hs_len = 0;
 	}
 
-	if (likely(super)) {
+	if (super) {
 		func->function.ss_descriptors = vla_ptr(vlabuf, d, ss_descs);
 		ss_len = ffs_do_descs(ffs->ss_descs_count,
 				vla_ptr(vlabuf, d, raw_descs) + fs_len + hs_len,
 				d_raw_descs__sz - fs_len - hs_len,
 				__ffs_func_bind_do_descs, func);
-		if (unlikely(ss_len < 0)) {
+		if (ss_len < 0) {
 			ret = ss_len;
 			goto error;
 		}
@@ -3196,7 +3195,7 @@ static int _ffs_func_bind(struct usb_configuration *c,
 			   (super ? ffs->ss_descs_count : 0),
 			   vla_ptr(vlabuf, d, raw_descs), d_raw_descs__sz,
 			   __ffs_func_bind_do_nums, func);
-	if (unlikely(ret < 0))
+	if (ret < 0)
 		goto error;
 
 	func->function.os_desc_table = vla_ptr(vlabuf, d, os_desc_table);
@@ -3217,13 +3216,13 @@ static int _ffs_func_bind(struct usb_configuration *c,
 				      d_raw_descs__sz - fs_len - hs_len -
 				      ss_len,
 				      __ffs_func_bind_do_os_desc, func);
-		if (unlikely(ret < 0))
+		if (ret < 0)
 			goto error;
 	}
 	func->function.os_desc_n =
 		c->cdev->use_os_string ? ffs->interfaces_count : 0;
 
-	if (likely(super)) {
+	if (super) {
 		func->function.ssp_descriptors =
 			usb_copy_descriptors(func->function.ss_descriptors);
 	}
@@ -3272,7 +3271,7 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	if (alt != (unsigned)-1) {
 		intf = ffs_func_revmap_intf(func, interface);
-		if (unlikely(intf < 0))
+		if (intf < 0)
 			return intf;
 	}
 
@@ -3297,7 +3296,7 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	ffs->func = func;
 	ret = ffs_func_eps_enable(func);
-	if (likely(ret >= 0))
+	if (ret >= 0)
 		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
 	return ret;
 }
@@ -3339,13 +3338,13 @@ static int ffs_func_setup(struct usb_function *f,
 	switch (creq->bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_INTERFACE:
 		ret = ffs_func_revmap_intf(func, le16_to_cpu(creq->wIndex));
-		if (unlikely(ret < 0))
+		if (ret < 0)
 			return ret;
 		break;
 
 	case USB_RECIP_ENDPOINT:
 		ret = ffs_func_revmap_ep(func, le16_to_cpu(creq->wIndex));
-		if (unlikely(ret < 0))
+		if (ret < 0)
 			return ret;
 		if (func->ffs->user_flags & FUNCTIONFS_VIRTUAL_ADDR)
 			ret = func->ffs->eps_addrmap[ret];
@@ -3599,7 +3598,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
 	ENTER();
 
 	func = kzalloc(sizeof(*func), GFP_KERNEL);
-	if (unlikely(!func))
+	if (!func)
 		return ERR_PTR(-ENOMEM);
 
 	func->function.name    = "Function FS Gadget";
@@ -3814,7 +3813,7 @@ static void ffs_closed(struct ffs_data *ffs)
 static int ffs_mutex_lock(struct mutex *mutex, unsigned nonblock)
 {
 	return nonblock
-		? likely(mutex_trylock(mutex)) ? 0 : -EAGAIN
+		? mutex_trylock(mutex) ? 0 : -EAGAIN
 		: mutex_lock_interruptible(mutex);
 }
 
@@ -3822,14 +3821,14 @@ static char *ffs_prepare_buffer(const char __user *buf, size_t len)
 {
 	char *data;
 
-	if (unlikely(!len))
+	if (!len)
 		return NULL;
 
 	data = kmalloc(len, GFP_KERNEL);
-	if (unlikely(!data))
+	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	if (unlikely(copy_from_user(data, buf, len))) {
+	if (copy_from_user(data, buf, len)) {
 		kfree(data);
 		return ERR_PTR(-EFAULT);
 	}
-- 
2.29.2

