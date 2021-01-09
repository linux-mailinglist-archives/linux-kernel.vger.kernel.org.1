Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E452EFEB5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 10:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAIJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 04:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbhAIJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 04:02:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6889F2388A;
        Sat,  9 Jan 2021 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610182888;
        bh=oWWZ4QtPz6X3VjuMisVOWmtyWuCrAIJg6amlhmHFDHg=;
        h=Date:From:To:Cc:Subject:From;
        b=biTY1/6KLkTa7nC15wCZBcTqdGZBoOb5Bjya80k+R0kEo7tLa6fxavzMORvAupTdC
         vUkPD69qutJvCc+oJvv1XFBUacaYO53CN2M6HX0tWa/6nJYRgdu8MyyYHOS/0smkwH
         YRjzpKrHjBdPm0xvN3MSxohGB9+Ll5/zIet3kISirFUVQTyCyQvYB37Xu6ehTI2sFI
         UW1Gf/jXTIU3tQxrufnAQLfTzJdE2c5Zw2GHUFJDWElejOZwcNDp/upZnLY8a1YUFZ
         8SVi1hpQ/gPIIWYou0lOwZnBe1uq0kQPDnqtktnzUrT8q44efTxJo7jb8HGgtTIcpx
         B5dQdLG8FzOKw==
Date:   Sat, 9 Jan 2021 14:31:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v5.11
Message-ID: <20210109090124.GY2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive fixes for dmaengine drivers. Odd fixes for few
drivers.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-5.11

for you to fetch changes up to e1263f9277bad198c2acc8092a41aea1edbea0e4:

  dmaengine: stm32-mdma: fix STM32_MDMA_VERY_HIGH_PRIORITY value (2021-01-0=
4 21:27:45 +0530)

----------------------------------------------------------------
dmaengine fixes for v5.11

Bunch of dmaengine driver fixes for:
- coverity discovered issues for xilinx driver
- qcom, gpi driver fix for undefined bhaviour and one off cleanup
- Update Peter's email for TI DMA drivers
- one off for idxd driver
- resource leak fix for mediatek and milbeaut drivers

----------------------------------------------------------------
Amelie Delaunay (1):
      dmaengine: stm32-mdma: fix STM32_MDMA_VERY_HIGH_PRIORITY value

Arnd Bergmann (1):
      dmaengine: qcom: fix gpi undefined behavior

Christophe JAILLET (2):
      dmaengine: mediatek: mtk-hsdma: Fix a resource leak in the error hand=
ling path of the probe function
      dmaengine: milbeaut-xdmac: Fix a resource leak in the error handling =
path of the probe function

Dan Carpenter (2):
      dmaengine: idxd: off by one in cleanup code
      dmaengine: dw-edma: Fix use after free in dw_edma_alloc_chunk()

Peter Ujfalusi (3):
      dmaengine: ti: k3-udma: Fix pktdma rchan TPL level setup
      MAINTAINERS: Add entry for Texas Instruments DMA drivers
      dt-bindings: dma: ti: Update maintainer and author information

Shravya Kumbham (3):
      dmaengine: xilinx_dma: check dma_async_device_register return value
      dmaengine: xilinx_dma: fix incompatible param warning in _child_probe=
()
      dmaengine: xilinx_dma: fix mixed_enum_type coverity warning

Xiaoming Ni (1):
      dmaengine: qcom: gpi: Fixes a format mismatch

Zheng Yongjun (1):
      qcom: bam_dma: Delete useless kfree code

 Documentation/devicetree/bindings/dma/ti/k3-bcdma.yaml  |  4 +++-
 Documentation/devicetree/bindings/dma/ti/k3-pktdma.yaml |  4 +++-
 Documentation/devicetree/bindings/dma/ti/k3-udma.yaml   |  4 +++-
 MAINTAINERS                                             | 13 +++++++++++++
 drivers/dma/dw-edma/dw-edma-core.c                      |  4 ++--
 drivers/dma/idxd/sysfs.c                                |  4 ++--
 drivers/dma/mediatek/mtk-hsdma.c                        |  1 +
 drivers/dma/milbeaut-xdmac.c                            |  4 +++-
 drivers/dma/qcom/bam_dma.c                              |  6 +-----
 drivers/dma/qcom/gpi.c                                  | 10 +++++-----
 drivers/dma/stm32-mdma.c                                |  2 +-
 drivers/dma/ti/k3-udma.c                                |  6 +++---
 drivers/dma/xilinx/xilinx_dma.c                         | 11 ++++++++---
 13 files changed, 48 insertions(+), 25 deletions(-)



--=20
~Vinod

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAl/5cOMACgkQfBQHDyUj
g0c8jxAAon5kduChT+JuOQN5fIj3QlaRhppYtLiGlnwazX1XI/vQWxEZnQ38kRRJ
sbSMLAMHotsAbxQwLQGOgGOiw1OhHLFGag2Cgfk9NOgZTORsh4un0UU9PaIQodXg
XuefGycC8S4zbfSZn+ZMYoB5TIVBijEw65xekGL3qaWIYI3/UAWHbejHGvZQrYPt
/aeOb4V6HFFRuULYq9aLEiAUyaLgOHJWRPMCQJUJ+V8qu3RbxM4SV3U+MvcZIwBZ
+CzeX7hqhIaQyr99D7n87s1XoLxOZQ1QqFWvor1NBjkjEmiSoYHxpNSR5sxrl+Jb
z8EBLypIMEldXhT6esglKyFwl+tWGPXz0/CLIh7nML8LrzoG6cmN14UJTYwpAI0g
tSnPsxXO7yWpUbNegwWeTECtzZJDxmyGr9EY2MW1mTeoGYaD4dlSiOTnFNyvwkYM
YphMCB/5Y0Av0sVcwn1jy80a0Iwyebe+PXFFNl3MDF+CkFFM4YB4LM+C/7mHfu/2
jb+pIQnrJmIi+7zpm+s/4r8T99coZqe7s5RRsG8A7qnORle7+CWRU57SJ4wZb6uV
oc/SZp9z2nMnH2QPw1pXRcYx0vJ0jwu0YLYobqNevXkMwiEmUPNl7qiMz2UVlRQw
ZaBoB2KKB3D9clUdZTEYF61FuzPcnERJ70a5wcgEcD1AzwpI4L4=
=35B1
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
