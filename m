Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB42EBBFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAFJ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbhAFJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:56:52 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4FC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 01:56:12 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 30so1887932pgr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 01:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDsopHKKF607Xe9UdumCtEOjuD6D8IDJARDfhwx961A=;
        b=UjuHEcbWMscc6ZSzJ7TDd9JJCm9n4VnkUlStwKAOguAfU/sdlDko1X3O+Il4eCep64
         FNMBnXnaqWF67HUYimnCpXImAWJEkzwV+MWbkc17EMYL/ea/G0B7hQKxtdi0sFF/Tj9z
         x1s3BUdje4Kfc+9MTTJJ78IS/4DaKLqeElEJmfF7jxQl0iH1ydnzMOtNc5BcXAx/Jh93
         6LbgWt66T3Y4Rhhp7pHYyArPqqYNwV8Dnqo+HhnJR2q01PGJt0ODj9fZl6aY/jhAOHy+
         ndgOm1QUNwCgNMmYCzipR+WychdTi4aVTigrqsMZlXe77hrmyz0iwJUgvV99SwM9m2gb
         OSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rDsopHKKF607Xe9UdumCtEOjuD6D8IDJARDfhwx961A=;
        b=abYtioZrGm/Qmdh8arKMzzS4I5jgOXlONbkYt6P3yFz4mN6xaBLtfNtKZU4txK61uv
         DvZEHBNYYQUmthIzXoy4bCImVz67h97aF/PoOStifIYfFyCl8l4iKPUV+pVArffcXl43
         vtS9thMlM6+JmaKP4/wr0rjCpLEjbtoZN879ouy6gJIiLS8uqP4o7015eFe+Hse1835G
         XqYCcFIXY2VHLDjom/hv/bWoO1+Z0txe149C02GM3AxKqr7u8kkpF6HpkNDI19T6Sre0
         wGwc5iffAQ09HbTd6FKC6XpGwlUSig8lNOo8khezG40yRnkk3BegnlLbwb/5DFpMZsSH
         sq7w==
X-Gm-Message-State: AOAM5313hdDEREUrQYBrXHHD1FmYSkoJaok5jn7YFxkojocz8KBJCoFv
        nFktUST+Wtyyv+AYMD22EAFhcA==
X-Google-Smtp-Source: ABdhPJyhjklbZ9D8h8V3INNROw/UDmBeF+8wOE+aDWhFonc1dFAFl0LbkZMRp9mJfjLysXE0UYyqiw==
X-Received: by 2002:a65:5244:: with SMTP id q4mr3762581pgp.50.1609926972231;
        Wed, 06 Jan 2021 01:56:12 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id e5sm1963171pfc.76.2021.01.06.01.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 01:56:11 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: [PATCH] dtc: Allow overlays to have .dtbo extension
Date:   Wed,  6 Jan 2021 15:26:08 +0530
Message-Id: <30fd0e5f2156665c713cf191c5fea9a5548360c0.1609926856.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the overlays to have .dtbo extension instead of just .dtb. This
allows them to be identified easily by tools as well as humans.

Allow the dtbo outform in dtc.c for the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
Hello,

This was earlier posted for the Linux Kernel and here is the thread
where Rob gave his feedback:

https://lore.kernel.org/lkml/CAL_Jsq+0dL=LHo8r9mY_weBP_bQ97UOBnt596J3JoVHwGNinHA@mail.gmail.com/
---
 dtc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dtc.c b/dtc.c
index bdb3f5945699..838c5df96c00 100644
--- a/dtc.c
+++ b/dtc.c
@@ -122,6 +122,8 @@ static const char *guess_type_by_name(const char *fname, const char *fallback)
 		return "dts";
 	if (!strcasecmp(s, ".yaml"))
 		return "yaml";
+	if (!strcasecmp(s, ".dtbo"))
+		return "dtb";
 	if (!strcasecmp(s, ".dtb"))
 		return "dtb";
 	return fallback;
@@ -357,6 +359,8 @@ int main(int argc, char *argv[])
 #endif
 	} else if (streq(outform, "dtb")) {
 		dt_to_blob(outf, dti, outversion);
+	} else if (streq(outform, "dtbo")) {
+		dt_to_blob(outf, dti, outversion);
 	} else if (streq(outform, "asm")) {
 		dt_to_asm(outf, dti, outversion);
 	} else if (streq(outform, "null")) {
-- 
2.25.0.rc1.19.g042ed3e048af

