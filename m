Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8F2FE509
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbhAUIbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbhAUI3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:29:00 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97662C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:28:20 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y128so1250025ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzqrP1E5Rm31KGX2xrj266D7qD4HKSJ9qaN3EqFxcng=;
        b=CTjFrWPiTySEi+YPu3IsKk3tpFyr5jU5qj+EfiRiNCHcCc2VI0+uJJ9O9P8U+hhqSh
         IDRIZ74zSlzDRuDK/MHNZeRkeM8Gl6P5LRpf+19vyU5GMvMiRH8xs46MrEnhWBeDIezk
         VxZUgymc3jofTJyDOulvTFwKY8HDJZ9SSPIqZz4g2sR712TYVCu7SckmIeCPG+maO5Es
         TfDcbfKBBgHwMsIa0uml4dS1TEB14EUD4fZcQem8efAB3K9MF/dgPwdio/zWN7pkY4Az
         ALvJF+T3pQ0e721ebZnipK8YiiEOMzOSaB8d9yOYRy3VwMtg5yHBe+vsqQhAHJVT6gOg
         gViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VzqrP1E5Rm31KGX2xrj266D7qD4HKSJ9qaN3EqFxcng=;
        b=cuaxDdlaETna553GiGoG6nsgNL5GC5xO7EcMYhcJjPS/uKfO1O72qf76F3mtEdfz+i
         vD7QpVfoqxIIk0gOQSKqhJEQQfbnXXqMJEZR2D3aBnfRQjVzLDc/mL3c6erBtVJc3sTa
         qp2RDasGgvA2rmQH0OggVIbb8Zufgpjy0JSpasaZWt/k2x29cT8dQ443m66zUB/oP09N
         PMOSZIaWA3LYmllb/OoLU1ldDB9of7pIY3zOhCFtMv2bLg1ixMVBTYHhigDrG+FTJY1g
         5QAAPT+MI0XpVQ+B7YT4PxvEctDzA9C2+G1dtMjkVnfxsRwsjsxqdCiS+/9plE7vtTjO
         y4fg==
X-Gm-Message-State: AOAM533QQrhTnKel0p2j09QFlFjeedk1838XiqhjBRdVpvLwTwrtmD6N
        hTSHVnudogajfYxlLW+c3gB0y7T1NmICD1qyDCNAUg==
X-Google-Smtp-Source: ABdhPJyL6bsTwTpxJxO7woV3NKMk174dJs67bmTDIy2+D2yQ2uoKds1LkUjy0pM1zVmTX/XBezL/JDAMhSeM5LCXKPE=
X-Received: by 2002:a25:2f46:: with SMTP id v67mr6544807ybv.20.1611217699760;
 Thu, 21 Jan 2021 00:28:19 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-6-saravanak@google.com> <20210121082248.883253-1-saravanak@google.com>
In-Reply-To: <20210121082248.883253-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 21 Jan 2021 00:27:43 -0800
Message-ID: <CAGETcx9+JbVAX4uXGn5hYSd-1VK8oZeLxhGAKZksyR31xpeQhg@mail.gmail.com>
Subject: Re: [TEST PATCH v1] driver: core: Make fw_devlink=on more forgiving
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 12:22 AM Saravana Kannan <saravanak@google.com> wrote:
>
> This patch is for test purposes only and pretty experimental. Code might
> not be optimized, clean, formatted properly, etc.
>
> Please review it only for functional bugs like locking bugs, wrong
> logic, etc.
>
> It's basically trying to figure out which devices will never probe and
> ignore them. Might not always work.
>
> Marek, Geert, Marc,
>
> Can you please try this patch INSTEAD of the other workarounds we found?

Oh and can you please also try with the CONFIG_MODULES enabled vs
disabled? Or have it disabled but fix the patch so the condition
always evaluates to true.

Thanks,
Saravana

