Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82018269471
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgINSJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgINSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:08:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E51C06174A;
        Mon, 14 Sep 2020 11:08:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h4so1102525ioe.5;
        Mon, 14 Sep 2020 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZYM1zNvdp+0suZMOM9aLRz3jzs68cX818tEEyvWRCc=;
        b=Jy0Ir5Tj+S/MvDzXuilfUymXgGV7IdN3o13CQKyQ3/nDdrpZk+6sq58JouhmTgCm9L
         Qd3oDkLN/ode8Ofmyuy6k+AOIk+G8o+N93iML/Yqc0FDH4uPQuMOqZlLS4PSESR28hv9
         YdeeYzxu3TWvB4vUTu1v2w66oF0WvrK111SPxuCf2RZ2faqrFFLj7OOZyecvWZrCkhjU
         jyN9B4+yQN8GubM8k0x7SFwoPvxbn91svR8SoDKCccRvqlT0TQyoXXqp3EMSp9ElPsiM
         e+XCXZV4edf+LljZXr+gQxK94tGTqOhyNK6CkTPj7fZLoElz65wDA7YooR+HQsUAsYUq
         asPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZYM1zNvdp+0suZMOM9aLRz3jzs68cX818tEEyvWRCc=;
        b=olo13uDvhvfFVhaGSIJAND5ZmLpg4LkZHz24YzabMobi9N3ossgscZt47HpYO0PQBq
         3IjkWTUdJ7ifcFMQLoKFMD/EjpMUVjjPYaWSEemcX7NkgdEs0Knvbxs7fF2yAdsrqp/6
         AiSWbWCSkc2Ze4/96dJ2qV+wV0g54nYYAX3EXVS9dV2u8A7Ish448LgRzKl6P8cR239u
         +ASq1zLZndWtFaEEhfi8tn6TMRIBIBgcB+j9ipprbQj0QmS9NcKTkUCnVyJQEgsedwF+
         39YrO19mFb0LmK1N2Q7YAdt88FDg71kvFapuOCCt8WDsjUGAOfbcGMC+4z7aCvMjCDAN
         IBrA==
X-Gm-Message-State: AOAM531Sah5tkPJqWLK6OTbFhL3qUydzPA8CUwS0rZqBlEHV437yPBEd
        p8WTbZM7cpleuCLkoBe2JrzoOjPA9Alk85wj+vo=
X-Google-Smtp-Source: ABdhPJyixTyWAz/TFxWGhOLG0TGM2AsD7w4ntqO4Q7u1lEzSvDTEtDs6pR/3KQqr08NlggT9cjB9HYb471m2Fl+q10k=
X-Received: by 2002:a05:6638:25cd:: with SMTP id u13mr14274578jat.87.1600106885238;
 Mon, 14 Sep 2020 11:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200911194549.12780-1-david.e.box@linux.intel.com>
 <20200911194549.12780-4-david.e.box@linux.intel.com> <6e3738db-bfff-7fd2-65e6-bd0d126f9eaa@redhat.com>
In-Reply-To: <6e3738db-bfff-7fd2-65e6-bd0d126f9eaa@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 14 Sep 2020 11:07:54 -0700
Message-ID: <CAKgT0UcxSwRseMBdMd0_HDUS=JGZDAZnAy-tkLkB-hMXLYtucw@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: Intel PMT Crashlog capability driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, lee.jones@linaro.org,
        dvhart@infradead.org, andy@infradead.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:42 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/11/20 9:45 PM, David E. Box wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for the Intel Platform Monitoring Technology crashlog
