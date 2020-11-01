Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885242A1E7A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgKAOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 09:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbgKAOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604239897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sIyk7Z/4NPATT4L/LX2Y5gpqyse3pPUcPApM/XM/zvo=;
        b=h3jmcxSxFmakJKg+wCd+r2TcKiBKcDO5yvrul37slq0ZW5R4i1uohHq9jhK5CBJpOhooEB
        m6EV/foSLZDs21G+vMuF8XyGLMm/T1GnKUXDsp5ax6I8qsQ0K61peacrCYdGE1gSNNkgO3
        R8JuhxqgmW6Bx6h9X2cXSoFaMTWEM30=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-IgwWj_6cOVmxOiP3Xf0phA-1; Sun, 01 Nov 2020 09:11:35 -0500
X-MC-Unique: IgwWj_6cOVmxOiP3Xf0phA-1
Received: by mail-oi1-f198.google.com with SMTP id g187so4582503oib.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 06:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sIyk7Z/4NPATT4L/LX2Y5gpqyse3pPUcPApM/XM/zvo=;
        b=PblwcP1jx3P8No5Ll3W8nDA687pmTb4El9xK+TGIujucgYSr2GhdubgGKrk+zAABpr
         phwyFGPoiGaDSiMkfQX7bOILDKGxblzWvfAtRt6rZwCh0jiMfBcSRRzD2rCKqxpjzbdF
         ly9p92HUCI/AE7qN9kxv4RGEVNWkr9e3YWdg5mEuHgAMzrmStBd5zpu9eC8jMGQsZzwa
         IFEoO00kCmTC7sGEtBzBheQJBKkCgy5yqVFVIQomiPRtki1Xw4x6qVzakR3p+z8hAEPO
         RNO5wl45U4QXfGXRASA1+NFUjinrC84d2ZIvgXotx6GLXBvHGedf2Ge5m4TSZdSVhS0O
         ZawA==
X-Gm-Message-State: AOAM532+A7Xo1DCOUHeLk6JuHiNdr8yqU9q/zTlVU11dABLiVlB+rThU
        X3rzR8GnQcGzZmIy0ykZUWqvZZRCUACXH5XymAwNLJG6qlmJoIoe9yNrmc+UA4sOt7bNiWBmHAt
        qYsbLQrQzaCpGEwqvqpH1FWwl
X-Received: by 2002:a9d:7505:: with SMTP id r5mr2592996otk.64.1604239894541;
        Sun, 01 Nov 2020 06:11:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUSjuZ0Qnvh2QaYVQYJ/+PNtONAzdv5wxwEbdXjZqg59Rvus/EwGHHO9o2uBHFGMtvGnwmEw==
X-Received: by 2002:a9d:7505:: with SMTP id r5mr2592986otk.64.1604239894382;
        Sun, 01 Nov 2020 06:11:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s20sm2844146oof.39.2020.11.01.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 06:11:33 -0800 (PST)
From:   trix@redhat.com
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] powercap/intel_rapl: remove unneeded semicolon
Date:   Sun,  1 Nov 2020 06:11:29 -0800
Message-Id: <20201101141129.2280794-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/powercap/intel_rapl_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 983d75bd5bd1..020373d6d3f1 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -613,7 +613,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	case ARBITRARY_UNIT:
 	default:
 		return value;
-	};
+	}
 
 	if (to_raw)
 		return div64_u64(value, units) * scale;
-- 
2.18.1

