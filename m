Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A5D1AE290
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 18:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgDQQy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 12:54:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:42388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgDQQy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:54:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B4C89AB5C;
        Fri, 17 Apr 2020 16:54:54 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com, linux-kernel@vger.kernel.org
Cc:     frowand.list@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 0/2] of: property: fw_devlink misc fixes
Date:   Fri, 17 Apr 2020 18:54:40 +0200
Message-Id: <20200417165442.1856-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I'm interested in using this feature to fine-tune Raspberry Pi 4's
device probe dependencies, I tried to get the board to boot with
fw_devlink=on. As of today's linux-next the board won't boot with that
option. I tried to address the underlying issues.

---

Changes since v1:
 - Address Saravana's comments
 - Drop patch #3 & #4

Nicolas Saenz Julienne (2):
  of: property: Fix create device links for all child-supplier
    dependencies
  of: property: Do not link to disabled devices

 drivers/of/property.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

-- 
2.26.0

