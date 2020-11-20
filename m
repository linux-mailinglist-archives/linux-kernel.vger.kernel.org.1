Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591492BA5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKTJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:15:40 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:62922 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgKTJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:15:39 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK9C0ew009168;
        Fri, 20 Nov 2020 10:15:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=O4FJ2e5h7b+AxB/Q4KYOv8DIfhDXse4YLP1vuz+xoFo=;
 b=ze9t1fBQ1+EtZ5xGaq+GC463OHB7X3gWOu19ziVxL8+qXDVFs49kLhnuk0yvqbVl/thK
 +A4yaaffYLV6jy+jNfv0hWhE6/AxvA5zEOFFyZID661RUuEGIXkxImDF8XP0UvKxZ6oS
 kl2zEJAQQc/hUGAFYygTiTB1xtFvH+dXERd9JwvCnP+iP03objsPp6ZHKO8JTq1qn4J/
 3F/62lXUeRMv2MvU2FFNY6tg7rYvBKIJaMlh+dibyv89Q+/30uChUUA50XPZYAmB1aIb
 471Ivq+l9b9WPMozqNpMZ3O8devgUJiihslFwj4RY5FJt534H9DvAFQJBcZY6/HMxDBi Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5w2cwvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 10:15:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62585100034;
        Fri, 20 Nov 2020 10:15:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 49468236076;
        Fri, 20 Nov 2020 10:15:10 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov 2020 10:15:09
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <linux@armlinux.org.uk>, <shawnguo@kernel.org>, <olof@lixom.net>,
        <alexandre.torgue@st.com>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <amelie.delaunay@st.com>,
        <aisheng.dong@nxp.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <christian.gmeiner@gmail.com>, <enric.balletbo@collabora.com>,
        <lionel.debieve@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH v2 0/2] ARM: multi_v7_defconfig: enable dfsdm and spdifrx support
Date:   Fri, 20 Nov 2020 10:15:04 +0100
Message-ID: <20201120091506.18326-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_04:2020-11-19,2020-11-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add STM32 SPDIFRX and DFSDM audio support to multi_v7_defconfig

Change in v2:
- Add targeted SoC in commit message for DFSDM config

Olivier Moysan (2):
  ARM: multi_v7_defconfig: enable spdifrx support
  ARM: multi_v7_defconfig: enable dfsdm audio support

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1

