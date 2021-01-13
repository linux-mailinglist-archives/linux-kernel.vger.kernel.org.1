Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651A2F493D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbhAMLAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbhAMLAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94DF32333F;
        Wed, 13 Jan 2021 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535569;
        bh=wLPtDikaEr2WKIz4STdFMo8JbsgQLRoWtqG1j7dtivs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5br75HKFNEdTlmPmoMKPHHZZf8vgUo9uoBlvh4/1+WT5Yek+el7vWTyRK8bhZBFh
         6SmsRQVKUfJUDpZ0rK+8wJnbzj/PYxgT9lIc1ykbaR2kvbvQW3RXSQfBAXNaxUoeVH
         j+xEHiKU2CZmk8WWdTLYprZNaY10zof1ff6FQqhxCS9y4K9xiZ0xtbMh/e1J5OMooc
         WhjvXALnIkWcMirx8TX/mne/K/mBUwo7t416gd17TPRRcyZfgx6HtG8j2BgA6tXLuf
         Xuye0aYZWpAXTOjGGf/ol/2SSADYlabIGec1h9WooQpYVDmbbQFXubtzLf7sTf/5XT
         pst1hBaFV6tQg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpFu-58; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/24] MAINTAINERS: update st,hts221.yaml reference
Date:   Wed, 13 Jan 2021 11:59:04 +0100
Message-Id: <c2f39f957d717a28b4e05a371d22a67ab20562f6.1610535349.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 9a6ac3138258 ("dt-bindings:iio:humidity:st,hts221 yaml conversion.")
renamed: Documentation/devicetree/bindings/iio/humidity/hts221.txt
to: Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7578b9798bfe..b3fe85038eb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8215,7 +8215,7 @@ M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 W:	http://www.st.com/
-F:	Documentation/devicetree/bindings/iio/humidity/hts221.txt
+F:	Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
 F:	drivers/iio/humidity/hts221*
 
 HUAWEI ETHERNET DRIVER
-- 
2.29.2

