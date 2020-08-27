Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C494B253C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgH0D4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 23:56:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:2156 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgH0D4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:56:38 -0400
IronPort-SDR: ztJ7R9WHfX+FWfazZxa6HjoYRc0AVnraPCw8SK5I02iJyn78lgFnXXwH5r8janqTLSYK4BteET
 7U2Ggn3cCUvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153838736"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="153838736"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 20:56:37 -0700
IronPort-SDR: s54ddtdeNLEYPg63PVOkBeeBtRtvxBPET5Qsz5WF11scN8zs1dimkrUDJ5BhSnuYvedg54TNk2
 zhTrA83gig5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="323442900"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 20:56:35 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 0/2] extcon: ptn5150: Add usb-typec support for Intel LGM SoC
Date:   Thu, 27 Aug 2020 11:56:31 +0800
Message-Id: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

Built and tested it's working fine, overthat created the new patch.

Thanks for Krzyszto and Chanwoo Choi
---
v2:
  - Krzyszto review comments update
  - squash my previous patches 1 to 5 as single patch
  - add extcon_set_property_capability for EXTCON_USB and EXTCON_PROP_USB_TYPEC_POLARITY 

Reference to mail discussion:
 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2281723.html

Ramuthevar Vadivel Murugan (2):
  extcon: ptn5150: Switch to GENMASK() and BIT() macros
  extcon: ptn5150: Set the VBUS and POLARITY property state

 drivers/extcon/extcon-ptn5150.c | 49 ++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

-- 
2.11.0

