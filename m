Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFC228CB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgGUX3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 19:29:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:29:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTFU2113697
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595374155;
        bh=XTgVhSn9cvqVM8cziFcXaCIXMVCkPt/CZLpLP6PMMGY=;
        h=From:To:CC:Subject:Date;
        b=atTdsPIXkfmA1YxUSq63gTdVlgOYfkOhFL5mxjkVzU2ZG5htpvs5qt++UYyurx/ro
         KxsexYJXUyTPPsintL1oSPz7azBM/C+I0DgRaN/TjLiTrjinqOfwgPOU8A7EJk7iX5
         OqG+RWEMmiZlvOl/pWTQ7N10pAS4KbrxEBnb/Y6Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTFVC096878
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 18:29:15 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 21
 Jul 2020 18:29:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 21 Jul 2020 18:29:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06LNTDJa007619;
        Tue, 21 Jul 2020 18:29:14 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/3] phy: ti: gmii-sel: update to support multiport k3 devices
Date:   Wed, 22 Jul 2020 02:29:10 +0300
Message-ID: <20200721232913.4979-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

This series introduces support for multiport K3 CPSW devices like one, which
can be found on J721E SoC (MAIN CPSW).
The first two patches are preparation changes. The Patch 3 add support for
retrieving number of ports and base registers offset from DT.

Grygorii Strashko (3):
  phy: ti: gmii-sel: move phy init in separate function
  phy: ti: gmii-sel: use features mask during init
  phy: ti: gmii-sel: retrieve ports number and base offset from dt

 drivers/phy/ti/phy-gmii-sel.c | 159 ++++++++++++++++++++--------------
 1 file changed, 96 insertions(+), 63 deletions(-)

-- 
2.17.1

