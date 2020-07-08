Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6183E217DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 06:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgGHEHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 00:07:53 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:45384 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgGHEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:07:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 1E8242000305;
        Wed,  8 Jul 2020 12:07:50 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Kr9PBFrsGXLm; Wed,  8 Jul 2020 12:07:50 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id F1C6D20001F5;
        Wed,  8 Jul 2020 12:07:49 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id DA0EBC01B68;
        Wed,  8 Jul 2020 12:07:49 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id B2D3720031F; Wed,  8 Jul 2020 12:07:49 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] shtc1: add support for device tree bindings
Date:   Wed,  8 Jul 2020 12:07:45 +0800
Message-Id: <20200708040748.9014-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DTS bindings to the shtc driver
The patches add the compatible table and of_property_read_bool to the
shtc1.c. Newly created Yaml document has been released to the
Documentation/devicetree/hwmon/sensirion,shtc1.yaml

Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
 Version 4
	Fix errors report by make dt_binding_check (devicetree)
	Set maintainers for the yaml document to my own.
 Version 3
	Fix errors report with checkpatch.pl
	Correct logic, add (!) when check for sensirion,low_precision
 Version 2
	remove the #ifdef CONFIG_OF
	ignore platform data if dev->of_node is valid
	use boolean only therefor use sensirion,low_precise to fit the logic
	add missing driver.of_match_table entry
 Version 1
	initial version
