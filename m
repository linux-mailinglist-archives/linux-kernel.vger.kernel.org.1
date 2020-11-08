Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B822AABA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKHOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:43:42 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8697C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:43:40 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r9so7237335ioo.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3uGYEJTOMgsF56siUNUkcpHFw8WkbPGQzGEhpBEWLE=;
        b=JjP5+OiwN25x2yNVrLyx0siBwn9ZOMs8uZWrXBubKAn0/bMakN8+6ERKuGz3zVsLus
         Jt+W5mUHupHGJU46YwSJjSdWRCDrVYrOKlG4yYdATbmYZxAtq1eNDhLt02wZgfzG6mWR
         uu/2d9fQcYNpAJXIaJkU1P3kyt84dQxdegetTFFpdtWIfham4lA5aF1dCvyi6dlZCaTp
         Bslab7sni7oi413OnvE/sSJI3xDmNl/cGl1DPqiUT5vGF9zyuN8z3gZQCAGrYlCdYoI1
         y3hF5PxJo80HDStV8B152EQfx8yyeLXibzqqpKT6Y6qFZmJSLjmzA2qmFINje6MlwJaM
         +8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3uGYEJTOMgsF56siUNUkcpHFw8WkbPGQzGEhpBEWLE=;
        b=fgWooUzdU8wgvZZhNeM11uzof9ilmLp2LJgi5s76YEcOgEalnoK3udybA30cpDI9Q9
         aghASq4bH/I4Gh1YewO4NXQ7TRby0izA28JegyzRnu6vbmi0/ShAhNfN6bg3Q1EUl8Jv
         ta4JwJuhDUd6dzZYVeddVXOtlXy9FTuOsWDEEeAobbteIJWQmPNIJmoOG0yNfBkiXB+x
         9Nw19m31qgjmLTkmV86G60OOi0dIkzELc2ftYz5BcXuyU7IlE2o9UPavad3G+3PknRme
         tZ/UEVhv0HJA/J/gEKpKhmTdC7B9fwc/il1DDsu3Xj5ILQy6cBGNodyFgGJSknZsV4aq
         B0Qw==
X-Gm-Message-State: AOAM530c6rVPZN5x9ViXyaBOdlRNwRuE7FWQQr2fDnVurnX98QMNIlJd
        +YY1eyxiqza/4fsSNh2Vq6obk7OMcXIpbYpXAWvI3iCgBRI=
X-Google-Smtp-Source: ABdhPJwtv6KRSQrCgztmacXKwxoCTS1cjRUkWLgE+srVIf6/2C7j7oc1bRMyYg+WCt7lQnut8i+x0NASY12CgGTipS4=
X-Received: by 2002:a6b:4401:: with SMTP id r1mr7051505ioa.78.1604846620256;
 Sun, 08 Nov 2020 06:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20201016132047.3068029-1-hch@lst.de> <20201016132047.3068029-9-hch@lst.de>
