Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90932F1E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbhAKStb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:49:31 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:29201 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAKSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610390797;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-ID:Subject:Cc:To:From:Date:From:Subject:Sender;
        bh=WH0H0/U0+7xOmeRhVlVuX+/dYtaThWYbRJjUaN+ZyIw=;
        b=OiLiOLmhJpj6176ErlEEWgabl8At6tMIM8QbPv9kU7hkyb2g+dKRhymqMgKX7XdXTX
        anqiVJcJqfxfIpheYKRc6n+KmS8t4KsfF35gBtJrKpi6JqR1EMghRCmrYTDsuZVguXN5
        PHLAEDiymgoMYcMYVtAy0GUrLoClAGGrCs8NGHCvp+RWDRv4s6HsJyn6v/EP/FzzCu2k
        bUV8UDpiurkH2bsoo1pIMaN/Fj3i8wST3f5glrOISkXdgIkHbIyFl6d0JRVWlTtkmk6+
        xPJq1MmrKEnhB/j7sSnaSdoRUb02oOj8p5bTZ0XzJSPZqS2wh4F/ius+Rpr2L1+Q/Lh3
        iBDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8jxIc/DBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0BIhMzCM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 11 Jan 2021 19:43:22 +0100 (CET)
Date:   Mon, 11 Jan 2021 19:43:14 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Peter Chen <Peter.Chen@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Infinite recursion in device_reorder_to_tail() due to circular
 device links
Message-ID: <X/ycQpu7NIGI969v@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qsnshZ7+7gs41/Sw"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qsnshZ7+7gs41/Sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

since 5.11-rc1 I get kernel crashes with infinite recursion in
device_reorder_to_tail() in some situations... It's a bit complicated to
explain so I want to apologize in advance for the long mail. :)

  Kernel panic - not syncing: kernel stack overflow
  CPU: 1 PID: 33 Comm: kworker/1:1 Not tainted 5.11.0-rc3 #1
  Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
  Call trace:
   ...
   device_reorder_to_tail+0x4c/0xf0
   device_reorder_to_tail+0x98/0xf0
   device_reorder_to_tail+0x60/0xf0
   device_reorder_to_tail+0x60/0xf0
   device_reorder_to_tail+0x60/0xf0
   ...

