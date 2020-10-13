Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F218128CF16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgJMNYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:24:35 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:50179 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgJMNYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:24:34 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id SKI0k3hbS4gEjSKI1kISV2; Tue, 13 Oct 2020 15:24:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1602595471; bh=6xSanXaEOlo9zDnJWppAT+rJ/WwXol434kmVjZbPsU8=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=LfJ6irCJuglLne8B5Kp3hj3gSPCWAx2fDQBgpBgG5D9oWxhmFem8YJGzcto/07y2B
         8yf4x3+k6XWJQdvPbOqZ8GiNdC8sz8kHlTZS9CswPXXxCXfVrxzCm2mD+t/uY8MS9N
         TsaEapWrB/QSJON8OhG1j5cFzNfWDQb7SyZRzFjBbPrBVvWPQO+Vij4bYXESHX4mMt
         0PIxGw9p3NbBce88r5TYWf44IG03NMp0K/gFOFm/lzXvKxfXbl/SX7VgNFaNm3X23W
         s7ovCrlMdJksv5zTfpQZbYHn4G/UdhZlPxVDnirA1RH9CWmcOSMLbzrtQCmmJNz51b
         mJJYYUI21jzKw==
Subject: Re: disabling CONFIG_LED_CLASS
From:   Udo van den Heuvel <udovdh@xs4all.nl>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <2835d02a-380b-6a3a-0e4d-abf07aee18bc@xs4all.nl>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
Organization: hierzo
Message-ID: <53e698c1-86e4-8b1f-afb0-b8471349e701@xs4all.nl>
Date:   Tue, 13 Oct 2020 15:24:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2835d02a-380b-6a3a-0e4d-abf07aee18bc@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNxKgu7UrNNVXafLgdp8czc/Q5ZYhLimAIzoQw6v4HiyNFwBqbzr98Q+0gKBTszK5dpzVSPDepR68mw3Hf0fjtT9qTxle/2e3WkNfAZ0apmzc0FaDaMr
 OlsP88H77FnhVezrTZluMS8NJXmMSqnDzqOQolugay5Mj90CJx4SbEKY29r+vBWESt+JUFYbqfpKi40r4aTQK8OqyeGCEdpiBi6XxRwwmZKLDTG6PvWAGreb
 tzB22XqySYDfwaQtqAa+79jccu1bvYEnjSLdJrl3tYM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,

Even after removing all LED referneces from .config, a `make oldconfig`
leads to:

*
* LED Support
*
LED Support (NEW_LEDS) [Y/?] (NEW) y
  LED Class Support (LEDS_CLASS) [M/y/?] (NEW) n

Where 'n' is not a valid choice.
So why is this LED thing forced upon us and how do we get rid of it?

Or else please explain how to make this work on a Gigabyte Technology
Co., Ltd. X570 AORUS PRO...

Kind regards,
Udo


