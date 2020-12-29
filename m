Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3CE2E6EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgL2Hja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgL2Hj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:39:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCF2C061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:38:49 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l23so1097266pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRkg87WbhTyVq1GmNw/QSz94cuJmjPJO6TYNObw6kr4=;
        b=Gex3e7KyzNCr2lKCECgDhF4S01LHloc7y48I003ouhQ7svkzCSrI4NWAiM9xCiJ4gZ
         BGOHX7mdS5cI/P4zHHN09QvIZzU+x/aOWbPP/37W3bOiWDEGUETDc78yhs1Qm+sBRuqD
         0+IsjU/NZFMTY3bO4kt/9j3j4QGBx+yY0OCJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRkg87WbhTyVq1GmNw/QSz94cuJmjPJO6TYNObw6kr4=;
        b=az7Eoj1CSHwLZ6y2bjXoNPPKkenDC0Vm5nj26LQNbbYTJBVa90aRcVxfwDzGWiVT4y
         laOiQGccWnS9tbrLdUDYMBkVv13Y38Kp2pI5sg19EneqNlMhI5kcUUfD5GI5Nusm2dr0
         wlgkV7TONhebq1LuF9aeS270xdi7tkZoowtsKfwfknPBtp7o20+btOAP7t06n88lNLM+
         8CHwsqVGfbCuJs2b/40q1uNBWU1OndB6UDJmnWiGLgJQ1s1hEAuQxDBSzIUeXnSxLIFq
         8Y+bPFgLIwmV6PQhUDdim01CJk5zDSzS9AjVVDxVWsGITROL/UMo/QKHncLXHEI7BjS4
         +jWQ==
X-Gm-Message-State: AOAM5321RPQu+9+jmXON70o1mkJEc4GdqCOXzuaxToMMOOc9NI15d/u2
        ogdZAqb3vfhvk6zGDw1DZU2T8vDE896f6kcevCJINA==
X-Google-Smtp-Source: ABdhPJwUO3J1NZQgc10hogKW+6LyRgLxDEBlh6fCSuzC8OXzEh6Y/DojrQstDhfZFMHMVr+QI9pWj6J4rKUozpOfCg8=
X-Received: by 2002:a17:90a:902:: with SMTP id n2mr2897636pjn.126.1609227528563;
 Mon, 28 Dec 2020 23:38:48 -0800 (PST)
