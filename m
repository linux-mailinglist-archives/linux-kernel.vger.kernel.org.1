Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B778E27F678
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgJAAHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:07:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:30001 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgJAAHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:07:51 -0400
IronPort-SDR: HKAYfHfPpCCUauNPXfqKw4VPVgzeFF4qF2X9ihnXjhoedY9b0g6m5QFGYig7aIwcKVsoHGgqci
 gE/ZXmhtlTzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="142583639"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="142583639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:07:43 -0700
IronPort-SDR: kGsqz0hiTsd610OJIuk3E/14H2H0tYni5q6Vx3eky2dqMrZiVk4PxNZfcFMSe7Kd6u8Vy3n+va
 WSgPSusQ6CHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="325205268"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Sep 2020 17:07:40 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNm8K-0000RT-0J; Thu, 01 Oct 2020 00:07:40 +0000
Date:   Thu, 01 Oct 2020 08:07:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS WITH WARNING
 e9542fdb89751d93026a48a5fba66facc22df6fd
Message-ID: <5f751daa.MWCN//Fuhf0BEBnk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: e9542fdb89751d93026a48a5fba66facc22df6fd  Merge branch 'core/build'

Warning in current branch:

ld.lld: warning: arch/arm/built-in.a(mm/init.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(auxdisplay/charlcd.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(base/devcon.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(base/regmap/regmap-w1.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(bus/vexpress-config.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(clk/at91/pmc.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq_governor.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq_governor_attr_set.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/freq_table.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpuidle/dt_idle_states.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(dma/qcom/hidma_mgmt.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(dma/qcom/hidma_mgmt_sys.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(gpio/gpiolib-devprop.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/connection.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/core.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/debugfs.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/hd.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/interface.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/operation.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(greybus/svc.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(hwmon/sch56xx-common.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(hwtracing/intel_th/core.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(mfd/max14577.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(mfd/max8997.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(mfd/stm32-timers.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(misc/atmel-ssc.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(misc/cardreader/rtsx_usb.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(most/configfs.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(most/core.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(pcmcia/cs.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(pcmcia/rsrc_mgr.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(perf/arm_pmu.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(rpmsg/qcom_glink_native.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(rpmsg/qcom_glink_ssr.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(rpmsg/rpmsg_core.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/bus.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/bus_type.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/mipi_disco.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/stream.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(thermal/st/st_thermal.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(tty/hvc/hvc_console.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/core/of.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci-dbg.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci-ext-caps.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci-pci-renesas.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/phy/phy-isp1301.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/phy/phy-ulpi-viewport.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/phy/phy-ulpi.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(vhost/iotlb.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(vhost/vhost.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(vhost/vringh.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(virtio/virtio.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(virtio/virtio_ring.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: kernel/built-in.a(bpf/cgroup.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: kernel/built-in.a(dma/dummy.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: kernel/built-in.a(sched/cpufreq.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(crc64.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(kunit/assert.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(kunit/test.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(kunit/try-catch.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(ubsan.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(balloon_compaction.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(cleancache.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(page_reporting.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: net/built-in.a(mptcp/subflow.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: net/built-in.a(mptcp/token.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: virt/built-in.a(lib/irqbypass.o):(".discard.ksym") is being placed in '".discard.ksym"'

Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm-randconfig-r016-20200930
    |-- ld.lld:warning:arch-arm-built-in.a(mm-init.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(auxdisplay-charlcd.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(base-devcon.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(base-regmap-regmap-w1.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(bus-vexpress-config.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(clk-at91-pmc.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq_governor.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq_governor_attr_set.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-freq_table.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpuidle-dt_idle_states.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(dma-qcom-hidma_mgmt.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(dma-qcom-hidma_mgmt_sys.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(gpio-gpiolib-devprop.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-connection.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-debugfs.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-hd.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-interface.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-operation.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(greybus-svc.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(hwmon-sch56xx-common.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(hwtracing-intel_th-core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(mfd-max14577.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(mfd-max8997.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(mfd-stm32-timers.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(misc-atmel-ssc.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(misc-cardreader-rtsx_usb.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(most-configfs.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(most-core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(pcmcia-cs.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(pcmcia-rsrc_mgr.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(perf-arm_pmu.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(rpmsg-qcom_glink_native.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(rpmsg-qcom_glink_ssr.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(rpmsg-rpmsg_core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(soundwire-bus.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(soundwire-bus_type.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(soundwire-mipi_disco.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(soundwire-stream.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(thermal-st-st_thermal.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_console.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-core-of.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci-dbg.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci-ext-caps.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci-pci-renesas.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-phy-phy-isp1301.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-phy-phy-ulpi-viewport.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(usb-phy-phy-ulpi.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(vhost-iotlb.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(vhost-vhost.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(vhost-vringh.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(virtio-virtio.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(virtio-virtio_ring.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:kernel-built-in.a(bpf-cgroup.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:kernel-built-in.a(dma-dummy.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:kernel-built-in.a(sched-cpufreq.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:lib-built-in.a(crc64.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:lib-built-in.a(kunit-assert.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:lib-built-in.a(kunit-test.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:lib-built-in.a(kunit-try-catch.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:lib-built-in.a(ubsan.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:mm-built-in.a(balloon_compaction.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:mm-built-in.a(cleancache.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:mm-built-in.a(page_reporting.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:net-built-in.a(mptcp-subflow.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:net-built-in.a(mptcp-token.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    `-- ld.lld:warning:virt-built-in.a(lib-irqbypass.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym

elapsed time: 722m

configs tested: 115
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                          g5_defconfig
arm                           u8500_defconfig
powerpc                     sbc8548_defconfig
powerpc                    gamecube_defconfig
mips                          rb532_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 linkstation_defconfig
c6x                         dsk6455_defconfig
powerpc64                        alldefconfig
nds32                            alldefconfig
mips                           rs90_defconfig
mips                      pistachio_defconfig
arm                          imote2_defconfig
nios2                         10m50_defconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
sh                                  defconfig
parisc                              defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     tqm8540_defconfig
xtensa                  cadence_csp_defconfig
sh                          lboxre2_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
m68k                             allyesconfig
sh                 kfr2r09-romimage_defconfig
arm                           stm32_defconfig
h8300                            alldefconfig
arm                         nhk8815_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
mips                           mtx1_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
sh                          rsk7203_defconfig
sh                   sh7724_generic_defconfig
sh                             espt_defconfig
csky                                defconfig
arm                          iop32x_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
