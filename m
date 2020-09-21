Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3F271A64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 07:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIUFah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 01:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUFah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 01:30:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0EBC061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:30:37 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so6532759pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qj9PyCzhSHC6kaHgqz3Zpf6fqZ3au7JN7Je5cZmsugg=;
        b=LuNkfazDZtt3eVNFmfepYHcgt4usFSxYMzkGnDNxzwPJX88lgbHhRVmBuHVAJLalTZ
         SflpKQISWqhiFBtEtxv5lMf1Y2ophHv4pdKKuPUhG3efBZgI2/oEkZ931uRwgh5DW9dE
         44ZHwKnSLeOIB24e+zWDpBNdvtTqiLlTdKlrzdsWMWdL5bwZxoLuBSTQmbyNXDyKEqHs
         SF0XohbekIhTH06mLP1Qn02oO0xk5KHMXid8IqAqH/gZR10L1WFQJrkzj+YI9Z0fPSAb
         sVeNgWU56Joih14uKlDcwdOxeBEFeLxP4fh+Z+2eXWNxUsxH91Si88N6KvUz+Zh3+3qF
         Ncrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qj9PyCzhSHC6kaHgqz3Zpf6fqZ3au7JN7Je5cZmsugg=;
        b=eRo8B7l7TcbTu9gQM1KhpN15aZp+WN+B2N+V/oSBva6zw41a7G+L1y6/Z4nYa1Idmv
         ioM28ZHJKZbE1qoQa6jNzAZc+40cQt7ELH5O0/k/B5/06wKgcVkdo1TN5LSIqNHrS+xc
         83jtNJvMPVK0a4dCfccvx6e2un0xVj+6U9pNvdgCdNVWwp7UZwAeV5aArI7s2ku3oPkI
         OHbyZTalPSdPxTIPxUwpfsnIvTSSvg6VNPCNZMXN7mDQEdItlcurjRSNms55gtu3903V
         l6VHHsVxRfn3slSJF/ZgWMJxXk+L22zBUpAbAbx1e9oR1e7YXvgTrNXR+IjszKSgqXpU
         i/WA==
X-Gm-Message-State: AOAM532+sd4SShqhSCgifMZ3jv/r8Gs+gOPXmljbpaf7xU/mQYB4lWzx
        YYeTt6uFiF7IC4RlkcZukEA=
X-Google-Smtp-Source: ABdhPJztPjU1aIaxAfOPn2XAotl3oNSzV6uLf5VD4H+XhR728IPGnSHAmcPEEP/KwfFLu9iCMwiPEA==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr24461707pjy.172.1600666236667;
        Sun, 20 Sep 2020 22:30:36 -0700 (PDT)
Received: from james-Aspire-E5-575G.hsd1.wa.comcast.net (c-71-231-36-179.hsd1.wa.comcast.net. [71.231.36.179])
        by smtp.googlemail.com with ESMTPSA id y6sm9427235pji.1.2020.09.20.22.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 22:30:36 -0700 (PDT)
From:   James Browning <jamesbrowning137@gmail.com>
Cc:     James Browning <jamesbrowning137@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers:staging:comedi:comedi.h: Fixed typos in comments
Date:   Sun, 20 Sep 2020 22:30:00 -0700
Message-Id: <20200921053018.64095-1-jamesbrowning137@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed repeated words "the" and "in"

Signed-off-by: James Browning <jamesbrowning137@gmail.com>
---
 drivers/staging/comedi/comedi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
index 09a940066c0e..b5d00a006dbb 100644
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

