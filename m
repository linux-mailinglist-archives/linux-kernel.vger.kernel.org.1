Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD881CBEA4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEIIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 04:00:21 -0400
Received: from comms.puri.sm ([159.203.221.185]:57862 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgEIIAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:00:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 28D2AE01BB;
        Sat,  9 May 2020 00:59:50 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W7irikXnVrZC; Sat,  9 May 2020 00:59:48 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     bryan.odonoghue@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        garsilva@embeddedor.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de, robh@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v2 2/2] usb: typec: tps6598x: Add OF probe binding
Date:   Sat,  9 May 2020 09:59:26 +0200
Message-Id: <20200509075926.22753-1-martin.kepplinger@puri.sm>
In-Reply-To: <20200507214733.1982696-3-bryan.odonoghue@linaro.org>
References: <20200507214733.1982696-3-bryan.odonoghue@linaro.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

> Adds a MODULE_DEVICE_TABLE() to allow probing of this driver from a DTS
> setting.

Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

thanks!
                           martin
