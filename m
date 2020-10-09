Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C04288BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbgJIOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388691AbgJIOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:41:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A068C0613D2;
        Fri,  9 Oct 2020 07:41:04 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1kQtZr-002KHD-Q5; Fri, 09 Oct 2020 16:41:00 +0200
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Benjamin Berg <bberg@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] UCSI race condition resulting in wrong port state
Date:   Fri,  9 Oct 2020 16:40:45 +0200
Message-Id: <20201009144047.505957-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Berg <bberg@redhat.com>

Hi all,

so, I kept running in an issue where the UCSI port information was saying
that power was being delivered (online: 1), while no cable was attached.

The core of the problem is that there are scenarios where UCSI change
notifications are lost. This happens because querying the changes that
happened is done using the GET_CONNECTOR_STATUS command while clearing the
bitfield happens from the separate ACK command. Any change in between will
be lost.

Note that the problem may be almost invisible in the UI as e.g. GNOME will
still show the battery as discharging. But some policies like automatic
suspend may be applied incorrectly.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Benjamin Berg (2):
  usb: typec: ucsi: acpi: Always decode connector change information
  usb: typec: ucsi: Work around PPM losing change information

 drivers/usb/typec/ucsi/ucsi.c      | 125 ++++++++++++++++++++++++-----
 drivers/usb/typec/ucsi/ucsi.h      |   2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c |   5 +-
 3 files changed, 110 insertions(+), 22 deletions(-)

-- 
2.26.2

