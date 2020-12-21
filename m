Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB72DFDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgLUQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39997 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgLUQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608566591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vy2TADSbUuu9/F3d6TvrBXR8l6iJyutu/ClaiwDiIeo=;
        b=MmP9AN9U1nMCYNPeKOAboirC/MzqIc/rqB3i1R0gNChoKg8XCPJfl+rNnkdokZo2TVDXlB
        58Z3/8cYEOkAijc9ceZqCtJ2/8ULgp2eFQcxRZtI+P/bBrskTZAmCUhOCQz43K1Uwwks5Z
        8uzXgzhFKHOyghWL7kxntv3Lblzn2tY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-IF8FieCiMeqEotF50QsSUQ-1; Mon, 21 Dec 2020 11:03:08 -0500
X-MC-Unique: IF8FieCiMeqEotF50QsSUQ-1
Received: by mail-oi1-f197.google.com with SMTP id l9so5637592oih.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy2TADSbUuu9/F3d6TvrBXR8l6iJyutu/ClaiwDiIeo=;
        b=dpME6G8p7f8fYCWSDaF8vL36IVhXsAwf0IzvcW67ko6edIpOKmtSSeX1TiXlJ8XKzY
         RWznQuPTR9BeCh2ERVA5ZMMAqB/8KVdtrXFE5t61D9l8ug322os5I/xxcHMEyKsTb6KO
         JrCp+eM6jSredviXi8A/+w/RZV8R6F3Dr4Dv8ALeupnY7IZXKOdCtZZgyFOT4o6ud0NH
         bGYpgrMN8ZafMoJcxjQ/HNDzCet4bTPboYyfrrbztQ5yYCOSc8j2TxoZ7VqcWMDFRSMn
         SVmp5LutY/GNNdaP3+2J3nKkHf9/RwFwqf4yHxqIQosAIecCR03UFH83vfF6pBiyIUGY
         Xywg==
X-Gm-Message-State: AOAM5309h8WkFM6NfwauM/1XHgub/oWfVglQvq6UIpFAcmIXAwfCnbWB
        HZGyKtuYUHQYyvcllMsGIFMvZZCvYxSoyErXs0DFcKBVlpJfmDyBL3+k6Tp2EZ1Fh1hBkkALChk
        CEsd7J3gpsc/Dl8jK4mxDM5H9
X-Received: by 2002:a54:448f:: with SMTP id v15mr11683557oiv.106.1608566587620;
        Mon, 21 Dec 2020 08:03:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi/FAKLZdRWZAD+hmgdadkXialWoTax/uzPy2j7itrqWN/sCzu+29sZhmCqHiBE43NH8WDLQ==
X-Received: by 2002:a54:448f:: with SMTP id v15mr11683550oiv.106.1608566587519;
        Mon, 21 Dec 2020 08:03:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 126sm1791340oop.30.2020.12.21.08.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 08:03:06 -0800 (PST)
From:   trix@redhat.com
To:     rafael.j.wysocki@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] PNP: add printf attribute to log function
Date:   Mon, 21 Dec 2020 08:03:02 -0800
Message-Id: <20201221160302.3752887-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Attributing the function allows the compiler to more thoroughly
check the use of the function with -Wformat and similar flags.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/pnp/interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 187e4a1175b0..602c46893e83 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -33,6 +33,7 @@ struct pnp_info_buffer {
 
 typedef struct pnp_info_buffer pnp_info_buffer_t;
 
+__printf(2, 3)
 static int pnp_printf(pnp_info_buffer_t * buffer, char *fmt, ...)
 {
 	va_list args;
-- 
2.27.0

