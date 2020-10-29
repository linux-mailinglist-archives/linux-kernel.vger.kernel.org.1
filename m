Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5580529E849
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ2KFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:05:49 -0400
Received: from foss.arm.com ([217.140.110.172]:58624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgJ2KFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C516F139F;
        Thu, 29 Oct 2020 03:05:47 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68FC63F66E;
        Thu, 29 Oct 2020 03:05:45 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     Ofir Drang <ofir.drang@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Milan Broz <gmazyland@gmail.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] crypto: switch to crypto API for EBOIV generation
Date:   Thu, 29 Oct 2020 12:05:41 +0200
Message-Id: <20201029100546.28686-1-gilad@benyossef.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series creates an EBOIV template that produces a skcipher
transform which passes through all operations to the skcipher, while
using the same skcipher and key to encrypt the input IV, which is
assumed to be a sector offset, although this is not enforced.

This matches dm-crypt use of EBOIV to provide BitLocker support,
and so it is proposed as a replacement in patch #3.

Replacing the dm-crypt specific EBOIV implementation to a Crypto
API based one allows us to save a memory allocation per
each request, as well as opening the way for use of compatible
alternative transform providers, one of which, based on the
Arm TrustZone CryptoCell hardware, is proposed as patch #4.

Future potential work to allow encapsulating the handling of
multiple subsequent blocks by the Crypto API may also
benefit from this work.

The code has been tested on both x86_64 virtual machine
with the dm-crypt test suite and on an arm 32 bit board
with the CryptoCell hardware.

Since no offical source for eboiv test vectors is known,
the test vectors supplied as patch #2 are derived from
sectors which are part of the dm-crypt test suite.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Milan Broz <gmazyland@gmail.com> 

Changes from v2:
- Remove needless internal include left over by mistake.

Changes from v1:
- Incorporated feedback from Eric Biggers regarding eboiv template code.
- Incorporated fixes for issues found by kernel test robot.
- Moved from a Kconfig dependency of DM_CRYPT to EBOIV to
  EBOIV default of DM_CRYPT as suggested by Herbert Xu.



Gilad Ben-Yossef (4):
  crypto: add eboiv as a crypto API template
  crypto: add eboiv(cbc(aes)) test vectors
  dm crypt: switch to EBOIV crypto API template
  crypto: ccree: re-introduce ccree eboiv support

 crypto/Kconfig                       |  23 +++
 crypto/Makefile                      |   1 +
 crypto/eboiv.c                       | 269 ++++++++++++++++++++++++++
 crypto/tcrypt.c                      |   9 +
 crypto/testmgr.c                     |   6 +
 crypto/testmgr.h                     | 279 +++++++++++++++++++++++++++
 drivers/crypto/ccree/cc_cipher.c     | 132 +++++++++----
 drivers/crypto/ccree/cc_crypto_ctx.h |   1 +
 drivers/md/dm-crypt.c                |  61 ++----
 9 files changed, 702 insertions(+), 79 deletions(-)
 create mode 100644 crypto/eboiv.c

-- 
2.28.0

