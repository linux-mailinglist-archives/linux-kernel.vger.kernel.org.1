Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C703028CB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391457AbgJMJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:31:24 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:41139 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390610AbgJMJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:31:23 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 05:31:21 EDT
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id SGXXkQ6plv4gESGXYkdALY; Tue, 13 Oct 2020 11:24:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1602581056; bh=NgBK7b0/5eOTUg7amcOBkfdAW918ABPeJjYlM7njnDs=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Pb6fbnsD7reXz4QGw38Vn/O8BFKZfbuaWButEoUeK8u/kZ5k6+/lyHCfvX4UZnKTl
         Dk8c4vDNwT5F7dq4cR/IqNdfvvD9zCTWA1ySRNIrLb9Lu1x/haDQMYAC0uftg5Dz7S
         Gq7a1+OztBGu12iLN57+uKrjNbVwH2Los1AwQqpGnLOc+CQVKZHzIZoP60VpF0DKta
         Gl+esRurcKcm2g6OtkWaFTltt8nDkJ7hC/vsCo/xJUjO/lM5Uz7l7O9TZt0OXT30/6
         XDjuYBkkAvAIoWtqrlxYgNgxmRZTFrNXxt1eE5G+LKwJNnbYSqRdWBdVyxB5qgqmVp
         EU7yoLkwX/ltg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: disabling CONFIG_LED_CLASS
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
Organization: hierzo
Message-ID: <2835d02a-380b-6a3a-0e4d-abf07aee18bc@xs4all.nl>
Date:   Tue, 13 Oct 2020 11:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPXZXpWW5kOw+GFiT5Ez2Cnabcpm4YMb8KV3fTcaisaUHdn5YEnE2sysKL52Iu1v0+wU6i1T+9qCmuKxrKfrywVwbf65zt98o+/k4kmO8O8UX/kZYaNb
 NnH6aoXESfiQ66VO9K86d+KRTLOxJSBD2fq3zU/DLPEPXKaMWMdELS3HQizSPsAoBJWGRYt6RDTdtF7GVuBsL1Rbh+GDyVQ+mGFZPX7yaN9/A4x1xRt57EDH
 xPJiY/Lb2PjzHCAY0XX/PITVjNkOEZlfbt2y/7FvYi8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While looking at the 5.9 kernel config I noticed there is no easy way to
disable LED support in general.
There's this NEW_LEDS thing that is not shown, etc.
So I get:

# make oldconfig
scripts/kconfig/conf  --oldconfig Kconfig
*
* Restart config...
*
*
* LED Support
*
LED Support (NEW_LEDS) [Y/?] (NEW) y
  LED Class Support (LEDS_CLASS) [M/y/?] (NEW) n

CONFIG_LEDS_CLASS:

This option enables the LED sysfs class in /sys/class/leds.  You'll
need this to do anything useful with LEDs.  If unsure, say N.

Symbol: LEDS_CLASS [=m]
Type  : tristate
Defined at drivers/leds/Kconfig:17
  Prompt: LED Class Support
  Depends on: NEW_LEDS [=y]
  Location:
    -> Device Drivers
      -> LED Support (NEW_LEDS [=y])
Selected by [m]:
  - SND_HDA_GENERIC [=m] && SOUND [=y] && !UML && SND [=m] && SND_HDA
