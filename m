Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB1204993
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 08:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgFWGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 02:12:39 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39110 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgFWGMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:12:39 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A3D41A1917;
        Tue, 23 Jun 2020 08:12:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 716831A0E27;
        Tue, 23 Jun 2020 08:12:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CB87A4029C;
        Tue, 23 Jun 2020 14:12:27 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix unchecked return value for clk_prepare_enable
Date:   Tue, 23 Jun 2020 14:01:10 +0800
Message-Id: <cover.1592888591.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is to remove the check of clock pointer before calling
clk API.

Second patch is to fix the issue that the return value of
clk_prepare_enable is not checked.

changes in v2:
- split the patch to separate patches

Shengjiu Wang (2):
  ASoC: fsl_mqs: Don't check clock is NULL before calling clk API
  ASoC: fsl_mqs: Fix unchecked return value for clk_prepare_enable

 sound/soc/fsl/fsl_mqs.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.21.0

