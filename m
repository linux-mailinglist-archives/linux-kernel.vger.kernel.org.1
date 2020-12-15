Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A552DB358
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgLOSKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730483AbgLOSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:09:49 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C8C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:09:09 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id w1so24369488ejf.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=B6qNOoqltxeloTXeSJiHEsnoejIa/iODS20XwCdkukE=;
        b=I06WjCTXP6nt0NcJ4l9hrmmdC4x5Wr3mD7g/3+g47lfmJROVVwEqeSAEdsgVyJGHHI
         Joq9c5J2ASwOvmK4fiiXF75pCyJOBnQLfppU3RuX0fNdixt8ycqBEZHd/c5qJWz4nX0Q
         EDvPaZkFNo+g6+4Vo7ksT55RaAahBTObBDJZdsX6lGM+H9c8bCnzDDiRcQ4ODHwR6R0v
         pnnCXmUG7PP3L09bd4VyyOvk7BRIuylgd6muDn4XC/HndhFZme50cP9Ur4gkg0qgXDq8
         GAsbP8eLfJkX3ur0v9XMU0qDL91hS5HjE9f5zTlWscdZST7f9pEqNSv/UsdBbkaPcQ9h
         rMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=B6qNOoqltxeloTXeSJiHEsnoejIa/iODS20XwCdkukE=;
        b=buTyxGV7FHd8QqcKBdyi3hJxcXUAnCNlrW8EF3Rc8oS6L6jpNkkl2kYlXDhVKLNmVB
         tRLqDjFWgcsYmnyYC7cluzEAjOdGXauGDwF5iwdP+BqVN2z5VeEoehj9hhQrLBnBO8rO
         irBGURs0sr+Kj5vh63wuj70kILbBG8ZeKyjdl+eJ05MMg+dCwV4Bu1mGhRevdhHjA1HD
         nqw9f/33wM2iFbYaGJ+yei+uFnCps8k5jQX7uWpiwwBrv3V+5VtwFXdkVYTd20+tvxHD
         X2Yx0Ov4EfnYK3O8GLd/UJHB/uxMDW35neBTcWRVTHat9DLYa83qu8VxN+m4Bkar8h6Y
         /qPQ==
X-Gm-Message-State: AOAM530eIfF6Shj5eBOLd2bopnFDOrvJn6UfcdmiFvHHwIEJYmeDn20n
        OwMhec31rELO74kpRXUA4mQ=
X-Google-Smtp-Source: ABdhPJz2IO79O71SXC9aCfFIDMOxVeNrshREHXMOkjWqAkXsEWBqIPfft4fwsgVURupKoiNMMTxNVA==
X-Received: by 2002:a17:906:4304:: with SMTP id j4mr27386530ejm.304.1608055748031;
        Tue, 15 Dec 2020 10:09:08 -0800 (PST)
Received: from ryzen.localdomain (89-212-27-98.dynamic.t-2.net. [89.212.27.98])
        by smtp.gmail.com with ESMTPSA id n2sm1924842ejj.24.2020.12.15.10.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:09:07 -0800 (PST)
Date:   Tue, 15 Dec 2020 19:09:05 +0100
From:   Amadej Kastelic <amadejkastelic7@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/01] Add VID to support native DSD reproduction on FiiO
 devices.
Message-ID: <X9j7wdXSr4XyK7Bd@ryzen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message-Id: <c759bc50134ea434bfed0a183e0ce72984f5b609.camel@gmail.com>

Add VID to support native DSD reproduction on FiiO devices.

Tested-by: Amadej Kastelic <amadejkastelic7@gmail.com>
Signed-off-by: Emilio Moretti <emilio.moretti@gmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 349e1e52996d..f5fc65aef628 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1658,6 +1658,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case 0x25ce:  /* Mytek devices */
 	case 0x278b:  /* Rotel? */
 	case 0x292b:  /* Gustard/Ess based devices */
+	case 0x2972:  /* FiiO devices */
 	case 0x2ab6:  /* T+A devices */
 	case 0x3842:  /* EVGA */
 	case 0xc502:  /* HiBy devices */
--
2.20.1