[=m] && SND_HDA_GENERIC_LEDS [=y]
Selected by [n]:
  - TS5500 [=n] && X86_32 [=n] && MELAN [=n]
  - ADB_PMU_LED [=n] && MACINTOSH_DRIVERS [=n] && PPC_PMAC && ADB_PMU [=n]
  - ATH5K [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_ATH [=n]
&& (PCI [=y] || ATH25) && MAC80211 [=n]
  - ATH9K [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_ATH [=n]
&& MAC80211 [=n] && HAS_DMA [=y]
  - ATH9K_HTC [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_ATH
[=n] && USB [=y] && MAC80211 [=n]
  - CARL9170_LEDS [=n] && NETDEVICES [=y] && WLAN [=n] &&
WLAN_VENDOR_ATH [=n] && CARL9170 [=n]
  - BRCMSMAC [=n] && NETDEVICES [=y] && WLAN [=n] &&
WLAN_VENDOR_BROADCOM [=n] && MAC80211 [=n] && BCMA_POSSIBLE [=y] &&
BCMA_DRIVER_GPIO [=n]
  - IWLEGACY [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_INTEL [=n]
  - INPUT_WISTRON_BTNS [=n] && !UML && INPUT [=y] && INPUT_MISC [=y] &&
X86_32 [=n]
  - SENSORS_APPLESMC [=n] && HWMON [=y] && INPUT [=y] && X86 [=y]
  - IR_REDRAT3 [=n] && RC_DEVICES [=n] && USB_ARCH_HAS_HCD [=y] &&
RC_CORE [=n]
  - IR_WINBOND_CIR [=n] && RC_DEVICES [=n] && (X86 [=y] && PNP [=y] ||
COMPILE_TEST [=n]) && RC_CORE [=n]
  - IR_TTUSBIR [=n] && RC_DEVICES [=n] && USB_ARCH_HAS_HCD [=y] &&
RC_CORE [=n]
  - BACKLIGHT_ADP8860 [=n] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
[=y] && I2C [=y]
  - BACKLIGHT_ADP8870 [=n] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
[=y] && I2C [=y]
  - BACKLIGHT_LM3639 [=n] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
[=y] && I2C [=y]
  - SND_USB_TONEPORT [=n] && SOUND [=y] && !UML && SND [=m] && SND_USB
[=y] && USB [=y]
  - HID_LENOVO [=n] && INPUT [=y] && HID [=y]
  - HID_WACOM [=n] && INPUT [=y] && HID [=y] && USB_HID [=m]
  - HUAWEI_WMI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] &&
ACPI_BATTERY [=n] && ACPI_WMI [=n] && INPUT [=y]
  - ACER_WMI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI [=y]
&& BACKLIGHT_CLASS_DEVICE [=y] && SERIO_I8042 [=y] && INPUT [=y] &&
(RFKILL [=n] || RFKILL [=n]=n) && ACPI_WMI [=n]
  - ASUS_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && BACKLIGHT_CLASS_DEVICE [=y] && INPUT [=y] && (RFKILL [=n] ||
RFKILL [=n]=n) && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
  - ASUS_WIRELESS [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && INPUT [=y]
  - ASUS_WMI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI_WMI
[=n] && ACPI_BATTERY [=n] && INPUT [=y] && HWMON [=y] &&
BACKLIGHT_CLASS_DEVICE [=y] && (RFKILL [=n] || RFKILL [=n]=n) &&
HOTPLUG_PCI [=n] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
  - EEEPC_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n) && (ACPI_VIDEO [=n]
|| ACPI_VIDEO [=n]=n) && HOTPLUG_PCI [=n] && BACKLIGHT_CLASS_DEVICE [=y]
  - DELL_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && DMI
[=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO
[=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y] &&
DELL_SMBIOS [=n]
  - FUJITSU_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && INPUT [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
ACPI_VIDEO [=n]=n)
  - HP_ACCEL [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && INPUT [=y]
&& ACPI [=y] && SERIO_I8042 [=y]
  - THINKPAD_ACPI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && ACPI_BATTERY [=n] && INPUT [=y] && (RFKILL [=n] || RFKILL
[=n]=n) && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) &&
BACKLIGHT_CLASS_DEVICE [=y]
  - SAMSUNG_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] &&
(RFKILL [=n] || RFKILL [=n]=n) && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
&& BACKLIGHT_CLASS_DEVICE [=y]
  - ACPI_TOSHIBA [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && ACPI_WMI [=n] && BACKLIGHT_CLASS_DEVICE [=y] && INPUT [=y] &&
(SERIO_I8042 [=y] || SERIO_I8042 [=y]=n) && (ACPI_VIDEO [=n] ||
ACPI_VIDEO [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && IIO [=n]
  - LG_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI [=y]
&& ACPI_WMI [=n] && INPUT [=y]
  - SYSTEM76_ACPI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI [=y]
  - TOPSTAR_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
[=y] && INPUT [=y]


And there is no 'n' option. None of the devices as dependencies (on the
left) are enabled.
SND_HDA_GENERIC_LEDS is automagically enabled and disabling it via vi is
no option.
So how do I disable this stuff?

Kind regards,
Udo
