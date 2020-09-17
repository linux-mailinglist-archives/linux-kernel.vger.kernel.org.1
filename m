Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93626D671
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIQI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIQI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:26:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F980C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:26:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so936184pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Nh4GAOm0hko1A+aCz8p34Bkc9Qfa63CrTHwVTOLmZ/Q=;
        b=aqfkc6K7oRz8CuKPVuJ9svnfXtEulWQoGfMrGhrLhJNm8fsD3bSxy35//UH+Zh1hWH
         oCqdryDeW8pFN671mxDd18WF3TpRVKULPgFIs3f0D4cPhR6niTt0/0e49mFADYH4FCqo
         bpLRz0dIBSIdmUZs+3SAXnnJEtbHWEBsRIdcMPxmnEVEKbNquU6lSz69G7tlQuQ5nnIu
         SuPx9s5e++JhMgbhFhZLhdzJ+0TFznMavD1SA0KWBCoOdWM8hze1EYrS2JfHHoKt+p5t
         j/hqg3pVvKnpMfTjfy68x+IC/XUU6KU+JCkExxAxtgU4UuMvKhlon3GN8e3esxOrVb/N
         gR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nh4GAOm0hko1A+aCz8p34Bkc9Qfa63CrTHwVTOLmZ/Q=;
        b=leYnf8NnNL0OphXRgfxjVZMQW0GansLrZPDx+LCrmU3f6itsVg9YFsHY5s5yeeew+O
         aGvs6JeKrBO1fYojAD5/qjDF7RvMPqAFQpNoZCYobJTxxgsRqMrDiq7Z6Cyfw+ynjnOa
         tLc9dtai0sihNgopXZ27MCiF8Sa8zpkFtbfU/bxcqC7AleeO7uGvVMhik3pXqZ+mmHZl
         gbCfjg1xqsqkTyFRRl2dIFSJv3u8upzV2zSv46KEGSkLIgIFJqyIx00Me8xTwd6JpyIN
         aQZA5lT5dw2pzV6SkT+mXIzV/39u++bpwJFes4j3b5tnfXfv00CXLP1Aa8pW0kGK6zUl
         ywBA==
X-Gm-Message-State: AOAM533bG20axwYJ8RFJSm2EqzerlRFKS8HKr43EYDFiD/4zzwmnv/Ni
        tNZwAqGmVeL7FIlmaiW0A+yU
X-Google-Smtp-Source: ABdhPJxFftULprDAN34zvVrtfr+slMh9VfI1wHiCOeETwNdkVr+PNZmpGajFLKlo/WdTIh8mT02ezQ==
X-Received: by 2002:aa7:8084:0:b029:13f:b82a:1725 with SMTP id v4-20020aa780840000b029013fb82a1725mr23997407pff.9.1600331190897;
        Thu, 17 Sep 2020 01:26:30 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id g129sm8233194pfb.9.2020.09.17.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 01:26:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add USB support for SM8250
Date:   Thu, 17 Sep 2020 13:56:19 +0530
Message-Id: <20200917082622.6823-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds USB support for SM8250 SoC. The SM8250 specific patches
are sent by Jonathan earlier but didn't make it to qcom tree yet. So I'm
clubbing those in this series along with RB5 patch.

This series is based on qcom/for-next branch and tested on RB5 board.

Thanks,
Mani

Jonathan Marek (2):
  arm64: dts: qcom: sm8250: add apps_smmu node
  arm64: dts: qcom: sm8250: Add USB and PHY device nodes

Manivannan Sadhasivam (1):
  arm64: dts: qcom: qrb5165-rb5: Add USB support

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts |  46 ++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi     | 287 +++++++++++++++++++++++
 2 files changed, 333 insertions(+)

-- 
2.17.1

