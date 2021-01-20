Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170F22FD3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbhATPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbhATPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:15:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522EC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:14:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 76BE31F45829
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec: Add host command to keep AP off after EC reset.
Date:   Wed, 20 Jan 2021 16:14:37 +0100
Message-Id: <161115565913.676119.24181779049303168.b4-ty@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221041231.14516-1-pihsun@chromium.org>
References: <20201221041231.14516-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Dec 2020 12:12:23 +0800, Pi-Hsun Shih wrote:
> Add command to EC_CMD_REBOOT_EC to reset EC but don't boot AP.

Applied, thanks!

[1/2] platform/chrome: cros_ec: Add host command to keep AP off after EC reset.
      commit: 8e7a76ad8f51fd9aaabf8feeea54b22f4e4873d8
[2/2] platform/chrome: cros_ec_sysfs: Add cold-ap-off to sysfs reboot.
      commit: 91b9694542179f2f2325a5c4f86c4e7f9be277d3

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
