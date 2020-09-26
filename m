Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69260279B16
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgIZRBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZRBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:01:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89AC0613CE;
        Sat, 26 Sep 2020 10:01:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id e23so2813199eja.3;
        Sat, 26 Sep 2020 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=Jt8GccEnjq1iGwDCAIard4XMHgfmZQ7MJ7ku4c4id5Q=;
        b=oTYsBQ2lajSe8mxBNlatgPAwZgxPzkDW/f1s9lSDbl8Rf/UMktz1W0ygjeB5S4NTM2
         S2p4j2Dt9tV0BXzu/MQzAlW9+nBKnUV4dz63rrxJUUkZywoLFY2LDmbQwHnKFaMgW0f+
         LIfX9wBTX0eiMIZgp9syKPU9YZvmuiP88C+xleDm4btd4iFX9qZrUYJ0iC0sY/94jS9A
         oVtXre2b4bmlLH+i9dlvCTj20hMA6XY+UkWCOm62OS66Lq6Bglx5TD5K0Ji/KplfC2z2
         xDmI/hgWPa0gfoNAaHGk2jRXi94O9KICYm1pEFe5vTdhNqF/iNVgYjx0fAh7mFQhWvuu
         MNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Jt8GccEnjq1iGwDCAIard4XMHgfmZQ7MJ7ku4c4id5Q=;
        b=HAX/yml1K0RZNJ0FHUJBi2+9nqBxkzLPjh9W6GmrGuQz3T0qmfS5Vu4Ytwrua4rI2W
         SX1WDpFOluG3Gg5x8YT5qQY6dwkUR5lYkbY0LsifeHSvY8jgImyhJ9BOJnqPe0E3wJu9
         DU8OoveytKDeS3XjX4PkKdrNBWNFAxS4mosE2dVpr44VGTeAIQQLRTkw6JvgAbKzVbV6
         CI3iBrWTA7Q7Ym7LdfF6TZktl2mM2XC/Dm0eh0mGB/wZIvcbkARpOx/OURdSkaNkSlrG
         e8L2whoV8FuP+0mHxuF2EI9PPyjRt22r4Fowa9+nl3qaLd04rEj2fEHOv6IExvHlmrZO
         Qjvg==
X-Gm-Message-State: AOAM533SOS25nrt7hsNBr9W/p+QWsYN54m/1+18r813kWIjtNgKZC02S
        cr6JZamMopxhZsnwgyZpljw=
X-Google-Smtp-Source: ABdhPJyvnq26+Osyszon1/5y4kE4IL1r1Jx8cTPZL0t2ZczE/RIGdAomLjAXX1/ER4U6SAbeZ90GJw==
X-Received: by 2002:a17:906:249b:: with SMTP id e27mr8031434ejb.105.1601139700052;
        Sat, 26 Sep 2020 10:01:40 -0700 (PDT)
Received: from felia ([2001:16b8:2daa:2000:7547:ca13:c101:33d2])
        by smtp.gmail.com with ESMTPSA id a26sm4383926ejk.66.2020.09.26.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:01:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sat, 26 Sep 2020 19:01:32 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: License clarification of sound/soc/qcom/qdsp6/q6afe-clocks.c
Message-ID: <alpine.DEB.2.21.2009261855280.31589@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Srinivas,

with commit 520a1c396d19 ("ASoC: q6afe-clocks: add q6afe clock 
controller"), you have added the file sound/soc/qcom/qdsp6/q6afe-clocks.c 
with the SPDX-License-Identifier: GPL-1.0.

The use of 'GPL-1.0 only' is strongly not recommended as the Usage-Guide 
in ./LICENSES/deprecated/GPL-1.0 points out:

  The GNU General Public License (GPL) version 1 should not be used in new
  code. For existing kernel code the 'or any later version' option is
  required to be compatible with the general license of the project: GPLv2.

At the end of the file, you further state it licensed with GPL-2.0 with 
the following line:

MODULE_LICENSE("GPL v2");

So, is this just a typo in the SPDX-License-Identifier or do you really 
intend to license this file under GPL-1.0 only?


Best regards,

Lukas