On 13-10-2020 11:24, Udo van den Heuvel wrote:
> Hello,
> 
> While looking at the 5.9 kernel config I noticed there is no easy way to
> disable LED support in general.
> There's this NEW_LEDS thing that is not shown, etc.
> So I get:
> 
> # make oldconfig
> scripts/kconfig/conf  --oldconfig Kconfig
> *
> * Restart config...
> *
> *
> * LED Support
> *
> LED Support (NEW_LEDS) [Y/?] (NEW) y
>   LED Class Support (LEDS_CLASS) [M/y/?] (NEW) n
> 
> CONFIG_LEDS_CLASS:
> 
> This option enables the LED sysfs class in /sys/class/leds.  You'll
> need this to do anything useful with LEDs.  If unsure, say N.
> 
> Symbol: LEDS_CLASS [=m]
> Type  : tristate
> Defined at drivers/leds/Kconfig:17
>   Prompt: LED Class Support
>   Depends on: NEW_LEDS [=y]
>   Location:
>     -> Device Drivers
>       -> LED Support (NEW_LEDS [=y])
> Selected by [m]:
>   - SND_HDA_GENERIC [=m] && SOUND [=y] && !UML && SND [=m] && SND_HDA
> [=m] && SND_HDA_GENERIC_LEDS [=y]
> Selected by [n]:
>   - TS5500 [=n] && X86_32 [=n] && MELAN [=n]
>   - ADB_PMU_LED [=n] && MACINTOSH_DRIVERS [=n] && PPC_PMAC && ADB_PMU [=n]
>   - ATH5K [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_ATH [=n]
> && (PCI [=y] || ATH25) && MAC80211 [=n]
>   - ATH9K [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_ATH [=n]
> && MAC80211 [=n] && HAS_DMA [=y]
>   - ATH9K_HTC [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_ATH
> [=n] && USB [=y] && MAC80211 [=n]
>   - CARL9170_LEDS [=n] && NETDEVICES [=y] && WLAN [=n] &&
> WLAN_VENDOR_ATH [=n] && CARL9170 [=n]
>   - BRCMSMAC [=n] && NETDEVICES [=y] && WLAN [=n] &&
> WLAN_VENDOR_BROADCOM [=n] && MAC80211 [=n] && BCMA_POSSIBLE [=y] &&
> BCMA_DRIVER_GPIO [=n]
>   - IWLEGACY [=n] && NETDEVICES [=y] && WLAN [=n] && WLAN_VENDOR_INTEL [=n]
>   - INPUT_WISTRON_BTNS [=n] && !UML && INPUT [=y] && INPUT_MISC [=y] &&
> X86_32 [=n]
>   - SENSORS_APPLESMC [=n] && HWMON [=y] && INPUT [=y] && X86 [=y]
>   - IR_REDRAT3 [=n] && RC_DEVICES [=n] && USB_ARCH_HAS_HCD [=y] &&
> RC_CORE [=n]
>   - IR_WINBOND_CIR [=n] && RC_DEVICES [=n] && (X86 [=y] && PNP [=y] ||
> COMPILE_TEST [=n]) && RC_CORE [=n]
>   - IR_TTUSBIR [=n] && RC_DEVICES [=n] && USB_ARCH_HAS_HCD [=y] &&
> RC_CORE [=n]
>   - BACKLIGHT_ADP8860 [=n] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
> [=y] && I2C [=y]
>   - BACKLIGHT_ADP8870 [=n] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
> [=y] && I2C [=y]
>   - BACKLIGHT_LM3639 [=n] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE
> [=y] && I2C [=y]
>   - SND_USB_TONEPORT [=n] && SOUND [=y] && !UML && SND [=m] && SND_USB
> [=y] && USB [=y]
>   - HID_LENOVO [=n] && INPUT [=y] && HID [=y]
>   - HID_WACOM [=n] && INPUT [=y] && HID [=y] && USB_HID [=m]
>   - HUAWEI_WMI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] &&
> ACPI_BATTERY [=n] && ACPI_WMI [=n] && INPUT [=y]
>   - ACER_WMI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI [=y]
> && BACKLIGHT_CLASS_DEVICE [=y] && SERIO_I8042 [=y] && INPUT [=y] &&
> (RFKILL [=n] || RFKILL [=n]=n) && ACPI_WMI [=n]
>   - ASUS_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && BACKLIGHT_CLASS_DEVICE [=y] && INPUT [=y] && (RFKILL [=n] ||
> RFKILL [=n]=n) && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
>   - ASUS_WIRELESS [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && INPUT [=y]
>   - ASUS_WMI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI_WMI
> [=n] && ACPI_BATTERY [=n] && INPUT [=y] && HWMON [=y] &&
> BACKLIGHT_CLASS_DEVICE [=y] && (RFKILL [=n] || RFKILL [=n]=n) &&
> HOTPLUG_PCI [=n] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
>   - EEEPC_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n) && (ACPI_VIDEO [=n]
> || ACPI_VIDEO [=n]=n) && HOTPLUG_PCI [=n] && BACKLIGHT_CLASS_DEVICE [=y]
>   - DELL_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && DMI
> [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO
> [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y] &&
> DELL_SMBIOS [=n]
>   - FUJITSU_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && INPUT [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
> ACPI_VIDEO [=n]=n)
>   - HP_ACCEL [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && INPUT [=y]
> && ACPI [=y] && SERIO_I8042 [=y]
>   - THINKPAD_ACPI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && ACPI_BATTERY [=n] && INPUT [=y] && (RFKILL [=n] || RFKILL
> [=n]=n) && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) &&
> BACKLIGHT_CLASS_DEVICE [=y]
>   - SAMSUNG_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] &&
> (RFKILL [=n] || RFKILL [=n]=n) && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n)
> && BACKLIGHT_CLASS_DEVICE [=y]
>   - ACPI_TOSHIBA [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && ACPI_WMI [=n] && BACKLIGHT_CLASS_DEVICE [=y] && INPUT [=y] &&
> (SERIO_I8042 [=y] || SERIO_I8042 [=y]=n) && (ACPI_VIDEO [=n] ||
> ACPI_VIDEO [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && IIO [=n]
>   - LG_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI [=y]
> && ACPI_WMI [=n] && INPUT [=y]
>   - SYSTEM76_ACPI [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI [=y]
>   - TOPSTAR_LAPTOP [=n] && X86 [=y] && X86_PLATFORM_DEVICES [=n] && ACPI
> [=y] && INPUT [=y]
> 
> 
> And there is no 'n' option. None of the devices as dependencies (on the
> left) are enabled.
> SND_HDA_GENERIC_LEDS is automagically enabled and disabling it via vi is
> no option.
> So how do I disable this stuff?
> 
> Kind regards,
> Udo
> 

