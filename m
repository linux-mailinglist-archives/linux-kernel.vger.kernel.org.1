Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7679D2F36D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392575AbhALRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:16:21 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:37800 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391194AbhALRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:16:19 -0500
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CHDcv3030313;
        Tue, 12 Jan 2021 12:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=IuO+MqdxINFhV6RKwLi9ZG11Bhv9DITM4qJkav4smBk=;
 b=Rb6WUJoYnfPoHG54X9p3wyi/Af83PzlN8/VVAx2DbO4PhFBn6vCrwlsidVl8Eun71/7v
 lH8OANEWeau6yfrNfOSINxIHDoDSmBgthLIonGFuMNbVxFTJHH8YjYCzj7LUvRMsyTsI
 i3/eoD8WQI5N8g1Kgiiv61/jvqsI5BvB0YSqiR6c7xnrEp0O/GnB2fRs8r+BxdmVggRp
 2uVAhX/O45XhVKa37rCFs6foTiA+WJXViY721WcZEIFmWJP3RJ8wXTczAiu5uKgFlLte
 v+xH9haD84SghJTUgRmrLF89llJeH3F1dNoFy8Iw+SYKkL1Kz1oSUBe0vGpvOnSAJu3S 7g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 361fyag0fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 12:15:38 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CH9bNv025045;
        Tue, 12 Jan 2021 12:15:37 -0500
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 361fqw8dnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 12:15:36 -0500
X-LoopCount0: from 10.69.132.19
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.79,341,1602565200"; 
   d="scan'208";a="585223467"
From:   Perry Yuan <Perry.Yuan@dell.com>
To:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Perry.Yuan@dell.com,
        Mario.Limonciello@dell.com
Subject: [PATCH v3 0/3] Dell hardware privacy implementation for dell laptop
Date:   Wed, 13 Jan 2021 01:15:02 +0800
Message-Id: <20210112171502.11452-1-Perry_Yuan@Dell.com>
X-Mailer: git-send-email 2.19.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_12:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120100
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <perry_yuan@dell.com>

Hi All,
This patch set is a new driver for dell mobile platform ,which has the
hardware privacy feature.

For micmute led control, the hotkey is Fn + F4, it is a hardware based
mute state, and new privacy will prevent micphone void input from
hardware layer, any application cannot get voice data when micmute
activated. 

Camera mute use a new hardware design to control the camrea shutter.
When video is muted, no OS application should be functionally able to
capture images of the person/environment in front of the system

Older history:
[1]https://patchwork.kernel.org/project/platform-driver-x86/patch/20201228132855.17544-1-Perry_Yuan@Dell.com/
[2]https://patchwork.kernel.org/project/alsa-devel/patch/20201103125859.8759-1-Perry_Yuan@Dell.com/#23733605
[3]https://www.spinics.net/lists/alsa-devel/msg120537.html
[4]https://github.com/thesofproject/linux/pull/2660


Perry Yuan (3):
  platform/x86: dell-privacy: Add support for Dell hardware privacy
  x86/platform/dell-privacy-wmi: add document for dell privacy driver
  ASoC: rt715:add micmute led state control supports

 .../testing/sysfs-platform-dell-privacy-wmi   |  31 ++
 drivers/platform/x86/Kconfig                  |  17 +
 drivers/platform/x86/Makefile                 |   4 +-
 drivers/platform/x86/dell-laptop.c            |  25 +-
 drivers/platform/x86/dell-privacy-acpi.c      | 167 +++++++++
 drivers/platform/x86/dell-privacy-wmi.c       | 320 ++++++++++++++++++
 drivers/platform/x86/dell-privacy-wmi.h       |  33 ++
 drivers/platform/x86/dell-wmi.c               |  37 +-
 sound/soc/codecs/rt715-sdca.c                 |  16 +
 sound/soc/codecs/rt715-sdca.h                 |   1 +
 sound/soc/codecs/rt715.c                      |  14 +
 sound/soc/codecs/rt715.h                      |   1 +
 12 files changed, 650 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-privacy-wmi
 create mode 100644 drivers/platform/x86/dell-privacy-acpi.c
 create mode 100644 drivers/platform/x86/dell-privacy-wmi.c
 create mode 100644 drivers/platform/x86/dell-privacy-wmi.h

-- 
2.25.1

