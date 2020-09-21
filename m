Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFD2719C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 06:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIUEPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 00:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIUEPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 00:15:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93702C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:15:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so3345488pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 21:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMpd2iuQd7osjXvfgkBPJ2IsgF9Xf109kaUhH0GQtT8=;
        b=C44FnCdZfLj1icPeqExYE27n9tFJofco5mqWOXrUqnjmOeV6+2uUKyuZWIDd04H9cy
         icoIQueS9Fa80ikRnN7zutEf14HXA/455FDl5/LVduDXymJdn50lsHf0/TBwkz4Y0UsI
         V3NJn/mCK24AEDmWuOVWPZ4SoO370ll9Ej8aDjSfIRGW0y+mRkHE2BIDzXeXDRGDT4sd
         qq5PDKl0L8MCu6V8OQIeXVe//m9THfi8MTAjxIKBQtcgo1McCBwr0wqii4FvEY6emzcT
         aFhfoPkXHKtoSLAxT0tL9hyOfktGXI2gh15gkdRdC4g4Xbm8Zr00UmXHrcVqrVDSeRhy
         ozew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMpd2iuQd7osjXvfgkBPJ2IsgF9Xf109kaUhH0GQtT8=;
        b=T082V5AxYHx7430F+zJABUErBPi1ZgQlIAgcO5ayqgfSP4ja29nhnx+wplQnz0mMt1
         XTqxugKvtW6AlUXuu63y5BOw17C1PpDhG3dMoga6UFMjhuCF30B7as0jQjfhppZP+9gc
         Z365rYwt6QJjsW+Kjnod9Ye9selqSE49URxo3v23+Zefrn7T/UkdHNCOhGmg3rRUvijZ
         iunI2cpQ9Wcmr7qWFtBalhrJubtd2au0pprU4Ygz2YNCsEcQR2VWG7oR5TOPsxBdylGV
         zPn24oAp4JgF6qfYiVQeIbOJbhfGpFM8bingFOx5WD1vMxW6kd5bjAr5nC4a+zejL+H8
         xSmg==
X-Gm-Message-State: AOAM532RGHml6chQXysB7gjP+uvgGfONXAGCoNc17yS/rDJjNycVo584
        tygEOa7oQC3BzjY+iDmIcOg9W6w8zcO66LRa
X-Google-Smtp-Source: ABdhPJx17/1CADJbOaVVfJ7q+xbeT9muFWV/0J39iH7BCffiPIMpuBGC+mKOq90lKXIeLKYzoPEXtg==
X-Received: by 2002:a63:c64c:: with SMTP id x12mr309522pgg.138.1600661724156;
        Sun, 20 Sep 2020 21:15:24 -0700 (PDT)
Received: from james-Aspire-E5-575G.hsd1.wa.comcast.net (c-71-231-36-179.hsd1.wa.comcast.net. [71.231.36.179])
        by smtp.googlemail.com with ESMTPSA id s24sm8926823pjp.53.2020.09.20.21.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 21:15:23 -0700 (PDT)
From:   James Browning <jamesbrowning137@gmail.com>
Cc:     James Browning <jamesbrowning137@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers:staging:comedi:comedi.h Fixed typo in comment
Date:   Sun, 20 Sep 2020 21:14:49 -0700
Message-Id: <20200921041452.7293-1-jamesbrowning137@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed repeated word "in"

Signed-off-by: James Browning <jamesbrowning137@gmail.com>
---
 drivers/staging/comedi/comedi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index 3bc74bea830d..b5d00a006dbb 100644
--- a/drivers/staging/comedi/comedi.h
+++ b/drivers/staging/comedi/comedi.h
@@ -970,7 +970,7 @@ enum i8254_mode {
  *   major reasons exist why this caused major confusion for users:
  *   1) The register values are _NOT_ in user documentation, but rather in
  *     arcane locations, such as a few register programming manuals that are
- *     increasingly hard to find and the NI MHDDK (comments in in example code).
+ *     increasingly hard to find and the NI MHDDK (comments in example code).
  *     There is no one place to find the various valid values of the registers.
  *   2) The register values are _NOT_ completely consistent.  There is no way to
  *     gain any sense of intuition of which values, or even enums one should use
-- 
2.25.1