> > interface.  This interface provides a few sysfs values to allow for
> > controlling the crashlog telemetry interface as well as a character driver
> > to allow for mapping the crashlog memory region so that it can be accessed
> > after a crashlog has been recorded.
> >
> > This driver is meant to only support the server version of the crashlog
> > which is identified as crash_type 1 with a version of zero. Currently no
> > other types are supported.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >   .../ABI/testing/sysfs-class-pmt_crashlog      |  66 ++
> >   drivers/platform/x86/Kconfig                  |  10 +
> >   drivers/platform/x86/Makefile                 |   1 +
> >   drivers/platform/x86/intel_pmt_crashlog.c     | 588 ++++++++++++++++++
> >   4 files changed, 665 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_crashlog
> >   create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-pmt_crashlog b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
> > new file mode 100644
> > index 000000000000..40fb4ff437a6
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-pmt_crashlog
> > @@ -0,0 +1,66 @@
> > +What:                /sys/class/pmt_crashlog/
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             The pmt_crashlog/ class directory contains information
> > +             for devices that expose crashlog capabilities using the Intel
> > +             Platform Monitoring Technology (PTM).
> > +
> > +What:                /sys/class/pmt_crashlog/crashlogX
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             The crashlogX directory contains files for configuring an
> > +             instance of a PMT crashlog device that can perform crash data
> > +             recoring. Each crashlogX device has an associated
> > +             /dev/crashlogX device node. This node can be opened and mapped
> > +             to access the resulting crashlog data. The register layout for
> > +             the log can be determined from an XML file of specified guid
> > +             for the parent device.
> > +
> > +What:                /sys/class/pmt_crashlog/crashlogX/guid
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             (RO) The guid for this crashlog device. The guid identifies the
> > +             version of the XML file for the parent device that should be
> > +             used to determine the register layout.
> > +
> > +What:                /sys/class/pmt_crashlog/crashlogX/size
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             (RO) The length of the result buffer in bytes that corresponds
> > +             to the mapping size for the /dev/crashlogX device node.
> > +
> > +What:                /sys/class/pmt_crashlog/crashlogX/offset
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             (RO) The offset of the buffer in bytes that corresponds
> > +             to the mapping for the /dev/crashlogX device node.
> > +
> > +What:                /sys/class/pmt_crashlog/crashlogX/enable
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             (RW) Boolean value controlling if the crashlog functionality
> > +             is enabled for the /dev/crashlogX device node.
> > +
> > +What:                /sys/class/pmt_crashlog/crashlogX/trigger
> > +Date:                September 2020
> > +KernelVersion:       5.10
> > +Contact:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > +Description:
> > +             (RW) Boolean value controlling  the triggering of the
> > +             /dev/crashlogX device node. When read it provides data on if
> > +             the crashlog has been triggered. When written to it can be
> > +             used to either clear the current trigger by writing false, or
> > +             to trigger a new event if the trigger is not currently set.
> > +
>
> Both the pmt_crashlog and the attributes suggest that this is highly
> Intel PMT specific. /sys/class/foo interfaces are generally speaking
> meant to be generic interfaces.
>
> If this was defining a generic, vendor and implementation agnostic interface for
> configuring / accessing crashlogs, then using a class would be fine, but that
> is not the case, so I believe that this should not implement / register a class.
>
> Since the devices are instantiated through MFD there already is a
> static sysfs-path which can be used to find the device in sysfs:
> /sys/bus/platform/device/pmt_crashlog
>
> So you can register the sysfs attributes directly under the platform_device
> and then userspace can easily find them, so there really is no need to
> use a class here.

I see. So we change the root directory from "/sys/class/pmt_crashlog/"
to "/sys/bus/platform/device/pmt_crashlog" while retaining the same
functionality. That should be workable.

> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 48335b02014f..50c3234e4f72 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1360,6 +1360,16 @@ config INTEL_PMC_CORE
> >               - LTR Ignore
> >               - MPHY/PLL gating status (Sunrisepoint PCH only)
> >
> > +config INTEL_PMT_CRASHLOG
> > +     tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
> > +     help
> > +      The Intel Platform Monitoring Technology (PMT) crashlog driver provides
> > +      access to hardware crashlog capabilities on devices that support the
> > +      feature.
> > +
> > +      For more information, see
> > +      <file:Documentation/ABI/testing/sysfs-class-intel_pmt_crashlog>
> > +
> >   config INTEL_PMT_TELEMETRY
> >       tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
> >       help
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> > index ca942e70de8d..1b8b2502d460 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -140,6 +140,7 @@ obj-$(CONFIG_INTEL_MFLD_THERMAL)  += intel_mid_thermal.o
> >   obj-$(CONFIG_INTEL_MID_POWER_BUTTON)        += intel_mid_powerbtn.o
> >   obj-$(CONFIG_INTEL_MRFLD_PWRBTN)    += intel_mrfld_pwrbtn.o
> >   obj-$(CONFIG_INTEL_PMC_CORE)                += intel_pmc_core.o intel_pmc_core_pltdrv.o
> > +obj-$(CONFIG_INTEL_PMT_CRASHLOG)     += intel_pmt_crashlog.o
> >   obj-$(CONFIG_INTEL_PMT_TELEMETRY)   += intel_pmt_telemetry.o
> >   obj-$(CONFIG_INTEL_PUNIT_IPC)               += intel_punit_ipc.o
> >   obj-$(CONFIG_INTEL_SCU_IPC)         += intel_scu_ipc.o
> > diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel_pmt_crashlog.c
> > new file mode 100644
> > index 000000000000..31d43708055c
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel_pmt_crashlog.c
> > @@ -0,0 +1,588 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Platform Monitoring Technology Crashlog driver
> > + *
> > + * Copyright (c) 2020, Intel Corporation.
> > + * All Rights Reserved.
> > + *
> > + * Authors: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
> > + */
> > +
> > +#include <linux/cdev.h>
> > +#include <linux/idr.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +
> > +#define DRV_NAME             "pmt_crashlog"
> > +
> > +/* Crashlog access types */
> > +#define ACCESS_FUTURE                1
> > +#define ACCESS_BARID         2
> > +#define ACCESS_LOCAL         3
> > +
> > +/* Crashlog discovery header types */
> > +#define CRASH_TYPE_OOBMSM    1
> > +
> > +/* Control Flags */
> > +#define CRASHLOG_FLAG_DISABLE        BIT(27)
> > +#define CRASHLOG_FLAG_CLEAR  BIT(28)
> > +#define CRASHLOG_FLAG_EXECUTE        BIT(29)
> > +#define CRASHLOG_FLAG_COMPLETE       BIT(31)
> > +#define CRASHLOG_FLAG_MASK   GENMASK(31, 28)
> > +
> > +/* Common Header */
> > +#define CONTROL_OFFSET               0x0
> > +#define GUID_OFFSET          0x4
> > +#define BASE_OFFSET          0x8
> > +#define SIZE_OFFSET          0xC
> > +#define GET_ACCESS(v)                ((v) & GENMASK(3, 0))
> > +#define GET_TYPE(v)          (((v) & GENMASK(7, 4)) >> 4)
> > +#define GET_VERSION(v)               (((v) & GENMASK(19, 16)) >> 16)
> > +
> > +#define GET_ADDRESS(v)               ((v) & GENMASK(31, 3))
> > +#define GET_BIR(v)           ((v) & GENMASK(2, 0))
> > +
> > +static DEFINE_IDA(crashlog_devid_ida);
> > +
> > +struct crashlog_header {
> > +     u32     base_offset;
> > +     u32     size;
> > +     u32     guid;
> > +     u8      bir;
> > +     u8      access_type;
> > +     u8      crash_type;
> > +     u8      version;
> > +};
> > +
> > +struct pmt_crashlog_priv;
> > +
> > +struct crashlog_entry {
> > +     struct pmt_crashlog_priv        *priv;
> > +     struct crashlog_header          header;
> > +     struct resource                 *header_res;
> > +     void __iomem                    *disc_table;
> > +     unsigned long                   crashlog_data;
> > +     size_t                          crashlog_data_size;
> > +     struct cdev                     cdev;
> > +     dev_t                           devt;
> > +     int                             devid;
> > +     struct ida                      *ida;
> > +};
> > +
> > +struct pmt_crashlog_priv {
> > +     struct device           *dev;
> > +     struct pci_dev          *parent;
> > +     struct crashlog_entry   *entry;
> > +     int                     num_entries;
> > +};
> > +
> > +/*
> > + * I/O
> > + */
> > +static bool pmt_crashlog_complete(struct crashlog_entry *entry)
> > +{
> > +     u32 control = readl(entry->disc_table + CONTROL_OFFSET);
> > +
> > +     /* return current value of the crashlog complete flag */
> > +     return !!(control & CRASHLOG_FLAG_COMPLETE);
> > +}
> > +
> > +static bool pmt_crashlog_disabled(struct crashlog_entry *entry)
> > +{
> > +     u32 control = readl(entry->disc_table + CONTROL_OFFSET);
> > +
> > +     /* return current value of the crashlog disabled flag */
> > +     return !!(control & CRASHLOG_FLAG_DISABLE);
> > +}
> > +
> > +static void pmt_crashlog_set_disable(struct crashlog_entry *entry, bool disable)
> > +{
> > +     u32 control = readl(entry->disc_table + CONTROL_OFFSET);
> > +
> > +     /* clear control bits */
> > +     control &= ~(CRASHLOG_FLAG_MASK | CRASHLOG_FLAG_DISABLE);
> > +     if (disable)
> > +             control |= CRASHLOG_FLAG_DISABLE;
> > +
> > +     writel(control, entry->disc_table + CONTROL_OFFSET);
> > +}
> > +
> > +static void pmt_crashlog_set_clear(struct crashlog_entry *entry)
> > +{
> > +     u32 control = readl(entry->disc_table + CONTROL_OFFSET);
> > +
> > +     /* clear control bits */
> > +     control &= ~CRASHLOG_FLAG_MASK;
> > +     control |= CRASHLOG_FLAG_CLEAR;
> > +
> > +     writel(control, entry->disc_table + CONTROL_OFFSET);
> > +}
> > +
> > +static void pmt_crashlog_set_execute(struct crashlog_entry *entry)
> > +{
> > +     u32 control = readl(entry->disc_table + CONTROL_OFFSET);
> > +
> > +     /* clear control bits */
> > +     control &= ~CRASHLOG_FLAG_MASK;
> > +     control |= CRASHLOG_FLAG_EXECUTE;
> > +
> > +     writel(control, entry->disc_table + CONTROL_OFFSET);
> > +}
>
> These 3 pmt_crashlog_set_* functions are all triggered through
> sysfs writes and they all do read-modify-write of the control-register,
> so this is racy. You need to add a mutex to protect the r-m-w sequences.

