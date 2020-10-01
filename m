Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68A280686
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbgJAS1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:27:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:18071 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgJAS1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:27:30 -0400
IronPort-SDR: WvDvRl/aSxd2FogI34OxeXk+mL9IeW8kQliMwqT9YAIwg5YnqU7FdAKPWA/uD+otkIXUwymMej
 pIMb2ebTmDOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="163661945"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="163661945"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:27:25 -0700
IronPort-SDR: YX4YpMW7c4vZnETn4oDAysXBT41Q5aDHulk0wlsQRO1Wb8/c37y/Ox6Xlq7ft2tLmjr9kyZ1kj
 tstSt0pMnf7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="313162742"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Oct 2020 11:27:22 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO3IY-0000gQ-IW; Thu, 01 Oct 2020 18:27:22 +0000
Date:   Fri, 02 Oct 2020 02:26:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS WITH WARNING
 99b8adf3cd30dbcb441cdd7282f0c6f7ef1615f3
Message-ID: <5f761f6c.3JikdZmQTQD4YT0X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 99b8adf3cd30dbcb441cdd7282f0c6f7ef1615f3  Merge branch 'linus'

Warning in current branch:

ld.lld: warning: arch/arm/built-in.a(crypto/aes-cipher-glue.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(crypto/aes-cipher-glue.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/built-in.a(crypto/chacha-glue.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(crypto/chacha-glue.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/built-in.a(crypto/poly1305-glue.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(crypto/poly1305-glue.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/built-in.a(crypto/sha1_glue.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(crypto/sha1_glue.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/built-in.a(crypto/sha512-glue.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(crypto/sha512-glue.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/built-in.a(kernel/cpuidle.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(kernel/cpuidle.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/built-in.a(kernel/machine_kexec.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/built-in.a(mm/init.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: arch/arm/built-in.a(net/bpf_jit_32.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/mach-ebsa110/built-in.a(core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/mach-ebsa110/built-in.a(core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: arch/arm/mach-ebsa110/built-in.a(io.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/mach-ebsa110/built-in.a(leds.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: arch/arm/mach-ebsa110/built-in.a(leds.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: crypto/built-in.a(algif_aead.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: crypto/built-in.a(algif_aead.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: crypto/built-in.a(algif_hash.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: crypto/built-in.a(algif_hash.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: crypto/built-in.a(arc4.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: crypto/built-in.a(arc4.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: crypto/built-in.a(curve25519-generic.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(auxdisplay/charlcd.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(base/devcon.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(base/devcon.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(base/isa.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(base/isa.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(base/regmap/regmap-w1.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(bus/vexpress-config.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(char/dtlk.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(char/dtlk.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(char/ipmi/ipmi_ssif.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(char/tpm/tpm_i2c_atmel.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(char/tpm/tpm_i2c_atmel.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(clk/at91/pmc.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(clk/clk-fixed-mmio.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(clk/clk-fixed-mmio.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(clk/clk-max77686.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(clk/clk-max77686.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(clk/clk-palmas.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(clk/clk-palmas.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(clk/clk-si570.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(clk/clk-si570.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq_governor.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/cpufreq_governor_attr_set.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpufreq/freq_table.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpuidle/cpuidle.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(cpuidle/cpuidle.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(cpuidle/driver.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(cpuidle/dt_idle_states.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(cpuidle/governor.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(cpuidle/governors/ladder.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(cpuidle/governors/ladder.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(cpuidle/sysfs.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_aead.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_buffer_mgr.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_cipher.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_debugfs.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_debugfs.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_driver.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_driver.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_hash.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_pm.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_request_mgr.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(crypto/ccree/cc_sram_mgr.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(dma-buf/heaps/cma_heap.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(dma-buf/heaps/system_heap.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(dma-buf/sw_sync.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(dma-buf/sync_debug.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(dma-buf/sync_debug.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(dma/qcom/hidma_mgmt.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(dma/qcom/hidma_mgmt_sys.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(gpio/gpio-rc5t583.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(gpio/gpio-rc5t583.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(gpio/gpio-sama5d2-piobu.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(gpio/gpio-sama5d2-piobu.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
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
ld.lld: warning: drivers/built-in.a(i2c/busses/i2c-rk3x.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(i2c/busses/i2c-rk3x.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(i2c/busses/i2c-taos-evm.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(i2c/busses/i2c-taos-evm.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(iommu/io-pgtable-arm-v7s.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(iommu/io-pgtable-arm-v7s.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(leds/leds-88pm860x.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(leds/leds-88pm860x.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(leds/leds-asic3.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(leds/leds-asic3.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(leds/leds-blinkm.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(leds/leds-blinkm.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(leds/leds-lp8788.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(leds/leds-lp8788.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(leds/leds-tlc591xx.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(leds/leds-tlc591xx.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(media/cec/i2c/ch7322.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(media/cec/i2c/ch7322.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/aat2870-core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/aat2870-core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/cs47l24-tables.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/da9062-core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/da9062-core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/htc-i2cpld.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/htc-i2cpld.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/lp873x.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/lp873x.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/lp8788-irq.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/lp8788.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/lp8788.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/max14577.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(mfd/max8925-core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/max8925-i2c.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/max8925-i2c.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/max8997.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(mfd/rohm-bd71828.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(mfd/rohm-bd71828.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(mfd/stm32-timers.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(misc/apds990x.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(misc/apds990x.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(misc/atmel-ssc.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(misc/cardreader/rtsx_usb.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(most/configfs.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(most/core.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(net/phy/aquantia_main.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/aquantia_main.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/bcm-phy-lib.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/broadcom.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/broadcom.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/fixed_phy.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/fixed_phy.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/icplus.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/icplus.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/intel-xway.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/intel-xway.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/linkmode.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/micrel.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/micrel.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/phy-c45.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/phy-core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/phy.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/phy_device.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/phy_device.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/phy_led_triggers.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/qsemi.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/qsemi.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/smsc.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/smsc.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/ste10Xp.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/ste10Xp.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/phy/swphy.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/vitesse.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/phy/vitesse.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/sb1000.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/sb1000.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(net/wan/dlci.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(net/wan/dlci.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(of/of_mdio.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pcmcia/cs.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(pcmcia/rsrc_mgr.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(perf/arm_pmu.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(phy/cadence/phy-cadence-torrent.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(phy/cadence/phy-cadence-torrent.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(pinctrl/pinctrl-ocelot.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pinctrl/pinctrl-ocelot.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(platform/chrome/cros_ec_i2c.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(platform/chrome/cros_ec_i2c.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(pnp/card.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(pnp/driver.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/interface.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/manager.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/quirks.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/resource.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/resource.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(pnp/support.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/system.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(pnp/system.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(power/reset/gpio-poweroff.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(power/reset/gpio-poweroff.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(power/reset/gpio-restart.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(power/reset/gpio-restart.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(power/reset/restart-poweroff.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(power/reset/restart-poweroff.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(power/supply/max77650-charger.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(power/supply/max77650-charger.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(power/supply/max8998_charger.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(power/supply/max8998_charger.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(power/supply/wm831x_power.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(power/supply/wm831x_power.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(regulator/bd9571mwv-regulator.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(regulator/bd9571mwv-regulator.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(regulator/max1586.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(regulator/max1586.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(regulator/max8998.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(regulator/max8998.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(regulator/qcom-labibb-regulator.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(regulator/qcom-labibb-regulator.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(regulator/sy8106a-regulator.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(regulator/sy8106a-regulator.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rpmsg/qcom_glink_native.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(rpmsg/qcom_glink_ssr.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(rpmsg/rpmsg_core.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(rtc/nvmem.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-88pm860x.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-88pm860x.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-cmos.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-cmos.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-em3027.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-em3027.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-hym8563.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-hym8563.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-lp8788.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-lp8788.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-max8998.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-max8998.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-mc146818-lib.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-palmas.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-palmas.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-tps65910.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-tps65910.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(rtc/rtc-tps80031.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(rtc/rtc-tps80031.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(soundwire/bus.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/bus_type.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/mipi_disco.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(soundwire/stream.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(ssb/driver_gpio.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(thermal/st/st_thermal.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(tty/goldfish.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/goldfish.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/hvc/hvc_console.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(tty/hvc/hvc_console.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/hvc/hvc_console.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/hvc/hvc_dcc.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/hvc/hvc_dcc.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/n_gsm.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/n_gsm.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/8250/8250_aspeed_vuart.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/8250/8250_aspeed_vuart.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/8250/8250_boca.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/8250/8250_dwlib.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/8250/8250_fintek.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/8250/8250_fourport.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/arc_uart.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/arc_uart.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/digicolor-usart.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/digicolor-usart.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/sifive.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/sifive.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/sprd_serial.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/sprd_serial.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(tty/serial/uartlite.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(tty/serial/uartlite.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(usb/core/of.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci-dbg.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci-ext-caps.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci-pci-renesas.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/host/xhci.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/phy/phy-isp1301.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/phy/phy-ulpi-viewport.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(usb/phy/phy-ulpi.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(vdpa/vdpa.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(vhost/iotlb.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(vhost/vdpa.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(vhost/vdpa.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(vhost/vhost.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(vhost/vringh.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(video/backlight/max8925_bl.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(video/backlight/max8925_bl.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(virtio/virtio.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(virtio/virtio_mmio.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(virtio/virtio_mmio.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(virtio/virtio_ring.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: drivers/built-in.a(watchdog/da9062_wdt.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/da9062_wdt.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(watchdog/ftwdt010_wdt.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/ftwdt010_wdt.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(watchdog/max77620_wdt.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/max77620_wdt.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(watchdog/mixcomwd.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/mixcomwd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(watchdog/pcwd.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/pcwd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(watchdog/pretimeout_panic.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/pretimeout_panic.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: drivers/built-in.a(watchdog/watchdog_pretimeout.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/wm831x_wdt.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: drivers/built-in.a(watchdog/wm831x_wdt.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: fs/built-in.a(coredump.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: fs/built-in.a(nls/nls_cp850.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: fs/built-in.a(nls/nls_cp850.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: fs/built-in.a(userfaultfd.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: fs/built-in.a(userfaultfd.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(bpf/bpf_struct_ops.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(bpf/cgroup.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: kernel/built-in.a(bpf/core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(bpf/dispatcher.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(bpf/trampoline.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(bpf/trampoline.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(cgroup/rdma.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(crash_core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(crash_core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(dma/dummy.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: kernel/built-in.a(kexec.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(kexec_core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(kexec_core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(kheaders.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: kernel/built-in.a(kheaders.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(power/qos.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: kernel/built-in.a(sched/cpufreq.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: kernel/built-in.a(uid16.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: lib/built-in.a(crc64.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(globtest.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: lib/built-in.a(kunit/assert.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(kunit/test.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(kunit/try-catch.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: lib/built-in.a(ubsan.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(balloon_compaction.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(balloon_compaction.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: mm/built-in.a(cleancache.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(cma_debug.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: mm/built-in.a(cma_debug.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: mm/built-in.a(debug_page_ref.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: mm/built-in.a(kmemleak.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: mm/built-in.a(kmemleak.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: mm/built-in.a(kmemleak.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
ld.lld: warning: mm/built-in.a(page_reporting.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: mm/built-in.a(process_vm_access.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: mm/built-in.a(slab.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: mm/built-in.a(slab.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: mm/built-in.a(slab.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
ld.lld: warning: mm/built-in.a(userfaultfd.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(8021q/vlan_core.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(8021q/vlan_core.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(bridge/br_vlan.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(bridge/br_vlan_options.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(bridge/br_vlan_tunnel.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(core/lwt_bpf.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(core/lwt_bpf.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(ipv4/bpf_tcp_ca.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(ipv6/sit.o):(.ARM.extab.ref.text) is being placed in '.ARM.extab.ref.text'
ld.lld: warning: net/built-in.a(mac802154/cfg.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/iface.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/llsec.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/mac_cmd.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/main.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/main.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(mac802154/mib.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/rx.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/trace.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/tx.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(mac802154/util.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/cls_bpf.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/cls_bpf.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(sched/cls_matchall.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/cls_matchall.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(sched/cls_rsvp6.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/cls_rsvp6.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(sched/sch_gred.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/sch_gred.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(sched/sch_hfsc.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/sch_hfsc.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(sched/sch_hhf.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/sch_hhf.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: net/built-in.a(sched/sch_sfq.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: net/built-in.a(sched/sch_sfq.o):(.ARM.extab.init.text) is being placed in '.ARM.extab.init.text'
ld.lld: warning: security/built-in.a(keys/persistent.o):(.ARM.extab) is being placed in '.ARM.extab'
ld.lld: warning: virt/built-in.a(lib/irqbypass.o):(".discard.ksym") is being placed in '".discard.ksym"'
ld.lld: warning: virt/built-in.a(lib/irqbypass.o):(.ARM.extab) is being placed in '.ARM.extab'

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r011-20200930
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-aes-cipher-glue.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-aes-cipher-glue.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-chacha-glue.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-chacha-glue.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-poly1305-glue.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-poly1305-glue.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-sha1_glue.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-sha1_glue.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-sha512-glue.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(crypto-sha512-glue.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-built-in.a(kernel-cpuidle.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(kernel-cpuidle.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-built-in.a(kernel-machine_kexec.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-built-in.a(net-bpf_jit_32.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-mach-ebsa110-built-in.a(core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-mach-ebsa110-built-in.a(core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:arch-arm-mach-ebsa110-built-in.a(io.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-mach-ebsa110-built-in.a(leds.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:arch-arm-mach-ebsa110-built-in.a(leds.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:crypto-built-in.a(algif_aead.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:crypto-built-in.a(algif_aead.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:crypto-built-in.a(algif_hash.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:crypto-built-in.a(algif_hash.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:crypto-built-in.a(arc4.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:crypto-built-in.a(arc4.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:crypto-built-in.a(curve25519-generic.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(base-devcon.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(base-isa.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(base-isa.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(char-dtlk.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(char-dtlk.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(char-ipmi-ipmi_ssif.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(char-tpm-tpm_i2c_atmel.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(char-tpm-tpm_i2c_atmel.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-fixed-mmio.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-fixed-mmio.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-max77686.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-max77686.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-palmas.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-palmas.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-si570.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(clk-clk-si570.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-cpuidle.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-cpuidle.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-driver.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-governor.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-governors-ladder.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-governors-ladder.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-sysfs.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_aead.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_buffer_mgr.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_cipher.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_debugfs.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_debugfs.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_driver.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_driver.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_hash.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_pm.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_request_mgr.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(crypto-ccree-cc_sram_mgr.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(dma-buf-heaps-cma_heap.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(dma-buf-heaps-system_heap.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(dma-buf-sw_sync.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(dma-buf-sync_debug.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(dma-buf-sync_debug.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(gpio-gpio-rc5t583.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(gpio-gpio-rc5t583.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(gpio-gpio-sama5d2-piobu.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(gpio-gpio-sama5d2-piobu.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(i2c-busses-i2c-rk3x.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(i2c-busses-i2c-rk3x.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(i2c-busses-i2c-taos-evm.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(i2c-busses-i2c-taos-evm.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(iommu-io-pgtable-arm-v7s.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(iommu-io-pgtable-arm-v7s.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-88pm86.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-88pm86.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-asic3.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-asic3.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-blinkm.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-blinkm.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-lp8788.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-lp8788.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-tlc591xx.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(leds-leds-tlc591xx.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(media-cec-i2c-ch7322.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(media-cec-i2c-ch7322.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-aat2870-core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-aat2870-core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-cs47l24-tables.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-da9062-core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-da9062-core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-htc-i2cpld.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-htc-i2cpld.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-lp873x.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-lp873x.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-lp8788-irq.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-lp8788.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-lp8788.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-max8925-core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-max8925-i2c.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-max8925-i2c.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(mfd-rohm-bd71828.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(mfd-rohm-bd71828.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(misc-apds99.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(misc-apds99.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-aquantia_main.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-aquantia_main.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-bcm-phy-lib.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-broadcom.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-broadcom.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-fixed_phy.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-fixed_phy.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-icplus.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-icplus.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-intel-xway.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-intel-xway.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-linkmode.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-micrel.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-micrel.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-phy-c45.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-phy-core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-phy.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-phy_device.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-phy_device.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-phy_led_triggers.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-qsemi.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-qsemi.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-smsc.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-smsc.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-ste10Xp.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-ste10Xp.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-swphy.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-vitesse.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-phy-vitesse.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-sb1000.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-sb1000.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(net-wan-dlci.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(net-wan-dlci.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(of-of_mdio.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(phy-cadence-phy-cadence-torrent.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(phy-cadence-phy-cadence-torrent.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(pinctrl-pinctrl-ocelot.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pinctrl-pinctrl-ocelot.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(platform-chrome-cros_ec_i2c.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(platform-chrome-cros_ec_i2c.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(pnp-card.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(pnp-driver.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-interface.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-manager.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-quirks.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-resource.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-resource.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(pnp-support.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-system.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(pnp-system.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(power-reset-gpio-poweroff.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(power-reset-gpio-poweroff.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(power-reset-gpio-restart.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(power-reset-gpio-restart.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(power-reset-restart-poweroff.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(power-reset-restart-poweroff.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(power-supply-max77650-charger.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(power-supply-max77650-charger.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(power-supply-max8998_charger.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(power-supply-max8998_charger.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(power-supply-wm831x_power.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(power-supply-wm831x_power.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(regulator-bd9571mwv-regulator.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(regulator-bd9571mwv-regulator.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(regulator-max1586.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(regulator-max1586.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(regulator-max8998.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(regulator-max8998.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(regulator-qcom-labibb-regulator.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(regulator-qcom-labibb-regulator.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(regulator-sy8106a-regulator.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(regulator-sy8106a-regulator.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-nvmem.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-88pm86.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-88pm86.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-cmos.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-cmos.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-em3027.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-em3027.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-hym8563.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-hym8563.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-lp8788.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-lp8788.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-max8998.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-max8998.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-mc146818-lib.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-palmas.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-palmas.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-tps65910.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-tps65910.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-tps80031.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(rtc-rtc-tps80031.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(ssb-driver_gpio.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-goldfish.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-goldfish.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_console.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_console.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_dcc.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_dcc.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-n_gsm.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-n_gsm.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-8250_aspeed_vuart.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-8250_aspeed_vuart.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-8250_boca.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-8250_dwlib.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-8250_fintek.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-8250_fourport.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-arc_uart.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-arc_uart.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-digicolor-usart.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-digicolor-usart.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-sifive.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-sifive.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-sprd_serial.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-sprd_serial.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-uartlite.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(tty-serial-uartlite.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(vdpa-vdpa.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(vhost-vdpa.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(vhost-vdpa.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(video-backlight-max8925_bl.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(video-backlight-max8925_bl.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(virtio-virtio_mmio.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(virtio-virtio_mmio.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-da9062_wdt.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-da9062_wdt.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-ftwdt010_wdt.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-ftwdt010_wdt.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-max77620_wdt.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-max77620_wdt.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-mixcomwd.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-mixcomwd.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-pcwd.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-pcwd.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-pretimeout_panic.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-pretimeout_panic.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-watchdog_pretimeout.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-wm831x_wdt.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:drivers-built-in.a(watchdog-wm831x_wdt.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:fs-built-in.a(coredump.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:fs-built-in.a(nls-nls_cp850.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:fs-built-in.a(nls-nls_cp850.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:fs-built-in.a(userfaultfd.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:fs-built-in.a(userfaultfd.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(bpf-bpf_struct_ops.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(bpf-core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(bpf-dispatcher.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(bpf-trampoline.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(bpf-trampoline.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(cgroup-rdma.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(crash_core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(crash_core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(kexec.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(kexec_core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(kexec_core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(kheaders.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:kernel-built-in.a(kheaders.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(power-qos.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:kernel-built-in.a(uid16.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:lib-built-in.a(globtest.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:mm-built-in.a(balloon_compaction.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:mm-built-in.a(cma_debug.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:mm-built-in.a(cma_debug.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:mm-built-in.a(debug_page_ref.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:mm-built-in.a(kmemleak.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:mm-built-in.a(kmemleak.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:mm-built-in.a(kmemleak.o):(.ARM.extab.ref.text)-is-being-placed-in-.ARM.extab.ref.text
|   |-- ld.lld:warning:mm-built-in.a(process_vm_access.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:mm-built-in.a(slab.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:mm-built-in.a(slab.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:mm-built-in.a(slab.o):(.ARM.extab.ref.text)-is-being-placed-in-.ARM.extab.ref.text
|   |-- ld.lld:warning:mm-built-in.a(userfaultfd.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(8021q-vlan_core.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(8021q-vlan_core.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(bridge-br_vlan.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(bridge-br_vlan_options.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(bridge-br_vlan_tunnel.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(core-lwt_bpf.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(core-lwt_bpf.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(ipv4-bpf_tcp_ca.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(ipv6-sit.o):(.ARM.extab.ref.text)-is-being-placed-in-.ARM.extab.ref.text
|   |-- ld.lld:warning:net-built-in.a(mac802154-cfg.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-iface.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-llsec.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-mac_cmd.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-main.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-main.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(mac802154-mib.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-rx.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-trace.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-tx.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(mac802154-util.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-cls_bpf.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-cls_bpf.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(sched-cls_matchall.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-cls_matchall.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(sched-cls_rsvp6.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-cls_rsvp6.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(sched-sch_gred.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-sch_gred.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(sched-sch_hfsc.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-sch_hfsc.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(sched-sch_hhf.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-sch_hhf.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:net-built-in.a(sched-sch_sfq.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   |-- ld.lld:warning:net-built-in.a(sched-sch_sfq.o):(.ARM.extab.init.text)-is-being-placed-in-.ARM.extab.init.text
|   |-- ld.lld:warning:security-built-in.a(keys-persistent.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|   `-- ld.lld:warning:virt-built-in.a(lib-irqbypass.o):(.ARM.extab)-is-being-placed-in-.ARM.extab
|-- arm-randconfig-r016-20200930
|   |-- ld.lld:warning:arch-arm-built-in.a(mm-init.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(auxdisplay-charlcd.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(base-devcon.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(base-regmap-regmap-w1.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(bus-vexpress-config.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(clk-at91-pmc.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq_governor.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq_governor_attr_set.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(cpufreq-freq_table.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(cpuidle-dt_idle_states.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(dma-qcom-hidma_mgmt.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(dma-qcom-hidma_mgmt_sys.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(gpio-gpiolib-devprop.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-connection.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-debugfs.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-hd.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-interface.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-operation.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(greybus-svc.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(hwmon-sch56xx-common.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(hwtracing-intel_th-core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(mfd-max14577.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(mfd-max8997.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(mfd-stm32-timers.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(misc-atmel-ssc.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(misc-cardreader-rtsx_usb.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(most-configfs.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(most-core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(pcmcia-cs.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(pcmcia-rsrc_mgr.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(perf-arm_pmu.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(rpmsg-qcom_glink_native.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(rpmsg-qcom_glink_ssr.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(rpmsg-rpmsg_core.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(soundwire-bus.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(soundwire-bus_type.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(soundwire-mipi_disco.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(soundwire-stream.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(thermal-st-st_thermal.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_console.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-core-of.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci-dbg.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci-ext-caps.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci-pci-renesas.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-host-xhci.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-phy-phy-isp1301.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-phy-phy-ulpi-viewport.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(usb-phy-phy-ulpi.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(vhost-iotlb.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(vhost-vhost.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(vhost-vringh.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(virtio-virtio.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:drivers-built-in.a(virtio-virtio_ring.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:kernel-built-in.a(bpf-cgroup.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:kernel-built-in.a(dma-dummy.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:kernel-built-in.a(sched-cpufreq.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:lib-built-in.a(crc64.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:lib-built-in.a(kunit-assert.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:lib-built-in.a(kunit-test.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:lib-built-in.a(kunit-try-catch.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:lib-built-in.a(ubsan.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:mm-built-in.a(balloon_compaction.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:mm-built-in.a(cleancache.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   |-- ld.lld:warning:mm-built-in.a(page_reporting.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
|   `-- ld.lld:warning:virt-built-in.a(lib-irqbypass.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
`-- x86_64-randconfig-r003-20200930
    |-- ld.lld:warning:drivers-built-in.a(base-devcon.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq_governor.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-cpufreq_governor_attr_set.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(cpufreq-freq_table.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(gpio-gpiolib-devprop.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(mfd-max14577.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(mfd-max8997.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(tty-hvc-hvc_console.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(virtio-virtio.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:drivers-built-in.a(virtio-virtio_ring.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:kernel-built-in.a(sched-cpufreq.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:lib-built-in.a(ubsan.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:mm-built-in.a(balloon_compaction.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    |-- ld.lld:warning:mm-built-in.a(cleancache.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym
    `-- ld.lld:warning:mm-built-in.a(page_reporting.o):(-discard.ksym-)-is-being-placed-in-.discard.ksym

elapsed time: 725m

configs tested: 109
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
sh                         ap325rxa_defconfig
powerpc                     sequoia_defconfig
mips                    maltaup_xpa_defconfig
m68k                             allmodconfig
alpha                               defconfig
powerpc                 canyonlands_defconfig
mips                          ath79_defconfig
c6x                        evmc6457_defconfig
powerpc                     asp8347_defconfig
arm                         mv78xx0_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                        bcm63xx_defconfig
nds32                            alldefconfig
nios2                         10m50_defconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
powerpc                   motionpro_defconfig
arm                          gemini_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                           alldefconfig
arm                         nhk8815_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
m68k                           sun3_defconfig
arm                          pxa910_defconfig
sh                     magicpanelr2_defconfig
powerpc                      chrp32_defconfig
mips                        jmr3927_defconfig
powerpc                      katmai_defconfig
powerpc                           allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
