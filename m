Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944AC2B9F8D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgKTBD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKTBD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:03:28 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9AC0613CF;
        Thu, 19 Nov 2020 17:03:28 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id v21so2701868plo.12;
        Thu, 19 Nov 2020 17:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcFqPyelBpW+q1MVwPl/wMjp1ZaAK3VKC/DF+b1t6gY=;
        b=arL66hRrdWpXc64BuKEk42pESDJsNPmZtGA5Lrpb/NQTimzpProSZM4lOj54pIXfnL
         VCNyihIHwMHiedWHlYKoZknLhFDQ08Kp7IXwKZUTS6lVe9OiDWRdl8wzbNnMgt1Y2pu9
         uPiGSqDIOp0Pl2G6E79sW5UVvojd8Ix4xqO5j3octK+TorRs0lxhJ5E9FN/+Yc1apTlu
         xWeMefYeXFVhE0DsFIMRHsn3WhavOg1DOnd+t7dsCHa3ys4qD2baTHhfB7437YJaMiDW
         gZQcFx9b3081K5k78GKfPS3TDufi5b6b/FpA0tE8og06KipF9odcSKDKDspcFY7kOILn
         6mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZcFqPyelBpW+q1MVwPl/wMjp1ZaAK3VKC/DF+b1t6gY=;
        b=Y9Teys4rOoZ6jSpjyzPQzdlqu7DWp/UKoDkyf9Et9A7cEHTXcg2SpEsOek0Z5+HABh
         Xpw+th9cr9BNUnPIvgtzViMBWO9NcpTr2bwzISQAJGGFHg3lwY3hgzmEt2feeZA5R6d+
         b3Hjg0P/JgVGeM/mz16pqrZtHCC5d9ZWwvY1hs9S6VPZ3D8gSTuYNlh3NhFeF1cBI8a3
         j3cgzjKVOygSKJ7NSBNesrSOpSJrXPEcOPIuZ1qG6zwA/nHDwMhdHIVUwGrurHlXz3y9
         34oPyxp3gQw9LRuCxo1Zee5kBFz0vxKKaI8ugbwyjnAV9KMEhT2sTmOPlXw8HWNc/Pbn
         kloQ==
X-Gm-Message-State: AOAM531alJB+3gwunbtxf7U2KVm20T9H8qgNogdHWZeRfMvVm/2FrXek
        niE71YJk8WVWIKPUFA5l7KE=
X-Google-Smtp-Source: ABdhPJzTBo2rpYScILcX37x8woBLO7ZvTZMu/a7ycBuPq6JR3JqxJt5lu+mfo5ofQoEcgTvFYqOyIQ==
X-Received: by 2002:a17:902:164:b029:d6:a42a:a952 with SMTP id 91-20020a1709020164b02900d6a42aa952mr11334120plb.44.1605834206443;
        Thu, 19 Nov 2020 17:03:26 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id q14sm1205273pfl.163.2020.11.19.17.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 17:03:25 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Eddie James <eajames@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 0/3] occ: Add support for P10
Date:   Fri, 20 Nov 2020 11:33:12 +1030
Message-Id: <20201120010315.190737-1-joel@jms.id.au>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, here's v2 of this series on behalf of Eddie. I made the
change to the compatible string that we spoke about in v2, and I'm happy
for these to go through the hwmon tree.

v1: https://lore.kernel.org/linux-hwmon/20200501150833.5251-1-eajames@linux.ibm.com/

The OCC in the P10 has a number of differences from the P9. Add some logic to
handle the differences in accessing the OCC from the service processor, and
support the new temperature sensor type.

Eddie James (3):
  dt-bindings: fsi: Add P10 OCC device documentation
  fsi: occ: Add support for P10
  hwmon: (occ) Add new temperature sensor type

 .../devicetree/bindings/fsi/ibm,p9-occ.txt    |  12 +-
 drivers/fsi/fsi-occ.c                         | 125 +++++++++++++-----
 drivers/hwmon/occ/common.c                    |  75 +++++++++++
 3 files changed, 172 insertions(+), 40 deletions(-)

-- 
2.29.2