I'll update things to add the mutex.

> > +
> > +/*
> > + * devfs
> > + */
> > +static int pmt_crashlog_open(struct inode *inode, struct file *filp)
> > +{
> > +     struct crashlog_entry *entry;
> > +     struct pci_driver *pci_drv;
> > +     struct pmt_crashlog_priv *priv;
> > +
> > +     if (!capable(CAP_SYS_ADMIN))
> > +             return -EPERM;
> > +
> > +     entry = container_of(inode->i_cdev, struct crashlog_entry, cdev);
> > +     priv = entry->priv;
> > +     pci_drv = pci_dev_driver(priv->parent);
> > +
> > +     if (!pci_drv)
> > +             return -ENODEV;
> > +
> > +     filp->private_data = entry;
> > +     get_device(&priv->parent->dev);
> > +
> > +     if (!try_module_get(pci_drv->driver.owner)) {
> > +             put_device(&priv->parent->dev);
> > +             return -ENODEV;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int pmt_crashlog_release(struct inode *inode, struct file *filp)
> > +{
> > +     struct crashlog_entry *entry = filp->private_data;
> > +     struct pmt_crashlog_priv *priv;
> > +     struct pci_driver *pci_drv;
> > +
> > +     priv = entry->priv;
> > +     pci_drv = pci_dev_driver(priv->parent);
> > +
> > +     put_device(&priv->parent->dev);
> > +     module_put(pci_drv->driver.owner);
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +pmt_crashlog_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +     struct crashlog_entry *entry = filp->private_data;
> > +     struct pmt_crashlog_priv *priv;
> > +     unsigned long phys = entry->crashlog_data;
> > +     unsigned long pfn = PFN_DOWN(phys);
> > +     unsigned long vsize = vma->vm_end - vma->vm_start;
> > +     unsigned long psize;
> > +
> > +     if ((vma->vm_flags & VM_WRITE) ||
> > +         (vma->vm_flags & VM_MAYWRITE))
> > +             return -EPERM;
> > +
> > +     priv = entry->priv;
> > +
> > +     if (!entry->crashlog_data_size) {
> > +             dev_err(priv->dev, "Crashlog data not accessible\n");
> > +             return -EAGAIN;
> > +     }
> > +
> > +     psize = (PFN_UP(entry->crashlog_data + entry->crashlog_data_size) - pfn) *
> > +             PAGE_SIZE;
> > +     if (vsize > psize) {
> > +             dev_err(priv->dev, "Requested mmap size is too large\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +     if (io_remap_pfn_range(vma, vma->vm_start, pfn,
> > +             vsize, vma->vm_page_prot))
> > +             return -EAGAIN;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct file_operations pmt_crashlog_fops = {
> > +     .owner =        THIS_MODULE,
> > +     .open =         pmt_crashlog_open,
> > +     .mmap =         pmt_crashlog_mmap,
>
> mmap but no read, I guess read may be emulated through mmap,
> is that the case ?
>
> I can see sysadmins wanting to be able to do a simple cat
> on this file to get the logs (including headers), so if
> the kernel-core does not emulate read in this case, you
> should really add read support I guess.

So first the contents of the crashlog are not really human readable,
so it is not likely that they would "cat" the contents. Also I don't
believe it is a very common thing to provide read access if we don't
know the memory layout of the region. If you take a look at the
handling for resourceN in
pci_create_attr(https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/pci/pci-sysfs.c#L1127)
it looks like it does something similar where it only provides mmap
for MMIO access.

> Also how big are these files ?  sysfs also supports binary
> files, so unless these files are huge / this is really
> performance critical it may make more sense to just add
> a binary sysfs attr for this and get rid of the whole chardev
> all together.

So for the file we are looking at the minimum of a page up to multiple
pages of data. It largely depends on how much information is collected
by the crashlog agent. I can take a look and see if we can do it. Odds
are it shouldn't be too different from how resourceN is done for the
PCI devices.

> > +     .release =      pmt_crashlog_release,
> > +};
> > +
> > +/*
> > + * sysfs
> > + */
> > +static ssize_t
> > +guid_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct crashlog_entry *entry;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +
> > +     return sprintf(buf, "0x%x\n", entry->header.guid);
> > +}
> > +static DEVICE_ATTR_RO(guid);
> > +
> > +static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> > +                      char *buf)
> > +{
> > +     struct crashlog_entry *entry;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +
> > +     return sprintf(buf, "%lu\n", entry->crashlog_data_size);
> > +}
> > +static DEVICE_ATTR_RO(size);
> > +
> > +static ssize_t
> > +offset_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct crashlog_entry *entry;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +
> > +     return sprintf(buf, "%lu\n", offset_in_page(entry->crashlog_data));
> > +}
> > +static DEVICE_ATTR_RO(offset);
> > +
> > +static ssize_t
> > +enable_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct crashlog_entry *entry;
> > +     int enabled;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +     enabled = !pmt_crashlog_disabled(entry);
> > +
> > +     return sprintf(buf, "%d\n", enabled);
> > +}
> > +
> > +static ssize_t
> > +enable_store(struct device *dev, struct device_attribute *attr,
> > +         const char *buf, size_t count)
> > +{
> > +     struct crashlog_entry *entry;
> > +     bool enabled;
> > +     int result;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +
> > +     result = kstrtobool(buf, &enabled);
> > +     if (result)
> > +             return result;
> > +
> > +     pmt_crashlog_set_disable(entry, !enabled);
> > +
> > +     return strnlen(buf, count);
> > +}
> > +static DEVICE_ATTR_RW(enable);
> > +
> > +static ssize_t
> > +trigger_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct crashlog_entry *entry;
> > +     int trigger;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +     trigger = pmt_crashlog_complete(entry);
> > +
> > +     return sprintf(buf, "%d\n", trigger);
> > +}
> > +
> > +static ssize_t
> > +trigger_store(struct device *dev, struct device_attribute *attr,
> > +         const char *buf, size_t count)
> > +{
> > +     struct crashlog_entry *entry;
> > +     bool trigger;
> > +     int result;
> > +
> > +     entry = dev_get_drvdata(dev);
> > +
> > +     result = kstrtobool(buf, &trigger);
> > +     if (result)
> > +             return result;
> > +
> > +     if (trigger) {
> > +             /* we cannot trigger a new crash if one is still pending */
> > +             if (pmt_crashlog_complete(entry))
> > +                     return -EEXIST;
> > +
> > +             /* if device is currently disabled, return busy */
> > +             if (pmt_crashlog_disabled(entry))
> > +                     return -EBUSY;
> > +
> > +             pmt_crashlog_set_execute(entry);
> > +     } else {
> > +             pmt_crashlog_set_clear(entry);
> > +     }
> > +
> > +     return strnlen(buf, count);
> > +}
> > +static DEVICE_ATTR_RW(trigger);
> > +
> > +static struct attribute *pmt_crashlog_attrs[] = {
> > +     &dev_attr_guid.attr,
> > +     &dev_attr_size.attr,
> > +     &dev_attr_offset.attr,
> > +     &dev_attr_enable.attr,
> > +     &dev_attr_trigger.attr,
> > +     NULL
> > +};
> > +ATTRIBUTE_GROUPS(pmt_crashlog);
> > +
> > +static struct class pmt_crashlog_class = {
> > +     .name = "pmt_crashlog",
> > +     .owner = THIS_MODULE,
> > +     .dev_groups = pmt_crashlog_groups,
> > +};
> > +
> > +/*
> > + * initialization
> > + */
> > +static int pmt_crashlog_make_dev(struct pmt_crashlog_priv *priv,
> > +                              struct crashlog_entry *entry)
> > +{
> > +     struct device *dev;
> > +     int ret;
> > +
> > +     ret = alloc_chrdev_region(&entry->devt, 0, 1, DRV_NAME);
> > +     if (ret < 0) {
> > +             dev_err(priv->dev, "alloc_chrdev_region err: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     /* Create a character device for Samplers */
> > +     cdev_init(&entry->cdev, &pmt_crashlog_fops);
> > +
> > +     ret = cdev_add(&entry->cdev, entry->devt, 1);
> > +     if (ret) {
> > +             dev_err(priv->dev, "Could not add char dev\n");
> > +             return ret;
> > +     }
> > +
> > +     dev = device_create(&pmt_crashlog_class, &priv->parent->dev, entry->devt,
> > +                         entry, "%s%d", "crashlog", entry->devid);
> > +
> > +     if (IS_ERR(dev)) {
> > +             dev_err(priv->dev, "Could not create device node\n");
> > +             cdev_del(&entry->cdev);
> > +     }
> > +
> > +     return PTR_ERR_OR_ZERO(dev);
> > +}
> > +
> > +static void
> > +pmt_crashlog_populate_header(void __iomem *disc_offset,
> > +                          struct crashlog_header *header)
> > +{
> > +     u32 discovery_header = readl(disc_offset);
> > +
> > +     header->access_type = GET_ACCESS(discovery_header);
> > +     header->crash_type = GET_TYPE(discovery_header);
> > +     header->version = GET_VERSION(discovery_header);
> > +     header->guid = readl(disc_offset + GUID_OFFSET);
> > +     header->base_offset = readl(disc_offset + BASE_OFFSET);
> > +
> > +     /*
> > +      * For non-local access types the lower 3 bits of base offset
> > +      * contains the index of the base address register where the
> > +      * crashlogetry can be found.
> > +      */
> > +     header->bir = GET_BIR(header->base_offset);
> > +     header->base_offset ^= header->bir;
> > +
> > +     /* Size is measured in DWORDs */
> > +     header->size = readl(disc_offset + SIZE_OFFSET);
> > +}
> > +
> > +static int pmt_crashlog_add_entry(struct pmt_crashlog_priv *priv,
> > +                               struct crashlog_entry *entry)
> > +{
> > +     struct resource *res = entry->header_res;
> > +     int ret;
> > +
> > +     pmt_crashlog_populate_header(entry->disc_table, &entry->header);
> > +
> > +     /* Local access and BARID only for now */
> > +     switch (entry->header.access_type) {
> > +     case ACCESS_LOCAL:
> > +             dev_info(priv->dev, "access_type: LOCAL\n");
> > +             if (entry->header.bir) {
> > +                     dev_err(priv->dev,
> > +                             "Unsupported BAR index %d for access type %d\n",
> > +                             entry->header.bir, entry->header.access_type);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             entry->crashlog_data = res->start + resource_size(res) +
> > +                                    entry->header.base_offset;
> > +             break;
> > +
> > +     case ACCESS_BARID:
> > +             dev_info(priv->dev, "access_type: BARID\n");
> > +             entry->crashlog_data =
> > +                     priv->parent->resource[entry->header.bir].start +
> > +                     entry->header.base_offset;
> > +             break;
> > +
> > +     default:
> > +             dev_err(priv->dev, "Unsupported access type %d\n",
> > +                     entry->header.access_type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_info(priv->dev, "crashlod_data address: 0x%lx\n", entry->crashlog_data);
> > +
> > +     entry->crashlog_data_size = entry->header.size * 4;
> > +
> > +     if (entry->header.crash_type != CRASH_TYPE_OOBMSM) {
> > +             dev_err(priv->dev, "Unsupported crashlog header type %d\n",
> > +                     entry->header.crash_type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (entry->header.version != 0) {
> > +             dev_err(priv->dev, "Unsupported version value %d\n",
> > +                     entry->header.version);
> > +             return -EINVAL;
> > +     }
> > +
> > +     entry->ida = &crashlog_devid_ida;
> > +
> > +     entry->devid = ida_simple_get(entry->ida, 0, 0, GFP_KERNEL);
> > +     if (entry->devid < 0)
> > +             return entry->devid;
> > +
> > +     ret = pmt_crashlog_make_dev(priv, entry);
> > +     if (ret) {
> > +             ida_simple_remove(entry->ida, entry->devid);
> > +             return ret;
> > +     }
>
> Hmm wait, you are making one chardev per log entry ? Then just using
> binary sysfs attributes seems to make even more sense to me.

Yes we are required to create one per log entry as each one can be
accessed independently.
