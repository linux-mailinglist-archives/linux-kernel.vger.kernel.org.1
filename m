Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9846C2FD3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390797AbhATPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390952AbhATPP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:15:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C207C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:14:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DE4891F45828
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Evan Benn <evanbenn@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_proto: Use EC_HOST_EVENT_MASK not BIT
Date:   Wed, 20 Jan 2021 16:14:36 +0100
Message-Id: <161115565913.676119.16319559230048312277.b4-ty@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
References: <20201209220306.1.I6133572c0ab3c6b95426f804bac2d3833e24acb1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 22:03:54 +0000, Evan Benn wrote:
> The host_event_code enum is 1-based, use EC_HOST_EVENT_MASK not BIT to
> generate the intended mask. This patch changes the behaviour of the
> mask, a following patch will restore the intended behaviour:
> 'Add LID and BATTERY to default mask'

Applied, thanks!

[1/2] platform/chrome: cros_ec_proto: Use EC_HOST_EVENT_MASK not BIT
      commit: 9eb4f16a67245f7155148d9a400e0eab3cb0fe7b
[2/2] platform/chrome: cros_ec_proto: Add LID and BATTERY to default mask
      commit: b33539f0d9f341a765c6b9dc63f00e253c8595aa

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
