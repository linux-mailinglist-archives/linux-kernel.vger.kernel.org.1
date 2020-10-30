Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A422A02C9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgJ3K0q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 30 Oct 2020 06:26:46 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54379 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJ3K0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:26:45 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DE32AC0014;
        Fri, 30 Oct 2020 10:26:37 +0000 (UTC)
Date:   Fri, 30 Oct 2020 11:26:35 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
Cc:     richard <richard@nod.at>, vigneshr <vigneshr@ti.com>,
        robh+dt <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        =?UTF-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20201030112635.162bb709@xps13>
In-Reply-To: <20201030181152443876127@rock-chips.com>
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
        <20201028114826.6cd6b841@xps13>
        <20201030181152443876127@rock-chips.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 赵仪峰,

赵仪峰 <yifeng.zhao@rock-chips.com> wrote on Fri, 30 Oct 2020 18:12:52
+0800:

> Hi Miquel,
> 
> >Hi Yifeng,
> >
> >A few more comments below, but overall looks better.
> >
> >Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote on Wed, 28 Oct 2020
> >17:53:24 +0800:
> >  
> >> This driver supports Rockchip NFC (NAND Flash Controller) found on RK3308,
> >> RK2928, RKPX30, RV1108 and other SOCs. The driver has been tested using
> >> 8-bit NAND interface on the ARM based RK3308 platform.
> >>
> >> Support Rockchip SoCs and NFC versions:
> >> - PX30 and RK3326(NFCv900).
> >> ECC: 16/40/60/70 bits/1KB.
> >> CLOCK: ahb and nfc.
> >> - RK3308 and RV1108(NFCv800).
> >> ECC: 16 bits/1KB.
> >> CLOCK: ahb and nfc.
> >> - RK3036 and RK3128(NFCv622).
> >> ECC: 16/24/40/60 bits/1KB.
> >> CLOCK: ahb and nfc.
> >> - RK3066, RK3188 and RK2928(NFCv600).
> >> ECC: 16/24/40/60 bits/1KB.
> >> CLOCK: ahb.
> >>
> >> Supported features:
> >> - Read full page data by DMA.
> >> - Support HW ECC(one step is 1KB).
> >> - Support 2 - 32K page size.
> >> - Support 8 CS(depend on SoCs)
> >>
> >> Limitations:
> >> - No support for the ecc step size is 512.
> >> - Untested on some SoCs.
> >> - No support for subpages.
> >> - No support for the builtin randomizer.
> >> - The original bad block mask is not supported. It is recommended to use
> >>   the BBT(bad block table).
> >>
> >> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> >> ---
> >>
> >> Changes in v13:
> >> - The nfc->buffer will realloc while the page size of the second mtd
> >>   is large than the first one.
> >> - Fix coding style.
> >> - Fix some comments.
> >>
> >> Changes in v12: None
> >> Changes in v11:
> >> - Fix compile error.
> >>
> >> Changes in v10:
> >> - Fix compile error on master v5.9-rc7.
> >>
> >> Changes in v9:
> >> - The nfc->buffer will realloc while the page size of the second mtd
> >>   is large than the first one
> >> - Fix coding style.
> >> - Remove struct rk_nfc_clk.
> >> - Prepend some function with rk_nfc_.
> >> - Replace function readl_poll_timeout_atomic with readl_relaxed_poll_timeout.
> >> - Remove function rk_nfc_read_byte and rk_nfc_write_byte.
> >> - Don't select the die if 'check_only == true' in function rk_nfc_exec_op.
> >> - Modify function rk_nfc_write_page and rk_nfc_write_page_raw.
> >>
> >> Changes in v8: None
> >> Changes in v7:
> >> - Rebase to linux-next.
> >> - Fix coding style.
> >> - Reserved 4 bytes at the beginning of the oob area.
> >> - Page raw read and write included ecc data.
> >>
> >> Changes in v6:
> >> - The mtd->name set by NAND label property.
> >> - Add some comments.
> >> - Fix compile error.
> >>
> >> Changes in v5:
> >> - Add boot blocks support  with different ECC for bootROM.
> >> - Rename rockchip-nand.c to rockchip-nand-controller.c.
> >> - Unification of other variable names.
> >> - Remove some compatible define.
> >>
> >> Changes in v4:
> >> - Define platform data structure for the register offsets.
> >> - The compatible define with rkxx_nfc.
> >> - Use SET_SYSTEM_SLEEP_PM_OPS to define PM_OPS.
> >> - Use exec_op instead of legacy hooks.
> >>
> >> Changes in v3: None
> >> Changes in v2:
> >> - Fix compile error.
> >> - Include header files sorted by file name.
> >>
> >>  drivers/mtd/nand/raw/Kconfig                  |   12 +
> >>  drivers/mtd/nand/raw/Makefile                 |    1 +
> >>  .../mtd/nand/raw/rockchip-nand-controller.c   | 1460 +++++++++++++++++
> >>  3 files changed, 1473 insertions(+)
> >>  create mode 100644 drivers/mtd/nand/raw/rockchip-nand-controller.c
> >>
> >> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> >> index 6c46f25b57e2..2cc533e4e239 100644
> >> --- a/drivers/mtd/nand/raw/Kconfig
> >> +++ b/drivers/mtd/nand/raw/Kconfig
> >> @@ -462,6 +462,18 @@ config MTD_NAND_ARASAN
> >>    Enables the driver for the Arasan NAND flash controller on
> >>    Zynq Ultrascale+ MPSoC.
> >> 
> >> +config MTD_NAND_ROCKCHIP
> >> +	tristate "Rockchip NAND controller"
> >> +	depends on ARCH_ROCKCHIP && HAS_IOMEM
> >> +	help
> >> +	  Enables support for NAND controller on Rockchip SoCs.
> >> +	  There are four different versions of NAND FLASH Controllers,
> >> +	  including:
> >> +	    NFC v600: RK2928, RK3066, RK3188
> >> +	    NFC v622: RK3036, RK3128
> >> +	    NFC v800: RK3308, RV1108
> >> +	    NFC v900: PX30, RK3326
> >> +
> >>  comment "Misc"
> >> 
> >>  config MTD_SM_COMMON
> >> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> >> index 2930f5b9015d..960c9be25204 100644
> >> --- a/drivers/mtd/nand/raw/Makefile
> >> +++ b/drivers/mtd/nand/raw/Makefile
> >> @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_NAND_STM32_FMC2)	+= stm32_fmc2_nand.o
> >>  obj-$(CONFIG_MTD_NAND_MESON)	+= meson_nand.o
> >>  obj-$(CONFIG_MTD_NAND_CADENCE)	+= cadence-nand-controller.o
> >>  obj-$(CONFIG_MTD_NAND_ARASAN)	+= arasan-nand-controller.o
> >> +obj-$(CONFIG_MTD_NAND_ROCKCHIP)	+= rockchip-nand-controller.o
> >> 
> >>  nand-objs := nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_ids.o
> >>  nand-objs += nand_onfi.o
> >> diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> >> new file mode 100644
> >> index 000000000000..2e96fd314346
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
> >> @@ -0,0 +1,1460 @@
> >> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> >> +/*
> >> + * Rockchip NAND Flash controller driver.
> >> + * Copyright (C) 2020 Rockchip Inc.
> >> + * Author: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/dma-mapping.h>
> >> +#include <linux/dmaengine.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/iopoll.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mtd/mtd.h>
> >> +#include <linux/mtd/rawnand.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/slab.h>
> >> +
> >> +/*
> >> + * NFC Page Data Layout:
> >> + *	1024 Bytes Data + 4Bytes sys data + 28Bytes~124Bytes ecc +
> >> + *	1024 Bytes Data + 4Bytes sys data + 28Bytes~124Bytes ecc +
> >> + *	......
> >> + * NAND Page Data Layout:
> >> + *	1024 * n Data + m Bytes oob
> >> + * Original Bad Block Mask Location:
> >> + *	First byte of oob(spare).
> >> + * nand_chip->oob_poi data layout:
> >> + *	4Bytes sys data + .... + 4Bytes sys data + ecc data.
> >> + */
> >> +
> >> +/* NAND controller register definition */
> >> +#define NFC_READ	(0)
> >> +#define NFC_WRITE	(1)
> >> +
> >> +#define NFC_FMCTL	(0x00)
> >> +#define   FMCTL_CE_SEL_M	0xFF
> >> +#define   FMCTL_CE_SEL(x)	(1 << (x))
> >> +#define   FMCTL_WP	BIT(8)
> >> +#define   FMCTL_RDY	BIT(9)
> >> +
> >> +#define NFC_FMWAIT	(0x04)
> >> +#define   FLCTL_RST	BIT(0)
> >> +#define   FLCTL_WR	(1)	/* 0: read, 1: write */
> >> +#define   FLCTL_XFER_ST	BIT(2)
> >> +#define   FLCTL_XFER_EN	BIT(3)
> >> +#define   FLCTL_ACORRECT	BIT(10) /* Auto correct error bits. */
> >> +#define   FLCTL_XFER_READY	BIT(20)
> >> +#define   FLCTL_XFER_SECTOR	(22)
> >> +#define   FLCTL_TOG_FIX	BIT(29)
> >> +
> >> +#define   BCHCTL_BANK_M	(7 << 5)
> >> +#define   BCHCTL_BANK	(5)
> >> +
> >> +#define   DMA_ST	BIT(0)
> >> +#define   DMA_WR	(1)	/* 0: write, 1: read */
> >> +#define   DMA_EN	BIT(2)
> >> +#define   DMA_AHB_SIZE	(3)	/* 0: 1, 1: 2, 2: 4 */
> >> +#define   DMA_BURST_SIZE	(6)	/* 0: 1, 3: 4, 5: 8, 7: 16 */
> >> +#define   DMA_INC_NUM	(9)	/* 1 - 16 */
> >> +
> >> +#define ECC_ERR_CNT(x, e) ((((x) >> (e).low) & (e).low_mask) |\
> >> +	  (((x) >> (e).high) & (e).high_mask) << (e).low_bn)
> >> +#define   INT_DMA	BIT(0)
> >> +#define NFC_BANK	(0x800)
> >> +#define NFC_BANK_STEP	(0x100)
> >> +#define   BANK_DATA	(0x00)
> >> +#define   BANK_ADDR	(0x04)
> >> +#define   BANK_CMD	(0x08)
> >> +#define NFC_SRAM0	(0x1000)
> >> +#define NFC_SRAM1	(0x1400)
> >> +#define NFC_SRAM_SIZE	(0x400)
> >> +#define NFC_TIMEOUT	(500000)
> >> +#define NFC_MAX_OOB_PER_STEP	128
> >> +#define NFC_MIN_OOB_PER_STEP	64
> >> +#define MAX_DATA_SIZE	0xFFFC
> >> +#define MAX_ADDRESS_CYC	6
> >> +#define NFC_ECC_MAX_MODES	4
> >> +#define NFC_MAX_NSELS	(8) /* Some Socs only have 1 or 2 CSs. */
> >> +#define NFC_SYS_DATA_SIZE	(4) /* 4 bytes sys data in oob pre 1024 data.*/
> >> +#define RK_DEFAULT_CLOCK_RATE	(150 * 1000 * 1000) /* 150 Mhz */
> >> +#define ACCTIMING(csrw, rwpw, rwcs)	((csrw) << 12 | (rwpw) << 5 | (rwcs))
> >> +
> >> +enum nfc_type {
> >> +	NFC_V6,
> >> +	NFC_V8,
> >> +	NFC_V9,
> >> +};
> >> +
> >> +/**
> >> + * struct rk_ecc_cnt_status: represent a ecc status data.
> >> + * @err_flag_bit: error flag bit index at register.
> >> + * @low: ecc count low bit index at register.
> >> + * @low_mask: mask bit.
> >> + * @low_bn: ecc count low bit number.
> >> + * @high: ecc count high bit index at register.
> >> + * @high_mask: mask bit
> >> + */
> >> +struct ecc_cnt_status {
> >> +	u8 err_flag_bit;
> >> +	u8 low;
> >> +	u8 low_mask;
> >> +	u8 low_bn;
> >> +	u8 high;
> >> +	u8 high_mask;
> >> +};
> >> +
> >> +/*
> >> + * @type: nfc version
> >> + * @ecc_strengths: ecc strengths
> >> + * @ecc_cfgs: ecc config values
> >> + * @flctl_off: FLCTL register offset
> >> + * @bchctl_off: BCHCTL register offset
> >> + * @dma_data_buf_off: DMA_DATA_BUF register offset
> >> + * @dma_oob_buf_off: DMA_OOB_BUF register offset
> >> + * @dma_cfg_off: DMA_CFG register offset
> >> + * @dma_st_off: DMA_ST register offset
> >> + * @bch_st_off: BCG_ST register offset
> >> + * @randmz_off: RANDMZ register offset
> >> + * @int_en_off: interrupt enable register offset
> >> + * @int_clr_off: interrupt clean register offset
> >> + * @int_st_off: interrupt status register offset
> >> + * @oob0_off: oob0 register offset
> >> + * @oob1_off: oob1 register offset
> >> + * @ecc0: represent ECC0 status data
> >> + * @ecc1: represent ECC1 status data
> >> + */
> >> +struct nfc_cfg {
> >> +	enum nfc_type type;
> >> +	u8 ecc_strengths[NFC_ECC_MAX_MODES];
> >> +	u32 ecc_cfgs[NFC_ECC_MAX_MODES];
> >> +	u32 flctl_off;
> >> +	u32 bchctl_off;
> >> +	u32 dma_cfg_off;
> >> +	u32 dma_data_buf_off;
> >> +	u32 dma_oob_buf_off;
> >> +	u32 dma_st_off;
> >> +	u32 bch_st_off;
> >> +	u32 randmz_off;
> >> +	u32 int_en_off;
> >> +	u32 int_clr_off;
> >> +	u32 int_st_off;
> >> +	u32 oob0_off;
> >> +	u32 oob1_off;
> >> +	struct ecc_cnt_status ecc0;
> >> +	struct ecc_cnt_status ecc1;
> >> +};
> >> +
> >> +struct rk_nfc_nand_chip {
> >> +	struct list_head node;
> >> +	struct nand_chip chip;
> >> +
> >> +	u16 spare_per_sector;
> >> +	u16 oob_buf_per_sector;
> >> +	u16 boot_blks;
> >> +	u16 boot_ecc;
> >> +	u16 metadata_size;
> >> +
> >> +	u8 nsels;
> >> +	u8 sels[0];
> >> +	/* Nothing after this field. */
> >> +};
> >> +
> >> +struct rk_nfc {
> >> +	struct nand_controller controller;
> >> +	const struct nfc_cfg *cfg;
> >> +	struct device *dev;
> >> +
> >> +	struct clk *nfc_clk;
> >> +	struct clk *ahb_clk;
> >> +	void __iomem *regs;
> >> +
> >> +	u32 selected_bank;
> >> +	u32 band_offset;
> >> +	u32 cur_clk;
> >> +
> >> +	struct completion done;
> >> +	struct list_head chips;
> >> +
> >> +	u8 *buffer;
> >> +	u8 *page_buf;
> >> +	u32 *oob_buf;
> >> +	u32 buffer_size;
> >> +	u32 oob_buf_size;
> >> +
> >> +	unsigned long assigned_cs;
> >> +};
> >> +
> >> +static inline struct rk_nfc_nand_chip *rk_nfc_to_rknand(struct nand_chip *chip)
> >> +{
> >> +	return container_of(chip, struct rk_nfc_nand_chip, chip);
> >> +}
> >> +
> >> +static inline u8 *rk_nfc_buf_to_data_ptr(struct nand_chip *chip, const u8 *p, int i)
> >> +{
> >> +	return (u8 *)p + i * chip->ecc.size;
> >> +}
> >> +
> >> +static inline u8 *rk_nfc_buf_to_oob_ptr(struct nand_chip *chip, int i)
> >> +{
> >> +	u8 *poi;
> >> +
> >> +	poi = chip->oob_poi + i * NFC_SYS_DATA_SIZE;
> >> +
> >> +	return poi;
> >> +}
> >> +
> >> +static inline u8 *rk_nfc_buf_to_oob_ecc_ptr(struct nand_chip *chip, int i)
> >> +{
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +	u8 *poi;
> >> +
> >> +	poi = chip->oob_poi + rknand->metadata_size +
> >> +	      chip->ecc.bytes * i;
> >> +
> >> +	return poi;
> >> +}
> >> +
> >> +static inline int rk_nfc_data_len(struct nand_chip *chip)
> >> +{
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +
> >> +	return chip->ecc.size + rknand->spare_per_sector;
> >> +}
> >> +
> >> +static inline u8 *rk_nfc_data_ptr(struct nand_chip *chip,  int i)
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +
> >> +	return nfc->buffer + i * rk_nfc_data_len(chip);
> >> +}
> >> +
> >> +static inline u8 *rk_nfc_oob_ptr(struct nand_chip *chip, int i)
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +
> >> +	return nfc->buffer + i * rk_nfc_data_len(chip) + chip->ecc.size;
> >> +}
> >> +
> >> +static void rk_nfc_select_chip(struct nand_chip *chip, int cs)
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +	u32 val;
> >> +
> >> +	if (cs < 0) {
> >> +	nfc->selected_bank = -1;
> >> +	/* Deselect the currently selected target. */
> >> +	val = readl_relaxed(nfc->regs + NFC_FMCTL);
> >> +	val &= ~FMCTL_CE_SEL_M;
> >> +	writel(val, nfc->regs + NFC_FMCTL);
> >> +	return;
> >> +	}
> >> +
> >> +	nfc->selected_bank = rknand->sels[cs];
> >> +	nfc->band_offset = NFC_BANK + nfc->selected_bank * NFC_BANK_STEP;
> >> +
> >> +	val = readl_relaxed(nfc->regs + NFC_FMCTL);
> >> +	val &= ~FMCTL_CE_SEL_M;
> >> +	val |= FMCTL_CE_SEL(nfc->selected_bank);
> >> +
> >> +	writel(val, nfc->regs + NFC_FMCTL);
> >> +}
> >> +
> >> +static inline int rk_nfc_wait_ioready(struct rk_nfc *nfc)
> >> +{
> >> +	int rc;
> >> +	u32 val;
> >> +
> >> +	rc = readl_relaxed_poll_timeout(nfc->regs + NFC_FMCTL, val,
> >> +	val & FMCTL_RDY, 10, NFC_TIMEOUT);
> >> +
> >> +	return rc;
> >> +}
> >> +
> >> +static void rk_nfc_read_buf(struct rk_nfc *nfc, u8 *buf, int len)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < len; i++)
> >> +	buf[i] = readb_relaxed(nfc->regs + nfc->band_offset +
> >> +	       BANK_DATA);
> >> +}
> >> +
> >> +static void rk_nfc_write_buf(struct rk_nfc *nfc, const u8 *buf, int len)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < len; i++)
> >> +	writeb(buf[i], nfc->regs + nfc->band_offset + BANK_DATA);
> >> +}
> >> +
> >> +static int rk_nfc_cmd(struct nand_chip *chip,
> >> +	      const struct nand_subop *subop)
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	unsigned int i, j, remaining, start;
> >> +	int reg_offset = nfc->band_offset;
> >> +	u8 *inbuf = NULL;
> >> +	const u8 *outbuf;
> >> +	u32 cnt = 0;
> >> +	int ret = 0;
> >> +
> >> +	for (i = 0; i < subop->ninstrs; i++) {
> >> +	const struct nand_op_instr *instr = &subop->instrs[i];
> >> +
> >> +	switch (instr->type) {
> >> +	case NAND_OP_CMD_INSTR:
> >> +	writeb(instr->ctx.cmd.opcode,
> >> +	       nfc->regs + reg_offset + BANK_CMD);
> >> +	break;
> >> +
> >> +	case NAND_OP_ADDR_INSTR:
> >> +	remaining = nand_subop_get_num_addr_cyc(subop, i);
> >> +	start = nand_subop_get_addr_start_off(subop, i);
> >> +
> >> +	for (j = 0; j < 8 && j + start < remaining; j++)
> >> +	writeb(instr->ctx.addr.addrs[j + start],
> >> +	       nfc->regs + reg_offset + BANK_ADDR);
> >> +	break;
> >> +
> >> +	case NAND_OP_DATA_IN_INSTR:
> >> +	case NAND_OP_DATA_OUT_INSTR:
> >> +	start = nand_subop_get_data_start_off(subop, i);
> >> +	cnt = nand_subop_get_data_len(subop, i);
> >> +
> >> +	if (instr->type == NAND_OP_DATA_OUT_INSTR) {
> >> +	outbuf = instr->ctx.data.buf.out + start;
> >> +	rk_nfc_write_buf(nfc, outbuf, cnt);
> >> +	} else {
> >> +	inbuf = instr->ctx.data.buf.in + start;
> >> +	rk_nfc_read_buf(nfc, inbuf, cnt);
> >> +	}
> >> +	break;
> >> +
> >> +	case NAND_OP_WAITRDY_INSTR:
> >> +	if (rk_nfc_wait_ioready(nfc) < 0) {
> >> +	ret = -ETIMEDOUT;
> >> +	dev_err(nfc->dev, "IO not ready\n");
> >> +	}
> >> +	break;
> >> +	}
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static const struct nand_op_parser rk_nfc_op_parser = NAND_OP_PARSER(
> >> +	NAND_OP_PARSER_PATTERN(
> >> +	rk_nfc_cmd,
> >> +	NAND_OP_PARSER_PAT_CMD_ELEM(true),
> >> +	NAND_OP_PARSER_PAT_ADDR_ELEM(true, MAX_ADDRESS_CYC),
> >> +	NAND_OP_PARSER_PAT_CMD_ELEM(true),
> >> +	NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> >> +	NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, MAX_DATA_SIZE)),
> >> +	NAND_OP_PARSER_PATTERN(
> >> +	rk_nfc_cmd,
> >> +	NAND_OP_PARSER_PAT_CMD_ELEM(true),
> >> +	NAND_OP_PARSER_PAT_ADDR_ELEM(true, MAX_ADDRESS_CYC),
> >> +	NAND_OP_PARSER_PAT_DATA_OUT_ELEM(true, MAX_DATA_SIZE),
> >> +	NAND_OP_PARSER_PAT_CMD_ELEM(true),
> >> +	NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> >> +);
> >> +
> >> +static int rk_nfc_exec_op(struct nand_chip *chip,
> >> +	  const struct nand_operation *op,
> >> +	  bool check_only)
> >> +{
> >> +	if (!check_only)
> >> +	rk_nfc_select_chip(chip, op->cs);
> >> +
> >> +	return nand_op_parser_exec_op(chip, &rk_nfc_op_parser, op,
> >> +	      check_only);
> >> +}
> >> +
> >> +static int rk_nfc_setup_data_interface(struct nand_chip *chip, int csline,
> >> +	       const struct nand_interface_config *conf)  
> >
> >Please have a look at the recent changes in the core, this helper
> >should be named "setup_interface".
> >  
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	const struct nand_sdr_timings *timings;
> >> +	u32 rate, tc2rw, trwpw, trw2c;
> >> +	u32 temp;
> >> +
> >> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> >> +	return 0;
> >> +
> >> +	timings = nand_get_sdr_timings(conf);
> >> +	if (IS_ERR(timings))
> >> +	return -EOPNOTSUPP;
> >> +
> >> +	if (IS_ERR(nfc->nfc_clk))
> >> +	rate = clk_get_rate(nfc->ahb_clk);
> >> +	else
> >> +	rate = clk_get_rate(nfc->nfc_clk);
> >> +
> >> +	/* Turn clock rate into kHz. */
> >> +	rate /= 1000;
> >> +
> >> +	tc2rw = 1;
> >> +	trw2c = 1;
> >> +
> >> +	trwpw = max(timings->tWC_min, timings->tRC_min) / 1000;
> >> +	trwpw = DIV_ROUND_UP(trwpw * rate, 1000000);
> >> +
> >> +	temp = timings->tREA_max / 1000;
> >> +	temp = DIV_ROUND_UP(temp * rate, 1000000);
> >> +
> >> +	if (trwpw < temp)
> >> +	trwpw = temp;
> >> +
> >> +	/*
> >> +	* ACCON: access timing control register
> >> +	* -------------------------------------
> >> +	* 31:18: reserved
> >> +	* 17:12: csrw, clock cycles from the falling edge of CSn to the
> >> +	*   falling edge of RDn or WRn
> >> +	* 11:11: reserved
> >> +	* 10:05: rwpw, the width of RDn or WRn in processor clock cycles
> >> +	* 04:00: rwcs, clock cycles from the rising edge of RDn or WRn to the
> >> +	*   rising edge of CSn
> >> +	*/
> >> +	temp = ACCTIMING(tc2rw, trwpw, trw2c);
> >> +	writel(temp, nfc->regs + NFC_FMWAIT);  
> >
> >You should save the chip's timing configuration instead of writing it
> >here, and setting the register value during chip selection. This way
> >you may handle several chips with different timing
> >constraints/configurations.
> >  
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nfc_hw_ecc_setup(struct nand_chip *chip,
> >> +	       struct nand_ecc_ctrl *ecc,
> >> +	       uint32_t strength)
> >> +{
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	u32 reg, i;
> >> +
> >> +	for (i = 0; i < NFC_ECC_MAX_MODES; i++) {
> >> +	if (ecc->strength == nfc->cfg->ecc_strengths[i]) {
> >> +	reg = nfc->cfg->ecc_cfgs[i];
> >> +	break;
> >> +	}
> >> +	}
> >> +
> >> +	if (i >= NFC_ECC_MAX_MODES)
> >> +	return -EINVAL;
> >> +
> >> +	writel(reg, nfc->regs + nfc->cfg->bchctl_off);  
> >
> >Same here, if you handle different chips, they may use different ECC
> >configurations, this should be handled.
> >  
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void rk_nfc_xfer_start(struct rk_nfc *nfc, u8 rw, u8 n_KB,
> >> +	      dma_addr_t dma_data, dma_addr_t dma_oob)
> >> +{
> >> +	u32 dma_reg, fl_reg, bch_reg;
> >> +
> >> +	dma_reg = DMA_ST | ((!rw) << DMA_WR) | DMA_EN | (2 << DMA_AHB_SIZE) |
> >> +	      (7 << DMA_BURST_SIZE) | (16 << DMA_INC_NUM);
> >> +
> >> +	fl_reg = (rw << FLCTL_WR) | FLCTL_XFER_EN | FLCTL_ACORRECT |
> >> +	(n_KB << FLCTL_XFER_SECTOR) | FLCTL_TOG_FIX;
> >> +
> >> +	if (nfc->cfg->type == NFC_V6 || nfc->cfg->type == NFC_V8) {
> >> +	bch_reg = readl_relaxed(nfc->regs + nfc->cfg->bchctl_off);
> >> +	bch_reg = (bch_reg & (~BCHCTL_BANK_M)) |
> >> +	  (nfc->selected_bank << BCHCTL_BANK);
> >> +	writel(bch_reg, nfc->regs + nfc->cfg->bchctl_off);
> >> +	}
> >> +
> >> +	writel(dma_reg, nfc->regs + nfc->cfg->dma_cfg_off);
> >> +	writel((u32)dma_data, nfc->regs + nfc->cfg->dma_data_buf_off);
> >> +	writel((u32)dma_oob, nfc->regs + nfc->cfg->dma_oob_buf_off);
> >> +	writel(fl_reg, nfc->regs + nfc->cfg->flctl_off);
> >> +	fl_reg |= FLCTL_XFER_ST;
> >> +	writel(fl_reg, nfc->regs + nfc->cfg->flctl_off);
> >> +}
> >> +
> >> +static int rk_nfc_wait_for_xfer_done(struct rk_nfc *nfc)
> >> +{
> >> +	void __iomem *ptr;
> >> +	int ret = 0;
> >> +	u32 reg;
> >> +
> >> +	ptr = nfc->regs + nfc->cfg->flctl_off;
> >> +
> >> +	ret = readl_relaxed_poll_timeout(ptr, reg,
> >> +	reg & FLCTL_XFER_READY,
> >> +	10, NFC_TIMEOUT);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
> >> +	int oob_on, int page)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(chip);
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	int ret = 0;
> >> +	u32 i;
> >> +
> >> +	if (!buf)
> >> +	memset(nfc->buffer, 0xff, mtd->writesize + mtd->oobsize);
> >> +
> >> +	for (i = 0; i < ecc->steps; i++) {
> >> +	/* Copy data to nfc buffer. */
> >> +	if (buf)
> >> +	memcpy(rk_nfc_data_ptr(chip, i),
> >> +	       rk_nfc_buf_to_data_ptr(chip, buf, i),
> >> +	       ecc->size);
> >> +	/*
> >> +	* The first four bytes of OOB are reserved for the
> >> +	* boot ROM. In some debugging cases, such as with a
> >> +	* read, erase and write back test these 4 bytes stored
> >> +	* in OOB also need to be written back.
> >> +	*/  
> >
> >The controller driver should not arbitrate this. If you don't want to
> >expose these bytes, they should not appear "free" in the OOB layout,
> >but a raw access *must* but able to address the entire page/oob.  
> 
> I don't have a solution to fix it.
> The function nand_block_bad detect bad block like it:
>     bad = chip->oob_poi[chip->badblockpos]; //chip->badblockpos = 0 for large page NAND Flash.
> So chip->oob_poi[0] is bad masker.
> 
> The oob data layout for rk nfc is:
>  PA0 PA1 PA2 PA3 | BBM OOB1 OOB2 OOB3 | ...
> or
>  0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
> 
> The code here just to swap the first 4 bytes with the last 4 bytes and without droped any  data.
> and the chip->oob_poi data layout:
> BBM OOB1 OOB2 OOB3|......| PA0 PA1 PA2 PA3 
> 
> The OOB layout free already reserved this 4 bytes:
> oob_region->offset = NFC_SYS_DATA_SIZE + 2;
> 
> >> +	if (!i)
> >> +	memcpy(rk_nfc_oob_ptr(chip, i),
> >> +	       rk_nfc_buf_to_oob_ptr(chip, ecc->steps - 1),
> >> +	       NFC_SYS_DATA_SIZE);
> >> +	else
> >> +	memcpy(rk_nfc_oob_ptr(chip, i),
> >> +	       rk_nfc_buf_to_oob_ptr(chip, i - 1),
> >> +	       NFC_SYS_DATA_SIZE);
> >> +	/* Copy ECC data to the NFC buffer. */
> >> +	memcpy(rk_nfc_oob_ptr(chip, i) + NFC_SYS_DATA_SIZE,
> >> +	       rk_nfc_buf_to_oob_ecc_ptr(chip, i),
> >> +	       ecc->bytes);
> >> +	}
> >> +
> >> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> >> +	rk_nfc_write_buf(nfc, buf, mtd->writesize + mtd->oobsize);
> >> +	ret = nand_prog_page_end_op(chip);
> >> +
> >> +	/*
> >> +	* Deselect the currently selected target after the ops is done
> >> +	* to reduce the power consumption.
> >> +	*/
> >> +	rk_nfc_select_chip(chip, -1);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int rk_nfc_write_oob(struct nand_chip *chip, int page)
> >> +{
> >> +	return rk_nfc_write_page_raw(chip, NULL, 1, page);  
> >
> >Not sure this is relevant. You should not do that, I guess the core
> >will automatically take care of it.
> >  
> >> +}
> >> +
> >> +static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
> >> +	   int oob_on, int page)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(chip);
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
> >> +	NFC_MIN_OOB_PER_STEP;
> >> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
> >> +	int ret = 0, i, boot_rom_mode = 0;
> >> +	dma_addr_t dma_data, dma_oob;
> >> +	u32 reg;
> >> +	u8 *oob;
> >> +
> >> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> >> +
> >> +	memcpy(nfc->page_buf, buf, mtd->writesize);
> >> +
> >> +	/*
> >> +	* The first blocks (4, 8 or 16 depending on the device) are used
> >> +	* by the boot ROM and the first 32 bits of OOB need to link to
> >> +	* the next page address in the same block. We can't directly copy
> >> +	* OOB data from the MTD framework, because this page address
> >> +	* conflicts for example with the bad block marker (BBM),
> >> +	* so we shift all OOB data including the BBM with 4 byte positions.
> >> +	* As a consequence the OOB size available to the MTD framework is
> >> +	* also reduced with 4 bytes.
> >> +	*
> >> +	*    PA0 PA1 PA2 PA3 | BBM OOB1 OOB2 OOB3 | ...
> >> +	*
> >> +	* If a NAND is not a boot medium or the page is not a boot block,
> >> +	* the first 4 bytes are left untouched by writing 0xFF to them.
> >> +	*
> >> +	*   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
> >> +	*
> >> +	* Configure the ECC algorithm supported by the boot ROM.
> >> +	*/
> >> +	if ((page < pages_per_blk * rknand->boot_blks) &&
> >> +	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
> >> +	boot_rom_mode = 1;
> >> +	if (rknand->boot_ecc != ecc->strength)
> >> +	rk_nfc_hw_ecc_setup(chip, ecc,
> >> +	    rknand->boot_ecc);
> >> +	}
> >> +
> >> +	for (i = 0; i < ecc->steps; i++) {
> >> +	if (!i) {
> >> +	reg = 0xFFFFFFFF;
> >> +	} else {
> >> +	oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
> >> +	reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
> >> +	      oob[3] << 24;
> >> +	}
> >> +	if (!i && boot_rom_mode)
> >> +	reg = (page & (pages_per_blk - 1)) * 4;
> >> +
> >> +	if (nfc->cfg->type == NFC_V9)
> >> +	nfc->oob_buf[i] = reg;
> >> +	else
> >> +	nfc->oob_buf[i * (oob_step / 4)] = reg;
> >> +	}
> >> +
> >> +	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
> >> +	  mtd->writesize, DMA_TO_DEVICE);
> >> +	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
> >> +	ecc->steps * oob_step,
> >> +	DMA_TO_DEVICE);
> >> +
> >> +	reinit_completion(&nfc->done);
> >> +	writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
> >> +
> >> +	rk_nfc_xfer_start(nfc, NFC_WRITE, ecc->steps, dma_data,
> >> +	  dma_oob);
> >> +	ret = wait_for_completion_timeout(&nfc->done,
> >> +	  msecs_to_jiffies(100));
> >> +	if (!ret)
> >> +	dev_warn(nfc->dev, "write: wait dma done timeout.\n");
> >> +	/*
> >> +	* Whether the DMA transfer is completed or not. The driver
> >> +	* needs to check the NFC`s status register to see if the data
> >> +	* transfer was completed.
> >> +	*/
> >> +	ret = rk_nfc_wait_for_xfer_done(nfc);
> >> +
> >> +	dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
> >> +	DMA_TO_DEVICE);
> >> +	dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
> >> +	DMA_TO_DEVICE);
> >> +
> >> +	if (boot_rom_mode && rknand->boot_ecc != ecc->strength)
> >> +	rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
> >> +
> >> +	if (ret) {
> >> +	ret = -EIO;
> >> +	dev_err(nfc->dev,
> >> +	"write: wait transfer done timeout.\n");
> >> +	}
> >> +
> >> +	if (ret)
> >> +	return ret;
> >> +
> >> +	ret = nand_prog_page_end_op(chip);
> >> +
> >> +	/*
> >> +	* Deselect the currently selected target after the ops is done
> >> +	* to reduce the power consumption.
> >> +	*/  
> >
> >If you force this deselection, your should probably do it even in case
> >of error?
> >  
> >> +	rk_nfc_select_chip(chip, -1);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int rk_nfc_read_page_raw(struct nand_chip *chip, u8 *buf, int oob_on,
> >> +	int page)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(chip);
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	int i;
> >> +
> >> +	nand_read_page_op(chip, page, 0, NULL, 0);
> >> +	rk_nfc_read_buf(nfc, nfc->buffer, mtd->writesize + mtd->oobsize);
> >> +
> >> +	/*
> >> +	* Deselect the currently selected target after the ops is done
> >> +	* to reduce the power consumption.
> >> +	*/
> >> +	rk_nfc_select_chip(chip, -1);
> >> +
> >> +	for (i = 0; i < ecc->steps; i++) {
> >> +	/*
> >> +	* The first four bytes of OOB are reserved for the
> >> +	* boot ROM. In some debugging cases, such as with a read,
> >> +	* erase and write back test, these 4 bytes also must be
> >> +	* saved somewhere, otherwise this information will be
> >> +	* lost during a write back.  
> >
> >Ditto
> >  
> >> +	*/
> >> +	if (!i)
> >> +	memcpy(rk_nfc_buf_to_oob_ptr(chip, ecc->steps - 1),
> >> +	       rk_nfc_oob_ptr(chip, i),
> >> +	       NFC_SYS_DATA_SIZE);
> >> +	else
> >> +	memcpy(rk_nfc_buf_to_oob_ptr(chip, i - 1),
> >> +	       rk_nfc_oob_ptr(chip, i),
> >> +	       NFC_SYS_DATA_SIZE);
> >> +	/* Copy ECC data from the NFC buffer. */
> >> +	memcpy(rk_nfc_buf_to_oob_ecc_ptr(chip, i),
> >> +	       rk_nfc_oob_ptr(chip, i) + NFC_SYS_DATA_SIZE,
> >> +	       ecc->bytes);
> >> +	/* Copy data from the NFC buffer. */
> >> +	if (buf)
> >> +	memcpy(rk_nfc_buf_to_data_ptr(chip, buf, i),
> >> +	       rk_nfc_data_ptr(chip, i),
> >> +	       ecc->size);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nfc_read_oob(struct nand_chip *chip, int page)
> >> +{
> >> +	return rk_nfc_read_page_raw(chip, NULL, 1, page);  
> >
> >Ditto
> >  
> >> +}
> >> +
> >> +static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
> >> +	  int page)
> >> +{
> >> +	struct mtd_info *mtd = nand_to_mtd(chip);
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
> >> +	NFC_MIN_OOB_PER_STEP;
> >> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
> >> +	dma_addr_t dma_data, dma_oob;
> >> +	int ret = 0, i, boot_rom_mode = 0;
> >> +	int bitflips = 0, bch_st;
> >> +	u8 *oob;
> >> +	u32 tmp;
> >> +
> >> +	nand_read_page_op(chip, page, 0, NULL, 0);
> >> +
> >> +	dma_data = dma_map_single(nfc->dev, nfc->page_buf,
> >> +	  mtd->writesize,
> >> +	  DMA_FROM_DEVICE);
> >> +	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
> >> +	ecc->steps * oob_step,
> >> +	DMA_FROM_DEVICE);
> >> +
> >> +	/*
> >> +	* The first blocks (4, 8 or 16 depending on the device)
> >> +	* are used by the boot ROM.
> >> +	* Configure the ECC algorithm supported by the boot ROM.
> >> +	*/
> >> +	if ((page < pages_per_blk * rknand->boot_blks) &&
> >> +	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
> >> +	boot_rom_mode = 1;
> >> +	if (rknand->boot_ecc != ecc->strength)
> >> +	rk_nfc_hw_ecc_setup(chip, ecc,
> >> +	    rknand->boot_ecc);
> >> +	}
> >> +
> >> +	reinit_completion(&nfc->done);
> >> +	writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
> >> +	rk_nfc_xfer_start(nfc, NFC_READ, ecc->steps, dma_data,
> >> +	  dma_oob);
> >> +	ret = wait_for_completion_timeout(&nfc->done,
> >> +	  msecs_to_jiffies(100));
> >> +	if (!ret)
> >> +	dev_warn(nfc->dev, "read: wait dma done timeout.\n");
> >> +	/*
> >> +	* Whether the DMA transfer is completed or not. The driver
> >> +	* needs to check the NFC`s status register to see if the data
> >> +	* transfer was completed.
> >> +	*/
> >> +	ret = rk_nfc_wait_for_xfer_done(nfc);
> >> +	dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
> >> +	DMA_FROM_DEVICE);
> >> +	dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
> >> +	DMA_FROM_DEVICE);
> >> +
> >> +	if (ret) {
> >> +	bitflips = -EIO;
> >> +	dev_err(nfc->dev,
> >> +	"read: wait transfer done timeout.\n");
> >> +	goto out;
> >> +	}
> >> +
> >> +	for (i = 1; i < ecc->steps; i++) {
> >> +	oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
> >> +	if (nfc->cfg->type == NFC_V9)
> >> +	tmp = nfc->oob_buf[i];
> >> +	else
> >> +	tmp = nfc->oob_buf[i * (oob_step / 4)];
> >> +	*oob++ = (u8)tmp;
> >> +	*oob++ = (u8)(tmp >> 8);
> >> +	*oob++ = (u8)(tmp >> 16);
> >> +	*oob++ = (u8)(tmp >> 24);
> >> +	}
> >> +
> >> +	for (i = 0; i < (ecc->steps / 2); i++) {
> >> +	bch_st = readl_relaxed(nfc->regs +
> >> +	       nfc->cfg->bch_st_off + i * 4);
> >> +	if (bch_st & BIT(nfc->cfg->ecc0.err_flag_bit) ||
> >> +	    bch_st & BIT(nfc->cfg->ecc1.err_flag_bit)) {
> >> +	mtd->ecc_stats.failed++;
> >> +	bitflips = 0;
> >> +	} else {
> >> +	ret = ECC_ERR_CNT(bch_st, nfc->cfg->ecc0);
> >> +	mtd->ecc_stats.corrected += ret;
> >> +	bitflips = max_t(u32, bitflips, ret);
> >> +
> >> +	ret = ECC_ERR_CNT(bch_st, nfc->cfg->ecc1);
> >> +	mtd->ecc_stats.corrected += ret;
> >> +	bitflips = max_t(u32, bitflips, ret);
> >> +	}
> >> +	}
> >> +out:
> >> +	memcpy(buf, nfc->page_buf, mtd->writesize);
> >> +
> >> +	if (boot_rom_mode && rknand->boot_ecc != ecc->strength)
> >> +	rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
> >> +
> >> +	if (bitflips > ecc->strength)
> >> +	dev_err(nfc->dev, "read page: %x ecc error!\n", page);
> >> +
> >> +	/*
> >> +	* Deselect the currently selected target after the ops is done
> >> +	* to reduce the power consumption.
> >> +	*/
> >> +	rk_nfc_select_chip(chip, -1);
> >> +
> >> +	return bitflips;
> >> +}
> >> +
> >> +static inline void rk_nfc_hw_init(struct rk_nfc *nfc)
> >> +{
> >> +	/* Disable flash wp. */
> >> +	writel(FMCTL_WP, nfc->regs + NFC_FMCTL);
> >> +	/* Config default timing 40ns at 150 Mhz nfc clock. */
> >> +	writel(0x1081, nfc->regs + NFC_FMWAIT);
> >> +	/* Disable randomizer and DMA. */
> >> +	writel(0, nfc->regs + nfc->cfg->randmz_off);
> >> +	writel(0, nfc->regs + nfc->cfg->dma_cfg_off);
> >> +	writel(FLCTL_RST, nfc->regs + nfc->cfg->flctl_off);
> >> +}
> >> +
> >> +static irqreturn_t rk_nfc_irq(int irq, void *id)
> >> +{
> >> +	struct rk_nfc *nfc = id;
> >> +	u32 sta, ien;
> >> +
> >> +	sta = readl_relaxed(nfc->regs + nfc->cfg->int_st_off);
> >> +	ien = readl_relaxed(nfc->regs + nfc->cfg->int_en_off);
> >> +
> >> +	if (!(sta & ien))
> >> +	return IRQ_NONE;
> >> +
> >> +	writel(sta, nfc->regs + nfc->cfg->int_clr_off);
> >> +	writel(~sta & ien, nfc->regs + nfc->cfg->int_en_off);
> >> +
> >> +	complete(&nfc->done);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int rk_nfc_enable_clks(struct device *dev, struct rk_nfc *nfc)
> >> +{
> >> +	int ret;
> >> +
> >> +	if (!IS_ERR(nfc->nfc_clk)) {
> >> +	ret = clk_prepare_enable(nfc->nfc_clk);
> >> +	if (ret) {
> >> +	dev_err(dev, "failed to enable nfc clk\n");
> >> +	return ret;
> >> +	}
> >> +	}
> >> +
> >> +	ret = clk_prepare_enable(nfc->ahb_clk);
> >> +	if (ret) {
> >> +	dev_err(dev, "failed to enable ahb clk\n");
> >> +	if (!IS_ERR(nfc->nfc_clk))
> >> +	clk_disable_unprepare(nfc->nfc_clk);
> >> +	return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void rk_nfc_disable_clks(struct rk_nfc *nfc)
> >> +{
> >> +	if (!IS_ERR(nfc->nfc_clk))
> >> +	clk_disable_unprepare(nfc->nfc_clk);
> >> +	clk_disable_unprepare(nfc->ahb_clk);
> >> +}
> >> +
> >> +static int rk_nfc_ooblayout_free(struct mtd_info *mtd, int section,
> >> +	struct mtd_oob_region *oob_region)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +
> >> +	if (section)
> >> +	return -ERANGE;
> >> +
> >> +	/*
> >> +	* The beginning of the OOB area stores the reserved data for the NFC,
> >> +	* the size of the reserved data is NFC_SYS_DATA_SIZE bytes.
> >> +	*/
> >> +	oob_region->length = rknand->metadata_size - NFC_SYS_DATA_SIZE - 2;
> >> +	oob_region->offset = NFC_SYS_DATA_SIZE + 2;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rk_nfc_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +	struct mtd_oob_region *oob_region)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
> >> +
> >> +	if (section)
> >> +	return -ERANGE;
> >> +
> >> +	oob_region->length = mtd->oobsize - rknand->metadata_size;
> >> +	oob_region->offset = rknand->metadata_size;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct mtd_ooblayout_ops rk_nfc_ooblayout_ops = {
> >> +	.free = rk_nfc_ooblayout_free,
> >> +	.ecc = rk_nfc_ooblayout_ecc,
> >> +};
> >> +
> >> +static int rk_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +	const u8 *strengths = nfc->cfg->ecc_strengths;
> >> +	u8 max_strength, nfc_max_strength;
> >> +	int i;
> >> +
> >> +	nfc_max_strength = nfc->cfg->ecc_strengths[0];
> >> +	/* If optional dt settings not present. */
> >> +	if (!ecc->size || !ecc->strength ||
> >> +	    ecc->strength > nfc_max_strength) {
> >> +	chip->ecc.size = 1024;
> >> +	ecc->steps = mtd->writesize / ecc->size;
> >> +
> >> +	/*
> >> +	* HW ECC always requests the number of ECC bytes per 1024 byte
> >> +	* blocks. The first 4 OOB bytes are reserved for sys data.
> >> +	*/
> >> +	max_strength = ((mtd->oobsize / ecc->steps) - 4) * 8 /
> >> +	fls(8 * 1024);
> >> +	if (max_strength > nfc_max_strength)
> >> +	max_strength = nfc_max_strength;
> >> +
> >> +	for (i = 0; i < 4; i++) {
> >> +	if (max_strength >= strengths[i])
> >> +	break;
> >> +	}
> >> +
> >> +	if (i >= 4) {
> >> +	dev_err(nfc->dev, "Unsupported ECC strength\n");
> >> +	return -EOPNOTSUPP;
> >> +	}
> >> +
> >> +	ecc->strength = strengths[i];
> >> +	}
> >> +	ecc->steps = mtd->writesize / ecc->size;
> >> +	ecc->bytes = DIV_ROUND_UP(ecc->strength * fls(8 * 1024), 8);  
> >
> >Here you assume 1024 ECC step size, this is wrong. Either the
> >controller only supports 1024 bytes or you officially state somewhere
> >that you don't support more ECC step sizes yet.
> >  
> >> +	/* HW ECC always work with even numbers of ECC bytes. */
> >> +	ecc->bytes = ALIGN(ecc->bytes, 2);  
> >
> >Shouldn't you ensure the number of bytes is rounded up ?  
> 
> The V6 and V9 controller supports DDR mode, so ECC bytes need to be aligned to an even number if enable DDR mode.
> This drivers no support ddr mode now，I will drop this code.
> 

I think your approach is fine, I just misunderstood it because of the
comment.

Maybe you could:
- Create a helper for that
- Correct the comment to clearly explain what you do (your explanation
  here is very clear to me)
- Include the comment in the helper, not in each function
- Call the helper in every function accessing this area unless the
  block is reserved for the bootrom?

Thanks,
Miquèl
