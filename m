Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FEA220681
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 09:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgGOHwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 03:52:40 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:41390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728888AbgGOHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:52:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2F788180A7FDB;
        Wed, 15 Jul 2020 07:52:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:857:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1714:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3868:3870:3871:4321:4384:4605:5007:6119:7903:8957:9036:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12297:12438:12740:12760:12895:13019:13161:13229:13439:14659:14721:21063:21080:21433:21451:21611:21627:21773:30009:30046:30054:30055:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boot55_4b12d8026ef7
X-Filterd-Recvd-Size: 3675
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Jul 2020 07:52:37 +0000 (UTC)
Message-ID: <70107f0baa54e5ee8da989e01519f292536a41ef.camel@perches.com>
Subject: Re: [PATCH] mmc: cqhci: Fix a print format for the task descriptor
From:   Joe Perches <joe@perches.com>
To:     Ben Chuang <benchuanggli@gmail.com>, adrian.hunter@intel.com,
        riteshh@codeaurora.org, asutoshd@codeaurora.org,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Date:   Wed, 15 Jul 2020 00:52:36 -0700
In-Reply-To: <20200715073344.8965-1-benchuanggli@gmail.com>
References: <20200715073344.8965-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 15:33 +0800, Ben Chuang wrote:
> The format string of the task descriptor should be "%016llx".

There are a lot of these:

$ git grep -P -n '\b0x\d+%'
arch/m68k/include/asm/mmu_context.h:166:        pr_info("ksp load failed: mm=0x%p ksp=0x08%lx\n", mm, mmuar);
arch/powerpc/kvm/book3s_xive.c:1706:    pr_devel("  val=0x016%llx (server=0x%x, guest_prio=%d)\n",
drivers/atm/eni.c:590:                  EVENT("bad PDU (descr=0x08%lx,length=%ld)\n",descr,
drivers/dma/ppc4xx/adma.c:4366:                 "uses 0x1%02x polynomial.\n", reg);
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:3023:             DRM_INFO("Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
drivers/gpu/drm/i915/intel_uncore.c:495:                drm_dbg(&uncore->i915->drm, "GTFIFODBG = 0x08%x\n", fifodbg);
drivers/media/usb/gspca/ov519.c:2760:                           gspca_err(gspca_dev, "Unknown sensor: 0x76%02x\n",
drivers/mmc/host/cqhci.c:425:   pr_debug("%s: cqhci: tag %d task descriptor 0x016%llx\n",
drivers/mmc/host/s3cmci.c:192:           "#%u%s op:%i arg:0x%08x flags:0x08%x retries:%u",
drivers/net/can/flexcan.c:1517:         "gpr %s req_gpr=0x02%x req_bit=%u ack_gpr=0x02%x ack_bit=%u\n",
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:444:              "    info: cmd_reserved[] = 0x%02x 0x%02x 0x%02x 0x0%02x 0x%02x 0x%02x 0x%02x 0x0%02x\n",
drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:1397:                         "i = %d  buffer_info->dma = 0x08%llx  buffer_info->length = 0x%x\n",
drivers/net/wireless/intel/iwlwifi/pcie/trans.c:2298:           "Queue %d is %sactive on fifo %d and stuck for %u ms. SW [%d, %d] HW [%d, %d] FH TRB=0x0%x\n",
drivers/net/wireless/intersil/hostap/hostap_hw.c:779:                  "(%d,0x04%x,%d); reg=0x%04x\n",
drivers/net/wireless/realtek/rtw88/rtw8822c.c:429:              rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] ADCK 0x%08x=0x08%x\n",
drivers/scsi/mpt3sas/mpt3sas_scsih.c:6161:              ioc_err(ioc, "device is not present handle(0x04%x)!!!\n",
drivers/scsi/mpt3sas/mpt3sas_scsih.c:6923:              ioc_err(ioc, "device is not present handle(0x04%x)!!!\n",
drivers/staging/rtl8723bs/hal/hal_com_phycfg.c:328:                     DBG_871X("Invalid RegAddr 0x3%x in PHY_GetRateSectionIndexOfTxPowerByRate()", RegAddr);
drivers/usb/serial/spcp8x5.c:225:       dev_dbg(&port->dev, "0xc0:0x22:0:6  %d - 0x02%x\n", ret, *buf);
drivers/video/fbdev/s1d13xxxfb.c:500:   dbg_blit("(copyarea) bpp=%d=0x0%d, mem_offset1=%d, mem_offset2=%d\n", bpp, (bpp >> 1),
sound/pci/es1938.c:306:         "snd_es1938_write_cmd timeout (0x02%x/0x02%x)\n", cmd, v);
sound/pci/es1938.c:319: dev_err(chip->card->dev, "get_byte timeout: status 0x02%x\n", v);



