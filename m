Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF92ED176
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAGOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGOLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:11:24 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEA7C0612F4;
        Thu,  7 Jan 2021 06:10:44 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v3so6826759ilo.5;
        Thu, 07 Jan 2021 06:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dvo3HB5wYXZCfCpSjk0PVRiWT7Ji3S5OuovV7Ikl+Ws=;
        b=CbdC63JtDCoAYFoBHmgAyjh5qndb+2egVNKL3t/qvA1BG1+dLPqT+FKcM+xV7Hp5aw
         yQCap1hTh09a0YcBApczWa7S1175VaB7sghqYfLY05gIf70iZEpFXMbqI/SKr6ERS3AV
         Wy5b/X2DX/EJRwC37q5/SlxzveJR+MbFuQ+mD03QC7ioYsHxuUYSGkYVGbtk9Ce632XH
         2LhiXSjnyaDrPlzMcwMnlCUDG5UJUU0XuI68HvJNLBEJ7j9hN1f2MDbv506t5QgShGSp
         DV34uu6YiuvodG2euA8964PbVcCOMUi3xFdxCGN/SujxHhn9ojXza+FUMseUvCjd2693
         pGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dvo3HB5wYXZCfCpSjk0PVRiWT7Ji3S5OuovV7Ikl+Ws=;
        b=e+yq7iaaXnBt5oAECw+mDU/OSHdILTVZm4v1KwJr17jXqJJcD4bdoxkXHZsSJN4XBj
         EGgTDbxALmZ5X/28GFaGLneDPVXs5TZZq8UO4vtO1NUTuzJ+7AHkd/A+LLJffVQMUX+D
         4Z+DdswrQrE2XghPkwHga+F7TNiUti3PDkXjNYprVUeq9iEXSfSHpXmxO4Yuo9F6yBxK
         AZAQuA+7U5OHDT+929qj45twJ7DthEVfIPp2ZD9D3DwsJEvRtpcFrgCjmzAOkao1x0Qi
         gLGBNKUWVK7N6IXz/NdFAgyQKkx4ij2yyUPRCxVpg6wXXLjEQSyZ7FNXR4hwvCk0l+/D
         OFog==
X-Gm-Message-State: AOAM533ucsM0vB7ScODurA7kboBe/7XHTpX8v3zDFcIbc53KS4R2gK8z
        ZnzNK6XXnC4BEff+UWXWBrYAdl+k6kLmlAMmMmo=
X-Google-Smtp-Source: ABdhPJyA+rWcvCFjghwkesOaKGF4AkMhuZgf6D/LVdCemeCqYtos0f8QAJgNK30OudeQdIuM83o6iHaNnGWl6mZMPsU=
X-Received: by 2002:a92:8419:: with SMTP id l25mr8945792ild.100.1610028643512;
 Thu, 07 Jan 2021 06:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20210107103417.16010-4-alexandru.ardelean@analog.com> <202101072147.QymgDT7P-lkp@intel.com>
In-Reply-To: <202101072147.QymgDT7P-lkp@intel.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 7 Jan 2021 16:10:31 +0200
Message-ID: <CA+U=DsqXi5DWbEeU02tFWGsZLTAjFP2kSs=OTQ2yEF5GKzQ+ww@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hwmon: (ltc2945): add support for sense resistor
To:     kernel test robot <lkp@intel.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:29 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Alexandru,
>
> I love your patch! Yet something to improve:

Huh?

I'm stumped.
This looks like it may not be related to my patch?

I'll take a look deeper in a couple of days.

