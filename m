Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE57727F91B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 07:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgJAFgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 01:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgJAFgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 01:36:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5059BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:36:03 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m17so5304796ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 22:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QtbZAbWRhVwhreXSB0kTHv0ILfnB5bkBKlrIN7hAzs4=;
        b=b0n8nDbHjTjdcIuG4adVOb24ZWGiMpRZ9EGSsMco/b/sFDOJMFnn/ZnzjAgD8JOWkc
         bUNIMkNs6FQ8+7QBIamGHeO/XyzVtesCFr+8SChPfUFJKt8xrwEeskb/AhmE1v/QjI4X
         RxoYAMAYb1ydtXWVxP8XwLEVVcCLrDgJxtfmLyzcF0jmSTaRO2O6CD1wNOoTEh5IOG8g
         jjyZwNAfCRaxVyGU8O4xE6DmJnGX1+kyOT1egkypHyVxQ01fnvJNlDStdWQn4RXcUnzN
         Lr+ZXJy/GSHp4+esU5UJ+bO2AOXGjIScINtSg9cLic0RSjKD/pdhe90zW9gfM08kevij
         cblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QtbZAbWRhVwhreXSB0kTHv0ILfnB5bkBKlrIN7hAzs4=;
        b=I+qvRPWeyDkmOBRgKXS3g/sBUAxB8H0OQHEGt38szmMmQhJG3a3sUyJcz2bGnLHloL
         RgEorwXp/WCn5xM/gii3I/cD2eRr1KuiRAjoN7rle7ueZyvsqekDb8Sdb1wKik6ts3jP
         UG09EKq8RaLZDcNAZP3E1R4GWsvtvLXfo2V+BCXZSDgph3rM1iSW2k7GBlGW/26EtrUV
         TkyzVZB1lc9vUV0CZn/9h09kiAP8XYPVefKuMEZGXOrrFhZv1XL1BEsRyL3c8hMMRBP5
         eZ8MwWqjfjckuBGWtwyvlEuAps78ZrjTxpdgLoh0lZ8dR18CyvT3as9KPmW85Sll8C31
         zjNw==
X-Gm-Message-State: AOAM53080icZy2k+tGPuAoAfwBRCh9glg0BcVCSLMbt3jFgqaqyWiPkY
        hHt3b3S/Y7XVv9Cf82TXxuXVM2s1lhUVZqwqPnk=
X-Google-Smtp-Source: ABdhPJyEANHPuWScmaWhskyT8qulsVwG0NG2XTMS6k7HxpCz+PzLSYNd8VDRLJamjYd+48fCe4ekPBstE1rZG8FHx+g=
X-Received: by 2002:a6b:be46:: with SMTP id o67mr4036812iof.133.1601530562491;
 Wed, 30 Sep 2020 22:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200911222634.31804-1-michael@walle.cc> <20200911222634.31804-5-michael@walle.cc>
In-Reply-To: <20200911222634.31804-5-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Thu, 1 Oct 2020 07:35:51 +0200
Message-ID: <CAEyMn7ZXxdO5bKPh0hVU3ne4CRvfcJJ_HVBn8oVTUSo0r0eMqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: implement OTP support for Winbond
 and similar flashes
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jungseung Lee <js07.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael,

