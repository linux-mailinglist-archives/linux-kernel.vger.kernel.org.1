Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37EF2FBADE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbhASPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:14:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389708AbhASOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:53:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C417723134;
        Tue, 19 Jan 2021 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611067997;
        bh=QPhNHpYLf8K43bbBe2vUJNGQhTMqf+hpynKlYdc/Unc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWO7Zl2VVzOo85L1C2uHGV1g/CHSOxzU1P5tVKki8caVNM3L+cFhQrxosJpXi3xAx
         nQ81ubtZo8ehJ08WlMx8CwUKCh82QRX5/Rm5UtRZPBaFpGIYdULCR5UKME+pWp91D5
         UIbuPwqJdJDg7Ak4pdQZ4WkzUNaNIp4sJOh6DmByOgferdmnySE8ZBuTfRkz5GnD03
         QT5ZT1xSgfUVfo2MyhHkSSrGR9K8F06Trio+yZFFPt+7zLj67yKRFsredxt2NTYFCB
         W19IvpCX9cUGAyWxVcJSxg8t+L6JF4Btc6+BelmcCOpwYqf/2UwgYOqC858Wq4efME
         eCdNB3ER3vmHA==
Date:   Tue, 19 Jan 2021 20:23:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] soundwire: sysfs: Constify static struct
 attribute_group
Message-ID: <20210119145309.GU2771@vkoul-mobl>
References: <20210117220611.30921-1-rikard.falkeborn@gmail.com>
 <20210117221622.34315-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117221622.34315-1-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-21, 23:16, Rikard Falkeborn wrote:
> The only place sdw_slave_dev_attr_group is used is when its address is
> passed to devm_device_add_group() which takes a pointer to const struct
> attribute_group. Make it const to allow the compiler to put it in
> read-only memory. This makes all attribute_group structs in the file
> const. Done with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
