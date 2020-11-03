Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6542A410E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgKCKAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:00:33 -0500
Received: from smtp2.axis.com ([195.60.68.18]:17889 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbgKCKAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:00:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=805; q=dns/txt; s=axis-central1;
  t=1604397630; x=1635933630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RjKhKTGDdy/LlX00sdREDURXzOpCgHn5INCOvYAsuok=;
  b=UHXlyJ8NPgODxUVpsH8ut2mXRC5EzMNEUPZQEJeQnSZbMnd2GPPNt/Yx
   ib75ehnkiUtbuvIe+LMxs/hoisMs6qjiCQDSWXS2VPH3a6RpWM3/niCjB
   mDjC3CY0JZQEKbUTPMfypMngx0Zwvv9b4eq/lFcIHOCn3U9I/q1dEsIs5
   qvpru/SoppbQTbZNOFh75enmWYh6PvCpZvKmxsdUSnqiNNoXJZrexakmb
   +eCLM66Xm6d35HWCtSJcpw2Adf64JDnUGrFf1QhoaupjFijJ3UYCVPtvl
   kZzE7ZYwrgCW9xoMR7wdZyvDi3hzY70ESfMLeyE9LOfXalJruBmbVuhhk
   g==;
IronPort-SDR: GJfLfB8+0iiAIqiry2sqhWaJWMGpWZZpjlYGFm9Pgb2s8rXpVtai1RhzSlOveVh4bQJmVW8UER
 dzhHyK8DZr6E85dQC7JXtu4tcDU11lo6D4mCwUeko0OLwBaDtCwd1viH3FnhQn8RkKaPJhJsn2
 6/OWph9VTXMt2ARap3odttkOo6dFMLNBcMsRY7IvbvPrhKfgZbKjtrFxH4xWZWqiwl2MWXx5Po
 OxcIkvrWwQ+XkxdvYt8tgJzBhs3scf9Lrl8a/Mq4gdRr/lXSSN9+HVSlpv6DDTHmvqB75djEKN
 NEo=
X-IronPort-AV: E=Sophos;i="5.77,447,1596492000"; 
   d="scan'208";a="14164800"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <support.opensource@diasemi.com>
CC:     <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 0/2] DA9121 regulator support
Date:   Tue, 3 Nov 2020 11:00:19 +0100
Message-ID: <20201103100021.19603-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the DA9121, a "High-Performance, 10 A, Dual-Phase
DC-DC Converter".  The datasheet is currently available here:

 https://www.dialog-semiconductor.com/sites/default/files/da9121_datasheet_2v3.pdf

v2:
- Let the core get the constraints itself from a subnode in the device tree.

Vincent Whitchurch (2):
  dt-bindings: regulator: Add DA9121
  regulator: Add support for DA9121 regulator

 .../bindings/regulator/dlg,da9121.yaml        |  47 ++++++++
 drivers/regulator/Kconfig                     |  12 ++
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/da9121-regulator.c          | 108 ++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
 create mode 100644 drivers/regulator/da9121-regulator.c

-- 
2.28.0

