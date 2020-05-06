Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741231C7A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 21:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgEFTYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 15:24:07 -0400
Received: from node.akkea.ca ([192.155.83.177]:50624 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbgEFTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:24:06 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 May 2020 15:24:06 EDT
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 972204E204D;
        Wed,  6 May 2020 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588792705; bh=nJQ+uZEobk9pv0R9RtKOcEH3N7tNKBUrCdD5M9CPY54=;
        h=From:To:Cc:Subject:Date;
        b=sXGC/0l4sto0QB8MImtMcdGW6+pc8WCY7Niu0LCs/Beqy1mQdKi3mp7Oug4Uk5RPz
         cv1LD3sOAFT/2UyDq95leVcq6r6Zm79tlnHqCxPPEM/PTIChF9BcsMleVDxYU9pN74
         IehlQyTgvQVn9wNxUrYUXYbpZlwbEHqiAh1bMdf4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6yC_2xNZ-Abi; Wed,  6 May 2020 19:18:25 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id EA9A24E2003;
        Wed,  6 May 2020 19:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1588792705; bh=nJQ+uZEobk9pv0R9RtKOcEH3N7tNKBUrCdD5M9CPY54=;
        h=From:To:Cc:Subject:Date;
        b=sXGC/0l4sto0QB8MImtMcdGW6+pc8WCY7Niu0LCs/Beqy1mQdKi3mp7Oug4Uk5RPz
         cv1LD3sOAFT/2UyDq95leVcq6r6Zm79tlnHqCxPPEM/PTIChF9BcsMleVDxYU9pN74
         IehlQyTgvQVn9wNxUrYUXYbpZlwbEHqiAh1bMdf4=
From:   Angus Ainslie <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tps6598x: add device tree hooks and document
Date:   Wed,  6 May 2020 12:17:16 -0700
Message-Id: <20200506191718.2144752-1-angus@akkea.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree compatible string for tps6598x driver and create the dt binding doc for the driver

Angus Ainslie (2):
  usb: typec: tps6598x: add device tree hooks
  dt-bindings: usb: ti,tps6598x: add dt binding doc

 .../devicetree/bindings/usb/ti,tps6598x.yaml  | 75 +++++++++++++++++++
 drivers/usb/typec/tps6598x.c                  |  7 ++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml

-- 
2.25.1

