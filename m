Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE682DD5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgLQRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:01:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727303AbgLQRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:01:37 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHGvYVV002712;
        Thu, 17 Dec 2020 18:00:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=5X9I93/CknW78ByfJVCd4gjwHOCzonLGg9msimNptF4=;
 b=PeYzIzKIVQFzcMKkG+8IMCum3jiyvjUdxe6TMg8sfgOwEoEc9+gKqazwr+cQiJU8mujd
 SFQr7/QIhLC5sPb2Z/YP1h6YqxkWjhalOCwBuA5A2Csb/f+ziFqHtwBcIzohNd76jt7G
 N9LKlvnYL4LmyNpWEkHFs873n3w4zMvh+KrNI227in0JIIxL+L/WT4AEyJQo62fj67eQ
 NRTdaOpgyNqvKELKHcawLUGoACv8NDB+wwGT0ds8oueO9WYZ3k4wDfp3KsMORuYWSZK8
 N19x2P7NMyWKYrsxwIhDLosRyBOYcvcW0ZuStiifq26pAsvFINoE672u/mXYFyPxb3bY YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpwegwhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 18:00:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C1A6E10002A;
        Thu, 17 Dec 2020 18:00:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5AC325AAE1;
        Thu, 17 Dec 2020 18:00:53 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Dec 2020 18:00:53
 +0100
From:   <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] MAINTAINERS: update STMicroelectronics email
Date:   Thu, 17 Dec 2020 18:00:42 +0100
Message-ID: <20201217170044.12061-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series:
  _ update st.com to foss.st.com email for some maintainers.
  _ Remove Vincent Abriou as STI/STM DRM driver

Patrice Chotard (2):
  MAINTAINERS: Update some st.com email addresses to foss.st.com
  MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.

 MAINTAINERS | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

-- 
2.17.1

