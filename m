Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6542EC918
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhAGD2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbhAGD2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:28:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40B4622D01;
        Thu,  7 Jan 2021 03:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609990057;
        bh=10kzvXRthKI18fNu6GuYjy0UmG1vIJpOhjCIC5mR91U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BM/LLckINOMLOzXRzxgpKilsH7mnbB9staWUA43UJfWzu5nkxQIlIJlQw1JCT8exj
         a7g2XcYtymoF/OVCAlJiLFZLgcrj9flY+DwZMvOkDvWXblDzeWEsTskQ0ypI1LJ6hW
         2qLD9d8RzjVlQo253igg6GzeEJnxEwSVZNw34/H66Qx0Va21g6VXL660ilCn6eEYld
         t3LawhHSo5sINExXsyPUfmPNzb6DhzZ2RzzxcnvJsV3nQGDM5Q9oGZrPROYLFQ1hoq
         nAkixnv0uwKTByz/NGeU1WYSBjo1TIcLTuL8G/fURaCAD4llI9oKq2zUUM2HKiiW1A
         +uPbDYT+Chryw==
Date:   Thu, 7 Jan 2021 11:27:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>
Subject: Re: [PATCH v2] ARM: dts: imx28: add pinmux for USB1 overcurrent on
 pwm2
Message-ID: <20210107032730.GA28365@dragon>
References: <20201209220903.27058-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209220903.27058-1-lukma@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:09:03PM +0100, Lukasz Majewski wrote:
> From: Mans Rullgard <mans@mansr.com>
> 
> Add pinmux setting for USB1 overcurrent on pwm2 pad.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied, thanks.