Am Sa., 12. Sept. 2020 um 00:26 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> Use the new OTP ops to implement OTP access on Winbond flashes. Most
> Winbond flashes provides up to four different OTP areas ("Security
> Registers"). Newer flashes uses the first OTP area for SFDP data. Thus,
> for these flashes only the last three areas are handled and the first
> one is left untouched.
>
> This was tested on a Winbond W25Q32JW as well as on a W25Q32FW.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  drivers/mtd/spi-nor/core.c    | 161 ++++++++++++++++++++++++++++++++++
>  drivers/mtd/spi-nor/core.h    |   4 +
>  drivers/mtd/spi-nor/winbond.c |  18 +++-
>  include/linux/mtd/spi-nor.h   |  10 +++
>  4 files changed, 191 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 348db19958e9..c150e3b6ee44 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2997,6 +2997,167 @@ int spi_nor_otp_is_locked_scur(struct spi_nor *nor, unsigned int region)
>         return *scur & SCUR_LDSO;
>  }
>
> +/**
> + * spi_nor_otp_read_secr() - read OTP data
> + * @nor:       pointer to 'struct spi_nor'
> + * @from:       offset to read from
> + * @len:        number of bytes to read
> + * @buf:        pointer to dst buffer
> + *
> + * Read OTP data by using the SPINOR_OP_RSECR commands. This method is used on
> + * GigaDevice and Winbond flashes.
> + *
> + * Return: number of bytes read successfully, -errno otherwise
> + */
> +int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf)
> +{
> +       u8 addr_width, read_opcode, read_dummy;
> +       struct spi_mem_dirmap_desc *rdesc;
> +       enum spi_nor_protocol read_proto;
> +       int ret;
> +
> +       read_opcode = nor->read_opcode;
> +       addr_width = nor->addr_width;
> +       read_dummy = nor->read_dummy;
> +       read_proto = nor->read_proto;
> +       rdesc = nor->dirmap.rdesc;
> +
> +       nor->read_opcode = SPINOR_OP_RSECR;
> +       nor->addr_width = 3;
> +       nor->read_dummy = 8;
> +       nor->read_proto = SNOR_PROTO_1_1_1;
> +       nor->dirmap.rdesc = NULL;
> +
> +       ret = spi_nor_read_data(nor, addr, len, buf);
> +
> +       nor->read_opcode = read_opcode;
> +       nor->addr_width = addr_width;
> +       nor->read_dummy = read_dummy;
> +       nor->read_proto = read_proto;
> +       nor->dirmap.rdesc = rdesc;
> +
> +       return ret;
> +}
> +
> +/**
> + * spi_nor_otp_write_secr() - write OTP data
> + * @nor:        pointer to 'struct spi_nor'
> + * @to:         offset to write to
> + * @len:        number of bytes to write
> + * @buf:        pointer to src buffer
> + *
> + * Write OTP data by using the SPINOR_OP_PSECR commands. This method is used on
> + * GigaDevice and Winbond flashes.
> + *
> + * Return: number of bytes written successfully, -errno otherwise
> + */
> +int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf)
> +{
> +       enum spi_nor_protocol write_proto;
> +       struct spi_mem_dirmap_desc *wdesc;
> +       u8 addr_width, program_opcode;
> +       int ret;
> +
> +       program_opcode = nor->program_opcode;
> +       addr_width = nor->addr_width;
> +       write_proto = nor->write_proto;
> +       wdesc = nor->dirmap.wdesc;
> +
> +       nor->program_opcode = SPINOR_OP_PSECR;
> +       nor->addr_width = 3;
> +       nor->write_proto = SNOR_PROTO_1_1_1;
> +       nor->dirmap.wdesc = NULL;
> +
> +       /*
> +        * We only support a write to one single page. For now all winbond
> +        * flashes only have one page per OTP region.
> +        */
> +       ret = spi_nor_write_enable(nor);
> +       if (ret)
> +               goto out;
> +
> +       ret = spi_nor_write_data(nor, addr, len, buf);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret = spi_nor_wait_till_ready(nor);
> +
> +out:
> +       nor->program_opcode = program_opcode;
> +       nor->addr_width = addr_width;
> +       nor->write_proto = write_proto;
> +       nor->dirmap.wdesc = wdesc;
> +
> +       return ret;
> +}
> +
> +static int spi_nor_otp_lock_bit_cr(unsigned int region)
> +{
> +       static const int lock_bits[] = { SR2_LB1, SR2_LB2, SR2_LB3 };
> +
> +       if (region >= ARRAY_SIZE(lock_bits))
> +               return -EINVAL;
> +
> +       return lock_bits[region];
> +}
> +
> +/**
> + * spi_nor_otp_lock_sr2() - lock the OTP region
> + * @nor:        pointer to 'struct spi_nor'
> + * @region:     OTP region
> + *
> + * Lock the OTP region by writing the status register-2. This method is used on
> + * GigaDevice and Winbond flashes.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region)
> +{
> +       int lock_bit;
> +       u8 *sr2 = nor->bouncebuf;
> +       int ret;
> +
> +       lock_bit = spi_nor_otp_lock_bit_cr(region);
> +       if (lock_bit < 0)
> +               return lock_bit;
> +
> +       ret = spi_nor_read_cr(nor, sr2);
> +       if (ret)
> +               return ret;
> +
> +       /* check if its already locked */
> +       if (*sr2 & lock_bit)
> +               return 0;
> +
> +       return spi_nor_write_16bit_cr_and_check(nor, *sr2 | lock_bit);
> +}
> +
> +/**
> + * spi_nor_otp_is_locked_sr2() - get the OTP region lock status
> + * @nor:        pointer to 'struct spi_nor'
> + * @region:     OTP region
> + *
> + * Retrieve the OTP region lock bit by reading the status register-2. This
> + * method is used on GigaDevice and Winbond flashes.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region)
> +{
> +       int lock_bit;
> +       u8 *sr2 = nor->bouncebuf;
> +       int ret;
> +
> +       lock_bit = spi_nor_otp_lock_bit_cr(region);
> +       if (lock_bit < 0)
> +               return lock_bit;
> +
> +       ret = spi_nor_read_cr(nor, sr2);
> +       if (ret)
> +               return ret;
> +
> +       return (*sr2 & lock_bit);
> +}
>
>  static int spi_nor_init(struct spi_nor *nor)
>  {
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 7ec4add17b72..74bbb7aef1f1 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -472,6 +472,10 @@ int spi_nor_otp_read_otp_mode(struct spi_nor *nor, loff_t from, uint64_t len, u8
>  int spi_nor_otp_write_otp_mode(struct spi_nor *nor, loff_t to, uint64_t len, u8 *buf);
>  int spi_nor_otp_lock_scur(struct spi_nor *nor, unsigned int region);
>  int spi_nor_otp_is_locked_scur(struct spi_nor *nor, unsigned int region);
> +int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf);
> +int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, uint64_t len, u8 *buf);
> +int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
> +int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
>
>  int spi_nor_hwcaps_read2cmd(u32 hwcaps);
>  u8 spi_nor_convert_3to4_read(u8 opcode);
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 6dcde15fb1aa..3b14e96e993f 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -55,14 +55,19 @@ static const struct flash_info winbond_parts[] = {
>         { "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
>         { "w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64,
>                            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> +                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +                          OTP_INFO(256, 3, 0x1000, 0x1000)
> +       },
> +
>         { "w25q32jv", INFO(0xef7016, 0, 64 * 1024,  64,
>                            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                            SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },
>         { "w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
>                             SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> +                           OTP_INFO(256, 3, 0x1000, 0x1000)
> +       },
>         { "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
>         { "w25q64", INFO(0xef4017, 0, 64 * 1024, 128,
>                          SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> @@ -122,9 +127,18 @@ static int winbond_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
>         return spi_nor_write_disable(nor);
>  }
>
> +static const struct spi_nor_otp_ops winbond_otp_ops = {
> +       .read = spi_nor_otp_read_secr,
> +       .write = spi_nor_otp_write_secr,
> +       .lock = spi_nor_otp_lock_sr2,
> +       .is_locked = spi_nor_otp_is_locked_sr2,
> +};
> +
>  static void winbond_default_init(struct spi_nor *nor)
>  {
>         nor->params->set_4byte_addr_mode = winbond_set_4byte_addr_mode;
> +       if (nor->params->otp_info.n_otps)
> +               nor->params->otp_ops = &winbond_otp_ops;
>  }
>
>  static const struct spi_nor_fixups winbond_fixups = {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 04195d3e43b8..4750fb631c96 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -110,6 +110,11 @@
>  #define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
>  #define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
>
> +/* Used for GigaDevices and Winbond flashes. */
> +#define SPINOR_OP_ESECR                0x44    /* Erase Security registers */
> +#define SPINOR_OP_PSECR                0x42    /* Program Security registers */
> +#define SPINOR_OP_RSECR                0x48    /* Read Security registers */
> +
>  /* Status Register bits. */
>  #define SR_WIP                 BIT(0)  /* Write in progress */
>  #define SR_WEL                 BIT(1)  /* Write enable latch */
> @@ -141,8 +146,13 @@
>
>  /* Status Register 2 bits. */
>  #define SR2_QUAD_EN_BIT1       BIT(1)
> +#define SR2_LB0                        BIT(2)  /* Security Register Lock Bit 0 */
> +#define SR2_LB1                        BIT(3)  /* Security Register Lock Bit 1 */
> +#define SR2_LB2                        BIT(4)  /* Security Register Lock Bit 2 */
> +#define SR2_LB3                        BIT(5)  /* Security Register Lock Bit 3 */
>  #define SR2_QUAD_EN_BIT7       BIT(7)
>
> +
>  /* Supported SPI protocols */
>  #define SNOR_PROTO_INST_MASK   GENMASK(23, 16)
>  #define SNOR_PROTO_INST_SHIFT  16
>