MIME-Version: 1.0
References: <1608629682-8535-1-git-send-email-chunfeng.yun@mediatek.com> <1608629682-8535-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1608629682-8535-4-git-send-email-chunfeng.yun@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 29 Dec 2020 15:38:37 +0800
Message-ID: <CAATdQgCV+M5J1z6n9HcouOvoX34bofrb6E2e-BBimJTqmHs=gQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] usb: xhci-mtk: add support runtime pm
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhangyong.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 5:35 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> From: CK Hu <ck.hu@mediatek.com>
>
> add support runtime pm feature
>
> Signed-off-by: Zhanyong Wang <zhanyong.wang@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3:
>   1. fix some issues
>   2. remove attribute files
>
> v2: fix error caused by request irq suggested by CK
> ---
>  drivers/usb/host/xhci-mtk.c | 285 +++++++++++++++++++++++++++++++++++-
>  drivers/usb/host/xhci-mtk.h |  14 ++
>  2 files changed, 294 insertions(+), 5 deletions(-)
>  mode change 100755 => 100644 drivers/usb/host/xhci-mtk.c
>
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> old mode 100755
> new mode 100644
> index 34bd3de090b1..c07d54acbcb7
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -14,6 +14,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> @@ -77,6 +78,72 @@ enum ssusb_uwk_vers {
>         SSUSB_UWK_V3,
>  };
>
> +int xhci_mtk_runtime_ready;
> +
> +static int xhci_mtk_runtime_resume(struct device *dev);
> +
> +static void xhci_mtk_seal_work(struct work_struct *work)
> +{
> +       struct xhci_hcd_mtk *mtk =
> +                       container_of(work, struct xhci_hcd_mtk, seal.work);
> +       struct usb_hcd *hcd = mtk->hcd;
> +       struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +
> +       xhci_dbg(xhci, "spm unseals xHCI controller %i\n", mtk->seal_status);
> +       if (mtk->seal_status == SEAL_SUSPENDED) {
> +               mtk->seal_status = SEAL_RESUMING;
> +               pm_runtime_mark_last_busy(mtk->dev);
> +               pm_runtime_put_sync_autosuspend(mtk->dev);

If I understand correctly, this function is for waking up the device
but this function calls put() only without get().

> +       } else {
> +               /*
> +                * FIXME: Sometimes seal_status will keep it on SEAL_RESUMING staus not to expect
> +                * since pm_runtime_put_sync_autosuspend doesn't invoke runtime_resume of callback.
> +                * and to survey why not to invoke runtime_resume callback named
> +                * xhci_mtk_runtime_resume in time in short feature, Herely provide one solution
> +                * that make sure seal_status to match h/w state machine,and MTK xHCI clocks
> +                * on as soon as unseal event received.

I guess actual resuming should be happened only from the 1st interrupt
(when in SEAL_SUSPENDED)
and following spurious interrupts can be just ignored.

> +                */
> +               if (mtk->seal_status == SEAL_RESUMING)
> +                       xhci_mtk_runtime_resume(mtk->dev);

xhci_mtk_runtime_resume() is defined as a runtime pm callback,
pm core will call that callback when pm usage counter reaches to zero.

> +               else
> +                       xhci_warn(xhci,
> +                               "Ignore seal wakeup source disordered in xHCI controller\n");
> +       }
> +}
> +
> +static irqreturn_t xhci_mtk_seal_irq(int irq, void *data)
> +{
> +       struct xhci_hcd_mtk *mtk = data;
> +       struct usb_hcd *hcd = mtk->hcd;
> +       struct xhci_hcd *xhci = hcd_to_xhci(hcd);
> +
> +       xhci_dbg(xhci, "seal irq ISR invoked\n");
> +
> +       schedule_delayed_work(&mtk->seal, 0);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void xhci_mtk_seal_wakeup_enable(struct xhci_hcd_mtk *mtk, bool enable)
> +{
> +       struct irq_desc *desc;
> +       struct device *dev = mtk->dev;
> +
> +       if (mtk && mtk->seal_irq) {
> +               desc = irq_to_desc(mtk->seal_irq);
> +               if (enable) {
> +                       desc->irq_data.chip->irq_ack(&desc->irq_data);
> +                       enable_irq(mtk->seal_irq);
> +                       dev_dbg(dev, "%s: enable_irq %i\n",
> +                                __func__, mtk->seal_irq);
> +               } else {
> +                       disable_irq(mtk->seal_irq);
> +                       dev_dbg(dev, "%s: disable_irq %i\n",
> +                                __func__, mtk->seal_irq);
> +               }
> +       }
> +}
> +

I think this is unnecessary if this driver can check the current state
and ignore the spurious irqs if spm sometimes triggers the wake-up irqs.

>  static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
>  {
>         struct mu3c_ippc_regs __iomem *ippc = mtk->ippc_regs;
> @@ -347,7 +414,6 @@ static int usb_wakeup_of_property_parse(struct xhci_hcd_mtk *mtk,
>                         mtk->uwk_reg_base, mtk->uwk_vers);
>
>         return PTR_ERR_OR_ZERO(mtk->uwk);
> -
>  }
>
>  static void usb_wakeup_set(struct xhci_hcd_mtk *mtk, bool enable)
> @@ -482,9 +548,11 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       pm_runtime_set_active(dev);
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_set_autosuspend_delay(dev,
> +                               CONFIG_USB_AUTOSUSPEND_DELAY * 1000);
>         pm_runtime_enable(dev);
> -       pm_runtime_get_sync(dev);

The only one left pm_runtime_get() is removed by here,
now this driver only calls pm_runtime_put().

> -       device_enable_async_suspend(dev);
>
>         ret = xhci_mtk_ldos_enable(mtk);
>         if (ret)
> @@ -499,6 +567,14 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>                 ret = irq;
>                 goto disable_clk;
>         }
> +       dev_dbg(dev, "irq %i\n", irq);
> +
> +       mtk->seal_irq = platform_get_irq_optional(pdev, 1);
> +       if (mtk->seal_irq < 0) {
> +               ret = mtk->seal_irq;
> +               goto disable_clk;
> +       }
> +       dev_dbg(dev, "seal_irq %i\n", mtk->seal_irq);
>
>         hcd = usb_create_hcd(driver, dev, dev_name(dev));
>         if (!hcd) {
> @@ -565,6 +641,27 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>         if (ret)
>                 goto dealloc_usb2_hcd;
>
> +       INIT_DELAYED_WORK(&mtk->seal, xhci_mtk_seal_work);
> +       snprintf(mtk->seal_descr, sizeof(mtk->seal_descr), "seal%s:usb%d",
> +                hcd->driver->description, hcd->self.busnum);
> +       ret = devm_request_irq(dev, mtk->seal_irq, &xhci_mtk_seal_irq,
> +                         IRQF_TRIGGER_FALLING, mtk->seal_descr, mtk);
> +       if (ret != 0) {
> +               dev_err(dev, "seal request interrupt %d failed\n",
> +                       mtk->seal_irq);
> +               goto dealloc_usb2_hcd;
> +       }
> +       xhci_mtk_seal_wakeup_enable(mtk, false);
> +
> +       device_enable_async_suspend(dev);
> +       xhci_mtk_runtime_ready = 1;
> +
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);

