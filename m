Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656B32F5BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhANHyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbhANHya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:54:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB20E23A01;
        Thu, 14 Jan 2021 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=CkEHr9Hpk/gHNJIktPKbWkXyAFa/FuixQD4gAQAQgbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEEv9rwtr/61NpgfcTa7XW/I4/h+woANavlWf49P70CyijU77Jca5nZx5XUJjztcL
         IeCrtCrQ5RaI2/NiZ2YwPRarOS3g5xIuBhsWLUegHTjrn3SmWjRvV3WAgZ4y4BMYt8
         gp+gunDa246bXQ5U1fBvXJP6MYI1l989694WJOf1BDxh7wJo7t4BPEJ1Q+OxS/+1JZ
         irjiRcwRblqaCWn5jc0RekzE3JlKaeHwcJpMyzvK6OC3dFBIHN7HHgeNOC4q+x1IyW
         +2bnQ28lIf1DdncyOyv7H7sQRdv7sHe6DaJ6MaHyccsxHseK0jcdjKhNVK6d8usT72
         54rRCv8taz/5g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPuF-A9; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 07/10] dwc3: document gadget_max_speed
Date:   Thu, 14 Jan 2021 08:53:42 +0100
Message-Id: <e9332e31bec9bcead2c7ced2b25462120488ca85.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new field was added to struct dwc3_scratchpad_array, but
a documentation for it was missed:

	../drivers/usb/dwc3/core.h:1259: warning: Function parameter or member 'gadget_max_speed' not described in 'dwc3'

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/dwc3/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index ac290d896638..eec1cf4ba268 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -964,6 +964,7 @@ struct dwc3_scratchpad_array {
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
+ * @gadget_max_speed: maximum gadget speed requested
  * @ip: controller's ID
  * @revision: controller's version of an IP
  * @version_type: VERSIONTYPE register contents, a sub release of a revision
-- 
2.29.2

