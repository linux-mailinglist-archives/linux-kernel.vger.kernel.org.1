Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0042719C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 06:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgIUEOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 00:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUEOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 00:14:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51397C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:14:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so8138795pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwg8LWIc3FOEv4vf98tTvij6EQc2P2olbL/FuLZBLvU=;
        b=DalDOMV9eAvziC3M4KHRnCraZ01q5IQDSS6EJzA6aehQh6lYde84GeEsi7UdhUORg4
         kMVHCFhWw08+QdHcpZySXUuUob0g6DwwPEqQgwI8cSY7/jjw8awbaRDVhxM0tJDHrhyb
         1d7KUQDNZs9zsJKSLo9eKMVF9I3ZxaROklmGZpW4z4wwyZFQTGZtUCw/uSWM0wyfMHVn
         I70ST1zsW0C8ij7KXIGB0jU579/PMA0/nU2Z5st5EHr6/loyvVl961yNBXd/jLatMbb4
         EjWM8voSWt36AnxPWw+mMqExGaOtHm4xO/pKUe45bi1nJgb2rN56nBYxmZoHbx4pw0CL
         D7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwg8LWIc3FOEv4vf98tTvij6EQc2P2olbL/FuLZBLvU=;
        b=PG7kAhbRhmtsziH7UKacLZO0NHz/Lfg7U8z3HQoVwKI9cjousg4lyFFNOOHqxoSAF2
         DZG+6c6hToLDKw/MqEmnm89v9GucFaA73tx9DBdMS6RNpiKa/NXblLQprS+8xPXR99X/
         cuGYewpkETul9u6dXQA7F6oOF5g+vGYv5qoNw21jcaPBlYDZqO+igD9Leh7+DHbQ0BjG
         bmtZb/cwS+JYAiQvjIqkwde7SiOkm/L6ih/NR7aidAAOJHgUjijYlwx8w7ZIobsc7WQe
         HmTEcx0SQ+OercGTT4ixnDuq/gTnmKIk69vECVoxSafyCTlu2CS3aV5Lf3+rT2F5oqmg
         SZow==
X-Gm-Message-State: AOAM533jl8YVhV3RlBwWiA1okIJ/dQngT93bf7//LMqqp+I9qN8gUtL4
        LwMYYNveDMH5oixH9A8qj+0=
X-Google-Smtp-Source: ABdhPJwFBcq9+/Sf4/rZ/Q8b9BNuG/dAQ7ENb+cDMqQ53zomm7Sx8ktf1dDzvf7tQTRJF+aFwNFWeg==
X-Received: by 2002:a62:be0f:0:b029:142:2501:39f0 with SMTP id l15-20020a62be0f0000b0290142250139f0mr26132983pff.63.1600661641883;
        Sun, 20 Sep 2020 21:14:01 -0700 (PDT)
Received: from james-Aspire-E5-575G.hsd1.wa.comcast.net (c-71-231-36-179.hsd1.wa.comcast.net. [71.231.36.179])
        by smtp.googlemail.com with ESMTPSA id u14sm10281689pfm.80.2020.09.20.21.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 21:14:01 -0700 (PDT)
From:   James Browning <jamesbrowning137@gmail.com>
Cc:     James Browning <jamesbrowning137@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drivers:staging:comedi:comedi.h Fixed typo in comment
Date:   Sun, 20 Sep 2020 21:13:39 -0700
Message-Id: <20200921041341.7210-1-jamesbrowning137@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed repeated "the".

Signed-off-by: James Browning <jamesbrowning137@gmail.com>
---
 drivers/staging/comedi/comedi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index 09a940066c0e..3bc74bea830d 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -680,7 +680,7 @@ struct comedi_rangeinfo {
  * value of 1 volt.
  *
  * The only defined flag value is %RF_EXTERNAL (%0x100), indicating that the
- * the range needs to be multiplied by an external reference.
+ * range needs to be multiplied by an external reference.
  */
 struct comedi_krange {
 	int min;
-- 
2.25.1

