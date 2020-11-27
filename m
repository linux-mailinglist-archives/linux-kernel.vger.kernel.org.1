Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7A2C6312
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgK0K2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK0K2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:28:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86C2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so5022549wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsJWTmhcStBoXhNaXWCuO3ZKkcsTg4n7vfe9rkQwzs4=;
        b=EYyZkPDQ78214aAbWF8wthkUJyb9e0RtOVJpxZ45fkLW+xk9engDG2N2EgsPGLDh2f
         1xk6FKX92T7Z95bQ5UTR/i7L5nOHFHas8xrBhMDhKe6tKKOjTaOjsK2SGiLJHWqAfT1x
         Cabh6Eh8bUsheAEmGDldZuD4Y9DzoPLKzjkIobbabJT/DmIYV7wyx1z4tjPZduAYDcBJ
         6goDxkfqUTfIo8K+QW3LWFkBTOAaXqd7IKheO9ZBSOmJEpwESzNonL6oX4Jaz397JnEP
         mvps2SK2p+XtptMT4d9BIseYYZoPTE/XTK2tahNEd1tUAVNXVzYAxgAjSGh7JPvcfQUw
         f4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OsJWTmhcStBoXhNaXWCuO3ZKkcsTg4n7vfe9rkQwzs4=;
        b=Xzc9dEnzKGfcogJspip/zZ8Xt6+EYUxCOQRhJ42i80lNh9Mo5aN2K0OoJyFQXEHl/v
         +0Qdm7X3BIhi8ehzX6gqs2k1Agh9HXvcZjy/EoA0yn1nhDNfxZn0UIlQUtnEedDMbWKg
         MYPOegVLxP7G+zilfBVTOgLwy/BQAb0ls7RhdJx5Fydtj9oyVFr9vQClH2Q4T3ucp6KH
         h0TsECMb7h8dpQT1Z/y31mQqANMEfoYSFRVfUfyXVtS7Vx8+Jxif8IR/ZM1kFBcnTK6b
         0A23sIjrB1VyNg0AT67BB+oiYF/nEpMmlMBgG1QmVYlqvXCXFS7rs275pTYSMDo7UCG5
         mMgA==
X-Gm-Message-State: AOAM531YgbXh2vEFVnAlKzR+cErV8cGRM5fO5E5kww2kG3OORa4zGAXR
        /a9ElG+6pbh4lsI7HeIFVO9iyA==
X-Google-Smtp-Source: ABdhPJy3K3Q0zghD/5VvuKJb5c54xDk/4oISmToLCZ9j7Y7Txze7DYkV6gJPtbIW+cMbelEPHBQKeQ==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr9736131wrn.146.1606472924484;
        Fri, 27 Nov 2020 02:28:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d8sm14073051wrp.44.2020.11.27.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:28:43 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/5] nvmem: patches (set 1) for 5.11
Date:   Fri, 27 Nov 2020 10:28:32 +0000
Message-Id: <20201127102837.19366-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches for 5.11 which includes
- adding support to keepout regions in nvmem core
- support for unaligned word count in imx provider
- imx and qfprom new compatible strings.

Can you please queue them up for 5.11.

thanks for you help,
srini

Evan Green (3):
  nvmem: core: Add support for keepout regions
  dt-bindings: nvmem: Add soc qfprom compatible strings
  nvmem: qfprom: Don't touch certain fuses

Fabien Parent (1):
  dt-bindings: nvmem: mtk-efuse: add documentation for MT8516 SoC

Peng Fan (1):
  nvmem: imx-ocotp: add support for the unaliged word count

 .../devicetree/bindings/nvmem/mtk-efuse.txt   |   1 +
 .../bindings/nvmem/qcom,qfprom.yaml           |  17 +-
 drivers/nvmem/core.c                          | 153 +++++++++++++++++-
 drivers/nvmem/imx-ocotp.c                     |  30 +++-
 drivers/nvmem/qfprom.c                        |  30 ++++
 include/linux/nvmem-provider.h                |  17 ++
 6 files changed, 235 insertions(+), 13 deletions(-)

-- 
2.21.0

