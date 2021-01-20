Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF82FD3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbhATPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:16:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49730 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390953AbhATPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:15:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 335641F4582B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: Constify static attribute_group structs
Date:   Wed, 20 Jan 2021 16:14:38 +0100
Message-Id: <161115565913.676119.6220305847430124366.b4-ty@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109001748.58036-1-rikard.falkeborn@gmail.com>
References: <20210109001748.58036-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 01:17:48 +0100, Rikard Falkeborn wrote:
> The only usage of these is to print their name in a dev_err-message, and
> to pass their address to sysfs_create_group() and sysfs_remove_group(),
> both which takes pointers to const. Make them const to allow the compiler
> to put them in read-only memory.

Applied, thanks!

[1/1] platform/chrome: Constify static attribute_group structs
      commit: ed07d774c4b2793be4d2bfc62cf69c3e55667f5a

Best regards,
-- 
Enric Balletbo i Serra <enric.balletbo@collabora.com>
