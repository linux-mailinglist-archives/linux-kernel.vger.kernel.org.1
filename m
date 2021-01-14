Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7604C2F5BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbhANHzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:55:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727567AbhANHzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:55:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1204239EC;
        Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=oyRypSip+Dc6mUsxTJ/NR8kO+Bc/LQvciK+2bI5BDPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fu6Y+8Z2c2jNzdxmHJcHGbjFIpriwkan8PSime9yLvdEOx3mbLiU6UpR6haB09q67
         PkZpFljmQVwYCCpyilM/g3tMlxzNaePZG8QmYr7BU0nJFfklT2sqArPV6Hf3dBmWHj
         OhUNr87N/xWawio1R2WJKXPkCOV7wnnxhePrx9zOiM7yhL0jUX1Si32+YAQjf4CMW+
         LPSj31e36F+935DZspytxDTrVnIkxlpXd2LryUOsIMB3BO9FRBUyMrdLPF8y6eHGTq
         Z7z8hRsZJLOFCpH5TDvc+mOQvbr31QV0UGOZRL7ADp9HG85c6I37uag1FDXqWDN66I
         VvXn1JB+Txscw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPu9-78; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ABI: sysfs-firmware-sgi_uv
Date:   Thu, 14 Jan 2021 08:53:39 +0100
Message-Id: <452854f2dd0625b9fee33b9f5e29343d6149781e.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing blank line required to identify a literal block,
fixing this warning:

	.../Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-firmware-sgi_uv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
index 637c668cbe45..b0f79a1d14b3 100644
--- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
+++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
@@ -39,6 +39,7 @@ Description:
 
 		The uv_type entry contains the hub revision number.
 		This value can be used to identify the UV system version::
+
 			"0.*" = Hubless UV ('*' is subtype)
 
 			"3.0" = UV2
-- 
2.29.2

