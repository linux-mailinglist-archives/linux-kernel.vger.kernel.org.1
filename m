Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101F22AEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 14:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgGWMOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 08:14:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37217 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWMOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:14:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id q6so6076360ljp.4;
        Thu, 23 Jul 2020 05:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=De5ujUjaEtGy1IVbJ3mPu69B3vuyGVhsBXi/4yWBrCQ=;
        b=B4D2DMyx3dGEfJAhrME4U7DpChRGrRW6wWBQ8GGzEtYqHq2Q7J4U1GL+l/enOB/Vzn
         71MhdKMP9sujO6zoXtWunwbXvF6P1khtebouJ7szreAr3hB59rDcyt0xoGyGQAm6MKue
         bCj7aXEdLkxQMZTP/IpQrgUQ72SyIuM2oCIyZ+Wb9mmlQqmArHxruVyFcBP0oE4Hcswe
         6ro6sKWJJi3ukklfdrKLeXN9DTpzrZ9zIl7q9zOmnPIzsbxZiRlh8ZkYMr4G3IAIJVwh
         ThLm5IzX9cLDyHcmDrq8ezpL+P0gVCvvlskj+3PutYyjVxYZ4BoKWEg3sxr2sgITRz4n
         AAiQ==
X-Gm-Message-State: AOAM5321BuheSqqiALATAkBU+CzoqEK8Fia2qXN2ArUzFL3BglagVVuI
        oqvrCRm+JxpAB4nzItMMl5I=
X-Google-Smtp-Source: ABdhPJwVeCeM+oMcVcVcAaL0Apf9n1njpIkpd2GwGhMo1iHD3WZwjv5BcVuQ32s9cliSx1fJI3IvoQ==
X-Received: by 2002:a2e:880c:: with SMTP id x12mr1977174ljh.375.1595506480654;
        Thu, 23 Jul 2020 05:14:40 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y18sm2625557ljn.62.2020.07.23.05.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:14:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1jya7O-0006JQ-9v; Thu, 23 Jul 2020 14:14:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] serial: pmac_zilog: add sparse context annotation
Date:   Thu, 23 Jul 2020 14:14:22 +0200
Message-Id: <20200723121423.24217-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723121423.24217-1-johan@kernel.org>
References: <20200723121423.24217-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sparse context annotation to the receive handler, which releases and
reacquires the port lock, to silence a sparse warning:

	drivers/tty/serial/pmac_zilog.c:255:36: sparse: sparse: context imbalance in 'pmz_receive_chars' - unexpected unlock

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/pmac_zilog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
index ba65a3bbd72a..b0d8f4a6f9b4 100644
--- a/drivers/tty/serial/pmac_zilog.c
+++ b/drivers/tty/serial/pmac_zilog.c
@@ -213,6 +213,7 @@ static void pmz_interrupt_control(struct uart_pmac_port *uap, int enable)
 }
 
 static bool pmz_receive_chars(struct uart_pmac_port *uap)
+	__must_hold(uap->port.lock)
 {
 	struct tty_port *port;
 	unsigned char ch, r1, drop, flag;
-- 
2.26.2