The crash happens only in 5.11 with commit 5b6164d3465f ("driver core:
Reorder devices on successful probe"). It stops happening when I revert
this commit. But I don't think this commit is the actual problem...

It's easy to reproduce on any device based on the Qualcomm MSM8916 SoC
by adding a random regulator to the USB node, e.g.:

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 3a9538e1ec97..9f43fce9e6e3 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -372,6 +372,7 @@ codec {
 
 &usb {
 	status = "okay";
+	vbus-supply = <&pm8916_l5>;
 	extcon = <&usb_id>, <&usb_id>;
 
 	pinctrl-names = "default", "device";

I searched for problems in the regulator core but the problem actually
has nothing to do with regulators: The additional regulator supply just
delays probing of the USB driver long enough to trigger the issue.

Adding some debug output to device_reorder_to_tail() reveals that it
keeps recursing over the same 4 devices:

  msm_hsusb 78d9000.usb: device_reorder_to_tail()
  ci_hdrc ci_hdrc.0: device_reorder_to_tail()
  qcom_usb_hs_phy ci_hdrc.0.ulpi: device_reorder_to_tail()
  phy phy-ci_hdrc.0.ulpi.0: device_reorder_to_tail()
  msm_hsusb 78d9000.usb: device_reorder_to_tail()
  ...

The device hierarchy of these is (children devices):

  78d9000.usb -> ci_hdrc.0 -> ci_hdrc.0.ulpi -> phy-ci_hdrc.0.ulpi.0

ci_hdrc.0 calls phy_get(dev->parent, "usb-phy"). In phy_get(),
the phy-core then attempts to add the following device link:

  phy-ci_hdrc.0.ulpi.0 -> 78d9000.usb

The device link creation in phy-core is optional (see commit 1d7cb11e1090
("phy: core: Fix phy_get() to not return error on link creation failure"))
because this device link is circular in case of ULPI PHYs (like here).

And indeed, creating this device link usually fails (as it should).
However, adding the "vbus-supply" changes probe order in some way that
this circular device link ends up being created:
  /sys/class/devlink/phy-ci_hdrc.0.ulpi.0--78d9000.usb/ exists only when
I add the "vbus-supply" as in the diff above.

Apparently, there is a special situation where device_is_dependent()
does not work properly, and therefore the driver core allows creating
the circular device link.

To show the problem, I enabled some debug messages and added the
following log message:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 25e08e5f40bd..ff1344eabb31 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3089,9 +3089,11 @@ int device_add(struct device *dev)
 	}
 
 	bus_probe_device(dev);
-	if (parent)
+	if (parent) {
+		dev_info(dev, "add to parent %s\n", dev_name(parent));
 		klist_add_tail(&dev->p->knode_parent,
 			       &parent->p->klist_children);
+	}
 
 	if (dev->class) {
 		mutex_lock(&dev->class->p->mutex);

Running this with "vbus-supply" (where it crashes) produces:

     bus: 'platform': probing driver msm_hsusb with device 78d9000.usb
       <some probe deferrals while waiting for the regulator>
     bus: 'platform': probing driver msm_hsusb with device 78d9000.usb
     bus: 'platform': probing driver ci_hdrc with device ci_hdrc.0
     bus: 'ulpi': probing driver qcom_usb_hs_phy with device ci_hdrc.0.ulpi
     phy phy-ci_hdrc.0.ulpi.0: add to parent ci_hdrc.0.ulpi
     qcom_usb_hs_phy ci_hdrc.0.ulpi: add to parent ci_hdrc.0
 (1) msm_hsusb 78d9000.usb: Linked as a consumer to phy-ci_hdrc.0.ulpi.0
 (2) ci_hdrc ci_hdrc.0: add to parent 78d9000.usb
     Kernel panic - not syncing: kernel stack overflow
      ...

Note how ci_hdrc is added to the children list of 78d9000.usb (2) after
the device link was already created in (1). This is why device_is_dependent()
does not realize the devices will eventually be dependent on each other.

Without "vbus-supply" (2) happens before (1) because then the PHY driver
requests probe deferral a few times while waiting for regulators.

I'm not really sure what to do here, any suggestions how to fix this properly?

(In case it helps, I have attached an example kernel module (circdl.c)
 that allows reproducing the exact same crash.)

Thanks in advance!
Stephan

--qsnshZ7+7gs41/Sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="circdl.c"

#include <linux/module.h>
#include <linux/platform_device.h>

static int parent_probe(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct platform_device *middle;

	dev_info(dev, "probe\n");

	middle = platform_device_register_data(dev, "middle", PLATFORM_DEVID_AUTO, NULL, 0);
	if (IS_ERR(middle))
		return dev_err_probe(dev, PTR_ERR(middle), "failed to create middle\n");

	return 0;
}

static int middle_probe(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct platform_device *child;
	struct device_link *link;

	dev_info(dev, "probe\n");

	child = platform_device_register_data(dev, "child", PLATFORM_DEVID_AUTO, NULL, 0);
	if (IS_ERR(child))
		return dev_err_probe(dev, PTR_ERR(child), "failed to create child\n");

	dev_info(dev, "device_link_add\n");

	/*
	 * Note how the device link is created between the parent device and the
	 * child device. This is equivalent to what happens in the phy-core
	 * because ci_hdrc calls phy_get(dev->parent, "usb-phy");
	 */
	link = device_link_add(dev->parent, &child->dev, DL_FLAG_STATELESS);
	if (link)
		dev_err(dev, "Creating circular device link should have failed!\n");
	else
		dev_info(dev, "Creating device link failed (as it should)\n");

	return 0;
}

static int child_probe(struct platform_device *pdev)
{
	dev_info(&pdev->dev, "probe\n");
	return 0;
}

static struct platform_driver parent_driver = {
	.probe	= parent_probe,
	.driver	= {
		.name = "parent",
	},
};

static struct platform_driver middle_driver = {
	.probe	= middle_probe,
	.driver	= {
		.name = "middle",
	},
};

static struct platform_driver child_driver = {
	.probe	= child_probe,
	.driver	= {
		.name = "child",
	},
};

static int __init circdl_init(void)
{
	platform_driver_register(&parent_driver);
	platform_driver_register(&middle_driver);
	platform_driver_register(&child_driver);
	platform_device_register_simple("parent", PLATFORM_DEVID_AUTO, NULL, 0);
	return 0;
}

module_init(circdl_init)
MODULE_LICENSE("GPL v2");

--qsnshZ7+7gs41/Sw--
