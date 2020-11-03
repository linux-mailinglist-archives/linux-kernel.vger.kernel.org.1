Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C692A574A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbgKCVlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:41:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37176 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgKCVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:41:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id w1so20030347wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 13:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m4raXNcKMqgl6WmEQ4Blg2l4ucQHWNCBFrrf3NpZCXk=;
        b=L8lB5yZkEeuHiQQ2F2KznvRomC9yd/hr/U0dxC1WszCfyPLsPr7WIV4bNVlWpZOo8O
         yixEJJotYx4/2W1v6Iqv+5HplS0A+qnaT8+j9q4SjDQ6CKc+iR0ZxTAsLOxcgZMNUgHV
         kkj0jfaPeO4uw9CT4ydwPSqoykItlb0pskjPk1eFDRZqndHbHwrZ1kPSSuB8KjAyV9vp
         on91+7/LTAgNF8uLmplUFi8oLB9AhhAZhHmWYXYps4L/VzhLGxjZzH/KJu0F8EK20In7
         oJv74V9KmqkY4pGTzB2b3qDsuHHusARnMHzxwBDlLl4MpZxs7K7+ehrwz39HZ2vnbVIk
         bndg==
X-Gm-Message-State: AOAM5334QBne1qDEsM6Pk2k3RwsnQMxCPCOV9KsF0VlhpV6LIqy7LIgl
        SBZaLC4k8SUUN12DZMuSr/5k9Xykzq6NrIRq
X-Google-Smtp-Source: ABdhPJzUAlknIbdAwlcuK4WZxTsbTJUllB4XDCuBJ9G8zbv5Kyj+lbGc2kSw7DyYWufWur/GOskSmQ==
X-Received: by 2002:adf:9b8e:: with SMTP id d14mr30092484wrc.360.1604439670268;
        Tue, 03 Nov 2020 13:41:10 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-5-95-179-145.cust.vodafonedsl.it. [5.95.179.145])
        by smtp.gmail.com with ESMTPSA id o63sm84450wmo.2.2020.11.03.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:41:09 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/3] reboot: refactor and comment the cpu selection code
Date:   Tue,  3 Nov 2020 22:40:25 +0100
Message-Id: <20201103214025.116799-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103214025.116799-1-mcroce@linux.microsoft.com>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Small improvements to the code, without changing the way it works:
- use a local variable, to avoid a small time lapse where reboot_cpu
  can have an invalid value
- comment the code which is not easy to understand at a glance
- merge two identical code blocks into one
- replace pointer arithmetics with equivalent array syntax

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 kernel/reboot.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index af6f23d8bea1..dd483bde932b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -551,20 +551,24 @@ static int __init reboot_setup(char *str)
 			break;
 
 		case 's':
-			if (isdigit(*(str+1)))
-				reboot_cpu = simple_strtoul(str+1, NULL, 0);
-			else if (str[1] == 'm' && str[2] == 'p' &&
-							isdigit(*(str+3)))
-				reboot_cpu = simple_strtoul(str+3, NULL, 0);
-			else
+			/*
+			 * reboot_cpu is s[mp]#### with #### being the processor
+			 * to be used for rebooting. Skip 's' or 'smp' prefix.
+			 */
+			str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
+
+			if (isdigit(str[0])) {
+				int cpu = simple_strtoul(str, NULL, 0);
+
+				if (cpu >= num_possible_cpus()) {
+					pr_err("Ignoring the CPU number in reboot= option. "
+					"CPU %d exceeds possible cpu number %d\n",
+					cpu, num_possible_cpus());
+					break;
+				}
+				reboot_cpu = cpu;
+			} else
 				*mode = REBOOT_SOFT;
-			if (reboot_cpu >= num_possible_cpus()) {
-				pr_err("Ignoring the CPU number in reboot= option. "
-				       "CPU %d exceeds possible cpu number %d\n",
-				       reboot_cpu, num_possible_cpus());
-				reboot_cpu = 0;
-				break;
-			}
 			break;
 
 		case 'g':
-- 
2.28.0

