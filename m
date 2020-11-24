Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDF22C300C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbgKXSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:38:29 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:23021 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404163AbgKXSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606243106;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=7NWljRzzkmrr9OZyGcDPIVWrfcx4hneB9sbUTcfLkrQ=;
        b=KwUAXpUYiaDALQoIHEwjpa36DudeHmiV0j+vKgFG67yaxxD8NtYu6CR5y1uWw+1uF/
        mRwjMumh4fEyNnwyI+mMkEu4N22tYkO/BPk5e7O9IgRMkp2IdTSw8+1FjVTOCFoG2zAx
        /CIAoXsyHH0HJcTQxe/z6VQGFr9hxBbaluWjLPpd7C7SJI4IO9M9Wv163PA8wubF03Ba
        rwx/jl3UTjPLzURuoLMIHk1u2oxA1utsT7D+pqVzmoZV4oT1tM5J+Slrgmjiy1/Fwusm
        4LP3SPwjxhL9oGrgYF6WncsW1DmIEAOP6mpFwsCJ1tObjS1fo6HFZ2125ZDo31xhxoIP
        6eDg==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAOIcNFbG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 24 Nov 2020 19:38:23 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1khdCm-0008JG-LE; Tue, 24 Nov 2020 19:38:20 +0100
Received: (nullmailer pid 2250746 invoked by uid 502);
        Tue, 24 Nov 2020 18:38:20 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Michael Klein <michael@fossekall.de>
Subject: [PATCH 0/2] Fix spelling of "regulator"
Date:   Tue, 24 Nov 2020 19:37:28 +0100
Message-Id: <20201124183730.2250690-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Klein (2):
  Documentation: mcp16502-regulator: fix spelling mistake
  mfd: fix spelling mistakes

 .../devicetree/bindings/regulator/mcp16502-regulator.txt      | 2 +-
 drivers/regulator/da9055-regulator.c                          | 4 ++--
 include/linux/mfd/da9055/reg.h                                | 4 ++--
 include/linux/mfd/si476x-core.h                               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.29.2

