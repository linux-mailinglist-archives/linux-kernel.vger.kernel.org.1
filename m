Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE76828F0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgJOLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgJOLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:20:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B461C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:20:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id b23so1726852pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=h3tRYVbrXJtU2QrbFsBU9Spd181m5OYM6XKvEjWUj7o=;
        b=QIt/mP8DYXc3aZ9StyaAf2nXjupmpSXJxoytuCIbUXNsgENvncCxtqnJ4375DhrhXx
         EvL/5yz9peW8cIZdmOHclXRu7fLxJsjlN8cGjG1jPde7jP8CFUQk9eovln5n8Nj9VGrr
         rh2CIZQxIh/ecTcr5BFF5Rrw8+QNZvjClVcYhGHf2cW1JObwlI/XExq6jAlRsCN0B7r9
         c5X9bQAIwy0lOPAHZ0sMtnVpXr8acL1jKEtLCDmup52Z9pmxAXd3R12PYi/r9QgzcDzm
         JTQQnPyaTMlDOiBFEPiOTg7G9dzyk3MXoAnvZqqfT274OcFfZPnLX4m/0f97rb1Uyg/r
         itnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=h3tRYVbrXJtU2QrbFsBU9Spd181m5OYM6XKvEjWUj7o=;
        b=fxTkr8rgoEv5jYWgpr6s4KmCfTLFKFMQ/SzBDJSFJWhq1UZ1w0lsWGvand4/t3Riz8
         Jx6ksx5qkbEo4tIgflMDnkqYiyGmSmaDhLgKuX3GcEl6nOxCDsvaoDQtjgaUeV4blkbp
         CmUVbq1bXJik2Qx6LKqXA+IVKLDj2i9TpOd3IjHPk0kbXy6C1WI6IZrkEwm4LI8j3dc1
         +RiNHZgX3HT8nqjGpRgoCgZvEwV3pJrBhhsHuirx4cLvxxjV9rOuyQ2X+X59c0H1La0Y
         Kewz2FMWvlmoVuQWJ1bP+rhJVr9ABkmLXL5YARU4uETaCmlrBOS2mv2YljSYpUJ+GpTp
         PAtw==
X-Gm-Message-State: AOAM5301/3ATwnfKd5YabB/iz3VK6ohi1H3ccL/BRnRplLHYvG1kaNZJ
        FreLu4BQ7H97RKlYFj8QAf6Bxg==
X-Google-Smtp-Source: ABdhPJycSiqzIkOBMmcrMer+prhnFXkBkWVnnTG1jX+nH7iysz4LJoobpMqgfGJiu0O57TDIZE4ACQ==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr2958265pgd.433.1602760854749;
        Thu, 15 Oct 2020 04:20:54 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id k127sm2828221pgk.10.2020.10.15.04.20.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 04:20:54 -0700 (PDT)
Message-ID: <f746bda4c51d6553f2094b0a3dfbafa3e39d4c28.camel@areca.com.tw>
Subject: [PATCH 0/1] scsi: arcmsr: configure the default SCSI device command
 timeout value
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 16 Oct 2020 03:20:54 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against to mkp's 5.10/scsi-queue.

1. Configure the default SCSI device command timeout value.
---


