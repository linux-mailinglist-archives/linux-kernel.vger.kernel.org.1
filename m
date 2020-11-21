Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3672BBD74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 06:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKUF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 00:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKUF4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 00:56:01 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF568C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 21:56:00 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n12so7376688otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 21:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLDb+5nAdKajf4l/1zcD0rDEOYP1mCUs5/dRLgZKCGI=;
        b=NZnlHEf6Nvk6oZrtgCe2dT9fBwC9KA5VWSOvOnv5dZ+5z+7N/1RyUxgOpizqrRsY9Z
         bHYEg9gEogKjMtVtuOx6pFkteWgW84O0MV9MGJ74YPoCeOovcyjjT9U8g8KLQXbW0C0v
         OAE8iqv8BIUKxWn1sB3RRTObMsuuzhsc37MNhsZ4zK9E4mY1QCNatS5jUrpB3LeAhBVJ
         hhBtlxXaiw6O3AxvMFOEL3f8a6cOHXqGFPq6ye5VyN2zvmXUVe8+8vClF60/0K95s3J+
         aZ+D2a/qTyU9aD0DOiTvKPv9lZya55RtEIyeb+AZOM+jRsPu7SUuyZe4Jn4rEq0nm7yM
         cafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLDb+5nAdKajf4l/1zcD0rDEOYP1mCUs5/dRLgZKCGI=;
        b=I4L3YDtOMON833xFtv8pyyK/XBP/fxhMtwtNxYjxjPX4wDVq+JVuC/iqruQ8RaN9pV
         qCvW1z/g8Iqr1rXSIM418bFbQu/xS4T5NFnGZCRnKWkQWI5pW/uU+4PbpGwix5bplr8a
         mcWgM+AS4EJRZIGn23isttQNQdxTHQPqApkyZE8ea3spdoeVMQ7TqAn01tpxJv0zaNcX
         NwrtjlthpoiRf6Xlsrlo572m0WDbUXXTdLMp2sT2WHFuz7s9KvLvN7sFF9kGeB6RlMEI
         ZFzj3MFTzyBM7pUM0vUkwpJ1VBidkEsJUe+c5mpZaDKwkdFXC6eJC8LLd3X/VIDMSfCs
         U+4Q==
X-Gm-Message-State: AOAM5328SaUcQF13faGe9/Q2rKKc/MGrreVm7kLXXgA5dNsceHOEyEC5
        fNnU7ko5g9I/pw14t4jYXYm20g==
X-Google-Smtp-Source: ABdhPJwb0XTpa7th7zsw5TR53cJFIRcFBnkozOSPV+njSyVd3rQDkbPa9TkVIeOdPLZs59uD1EAbMw==
X-Received: by 2002:a9d:3dc6:: with SMTP id l64mr688627otc.331.1605938160222;
        Fri, 20 Nov 2020 21:56:00 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 92sm437014ota.67.2020.11.20.21.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 21:55:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8150-mtp: Specify remoteproc firmware
Date:   Fri, 20 Nov 2020 21:56:03 -0800
Message-Id: <20201121055603.582281-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Point the various remoteprocs of SM8150 MTP to a place with the platform
specific firmware.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 7a64a2ed78c3..3774f8e63416 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -369,14 +369,22 @@ resin {
 
 &remoteproc_adsp {
 	status = "okay";
+	firmware-name = "qcom/sm8150/adsp.mdt";
 };
 
 &remoteproc_cdsp {
 	status = "okay";
+	firmware-name = "qcom/sm8150/cdsp.mdt";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+	firmware-name = "qcom/sm8150/modem.mdt";
 };
 
 &remoteproc_slpi {
 	status = "okay";
+	firmware-name = "qcom/sm8150/slpi.mdt";
 };
 
 &tlmm {
-- 
2.28.0

