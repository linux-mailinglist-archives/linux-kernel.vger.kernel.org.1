Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD811A9060
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 03:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392525AbgDOBYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 21:24:41 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:57670 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392518AbgDOBYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:24:22 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 7D83A2DC0076;
        Wed, 15 Apr 2020 11:24:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1586913853;
        bh=Hnd7CQBwYdqkx5oYVKaymU8hhOOFePaDt87jkGY4AgM=;
        h=From:To:Cc:Subject:Date:From;
        b=e/aTMxG16640hUtwW8+PpPvW7EE6J01kTTaJl04jmrfmN3xmCtWqme3HJw1zRp8UN
         H6iNe33tsGT4abDuTHwRDhYRwPA6lX9XeAhUcbXvWnOo8T+1iWODcNBB/OSo5w8WxX
         KPEiJM0ZvjUKEur8M5EHfCqBeT4ggmHAFKdKvL4c+3rT8XAuSWscEZ8RYJnnuVMDzq
         +DcamskxAbifpj+84XCRY3zXuu6s+JMBdLR28xyTc78wXtqIAz2X178/lLl43iUUNj
         8ajooBi8dibJN5rDrjvBGop8+Bg12urt983xCjYERGgJ7K3SHnZsw55N6sLLuKLGbl
         XRPPq0tcNnbYUGTNVecj7u3RojGUhUYL82ssVLCpDCplOIflcVltHaiuqb2cdbBYSy
         zpmSogc2yA3bhHSIwF+xSG/OeGlBI0vl5cql0aFiA9v5NlQf0Lgg3OWWnRtlYDKDh1
         du5CL00DdjjqEc2LULNhxTzkoRjtolPhVx+ZAuJ465gK+r/g9aX741LRzYurcAtx+v
         Yb1CVAKZxjNI4aXcP6o0Mn4yQrMHhumaO7oIz/W3c7gnssbgXTNMAEjTl9ugY7lpoX
         YVpsREqhxmryJvhEHLlAw/7Ws7yuJTEelHguJXyStdGUZK39hpBhYPzBnBaEMXNDO5
         nSBpIavMxPioNCma7zc+vc3o=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 03F1O2Ru036615;
        Wed, 15 Apr 2020 11:24:04 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     alastair@d-silva.org
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] powerpc: OpenCAPI Cleanup
Date:   Wed, 15 Apr 2020 11:23:41 +1000
Message-Id: <20200415012343.919255-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Wed, 15 Apr 2020 11:24:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address checkpatch & kernel doc warnings
in the OpenCAPI infrastructure.

Alastair D'Silva (2):
  ocxl: Remove unnecessary externs
  ocxl: Address kernel doc errors & warnings

 arch/powerpc/include/asm/pnv-ocxl.h |  40 ++++++-----
 drivers/misc/ocxl/config.c          |  24 +++----
 drivers/misc/ocxl/ocxl_internal.h   |   9 +--
 include/misc/ocxl.h                 | 102 +++++++++++-----------------
 4 files changed, 77 insertions(+), 98 deletions(-)

-- 
2.25.1

