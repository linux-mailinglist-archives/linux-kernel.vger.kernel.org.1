Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE6925143E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgHYIbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 04:31:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:10916 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHYIbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:31:53 -0400
IronPort-SDR: y9Y6GWwxp4E0hdsO/kWYsFNe7S1rm79aIyWCeIeIatSNxDdahbTbGvrrUxXeNuNRF7qZE9fqYQ
 LdRPrRe1t3hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135617289"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="135617289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 01:31:52 -0700
IronPort-SDR: aP0lc4VtciVbZhXBdGz1laUhzeyPeB/4PdR7H938lEz97WTG3LE4BSY73p20mWj3F5vLreepfY
 qR1EN6DB+4eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="499779205"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2020 01:31:49 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 0/1] extcon: ptn5150: Add usb-typec support for Intel LGM SoC
Date:   Tue, 25 Aug 2020 16:31:46 +0800
Message-Id: <20200825083147.25270-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-typec detection support for the Intel LGM SoC based boards.

Original driver is not supporting usb detection on Intel LGM SoC based boards
then we debugged and fixed the issue, but before sending our patches Mr.Krzyszto
has sent the same kind of patches, so I have rebased over his latest patches
which is present in maintainer tree.

Built and tested it's working fine, overthat created the new patch V1.

Reference to mail discussion:
 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2281723.html

Ramuthevar Vadivel Murugan (1):
  extcon: ptn5150: Add usb-typec support for Intel LGM SoC

 drivers/extcon/extcon-ptn5150.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.11.0

