Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A912F53C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbhAMT71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:59:27 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:10451 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbhAMT70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:59:26 -0500
Received: from [84.39.76.69] (helo=thinkstation.fritz.box)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <vogelchr@vogel.cx>)
        id 1kzm9x-0006Vv-B7; Wed, 13 Jan 2021 20:50:25 +0100
From:   Christian Vogel <vogelchr@vogel.cx>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, vogelchr@vogel.cx, linux-kernel@vger.kernel.org
Subject: 
Date:   Wed, 13 Jan 2021 20:50:16 +0100
Message-Id: <20210113195018.7498-1-vogelchr@vogel.cx>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Df-Sender: Y2hyaXNAb21ncHduaWVzLmRl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

here are two patches for the onewire subsystem.

The first allows to have DS28E04 eproms on the bus (which have a
peculiar address-crc quirk when using the address strapping pins).

The second fixes a long-standing bug with hanging of a DS2490 USB
interface when some chips (that lock the bus mutex during add) are
discovered, e.g. https://github.com/raspberrypi/linux/issues/3491.

I initially sent to Evgeniy (cc), but he asked to resend to you and
Cc lkml.

	Chris