I expect the usage count will be -1 by here in probe.

> +
> +       dev_dbg(dev, "%s: xhci_mtk_runtime_ready %i",
> +                __func__, xhci_mtk_runtime_ready);
> +
>         return 0;
>
>  dealloc_usb2_hcd:
> @@ -587,7 +684,7 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>         xhci_mtk_ldos_disable(mtk);
>
>  disable_pm:
> -       pm_runtime_put_sync(dev);
> +       pm_runtime_put_sync_autosuspend(dev);
>         pm_runtime_disable(dev);
>         return ret;
>  }
> @@ -602,6 +699,7 @@ static int xhci_mtk_remove(struct platform_device *dev)
>         pm_runtime_put_noidle(&dev->dev);
>         pm_runtime_disable(&dev->dev);
>
> +       xhci_mtk_runtime_ready = 0;
>         usb_remove_hcd(shared_hcd);
>         xhci->shared_hcd = NULL;
>         device_init_wakeup(&dev->dev, false);
> @@ -638,6 +736,7 @@ static int __maybe_unused xhci_mtk_suspend(struct device *dev)
>         xhci_mtk_host_disable(mtk);
>         xhci_mtk_clks_disable(mtk);
>         usb_wakeup_set(mtk, true);
> +
>         return 0;
>  }
>
> @@ -659,10 +758,185 @@ static int __maybe_unused xhci_mtk_resume(struct device *dev)
>         return 0;
>  }
>
> +static int __maybe_unused xhci_mtk_bus_status(struct device *dev)
> +{
> +       struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
> +       struct usb_hcd *hcd;
> +       struct xhci_hcd *xhci;
> +       struct xhci_hub *usb2_rhub;
> +       struct xhci_hub *usb3_rhub;
> +       struct xhci_bus_state *bus_state;
> +       struct xhci_port *port;
> +       u32     usb2_suspended_ports = -1;
> +       u32     usb3_suspended_ports = -1;
> +       u16 status;
> +       int num_ports;
> +       int ret = 0;
> +       int i;
> +
> +       if (!mtk->hcd)
> +               return -ESHUTDOWN;
> +
> +       hcd = mtk->hcd;
> +       xhci = hcd_to_xhci(hcd);
> +       if ((xhci->xhc_state & XHCI_STATE_REMOVING) ||
> +                       (xhci->xhc_state & XHCI_STATE_HALTED)) {
> +               return -ESHUTDOWN;
> +       }

This is duplicated from xhci_mtk_runtime_suspend()

> +
> +       usb2_rhub = &xhci->usb2_rhub;
> +       if (usb2_rhub) {
> +               bus_state  = &usb2_rhub->bus_state;
> +               num_ports  = usb2_rhub->num_ports;
> +               usb2_suspended_ports  = bus_state->suspended_ports;
> +               usb2_suspended_ports ^= (BIT(num_ports) - 1);
> +               usb2_suspended_ports &= (BIT(num_ports) - 1);
> +               for (i = 0; i < num_ports; i++) {
> +                       if (usb2_suspended_ports & (1UL << i)) {
> +                               port = usb2_rhub->ports[i];
> +                               status = readl(port->addr);
> +
> +                               xhci_dbg(xhci,
> +                                         "USB20: portsc[%i]: 0x%04X\n",
> +                                         i, status);
> +
> +                               if (!(status & PORT_CONNECT))
> +                                       usb2_suspended_ports &= ~(1UL << i);
> +                       }
> +               }
> +
> +               if (usb2_suspended_ports) {
> +                       ret = -EBUSY;
> +                       goto ebusy;
> +               }
> +       }
> +
> +       usb3_rhub = &xhci->usb3_rhub;
> +       if (usb3_rhub) {
> +               bus_state  = &usb3_rhub->bus_state;
> +               num_ports  = usb3_rhub->num_ports;
> +               usb3_suspended_ports  = bus_state->suspended_ports;
> +               usb3_suspended_ports ^= (BIT(num_ports) - 1);
> +               usb3_suspended_ports &= (BIT(num_ports) - 1);
> +               for (i = 0; i < num_ports; i++) {
> +                       if (usb3_suspended_ports & BIT(i)) {
> +                               port = usb3_rhub->ports[i];
> +                               status = readl(port->addr);
> +
> +                               xhci_dbg(xhci, "USB3: portsc[%i]: 0x%04X\n",
> +                                         i, status);
> +
> +                               if (!(status & PORT_CONNECT))
> +                                       usb3_suspended_ports &= ~BIT(i);
> +                       }
> +               }
> +
> +               if (usb3_suspended_ports) {
> +                       ret = -EBUSY;
> +                       goto ebusy;
> +               }
> +       }
> +
> +ebusy:
> +       xhci_dbg(xhci, "%s: USB2: 0x%08X, USB3: 0x%08X ret: %i\n",
> +                 __func__, usb2_suspended_ports,
> +                 usb3_suspended_ports, ret);
> +
> +       return ret;
> +}
> +