>
> [auto build test ERROR on hwmon/hwmon-next]
> [also build test ERROR on v5.11-rc2 next-20210104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Alexandru-Ardelean/hwmon-ltc2945-add-support-for-sense-resistor/20210107-183412
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> config: openrisc-randconfig-r011-20210107 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/1c0d97e2ccf58d83a895972d54b652adb1aba1c4
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Alexandru-Ardelean/hwmon-ltc2945-add-support-for-sense-resistor/20210107-183412
>         git checkout 1c0d97e2ccf58d83a895972d54b652adb1aba1c4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> ERROR: modpost: "__mulsi3" [net/vmw_vsock/vsock.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/9p/9pnet.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/can/can-bcm.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/can/can.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/ax25/ax25.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/netrom/netrom.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/lapb/lapb.ko] undefined!
> ERROR: modpost: "__mulsi3" [net/packet/af_packet.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/xtensa/snd-soc-xtfpga-i2s.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/uniphier/snd-soc-uniphier-aio-cpu.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/sunxi/sun4i-i2s.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/sti/snd-soc-sti.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/img/img-spdif-in.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/fsl/snd-soc-fsl-easrc.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/fsl/snd-soc-fsl-esai.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/fsl/snd-soc-fsl-asrc.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/bcm/snd-soc-cygnus.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/atmel/snd-soc-mchp-i2s-mcc.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/codecs/snd-soc-sgtl5000.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/codecs/snd-soc-rt5645.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/codecs/snd-soc-rt5616.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/codecs/snd-soc-rl6231.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/codecs/snd-soc-nau8822.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/soc/codecs/snd-soc-cs42l42.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/firewire/motu/snd-firewire-motu.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/firewire/tascam/snd-firewire-tascam.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/firewire/digi00x/snd-firewire-digi00x.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/firewire/snd-isight.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/firewire/dice/snd-dice.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/firewire/snd-firewire-lib.ko] undefined!
> ERROR: modpost: "__mulsi3" [sound/usb/hiface/snd-usb-hiface.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/most/most_usb.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/counter/counter.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwtracing/stm/stm_core.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/vhost/vhost.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/vhost/vhost_vsock.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/vhost/vhost_scsi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/vhost/vhost_net.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/occ/occ-hwmon-common.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/wm8350-hwmon.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83l786ng.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83l785ts.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83627ehf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp421.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp401.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp108.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tmp102.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/thmc50.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/amc6821.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/stts751.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sparx5-temp.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/smsc47b397.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/shtc1.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sht3x.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sht21.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sht15.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sch5627.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/sch56xx-common.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pwm-fan.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/pc87427.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ntc_thermistor.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/npcm750-pwm-fan.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/nct7904.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/nct7802.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/nct6775.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/nct6683.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/mr75203.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/tc654.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/mc13783-adc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6697.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6650.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6642.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6639.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max6621.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/max1619.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4261.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4260.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4245.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4215.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc4151.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc2992.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc2990.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc2947-core.ko] undefined!
> >> ERROR: modpost: "__divdi3" [drivers/hwmon/ltc2945.ko] undefined!
> >> ERROR: modpost: "__udivdi3" [drivers/hwmon/ltc2945.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ltc2945.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm95245.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm95241.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm90.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm83.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm78.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm77.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm75.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/lm73.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/jc42.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ina209.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ibmpex.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/gpio-fan.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/gl520sm.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/g762.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/g760a.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ftsteutates.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/f75375s.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc6w201.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/emc1403.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ds1621.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ds620.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/dme1737.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/corsair-psu.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/corsair-cpro.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/bt1-pvt.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/aspeed-pwm-tacho.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/asc7621.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/as370-hwmon.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7475.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7470.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7462.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adt7x10.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ads7828.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm9240.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1031.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1029.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1026.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1025.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adm1021.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/adc128d818.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/ad7418.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83791d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83795.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83792d.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83773g.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/w83627hf.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwmon/hwmon-vid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ubi/ubi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtdoops.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/sm_ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/rfd_ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/ftl.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/mtd.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_nandbiterrs.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_torturetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_subpagetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_stresstest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_speedtest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_pagetest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/tests/mtd_oobtest.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/nandcore.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/nand/onenand/onenand.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/maps/sc520cdp.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/lpddr/lpddr_cmds.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/lpddr/qinfo_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/gen_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0001.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_cmdset_0002.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_util.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/chips/cfi_probe.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/parsers/redboot.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/mtd/parsers/sharpslpart.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/sbp/sbp_target.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/loopback/tcm_loop.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/target_core_user.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/target_core_file.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/target_core_iblock.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/target/target_core_mod.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwtracing/intel_th/intel_th_sth.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hwtracing/intel_th/intel_th_gth.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/most/dim2/most_dim2.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/most/sound/most_sound.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/emxx_udc/emxx_udc.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/comedi/drivers/vmk80xx.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/comedi/drivers/usbdux.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/comedi/drivers/comedi_test.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/comedi/kcomedilib/kcomedilib.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/comedi/comedi.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/greybus/gb-hid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/staging/media/tegra-vde/tegra-vde.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/usbhid/usbhid.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-sensor-hub.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-wiimote.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-waltop.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-sony.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-multitouch.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-microsoft.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-mcp2221.ko] undefined!
> ERROR: modpost: "__mulsi3" [drivers/hid/hid-magicmouse.ko] undefined!
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