In-Reply-To: <20201016132047.3068029-9-hch@lst.de>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <gmpy.liaowx@gmail.com>
Date:   Sun, 8 Nov 2020 22:43:29 +0800
Message-ID: <CAL3PxMpk_HV40EozhWMDZgc85vvLvosJ-e9CKWyZ+tRBB27hDA@mail.gmail.com>
Subject: Re: [PATCH 8/9] pstore/blk: use the normal block device I/O path
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Stop poking into block layer internals and just open the block device
> file an use kernel_read and kernel_write on it.  Note that this means
> the transformation from name_to_dev_t can't be used anymore, and proper
> block device file names must be used.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/pstore/blk.c            | 152 +++++++++++++------------------------
>  include/linux/pstore_blk.h |   2 +
>  init/main.c                |   4 +
>  3 files changed, 57 insertions(+), 101 deletions(-)
>
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index 0430b190a1df2a..bd4eadfc9bd795 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -8,15 +8,13 @@
>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include "../../block/blk.h"
>  #include <linux/blkdev.h>
>  #include <linux/string.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/platform_device.h>
>  #include <linux/pstore_blk.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/init_syscalls.h>
>  #include <linux/mount.h>
> -#include <linux/uio.h>
>
>  static long kmsg_size = CONFIG_PSTORE_BLK_KMSG_SIZE;
>  module_param(kmsg_size, long, 0400);
> @@ -88,7 +86,6 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
>   * during the register/unregister functions.
>   */
>  static DEFINE_MUTEX(pstore_blk_lock);
> -static struct block_device *psblk_bdev;
>  static struct pstore_zone_info *pstore_zone_info;
>
>  #define check_size(name, alignsize) ({                         \
> @@ -185,70 +182,20 @@ void unregister_pstore_device(const struct pstore_zone_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(unregister_pstore_device);
>
> +static struct file *psblk_file;
> +
>  static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
>  {
> -       struct block_device *bdev = psblk_bdev;
> -       struct file file;
> -       struct kiocb kiocb;
> -       struct iov_iter iter;
> -       struct kvec iov = {.iov_base = buf, .iov_len = bytes};
> -
> -       if (!bdev)
> -               return -ENODEV;
> -
> -       memset(&file, 0, sizeof(struct file));
> -       file.f_mapping = bdev->bd_inode->i_mapping;
> -       file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
> -       file.f_inode = bdev->bd_inode;
> -       file_ra_state_init(&file.f_ra, file.f_mapping);
> -
> -       init_sync_kiocb(&kiocb, &file);
> -       kiocb.ki_pos = pos;
> -       iov_iter_kvec(&iter, READ, &iov, 1, bytes);
> -
> -       return generic_file_read_iter(&kiocb, &iter);
> +       return kernel_read(psblk_file, buf, bytes, &pos);
>  }
>
>  static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
>                 loff_t pos)
>  {
> -       struct block_device *bdev = psblk_bdev;
> -       struct iov_iter iter;
> -       struct kiocb kiocb;
> -       struct file file;
> -       ssize_t ret;
> -       struct kvec iov = {.iov_base = (void *)buf, .iov_len = bytes};
> -
> -       if (!bdev)
> -               return -ENODEV;
> -
>         /* Console/Ftrace backend may handle buffer until flush dirty zones */
>         if (in_interrupt() || irqs_disabled())
>                 return -EBUSY;
> -
> -       memset(&file, 0, sizeof(struct file));
> -       file.f_mapping = bdev->bd_inode->i_mapping;
> -       file.f_flags = O_DSYNC | __O_SYNC | O_NOATIME;
> -       file.f_inode = bdev->bd_inode;
> -
> -       init_sync_kiocb(&kiocb, &file);
> -       kiocb.ki_pos = pos;
> -       iov_iter_kvec(&iter, WRITE, &iov, 1, bytes);
> -
> -       inode_lock(bdev->bd_inode);
> -       ret = generic_write_checks(&kiocb, &iter);
> -       if (ret > 0)
> -               ret = generic_perform_write(&file, &iter, pos);
> -       inode_unlock(bdev->bd_inode);
> -
> -       if (likely(ret > 0)) {
> -               const struct file_operations f_op = {.fsync = blkdev_fsync};
> -
> -               file.f_op = &f_op;
> -               kiocb.ki_pos += ret;
> -               ret = generic_write_sync(&kiocb, ret);
> -       }
> -       return ret;
> +       return kernel_write(psblk_file, buf, bytes, &pos);
>  }
>
>  static const struct pstore_zone_ops pstore_blk_zone_ops = {
> @@ -257,68 +204,71 @@ static const struct pstore_zone_ops pstore_blk_zone_ops = {
>         .write          = psblk_generic_blk_write,
>  };
>
> -static int __init pstore_blk_init(void)
> +static int __init __pstore_blk_init(const char *name)
>  {
> -       char bdev_name[BDEVNAME_SIZE];
> -       struct block_device *bdev;
> -       int ret = -ENODEV;
> -       fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
> -       sector_t nr_sects;
> -
> +       int ret = -EINVAL;
> +
>         if (!best_effort || !blkdev[0])
>                 return 0;
>
> -       /* hold bdev exclusively */
> -       bdev = blkdev_get_by_path(blkdev, mode, blkdev);
> -       if (IS_ERR(bdev)) {
> -               dev_t devt;
> -
> -               devt = name_to_dev_t(blkdev);
> -               if (devt == 0) {
> -                       pr_err("failed to open '%s'!\n", blkdev);
> -                       return -ENODEV;
> -               }
> -               bdev = blkdev_get_by_dev(devt, mode, blkdev);
> -               if (IS_ERR(bdev)) {
> -                       pr_err("failed to open '%s'!\n", blkdev);
> -                       return PTR_ERR(bdev);
> -               }
> +       psblk_file = filp_open(name, O_RDWR | O_DSYNC | O_NOATIME | O_EXCL, 0);
> +       if (IS_ERR(psblk_file)) {
> +               ret = PTR_ERR(psblk_file);
> +               pr_err("failed to open '%s': %d!\n", name, ret);
> +               goto out;
>         }
> -
> -       nr_sects = part_nr_sects_read(bdev->bd_part);
> -       if (!nr_sects) {
> -               pr_err("not enough space for '%s'\n", blkdev);
> -               ret = -ENOSPC;
> -               goto err_put_bdev;
> +       if (!S_ISBLK(file_inode(psblk_file)->i_mode)) {
> +               pr_err("'%s' is not block device!\n", blkdev);
> +               goto out_fput;
>         }
>
> -       /* psblk_bdev must be assigned before register to pstore/blk */
> -       psblk_bdev = bdev;
> -
>         ret = register_pstore_device(&pstore_blk_zone_ops,
> -                       nr_sects << SECTOR_SHIFT, 0);
> +                       file_inode(psblk_file)->i_bdev->bd_inode->i_size, 0);
>         if (ret)
> -               goto err_put_bdev;
> +               goto out_fput;
>
> -       bdevname(bdev, bdev_name);
> -       pr_info("attached %s (no dedicated panic_write!)\n", bdev_name);
> +       pr_info("using device '%s'\n", blkdev);
>         return 0;
> -
> -err_put_bdev:
> -       blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
> -       psblk_bdev = NULL;
> +out_fput:
> +       fput(psblk_file);
> +out:
> +       psblk_file = NULL;
>         return ret;
>  }
> +
> +#ifdef MODULE
> +static int __init pstore_blk_init(void)
> +{
> +       return __pstore_blk_init(blkdev);
> +}
>  late_initcall(pstore_blk_init);
>
>  static void __exit pstore_blk_exit(void)
>  {
> -       if (!psblk_bdev)
> +       if (!psblk_file)
>                 return;
>         unregister_pstore_device(&pstore_blk_zone_ops);
> -       blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
> +       fput(psblk_file);
>  }
>  module_exit(pstore_blk_exit);
> +#else /* MODULE */
> +/*
> + * During early boot the real root file system hasn't been mounted yet,
> + * and not device nodes are present yet.  Use the same scheme to find
> + * the device that we use for mounting the root file system.
> + */
> +void __init pstore_blk_early_init(void)
> +{
> +       const char devname[] = "/dev/pstore-blk";
> +       dev_t dev = name_to_dev_t(blkdev);
> +
> +       if (!dev)
> +               return;
> +       init_unlink(devname);
> +       init_mknod(devname, S_IFBLK | 0600, new_encode_dev(dev));
> +       __pstore_blk_init(devname);

How about pstore/blk making /dev/pstore-blk node no matter build-in
or module. Then pstore/blk always opens /dev/pstore-blk. By this way,
blkdev can also be a device number if pstore/blk built as a module.

> +}
> +#endif /* MODULE */
>
>  /* get information of pstore/blk */
>  int pstore_blk_get_config(struct pstore_blk_config *info)
> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
> index 0abd412a6cb3e3..7c06b9d6740e2a 100644
> --- a/include/linux/pstore_blk.h
> +++ b/include/linux/pstore_blk.h
> @@ -39,4 +39,6 @@ struct pstore_blk_config {
>   */
>  int pstore_blk_get_config(struct pstore_blk_config *info);
>
> +void __init pstore_blk_early_init(void);
> +
>  #endif
> diff --git a/init/main.c b/init/main.c
> index 1af84337cb18d5..058cce64f70390 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -98,6 +98,7 @@
>  #include <linux/mem_encrypt.h>
>  #include <linux/kcsan.h>
>  #include <linux/init_syscalls.h>
> +#include <linux/pstore_blk.h>
>
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -1524,6 +1525,9 @@ static noinline void __init kernel_init_freeable(void)
>                 prepare_namespace();
>         }
>
> +       if (IS_BUILTIN(CONFIG_PSTORE_BLK))
> +               pstore_blk_early_init();
> +
>         /*
>          * Ok, we have completed the initial bootup, and
>          * we're essentially up and running. Get rid of the
> --
> 2.28.0
>
