Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D072B17AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgKMI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKMI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:59:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9682C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:58:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B82A31F4680A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     alevkoy@chromium.org, dzigterman@chromium.org,
        heikki.krogerus@linux.intel.com, Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v2 0/7] platform/chrome: cros_ec_typec: Register partner PD information
Date:   Fri, 13 Nov 2020 09:58:51 +0100
Message-Id: <160525790930.600613.4044616455667583255.b4-ty@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 15:27:28 -0700, Prashant Malani wrote:
> This series adds support to retrieve Type C PD(Power Delivery) Discovery
> information from the Chrome OS EC, and register this information with
> the Type C connector class framework.
> 
> There are also a couple of patches which fix minor bugs with the
> existing cros-ec-typec driver.
> 
> [...]

Applied, thanks!

[1/7] platform/chrome: cros_ec_typec: Relocate set_port_params_v*() functions
      commit: 0498710be002b35bcb43895c4133a4c4bbfd837e
[2/7] platform/chrome: cros_ec_typec: Fix remove partner logic
      commit: 7ab5a673f4ce65875c76e9812d2e6da063b87fb7
[3/7] platform/chrome: cros_ec_typec: Clear partner identity on device removal
      commit: 514acf1cefd020eb21d7c180050a8d66b723d2d8
[4/7] platform/chrome: cros_ec: Import Type C host commands
      commit: cd2c40ff90b0e385c18f881ab5e17f7137864223
[5/7] platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
      commit: 80f8cef60d79f23c02e546ba3de2fce84d5e8bdb
[6/7] platform/chrome: cros_ec_typec: Parse partner PD ID VDOs
      commit: f6f668118918f533676e51f3214f5a104562b59c
[7/7] platform/chrome: cros_ec_typec: Register partner altmodes
      commit: de0f49487db3667f5204dcec6d3482c9bd1a0a30

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
