Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A552F7D18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbhAONso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:48:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2357 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbhAONsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:48:43 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DHMpp4qRHz67bvp;
        Fri, 15 Jan 2021 21:44:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 15 Jan 2021 14:48:00 +0100
Received: from localhost (10.47.77.110) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 15 Jan
 2021 13:48:00 +0000
Date:   Fri, 15 Jan 2021 13:47:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH 00/10] Fix documentation warnings at linux-next
Message-ID: <20210115134720.000011f9@Huawei.com>
In-Reply-To: <20210115104947.71d99e87@coco.lan>
References: <CAKXUXMziQ2H7_oiVSxbt1=bDFkjLQYOiOgd00YGyDnCTVDhbqA@mail.gmail.com>
        <20210115104947.71d99e87@coco.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.110]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 10:49:47 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Hi Lukas,
> 
> Em Fri, 15 Jan 2021 07:12:38 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:
> 
> > [reduced the recipient list to the main responsible ones and list]
> > 
> > Hi Mauro, hi Jonathan,
> > 
> > We both, Mauro and I, have been submitting patches to address the
> > documentation warnings on linux-next. If it is okay with you, Mauro, I
> > would like to take responsibility for the task to send out the patches
> > to address all warnings on linux-next in make htmldocs and follow up
> > with all the discussions. I can also provide a short weekly summary
> > (probably always on Friday) on what is pending where and what I could
> > not resolve by myself.
> > 
> > Is that okay for you?
> > 
> > If at some point I do not have the time to take care anymore, I will
> > let you know.  
> 
> Yeah, sure!
> 
> Anyway, after applying the patches I sent this week, the warnings
> I'm getting are all due to the validation scripts I wrote. So, if 
> everything gets merged (either yours or my version), we'll have zero
> Sphinx/kernel-doc warnings again.
> 
> The script-validation warnings are:
> 
> 1. Broken cross references
> --------------------------
> 
> $ scripts/documentation-file-ref-check
> Warning: Documentation/arm/booting.rst references a file that doesn't exist: Documentation/devicetree/booting-without-of.rst
> Warning: Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt references a file that doesn't exist: Documentation/devicetree/bindings/iio/iio-bindings.txt
> Warning: Documentation/devicetree/bindings/input/adc-joystick.yaml references a file that doesn't exist: Documentation/devicetree/bindings/iio/iio-bindings.txt
> Warning: Documentation/devicetree/bindings/power/supply/da9150-charger.txt references a file that doesn't exist: Documentation/devicetree/bindings/iio/iio-bindings.txt
> Warning: Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
> Warning: Documentation/translations/zh_CN/arm/Booting references a file that doesn't exist: Documentation/devicetree/booting-without-of.rst
> Warning: Documentation/virt/kvm/vcpu-requests.rst references a file that doesn't exist: Documentation/core-api/atomic_ops.rst
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/toshiba,tmpv7700-pinctrl.yaml
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/intel,kmb_display.yaml
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/media/i2c/ov2680.yaml
> Warning: include/linux/rculist_nulls.h references a file that doesn't exist: Documentation/core-api/atomic_ops.rst
> Warning: tools/memory-model/Documentation/simple.txt references a file that doesn't exist: Documentation/core-api/atomic_ops.rst
> 
> It sounds that part of the above is due to DT patches that weren't
> merged yet, but there are a few others that can be solved, but may
> require discussions with some Kernel developers/maintainers.
> 
> 2. Duplicated ABI definitions
> -----------------------------
> 
> $ scripts/get_abi.pl validate
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  ./Documentation/ABI/testing/sysfs-bus-iio:394
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  ./Documentation/ABI/testing/sysfs-bus-iio:395
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  ./Documentation/ABI/testing/sysfs-bus-iio:396
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  ./Documentation/ABI/testing/sysfs-bus-iio:397
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  ./Documentation/ABI/testing/sysfs-bus-iio:398
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  ./Documentation/ABI/testing/sysfs-bus-iio:399
> Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
> Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2  ./Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8
> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:0  ./Documentation/ABI/testing/sysfs-bus-iio:599
> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:36  ./Documentation/ABI/testing/sysfs-bus-iio:588
> Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:43  ./Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:38
> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  ./Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
> Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:0  ./Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:8
> Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  ./Documentation/ABI/testing/sysfs-bus-iio:45
> Warning: /sys/class/backlight/<backlight>/l1_daylight_max is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-backlight-adp8860:12  ./Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870:4
> Warning: /sys/class/leds/<led>/repeat is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-led-trigger-pattern:28  ./Documentation/ABI/testing/sysfs-class-led-driver-el15203000:0
> Warning: /sys/kernel/iommu_groups/reserved_regions is defined 2 times:  ./Documentation/ABI/testing/sysfs-kernel-iommu_groups:15  ./Documentation/ABI/testing/sysfs-kernel-iommu_groups:27
> 
> Perhaps you could check with Jonathan Cameron some strategy to address
> the IIO warnings.

I'm being a bit rubbish on those ones. All need a bit of thought...

I'll try to kill off a few of them this weekend as *touch wood* my
review queue is looking fairly short.

Jonathan

> 
> Thanks,
> Mauro