This is basically counting active ports by directly reading portsc register?
I expect this function never return -EBUSY  if you balance pm usage
counter well.
Are there any specific reasons of doing this manually?

> +static int __maybe_unused xhci_mtk_runtime_suspend(struct device *dev)
> +{
> +       bool wakeup = device_may_wakeup(dev);
> +       struct xhci_hcd_mtk  *mtk = dev_get_drvdata(dev);
> +       struct usb_hcd *hcd;
> +       struct xhci_hcd *xhci;
> +       int ret = 0;
> +
> +       if (!mtk->hcd)
> +               return -ESHUTDOWN;
> +
> +       hcd = mtk->hcd;
> +       xhci = hcd_to_xhci(hcd);
> +       if ((xhci->xhc_state & XHCI_STATE_REMOVING) ||
> +                       (xhci->xhc_state & XHCI_STATE_HALTED)) {
> +               return -ESHUTDOWN;
> +       }
> +
> +       mtk->seal_status = SEAL_BUSY;
> +       ret = xhci_mtk_bus_status(dev);
> +       if (wakeup && !ret) {
> +               mtk->seal_status = SEAL_SUSPENDING;
> +               xhci_mtk_suspend(dev);
> +               xhci_mtk_seal_wakeup_enable(mtk, true);
> +               mtk->seal_status = SEAL_SUSPENDED;
> +               xhci_dbg(xhci, "%s: seals xHCI controller\n", __func__);
> +       }
> +
> +       xhci_dbg(xhci, "%s: seals wakeup = %i, ret = %i!\n",
> +                 __func__, wakeup, ret);
> +
> +       return ret;
> +}
> +
> +static int __maybe_unused xhci_mtk_runtime_resume(struct device *dev)
> +{
> +       bool wakeup = device_may_wakeup(dev);
> +       struct xhci_hcd_mtk  *mtk = dev_get_drvdata(dev);
> +       struct usb_hcd *hcd;
> +       struct xhci_hcd *xhci;
> +
> +       if (!mtk->hcd)
> +               return -ESHUTDOWN;
> +
> +       hcd = mtk->hcd;
> +       xhci = hcd_to_xhci(hcd);
> +       if ((xhci->xhc_state & XHCI_STATE_REMOVING) ||
> +                       (xhci->xhc_state & XHCI_STATE_HALTED)) {
> +               return -ESHUTDOWN;
> +       }
> +
> +       /*
> +        *  list cases by one extra interrupt named seal to process!!!
> +        *  Who to process these module reinitilization after SPM wakeup
> +        *  case 1: usb remote wakeup, therefore xHCI need reinitilizate also.
> +        *  case 2: other-wakeup-source wakeup, therefore, xHCI need reinit
> +        *  case 3: usb client driver can invoke it in runtime mechanism
> +        *  case 4: user active
> +        */
> +       if (wakeup) {
> +               xhci_mtk_seal_wakeup_enable(mtk, false);
> +               xhci_mtk_resume(dev);
> +               xhci_dbg(xhci, "%s: unseals xHCI controller\n", __func__);
> +       }
> +       mtk->seal_status = SEAL_RESUMED;
> +
> +       xhci_dbg(xhci, "%s: unseals wakeup = %i\n", __func__, wakeup);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused xhci_mtk_runtime_idle(struct device *dev)
> +{
> +       int ret = 0;
> +
> +       dev_dbg(dev, "%s: xhci_mtk_runtime_ready %i",
> +                __func__, xhci_mtk_runtime_ready);
> +
> +       if (!xhci_mtk_runtime_ready)
> +               ret = -EAGAIN;
> +
> +       return ret;
> +}
> +
>  static const struct dev_pm_ops xhci_mtk_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(xhci_mtk_suspend, xhci_mtk_resume)
> +       SET_RUNTIME_PM_OPS(xhci_mtk_runtime_suspend,
> +                          xhci_mtk_runtime_resume,
> +                          xhci_mtk_runtime_idle)
>  };
> -#define DEV_PM_OPS IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL
> +
> +#define DEV_PM_OPS (IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL)
>
>  #ifdef CONFIG_OF
>  static const struct of_device_id mtk_xhci_of_match[] = {
> @@ -686,6 +960,7 @@ MODULE_ALIAS("platform:xhci-mtk");
>
>  static int __init xhci_mtk_init(void)
>  {
> +       xhci_mtk_runtime_ready = 0;
>         xhci_init_driver(&xhci_mtk_hc_driver, &xhci_mtk_overrides);
>         return platform_driver_register(&mtk_xhci_driver);
>  }
> diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
> index 323b281933b9..103d83ce6a3e 100644
> --- a/drivers/usb/host/xhci-mtk.h
> +++ b/drivers/usb/host/xhci-mtk.h
> @@ -133,6 +133,14 @@ struct mu3c_ippc_regs {
>         __le32 reserved3[33]; /* 0x80 ~ 0xff */
>  };
>
> +enum xhci_mtk_seal {
> +       SEAL_BUSY = 0,
> +       SEAL_SUSPENDING,
> +       SEAL_SUSPENDED,
> +       SEAL_RESUMING,
> +       SEAL_RESUMED
> +};
> +
>  struct xhci_hcd_mtk {
>         struct device *dev;
>         struct usb_hcd *hcd;
> @@ -158,6 +166,12 @@ struct xhci_hcd_mtk {
>         struct regmap *uwk;
>         u32 uwk_reg_base;
>         u32 uwk_vers;
> +
> +       /* usb eint wakeup source */
> +       int seal_irq;
> +       enum xhci_mtk_seal seal_status;
> +       struct delayed_work  seal;
> +       char   seal_descr[32];  /* "seal" + driver + bus # */
>  };
>
>  static inline struct xhci_hcd_mtk *hcd_to_mtk(struct usb_hcd *hcd)
> --
> 2.18.0
>
