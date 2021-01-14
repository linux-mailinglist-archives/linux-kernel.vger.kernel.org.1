Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9412F5AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 07:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhANG0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 01:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbhANG0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:26:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 130582395B;
        Thu, 14 Jan 2021 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610605567;
        bh=42C0pdj5Y949qvNInjCRVOhKPbX/Y0ICcm1eaq7sGx0=;
        h=From:To:Cc:Subject:Date:From;
        b=KpWxmgAQaWasCB8P/NGyzyeEO0mxJfq+97d0aGBsc8Ka75pqUpwdy6CiB8xbfb2D2
         8TCsZI/UwKSuBo88NvgC7oKlDSExX4i7dQ2SyvRFUBSt4YgjTVCGxqeVPzt5is8t/k
         /lwa/+sMXPWMY+AqFfCkLdDtCJoGrZ/iWOCUzxsty6lsg0c0/DhHKibgAC37e2AsQ4
         NmOLtGKWvRulS7WvlY84ssOW1FUYmDKdnwzB+NBJRh1mOJ/siJr7fErBMbVxN2ZGUi
         6pblfeIdeMEEgKpNVLw4Hqb5z9BKHKSuTtziEpi5lIeHUKHMLC8LJ3aL9vvGR9tmi4
         E0WeU0Sx5BGIQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzw56-00EJ7C-F5; Thu, 14 Jan 2021 07:26:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 0/3] Fix broken  references at next-20210114 due to yaml conversion
Date:   Thu, 14 Jan 2021 07:25:57 +0100
Message-Id: <cover.1610605373.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three new broken references were added between next-20210113 and
next-20210114, due to yaml conversion. 

Address them.

Please add those patches  at the same tree as the respective
conversion changesets were added.

Thanks!
Mauro

Mauro Carvalho Chehab (3):
  dt-bindings: usb: update snps,dwc3.yaml references
  Documentation/devicetree/bindings/usb/dwc3-st.txt: update usb-drd.yaml
    reference
  MAINTAINERS: update mediatek,ufs-phy.yaml reference

 Documentation/devicetree/bindings/usb/dwc3-st.txt    | 4 ++--
 Documentation/devicetree/bindings/usb/exynos-usb.txt | 2 +-
 Documentation/devicetree/bindings/usb/omap-usb.txt   | 2 +-
 MAINTAINERS                                          | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.29.2


