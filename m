Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89DD3045F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbhAZSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:07:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389955AbhAZJ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:26:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A8D121F44FBB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Gwendal Grignou <gwendal@chromium.org>, groeck@chromium.org,
        rdunlap@infradead.org, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] platform: chrome: Simplify interrupt path
Date:   Tue, 26 Jan 2021 10:25:35 +0100
Message-Id: <161165311118.2160839.18188794339266196197.b4-ty@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122054637.1422289-1-gwendal@chromium.org>
References: <20210122054637.1422289-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 21:46:35 -0800, Gwendal Grignou wrote:
> rrespective of the transport (i2c, spi, ish, rpmsg), have all cros ec
> interrupt stack call the threaded part (bottom half) of the interrupt
> handler.
> Fix an issue where EC could be stuck if it sends a message while the AP
> is not powered on.
> 
> Changes since v1:
> - fix merging issue and function comments syntax.
> 
> [...]

Applied, thanks!

[1/2] platform: cros_ec: Call interrupt bottom half in ISH or RPMSG mode
      commit: 24c69043be1725606e876b47d496a0f9f87d176a
[2/2] platform: cros_ec: Call interrupt bottom half at probe time
      commit: 4daeb395f1754340927d8d58269593e4e3b6afcd

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
