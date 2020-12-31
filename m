Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A797B2E7FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgLaMYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 07:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgLaMYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 07:24:35 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FC5C061799
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:23:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o19so43817482lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZB1AtrBu43JL4Z0ztKUFuHbHEpLk42ePJCa9AP7fR4=;
        b=xR+Hv0rGtfukXZKNZNGVJmQbfDpd+i53Z+xDXjNSkFcONyqjqNBxn3P1ULr2jTqSLa
         YE0fmfUdRNbPHUSTCZJufctzRfPv0gPH/9ycM5OoxX5YqZvP4wsW99tKqvserzJJsMO2
         OGw71AAtnnCygOP9oizhSgukJBJ0uXcQGoiou+dKPc04zmvJikEkbDw6nKJha51AlAp7
         wdLMhz8+PG5MwCwsCpWads/kQaBI2WdEckHR1Kk071fyFcEJo9HAXaG06gqSbryvXj+t
         3AB3BVIT68GH6soSJaFs1kEBhVYwCSC/mX3qDZs5+NtL2m5kIU1x8YCrlD6HANBuLZWv
         qYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZB1AtrBu43JL4Z0ztKUFuHbHEpLk42ePJCa9AP7fR4=;
        b=biIgnfa8AZXT87JYe+Tr8swH82oBkpO547LlKn2jdbEd/LWifOwxeoxFXO7J4rBJb5
         T09buuWe2iLeuMStrQujLN55VBVg8axSTkwORIpL/BHppvw6EbXhs6LXKD+7SIIs1IES
         sEdtBc2OVpD5ie3dTXAtHkyb7LDlkgQwAkUiZ/XgNOTazSpTpexf+X6XgDimbUeT3lK2
         aH9oNCLs5HxUXZHN+zKciFEjNry20v/7hsdlquHPCd+z7T1KsbTuH2I6IvKoYrU8Myr3
         6GddQF/dE0PxLGCD9DgnDvSxlQ7Gv1lvHd6ek+lRCA3AFq/T1LROlv0zyQ2ZCesTHrV9
         jj5w==
X-Gm-Message-State: AOAM532KE3AVyaHbVrIONk6eOvQU6GsWOTNp8y2m/EaGVT9ETbNfW7xt
        vWF3IX59/ZlwLXePREdNf4QUKw==
X-Google-Smtp-Source: ABdhPJzmxh3GiL2fCyqYuw7BSqAsk1cvtLafNZwjdu7WZkIaqueJSqbdif9gGfaaTx/DQ4GcAWdjhw==
X-Received: by 2002:ac2:5a50:: with SMTP id r16mr26188243lfn.195.1609417432846;
        Thu, 31 Dec 2020 04:23:52 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.115])
        by smtp.gmail.com with ESMTPSA id n10sm428569lji.99.2020.12.31.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:23:52 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] regulator: fix pm8009 bindings on sm8250
Date:   Thu, 31 Dec 2020 15:23:44 +0300
Message-Id: <20201231122348.637917-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


PM8009 has special revision (P=1), which is to be used for sm8250
platform. The major difference is the S2 regulator which supplies 0.95 V
instead of 2.848V. Declare regulators data to be used for this chip
revision. The datasheet calls the chip just pm8009-1, so use the same
name.

