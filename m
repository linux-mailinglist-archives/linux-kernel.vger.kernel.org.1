Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45222FBE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbhASR4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbhASO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:58:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92BC061574;
        Tue, 19 Jan 2021 06:57:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d13so19987301wrc.13;
        Tue, 19 Jan 2021 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S7s1aDdJzIQjumzCvBYrOOcnrCsH9+fQZVg5rQvhpjg=;
        b=QpVvmAtyMBONqrk1J3o1A1o3YCgKKWEmtVeAn5I6zbQExRfwxCB1aP76iMm1tvaKV0
         kSCGfOGdmTvQpm+gek0pJr4Qw54rnBUunT3i/CcxjVlS18BCcXNVt50Go3mImTXxAZjI
         nwFyFLGb+tzkvxcuDWOff+yK5fWUNfEstqNh/8/shTcqEFpVKX62vnFzcZGvfX5+AWJW
         MV7dM/j9Rle19cDTiuH6Wsq1ECFEa9CZqNRu4vKjctpQKhJjAGZ2EgVbskNSyPSKmeBm
         nxKIbIroZJuCNMEdoMeMVKOim3bnEOkQRpqoo63+xNC9mR2WzvN37T0GZuyw9Bc12d/g
         geTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S7s1aDdJzIQjumzCvBYrOOcnrCsH9+fQZVg5rQvhpjg=;
        b=cVfwGzGfD/Nr7C5brbSuXbBo0WLGFCRfz33C19jCi/FAjuksp8lE4fL8l9KdhtM8iY
         xFEHDjCnvoKje63f6mlBwlcBxQDlWawubhmOEwcSYwkqqGNhdwwMp/XeonGL5FLl+PFq
         IXuXjOXjbQxbE8FY0HnZoHG2OycD6IhHioN7xSDnw18jVMENiKYXm2i2HgW+zgajHMGW
         RfcqAtdDsC20Ewk0YQJCFfPcdE8d6Ya6Q0pwPpvN1EwQc/qqVDycX5FaEoi4qoJA+YQl
         Wbll52Ph3d5s/z9ARbhd6par4uCIbPBbi4PcTdrHBHX2nbxnuk975OoYqMkRSXjKSrfC
         eqYg==
X-Gm-Message-State: AOAM530HeuvF+4HL5JLL8nqlwuI0ESOU7yfPTwvHO0m5PvRdK1tn3e6j
        VVacbdUVX4OpjnnrCcdJopk=
X-Google-Smtp-Source: ABdhPJwlVliSnGIRl5fq1VrlSGKf5EfYyoA/cUAaO255OlTrVwFyZS+pvw/KTSyiE5n2JE7dYIKmTQ==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr4875065wrt.246.1611068258821;
        Tue, 19 Jan 2021 06:57:38 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id s1sm36786893wrv.97.2021.01.19.06.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:57:38 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 0/2] arm64: dts: meson: add support for Beelink GS-King-X
Date:   Tue, 19 Jan 2021 14:57:32 +0000
Message-Id: <20210119145734.12675-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds bindings and device-tree for the Beelink (AZW) GS-King-X,
which like GT-King and GT-King Pro is based on the W400 reference design.

Changes since v2:
- shorten audio card name to GSKING-X
- add Neil's tested-by
- add Martin's reviews

Changes since v1:
- move audio from TDM_B to TDM_A
- drop S/PDIF content
- add Rob's bindings ack

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for the Beelink GS-King-X
  arm64: dts: meson: add initial Beelink GS-King-X device-tree

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-gsking-x.dts  | 133 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts

-- 
2.17.1