>
> Jon, Michael,
>
> I'm explicitly not including you in the "To" because this patch won't
> work for your issues.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/base.h |   3 ++
>  drivers/base/core.c | 117 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/base/dd.c   |  24 +++++++++
>  3 files changed, 142 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index f5600a83124f..8d5fd95fa147 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -106,6 +106,9 @@ struct device_private {
>  #define to_device_private_class(obj)   \
>         container_of(obj, struct device_private, knode_class)
>
> +bool fw_devlink_is_permissive(void);
> +bool fw_devlink_unblock_probe(struct device *dev);
> +
>  /* initialisation functions */
>  extern int devices_init(void);
>  extern int buses_init(void);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e61e62b624ce..8528704bbb40 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -49,7 +49,6 @@ early_param("sysfs.deprecated", sysfs_deprecated_setup);
>  static LIST_HEAD(deferred_sync);
>  static unsigned int defer_sync_state_count = 1;
>  static DEFINE_MUTEX(fwnode_link_lock);
> -static bool fw_devlink_is_permissive(void);
>
>  /**
>   * fwnode_link_add - Create a link between two fwnode_handles.
> @@ -1481,7 +1480,7 @@ u32 fw_devlink_get_flags(void)
>         return fw_devlink_flags;
>  }
>
> -static bool fw_devlink_is_permissive(void)
> +bool fw_devlink_is_permissive(void)
>  {
>         return fw_devlink_flags == FW_DEVLINK_FLAGS_PERMISSIVE;
>  }
> @@ -1552,6 +1551,120 @@ static int fw_devlink_relax_cycle(struct device *con, void *sup)
>         return ret;
>  }
>
> +static int __device_links_suppliers_available(struct device *dev)
> +{
> +       struct device_link *link;
> +       int ret = 0;
> +
> +       if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
> +           !fw_devlink_is_permissive()) {
> +               return -EPROBE_DEFER;
> +       }
> +
> +       list_for_each_entry(link, &dev->links.suppliers, c_node) {
> +               if (!(link->flags & DL_FLAG_MANAGED))
> +                       continue;
> +
> +               if (link->status != DL_STATE_AVAILABLE &&
> +                   !(link->flags & DL_FLAG_SYNC_STATE_ONLY)) {
> +                       ret = -EPROBE_DEFER;
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +bool fw_devlink_unblock_probe(struct device *dev)
> +{
> +       struct fwnode_link *link, *tmp;
> +       struct device_link *dev_link, *dev_ln;
> +       struct fwnode_handle *fwnode = dev->fwnode;
> +       bool unblocked = false;
> +
> +       if (!fw_devlink_get_flags() || fw_devlink_is_permissive())
> +               return false;
> +
> +       if (!fwnode)
> +               return false;
> +
> +       mutex_lock(&fwnode_link_lock);
> +
> +       /* Delete questionable fwnode links */
> +       list_for_each_entry_safe(link, tmp, &fwnode->suppliers, c_hook) {
> +               struct device *par_dev;
> +               struct fwnode_handle *par;
> +               bool bound;
> +
> +               /*
> +                * Walk up fwnode tree of supplier till we find a parent device
> +                * that has been added or a parent fwnode that has fwnode links
> +                * (this is a firmware node that is expected to be added as a
> +                * device in the future).
> +                */
> +               par = fwnode_get_parent(link->supplier);
> +               while (par && list_empty(&par->suppliers) && !par->dev)
> +                       par = fwnode_get_next_parent(par);
> +
> +               /* Supplier is waiting on parent device to be added. */
> +               if (par && !par->dev) {
> +                       fwnode_handle_put(par);
> +                       continue;
> +               }
> +
> +               if (par && par->dev) {
> +                       par_dev = get_dev_from_fwnode(fwnode);
> +                       device_lock(par_dev);
> +                       bound = device_is_bound(par_dev);
> +                       device_unlock(par_dev);
> +                       put_device(par_dev);
> +
> +                       /* Supplier is waiting on parent device to be bound. */
> +                       if (!bound)
> +                               continue;
> +               }
> +
> +               /*
> +                * Supplier has no parent or the immediate parent device has
> +                * been bound to a device. It should have been added by now.
> +                * So, this link is spurious. Delete it.
> +                */
> +               dev_info(dev, "Deleting fwnode link to %pfwP\n",
> +                        link->supplier);
> +               list_del(&link->s_hook);
> +               list_del(&link->c_hook);
> +               kfree(link);
> +               unblocked = true;
> +       }
> +
> +       if (IS_ENABLED(CONFIG_MODULES))
> +               goto out;
> +
> +       device_links_write_lock();
> +
> +       list_for_each_entry_safe(dev_link, dev_ln, &dev->links.suppliers,
> +                                c_node) {
> +               if (!(dev_link->flags & DL_FLAG_INFERRED) ||
> +                   dev_link->flags & DL_FLAG_SYNC_STATE_ONLY ||
> +                   dev_link->status != DL_STATE_DORMANT)
> +                       continue;
> +
> +               /* This supplier should have probed by now. */
> +               if (!__device_links_suppliers_available(dev_link->supplier)) {
> +                       dev_info(dev, "Deleting dev link to %s\n",
> +                                dev_name(dev_link->supplier));
> +                       device_link_drop_managed(dev_link);
> +                       unblocked = true;
> +               }
> +       }
> +
> +       device_links_write_unlock();
> +
> +out:
> +       mutex_unlock(&fwnode_link_lock);
> +       return unblocked;
> +}
> +
>  /**
>   * fw_devlink_create_devlink - Create a device link from a consumer to fwnode
>   * @con - Consumer device for the device link
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 2f32f38a11ed..d4ccd2a2b6a4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -301,6 +301,25 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>  }
>  static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
>
> +static bool deferred_probe_fw_devlink_unblock(void)
> +{
> +       struct device *dev;
> +       struct device_private *private;
> +       bool unblocked = false;
> +
> +       if (!fw_devlink_get_flags() || fw_devlink_is_permissive())
> +               return false;
> +
> +       mutex_lock(&deferred_probe_mutex);
> +       list_for_each_entry(private, &deferred_probe_pending_list, deferred_probe) {
> +               dev = private->device;
> +               unblocked |= fw_devlink_unblock_probe(dev);
> +       }
> +       mutex_unlock(&deferred_probe_mutex);
> +
> +       return unblocked;
> +}
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -317,6 +336,11 @@ static int deferred_probe_initcall(void)
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
>         flush_work(&deferred_probe_work);
> +
> +       while (deferred_probe_fw_devlink_unblock()) {
> +               driver_deferred_probe_trigger();
> +               flush_work(&deferred_probe_work);
> +       }
>         initcalls_done = true;
>
>         /*
> --
> 2.30.0.296.g2bfb1c46d8-goog
>
